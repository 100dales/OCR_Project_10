## Script de construction de l'image et sa publication dans DockerHub

docker build -t wp-custom-05 ./Docker_Image_Wp
docker tag wp-custom-05:latest 100dales/wp-custom-05:latest
docker push 100dales/wp-custom-05:latest
