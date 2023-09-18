# Se instala la versión php:7.4.33 con apache
FROM php:7.4.33-apache
# Se actualizan los paquetes dentro de la distribución de linux
RUN apt-get update
# Se instalar librerías extras necesarias para las extensiones de apache
RUN apt install libicu-dev -y
RUN apt-get install libcurl4-openssl-dev -y
RUN apt-get install libxml2-dev -y 
RUN apt install curl -y
RUN apt-get install unzip
# Se instala las extensiones de docker
RUN docker-php-ext-install json
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install intl
RUN docker-php-ext-install curl
RUN docker-php-ext-install xml
RUN docker-php-ext-install xmlrpc

# Se instalan herramientas extras
RUN apt-get install unzip
# Instalar un editor de texto para la consola
RUN apt-get install vim -y
RUN apt-get install nano
# Instalar GNUPG2
## Más info: GnuPG es una herramienta de código abierto que proporciona funcionalidades de cifrado y firma digital
RUN apt-get install gnupg2 -y
# Instalar wget
## Más info: Herramienta para descargar archivos o recursos de Internet directamente a través de la terminal, sin necesidad de abrir un navegador web
RUN apt-get install wget

# Si tienes un proyecto, descomenta la linea que dice "COPY", en caso de que no, crea tu proyecto en la carpeta www
# Se copian los archivos del composer para el proyecto y de esta manera usarlos para descargar las librerías de CodeIgniter 4
# COPY ./www/composer.json /var/www/html/composer.json

# Solucion al error Apache docker container - Invalid command 'RewriteEngine'
RUN a2enmod rewrite
# Permisos de superusuario para hacer uso del composer
ENV COMPOSER_ALLOW_SUPERUSER=1
# Descarga de composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# Las siguientes líneas son para solucionar un error de guardado en caso de meter el proyecto dentro de el WSL de Windows
#   para más información, consultar el README.MD en el aparatado de "Contenedores lentos"
# Se crear un nuevo grupo de usuarios llamado "developer" asignado al grupo 1000, es el mismo grupo que un usuario normal
# create a new linux user group called 'developer' with an arbitrary group id of '1001'
RUN groupadd -g 1000 developer
# Se crea un nuevo usuario "developer" y se asigna al grupo anterior
RUN useradd -u 1000 -g developer developer
# Se cambia el dueño y el grupo del directorio de trabajo actual a "developer"
COPY --chown=developer:developer . /var/www
# Corre todas las subsecuencias y los comandos con ese nuevo usuario
USER developer

# Línea que podría ser de ayuda en caso de tener problema con los permisos en Linux
#   esta dse ejecuta dentro de la consola del contenedor de docker explicado en el README.MD
# RUN chmod o+w ./storage/ -R