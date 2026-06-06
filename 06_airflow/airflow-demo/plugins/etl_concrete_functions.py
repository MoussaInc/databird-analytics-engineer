import urllib.request
import os
import pandas as pd

# Chemins centralisés
# OUTPUT_DIR    = "../airflow-demo/db" pour tester localement, 
OUTPUT_DIR    = "/opt/airflow/db"
XLS_FILE      = os.path.join(OUTPUT_DIR, "Concrete_Data.xls")
CSV_RAW       = os.path.join(OUTPUT_DIR, "Concrete_Data_raw.csv")
CSV_TRANSFORM = os.path.join(OUTPUT_DIR, "Concrete_Data_transformed.csv")
CSV_NORMALIZE = os.path.join(OUTPUT_DIR, "Concrete_Data_normalized.csv")
CSV_CLEAN     = os.path.join(OUTPUT_DIR, "Concrete_Data_clean.csv")

URL = "https://archive.ics.uci.edu/ml/machine-learning-databases/concrete/compressive/Concrete_Data.xls"


def extract(**context):
    os.makedirs(OUTPUT_DIR, exist_ok=True)

    print("[EXTRACT] Téléchargement...")
    urllib.request.urlretrieve(URL, XLS_FILE)
    print(f"[EXTRACT] Fichier XLS sauvegardé : {XLS_FILE}")

    df = pd.read_excel(XLS_FILE)
    df.columns = [
        "cement", "blast_furnace_slag", "fly_ash", "water",
        "superplasticizer", "coarse_aggregate", "fine_aggregate",
        "age", "compressive_strength"
    ]

    df.to_csv(CSV_RAW, index=False)
    print(f"[EXTRACT] {len(df)} lignes extraites: {CSV_RAW}")


def transform(**context):
    df = pd.read_csv(CSV_RAW)

    df["water_cement_ratio"] = df["water"] / df["cement"]

    df.to_csv(CSV_TRANSFORM, index=False)
    print(f"[TRANSFORM] Colonne 'water_cement_ratio' ajoutée")
    print(df[["cement", "water", "water_cement_ratio"]].head())
    print(f"[TRANSFORM] {len(df)} lignes transformées: {CSV_TRANSFORM}")


def normalize(**context):
    df = pd.read_csv(CSV_RAW)

    for col in df.columns:
        col_min = df[col].min()
        col_max = df[col].max()
        if col_max - col_min > 0:
            df[col] = (df[col] - col_min) / (col_max - col_min)

    df.to_csv(CSV_NORMALIZE, index=False)
    print(f"[NORMALIZE] Normalisation min-max appliquée")
    print(df.head())
    print(f"[NORMALIZE] {len(df)} lignes normalisées: {CSV_NORMALIZE}")


def clean(**context):
    df = pd.read_csv(CSV_NORMALIZE)

    before = len(df)
    df = df.dropna()
    df = df.drop_duplicates()
    after = len(df)

    df.to_csv(CSV_CLEAN, index=False)
    print(f"[CLEAN] {before - after} lignes supprimées, {after} lignes restantes: {CSV_CLEAN}")


def load(**context):
    df_transformed = pd.read_csv(CSV_TRANSFORM)
    df_clean       = pd.read_csv(CSV_CLEAN)

    print(f"[LOAD] Données transformées : {len(df_transformed)} lignes")
    print(df_transformed.head())

    print(f"[LOAD] Données nettoyées    : {len(df_clean)} lignes")
    print(df_clean.head())

    print("[LOAD] Chargement simulé avec succès")

# if __name__ == "__main__":
#     extract()
#     transform()
#     normalize()
#     clean()
#     load()