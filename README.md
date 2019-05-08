# webserver
php webserver apache

Exemplo docker run

docker run -td -p 0.0.0.0:80:80 -h webserver --name webserver -v site:/var/www/html --restart always serverti/webserver

