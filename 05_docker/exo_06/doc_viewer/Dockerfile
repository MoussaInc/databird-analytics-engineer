FROM python:3.11-slim
WORKDIR /app

COPY readme.html index.html ./

EXPOSE 8000

# Lancer le serveur HTTP Python
CMD ["python", "-m", "http.server", "8000"]