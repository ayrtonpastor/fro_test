# Test Frogmi

## Requerimientos
* Git
* Docker y docker-compose
* Node v18 o superior

## Descripción de servicios

El proyecto está dockerizado y se encuentra dividido en 3 servicios: sismodb, sismobase y sismoclient.
* sismodb: Es el servicio que disponibiliza una base de datos en MySql
* sismobase: Es el servicio backend del proyecto. Realizado en Rails 6.1, en el cuál se generarán los features y se podrá hacer la gestión y realizar comentarios de los mismos.
* sismoclient: Es el servicio frontend del proyecto. Realizado en React y consumiendo los endpoints dispuestos por el backend.

## Pasos para inicializar el proyecto

1. Desde la terminal, ubicarse en la raíz del proyecto clonado y ejecutar el comando. Este paso tomará algunos minutos.
   `docker-compose up --build`
2. Crear la base de datos en el servicio sismodb. De forma personal yo he optado por utilizar MySql Workbench para realizar esta creación.
   El nombre de la bd será sismobase en SET utf8 y COLLATE utf8_spanish_ci
  `CREATE SCHEMA 'sismobase' DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;`
3. Si entramos a http://0.0.0.0:5000/ nos saldrá que hay que ejecutar las migraciones pendientes. Esto puede realizarse tambien con el siguiente comando:
   `docker-compose exec sismobase rails db:migrate:primary`
4. Una vez realizadas las migraciones (de features y comentarios). Se puede realizar la tarea para sincronizar los features. Esto se hace con el comando:
   `docker-compose exec sismobase bin/rake features:sync`
   Dicha tarea tomará algunos minutos.
5. Generadas las features, podrá ir a http://172.22.0.3:3000/ , el cual es la url del frontend. En dicha app, podrá visualizar las features y dejar, ir a detalle y dejar comentarios.

## Consideraciones
* En caso la ruta de la app frontend no sea http://172.22.0.3:3000/ , deberá actualizar la url en la linea 18 del archivo `sismobase/config/application.rb` el cuál le da acceso a frontend de acceder al backend
* Los modelos features y comentarios tienen las validaciones necesarias acordes a los requerimientos del ejercicio.
* Los endpoints de backend pueden ser probados con Postman importando la colección sismobase ubicada en `sismobase/Sismobase.postman_collection.json`
