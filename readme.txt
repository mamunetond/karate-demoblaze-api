================================================================================
PROYECTO: Pruebas de Servicios REST Signup y Login - Demoblaze (Karate DSL)
================================================================================

1. DESCRIPCIÓN
   Automatización de pruebas funcionales sobre los servicios REST de registro y
   autenticación de la plataforma https://www.demoblaze.com/ utilizando Karate DSL
   y JUnit 5.

   Endpoints y escenarios cubiertos:
   - POST https://api.demoblaze.com/signup
     * Caso 1: Creación exitosa de un nuevo usuario.
     * Caso 2: Intento de creación de un usuario ya existente.
   - POST https://api.demoblaze.com/login
     * Caso 3: Autenticación con usuario y contraseña correctos.
     * Caso 4: Autenticación con usuario y contraseña incorrectos.

2. PRERREQUISITOS DEL ENTORNO
   - Java JDK 17 o superior configurado en la variable de entorno JAVA_HOME.
   - Apache Maven 3.8 o superior configurado en la variable PATH.
   - Conexión a internet para la descarga de dependencias Maven y consumo de la API.

3. ESTRUCTURA DEL REPOSITORIO
   karate-demoblaze-api/
   ├── pom.xml                                              # Dependencias y plugins Maven
   ├── readme.txt                                           # Guía de instalación y ejecución
   ├── conclusiones.txt                                     # Hallazgos técnicos y conclusiones
   ├── src/test/java/
   │   ├── karate-config.js                                 # Configuración de URL base y timeouts
   │   └── demoblaze/DemoblazeTest.java                     # Ejecutor JUnit 5 para Karate
   ├── src/test/resources/demoblaze/
   │   └── auth_demoblaze.feature                           # Escenarios y aserciones REST
   └── target/karate-reports/karate-summary.html            # Reporte HTML con evidencias

4. INSTRUCCIONES DE EJECUCIÓN PASO A PASO
   Paso 1: Clonar el repositorio público en su equipo local:
           git clone https://github.com/mamunetond/karate-demoblaze-api.git

   Paso 2: Ingresar al directorio raíz del proyecto:
           cd karate-demoblaze-api

   Paso 3: Ejecutar la suite de pruebas de servicios REST:
           mvn test

   Paso 4: Visualizar el reporte de resultados con las entradas y salidas capturadas:
           Abrir en cualquier navegador web el archivo:
           target/karate-reports/karate-summary.html