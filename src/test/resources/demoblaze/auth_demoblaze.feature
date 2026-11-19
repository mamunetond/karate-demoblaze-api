Feature: Pruebas de servicios REST Signup y Login en Demoblaze

  Background:
    * url baseUrl
    * header Content-Type = 'application/json'
    * def toBase64 =
      """
      function(texto) {
        var Base64 = Java.type('java.util.Base64');
        return Base64.getEncoder().encodeToString(texto.getBytes('UTF-8'));
      }
      """
    * def passwordValido = toBase64('ClaveSegura2026!')

  Scenario: 1. Crear un nuevo usuario en signup
    * def usuarioNuevo = 'qa_user_' + java.util.UUID.randomUUID()
    * def payloadEntrada = { username: '#(usuarioNuevo)', password: '#(passwordValido)' }
    * print 'ENTRADA [Signup Usuario Nuevo]:', payloadEntrada

    Given path '/signup'
    And request payloadEntrada
    When method post
    Then status 200
    * print 'SALIDA [Signup Usuario Nuevo] - Status:', responseStatus, '| Body:', response
    And match response.trim() == '""'

  Scenario: 2. Intentar crear un usuario ya existente en signup
    # Precondición: registrar el usuario por primera vez
    * def usuarioDuplicado = 'qa_dup_' + java.util.UUID.randomUUID()
    * def payloadEntrada = { username: '#(usuarioDuplicado)', password: '#(passwordValido)' }
    Given path '/signup'
    And request payloadEntrada
    When method post
    Then status 200

    # Ejecución del caso: intentar registrar nuevamente el mismo usuario
    * print 'ENTRADA [Signup Usuario Existente]:', payloadEntrada
    Given path '/signup'
    And request payloadEntrada
    When method post
    Then status 200
    * print 'SALIDA [Signup Usuario Existente] - Status:', responseStatus, '| Body:', response
    And match response == { errorMessage: 'This user already exist.' }

  Scenario: 3. Usuario y password correcto en login
    # Precondición: crear usuario válido para autenticar
    * def usuarioValido = 'qa_login_' + java.util.UUID.randomUUID()
    * def payloadEntrada = { username: '#(usuarioValido)', password: '#(passwordValido)' }
    Given path '/signup'
    And request payloadEntrada
    When method post
    Then status 200

    # Ejecución del caso: login con credenciales correctas
    * print 'ENTRADA [Login Correcto]:', payloadEntrada
    Given path '/login'
    And request payloadEntrada
    When method post
    Then status 200
    * print 'SALIDA [Login Correcto] - Status:', responseStatus, '| Body:', response
    And match response contains 'Auth_token:'

  Scenario: 4. Usuario y password incorrecto en login
    # Precondición: crear usuario válido para probar contraseña errónea
    * def usuarioRegistrado = 'qa_badpass_' + java.util.UUID.randomUUID()
    * def payloadRegistro = { username: '#(usuarioRegistrado)', password: '#(passwordValido)' }
    Given path '/signup'
    And request payloadRegistro
    When method post
    Then status 200

    # Ejecución del caso: login con contraseña incorrecta
    * def passwordErroneo = toBase64('PasswordIncorrecto999')
    * def payloadLoginInvalido = { username: '#(usuarioRegistrado)', password: '#(passwordErroneo)' }
    * print 'ENTRADA [Login Incorrecto]:', payloadLoginInvalido

    Given path '/login'
    And request payloadLoginInvalido
    When method post
    Then status 200
    * print 'SALIDA [Login Incorrecto] - Status:', responseStatus, '| Body:', response
    And match response == { errorMessage: 'Wrong password.' }