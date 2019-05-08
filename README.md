# webserver
php webserver apache

## Exemplo para compilar a imagem 
  
  docker build . -t serverti/webserver

## Exemplo docker run
  
  docker run -td -p 0.0.0.0:80:80 -h webserver --name webserver -v site:/var/www/html --restart always serverti/webserver

## Monitorar os Logs

 docker logs -f webserver
 
# Reiniciar o apache

  docker exec -it  webserver httpd -k restart

# Usando o composer

  docker exec -it -u apache webserver composer update -o

# Fazendo um clone de uma pagina com o git

 docker exec -it -u apache webserver git clone https://github.com/roke22/PHP-SSH2-Web-Client.git /var/www/html
 
 
