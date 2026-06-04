# Exercice — Bind Mount : persister un fichier après suppression du conteneur
 
 ## Commande qui lance un conteneur avec un Bind Mount

docker run --rm \
  -v ~/docker-demo/docs:/app/data \
  alpine \
  sh -c "echo 'Hello from Docker!' > /app/data/hello.txt"

 ## pour une 2nde et 3ieme ligne dans le meme fichie texte:
docker run --rm  \
 -v ./docker-demo/docs:/app/data \
   alpine  \
   sh -c 'echo "Une 2nde ligne inserer dans le fichier depuis le container" >> /app/data/hello.txt'

docker run --rm \
 -v ./docker-demo/docs:/app/data \
  alpine \
  sh -c 'echo "Et une 3ieme ligne " >> /app/data/hello.txt'


# Named Volumes — Persistance gérée par Docker

 ## creer un volume
 docker volume create data-volume

  ## lancer le container qui ecrit dans le volume
  docker run --rm \
    -v data-volume:/app/data \
    alpine \
    sh -c 'echo "Hello depuis un Named Volume !" >> /app/data/hello.txt'

  ## supprime le container et verifier la persistance du volume
  docker rm alpine
  docker ps -a
  docker volume ls

  ## pour connaitre le chemin exact du volume creer
  docker volume inspect data-volume