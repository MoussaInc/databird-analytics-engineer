# 1. Creation du Dockerfile

<!-- FROM alpine:3.18

# Installer ffmpeg
RUN apk add --no-cache ffmpeg

# Dossier de travail dans le conteneur
WORKDIR /media

# Commande principale
ENTRYPOINT ["ffmpeg"]

# Conversion par défaut mp4 → mp3
CMD ["-i", "input.mp4", "output.mp3"] -->

# 2. Build de l'image
docker build -t music-converter .


# 3. Execution du container: lancer sans argument (ENTRYPOINT + CMD)
docker run --rm -v ./media/:/media/ music-converter
docker run --rm music-converter -version


# 4. verification de la presence du fichier conerti (en mp3)
ls media/
cat ./media/output.mp3