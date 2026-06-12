"""
INGESTION PIPELINE - LOCAL CSV → SNOWFLAKE STAGE

Objectif :
    Charger des fichiers CSV locaux dans Snowflake de manière incrémentale.

Logique :
    1. Scanner les fichiers locaux
    2. Calculer un hash SHA256 de chaque fichier
    3. Comparer avec ingestion_log dans Snowflake
    4. Uploader uniquement les fichiers nouveaux ou modifiés
    5. Mettre à jour ingestion_log

"""

import os
import hashlib
from pathlib import Path
import snowflake.connector

# BASE_DIR = Path(__file__).resolve().parents[2]
# DATA_FOLDER = BASE_DIR / "data" / "localbike_dataset"
DATA_FOLDER = Path("/opt/airflow/data")

STAGE_NAME = "STAGE_DB.STAGE_SCHEMA.LOCALBIKE_STAGE"

SNOWFLAKE_CONFIG = {
    "account": os.getenv("SNOWFLAKE_ACCOUNT"),
    "user": os.getenv("SNOWFLAKE_USER"),
    "password": os.getenv("SNOWFLAKE_PASSWORD"),
    "role": os.getenv("SNOWFLAKE_ROLE_STAGE"),
    "warehouse": os.getenv("SNOWFLAKE_WAREHOUSE_STAGE"),
    "database": os.getenv("SNOWFLAKE_DATABASE_STAGE"),
    "schema": os.getenv("SNOWFLAKE_SCHEMA_STAGE"),
}


def get_connection():
    return snowflake.connector.connect(**SNOWFLAKE_CONFIG)


def file_hash(path: Path) -> str:
    """
    Calcule un hash SHA256 d'un fichier.
    Objectif :
        Identifier de manière unique le contenu d'un fichier.
        Si le fichier change (même légèrement), le hash change.
    """
    # Initialisation de l'algorithme SHA256
    h = hashlib.sha256()

    # Lecture du fichier en binaire
    with open(path, "rb") as f:
        # Lecture par blocs (évite de charger tout le fichier en mémoire)
        while chunk := f.read(8192):
            h.update(chunk)

    # Retour du fingerprint final du fichier
    return h.hexdigest()


def get_ingestion_log(cur) -> dict:
    """
    Récupère l'historique des fichiers déjà ingérés depuis Snowflake.
    Objectif :
        Servir de mémoire du pipeline pour éviter de recharger
        des fichiers déjà traités et inchangés.

    Table utilisée :
        STAGE_DB.STAGE_SCHEMA.INGESTION_LOG

    Args:
        cur: cursor Snowflake déjà connecté

    Returns:
        dict:
            Dictionnaire sous la forme :
            {
                "orders.csv": "a8f5c3...",
                "stocks.csv": "91c2ab..."
            }
    """

    # Requête vers Snowflake pour récupérer les fichiers déjà traités
    rows = cur.execute("""
        SELECT file_name, file_hash
        FROM STAGE_DB.STAGE_SCHEMA.INGESTION_LOG
    """).fetchall()

    return {row[0]: row[1] for row in rows}


def upload():
    conn = get_connection()
    cur = conn.cursor()

    try:
        cur.execute(f"CREATE STAGE IF NOT EXISTS {STAGE_NAME}")

        local_files = list(DATA_FOLDER.glob("*.csv"))
        log = get_ingestion_log(cur)

        for file in local_files:
            h = file_hash(file)

            # skip si identique
            if (file.name in log) and (log[file.name] == h):
                print(f"SKIP {file.name} : fichier inchangé")
                continue

            print(f"UPLOAD {file.name}")

            cur.execute(f"""
                PUT file://{file}
                @{STAGE_NAME}
                AUTO_COMPRESS=TRUE
                OVERWRITE=TRUE;
            """)

            # upsert log
            cur.execute("""
                MERGE INTO STAGE_DB.STAGE_SCHEMA.INGESTION_LOG t
                USING (
                    SELECT %s AS file_name, %s AS file_hash
                ) s
                ON t.file_name = s.file_name
                WHEN MATCHED THEN UPDATE SET file_hash = s.file_hash, ingested_at = CURRENT_TIMESTAMP
                WHEN NOT MATCHED THEN INSERT (file_name, file_hash, status)
                VALUES (s.file_name, s.file_hash, 'SUCCESS')
            """, (file.name, h))

        print("Ingestion terminée")

    finally:
        cur.close()
        conn.close()


if __name__ == "__main__":
    upload()
    