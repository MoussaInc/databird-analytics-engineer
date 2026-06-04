FROM alpine:3.18

# Installer ffmpeg
RUN apk add --no-cache ffmpeg

# Dossier de travail dans le conteneur
WORKDIR /media

# Commande principale
ENTRYPOINT ["ffmpeg"]

# Conversion par défaut mp4 → mp3
# Options: "-q:a" et "0" : pour une meilleure qualité audio
#         "-map" et "a" : pour extraire uniquement la piste audio (ignore la vidéo)
CMD ["-i", "input.mp4", "-q:a", "0", "-map", "a", "output.mp3"] 