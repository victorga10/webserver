# webserver
php webserver apache


Exemplo docker run

docker run -td --link mariadb01:db -p 0.0.0.0:80:80 -p 0.0.0.0:443:443 -p 0.0.0.0:4321:4321 -h webserver --name webserver -v site:/var/www/html --restart always  serverti/webserver
