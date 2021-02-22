# Ejemplo Politics

[![Build Status](https://travis-ci.com/uqbar-project/eg-politics-springboot.svg?branch=master)](https://travis-ci.com/uqbar-project/eg-politics-springboot)

## Material relacionado

- En el branch `master` está la versión que recomendamos usar para resolver el TP, en el branch `entity-manager` está la versión menos declarativa que usa el Entity Manager como representación de los queries a la base
- [Apunte con la explicación completa](https://docs.google.com/document/d/13vAmPKbWfWpRWze3AhLwnCHfWktfIIXnju3PD_tzyW4/edit)

## Swagger - Open API

Un chiche interesante es que pueden explorar y testear con Swagger el presente ejemplo, levantando la aplicación y navegando en la siguiente URL:

http://localhost:8080/swagger-ui/index.html#/

[Swagger](https://swagger.io/) busca los controllers y arma un entorno web para probar los endpoints (puede resultar más cómodo que POSTMAN sobre todo para métodos POST o PUT).

Para conseguir el mismo efecto en tu proyecto solo tenés que agregar dos dependencias:

```xml
<dependency>
  <groupId>io.springfox</groupId>
  <artifactId>springfox-boot-starter</artifactId>
  <version>3.0.0</version>
</dependency>
<dependency>
  <groupId>io.springfox</groupId>
  <artifactId>springfox-swagger-ui</artifactId>
  <version>3.0.0</version>
</dependency>
```
