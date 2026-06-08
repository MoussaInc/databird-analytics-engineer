# 05 — Docker Volumes

## Bind Mount — persister un fichier sur le host

```bash
# Créer / écrire dans un fichier
docker run --rm \
  -v $(pwd)/docker-demo/docs:/app/data \
  alpine \
  sh -c "echo 'Hello from Docker!' > /app/data/hello.txt"

# Ajouter des lignes (>>)
docker run --rm \
  -v $(pwd)/docker-demo/docs:/app/data \
  alpine \
  sh -c 'echo "2ème ligne" >> /app/data/hello.txt'
```

> Le fichier persiste sur le host même après suppression du container.

## Named Volume — persistance gérée par Docker

```bash
# Créer un volume
docker volume create data-volume

# Écrire dans le volume
docker run --rm \
  -v data-volume:/app/data \
  alpine \
  sh -c 'echo "Hello depuis un Named Volume !" >> /app/data/hello.txt'

# Inspecter le volume (chemin exact sur le host)
docker volume inspect data-volume

# Lister les volumes
docker volume ls

# Supprimer un volume
docker volume rm data-volume
```

> Le volume persiste même après suppression du container.  
> Contrairement au Bind Mount, c'est Docker qui gère l'emplacement sur le disque.

## Bind Mount vs Named Volume

| | Bind Mount | Named Volume |
|---|---|---|
| Emplacement | Défini par l'utilisateur | Géré par Docker |
| Usage | Partager des fichiers avec le host | Persistance de données |
| Commande | `-v $(pwd)/dossier:/container` | `-v nom-volume:/container` |