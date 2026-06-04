FROM python:3.11-slim

WORKDIR /app

EXPOSE 8000

CMD ["python", "-m", "http.server", "8000"]

# Ensuite on rebuild l'image docker build -t doc-viewer .
# Puis on demarre le conteneur en montant le fichier readme.html ou index.html du host vers le conteneur :
#   docker run --rm -p 8000:8000 -v ../dc_viewer/index.html:/app  doc-viewer  
# Voir la documention : http://localhost:8000/index.html
