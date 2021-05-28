# webserver
Conteiner com Apache, PHP 7 no CentOS

## Exemplo para compilar a imagem 
  
```bash
docker build -t nome_imagem .
```

## Exemplo docker run da imagem local
  
```bash
docker run -d --name nome_conteiner -v "caminho do código PHP":/var/www/html -p "sua porta ex:80":80 nome_imagem
```

## Exemplo docker run da imagem publica do DokerHub (não precisa compilar a imagem)

```bash
docker run -d --name nome_conteiner -v "caminho do código PHP":/var/www/html -p "sua porta ex:80":80 serverti/webserver
```

## Monitorar os Logs

```bash
docker logs -f webserver
 ```
 
## Reiniciar o apache

```bash
docker exec -it  webserver httpd -k restart
```

## Usando o composer

```bash
docker exec -it -u apache webserver composer update -o
```

## Fazendo um clone de uma pagina com o git

```bash
docker exec -it -u apache webserver git clone https://github.com/roke22/PHP-SSH2-Web-Client.git /var/www/html
```
