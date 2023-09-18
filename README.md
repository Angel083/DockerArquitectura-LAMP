# Infraestructura tipo LAMP

Ambiente de trabajo que funciona bajo la infrastructura LAMP (Linux, Apache/php, MariaDB, PhpMyAdmin).

El proyecto esta preparado para ser usado para el framework de CodeIgniter en su versión 4, sin embargo, comparte arquitectura para Laravel y Symfony (faltan pruebas).

## Uso de las carpetas
- www
  Acá dentro irá tu proyecto
- dump
  Acá podrás cargar tu script al momento que se **crea o recontruyen** todos los contenedores
- config
  Dentro de esta carpeta se encuentra los archivos necesarios para apache, como configuraciones extras, tales como el php.ini.
## Tecnologías utilizadas
- PHP v7.4.33
- Apache v2.4.57
- Docker / Docker compose
- MariaDB v11.0.2

## Requerimientos
- Tener instalado Docker (descargar Docker Desktop para el caso de Windows y Mac, y así se instala Docker, si usas alguna distribución de Linux tedrás que investigar más a fondo).
- Pasos exclusivos para Windows debido a que el subsistema de Linux en Windows es muy lento con los servidores
  - Instalar alguna Distro para Docker, en esta ocasión se uso Ubuntu, pero cualquiera puede servir
    - Abrir Windows Power Shell como administrador y ejecutar
    ```Power shell
    wsl --install -d Ubuntu
    ```
    - Seleccionar por default la Distro nueva
    ```Power shell
    wsl --set-default Ubuntu
    ```
    - Actualizar la distro a WL2
    ```Power shell
    wsl --set-version Ubuntu 2
    ```
  - Dentro de la interfaz de Docker Desktop ve hacia Configuraciones > Resources > WSL Integration y ya no deberías de ver el mensaje de actualización de WSL 2 Distro.

## Creación del proyecto
Se enlistarán dos maneras de instalar el proyecto, estás solo difieren al inicio ya que después tienen los mismos pasos, esto se debe a que (al menos en Windows) el servidor de apache de esta versión, es muy lento al cargar los archivos, algo bastante curioso que no sucede con phpmyadmin, llegando a tardar hasta 20 segundos en una sola petición.
Para más información puedes consultar en el siguiente enlace ["Contenedores lentos"](https://github.com/irradev/docker-windows-helps/blob/main/contenedores-muy-lentos.md).
### Creación común
- Clonar el proyecto de manera local desde el repositorio en cualquier carpeta.
---
### Creación no convencional
- Tendrás que, en tu explorador de archivos, poner la siguiente ruta: **\\\wsl$**.
- Si estás usando Ubuntu, tendrás que dirigirte a: **\\\wsl$\Ubuntu\home\tu-usuario**.
- Crea una nueva carpeta dentro de este directorio para el proyecto y es aquí donde harás la clonación del proyecto que contiene esta infraestructura.
  > Recuerda abrir la terminal desde acá, ya que de otra manera no funcionará. Lo más probable sea que te pida permisos para hacer cambios, dale los permisos necesarios.
---
- Abre el proyecto con tu editor de código favorito (a titulo personal uso VSC) abre un bash en la dirección que se encuentre el proyecto, aunque es bastante recomendable usar la misma terminal que ofrece Ubuntu, solo escribe Ubunto en inicio.
- Una vez dentro de la carpeta usa el siguiente comando para iniciar los servicios y las imagenes necesarias.
  ```Docker
  docker compose up -d
  ```
    > 📘 Info extra
    > 
    > La primera vez puede llegar a tardar debido a que tiene que instalar todos las imagenes y extensiones necesarias
    >
    > El comando funciona de la siguiente manera: 
    > - *docker compose* usa el servicio de docker compose
    > - *up* levanta el contenedor
    > - *-d* detach-> al terminar de levantar los contenedores te deja usar la terminal nuevamente, en caso de no tener esta **flag**, te mostrará en la terminal todos los mensajes que se estén generando en los contenedores.
- En caso de haber hecho cambios o modificaciones en el Dockerfile o el docker-compose se ejecuta el primer comando pero agregando la flag (bandera, aunque tambien se le podría decir propiedad) *--build*, este comando lo que hace es recrear las imagenes
  ```Docker
  docker compose up -d --build
  ```
### Instalar librerías y dar permisos de escritura
Al levantar todos los contenedores ya tendrías que poder visualizarlos en docker, sin embargo, el proyecto no va a funcionar ya que le hacen falta las librerías necesarias que necesita CodeIgniter (Laravel también las usa, hasta ahora no se han hecho pruebas con Symfony)

  - Usa el siguiente comando para que se abra una terminal interactiva de docker desde aquí se realizarán todos los comandos: 
    ```Bash
    docker exec -it webAplication bash
    ```
  - Una vez dentro ejecutar
    ```Bash
    composer update
    ```  
  Si llegas a tener problemas de escritura en alguna carpeta entra nuevamente al contenedor
    ```Bash
    docker exec -it webAplication bash
    ```
  Y luego ejecutar el siguiente comando:
    ```Bash
    chmod o+w ./ -R
    ```
No olvides poner tu archivo ***.env*** algunos .gitignore lo eliminan para evitar incompatibilidades entre el equipo de trabajo.

Con todos estos pasos, ¡Ya tendrías que poder visualizar el proyecto!

Abre la dirección [http://localhost:80/login](http://localhost:80/login) donde estará el proyecto

Ve a [http://localhost:8000](http://localhost:8000) y usa las credenciales usr: root, pwd:root