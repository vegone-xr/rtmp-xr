# multistream

## Documentations

NGINX-RTMP-DOCKER : https://github.com/tiangolo/nginx-rtmp-docker/blob/master/Dockerfile
NGINX-RTMP-MODULE : https://github.com/arut/nginx-rtmp-module/

TUTO :
https://www.scaleway.com/en/docs/setup-rtmp-streaming-server/
https://github.com/arut/nginx-rtmp-module/wiki/Installing-on-Ubuntu-using-PPAs
https://blog.gochu.fr/index.php/2020/04/19/ajouter-la-prise-en-charge-du-rtmps-a-votre-serveur-nginx-rtmp/
https://forums.linuxmint.com/viewtopic.php?t=335378
http://nginx-rtmp.blogspot.com/
https://dev.to/lax/rtmps-relay-with-stunnel-12d3
https://obsproject.com/forum/resources/obs-studio-stream-to-multiple-platforms-or-channels-at-once.932/

NGINX VERSION :
https://nginx.org/en/download.html

APPLICATION :
https://github.com/sieuhuflit/react-native-live-stream-rtmp-example

## Installation

### Configuration du serveur OVH

Creation d'une instance Public Cloud sur OVH : B2-7 (7 Go RAM, 2 vCores (2,3 GHz), 50 Go SSD, 250 Mbit/s)
Localisation : Gravelines GRA3
Sélectionnez une image : Ubuntu 20.04
Clé SSH : ssh_key_4096
Nombre d'instances à créer : 1
Nom de l'instance : b2-7-gra3-multistream
Script de post-installation :

    #!/bin/bash

    echo "test" >> test.txt

Sauvegarde automatisée des instances : Oui
Sélectionnez une période de facturation : Horaire

### Lancer le script d'installation

wget https://raw.githubusercontent.com/vegone-xr/rtmp-xr/main/server/install.sh
chmod +x install.sh
./install.sh

### NGINX

sudo nginx
sudo nginx -s reload
sudo nginx -s stop

### Kill old Nginx on port 80

sudo apt install net-tools
sudo netstat -tunlp
sudo kill -9 17421