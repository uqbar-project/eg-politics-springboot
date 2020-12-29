# Primer ejemplo Servicio REST: Saludo con Springboot

[![Build Status](https://travis-ci.com/algo3-unsam/tp-recetas-2020-gr-XX.svg?branch=master)](https://travis-ci.com/algo3-unsam/tp-recetas-2020-gr-XX)

## Cosas a hablar


### Lazyness

Failed to lazily initialize a collection of role... porque cambiamos el openInView. Las estrategias son

- armar un DTO a mano: es lo que hacemos cuando buscamos las zonas
- definir un serializer: para traer una zona seleccionada con candidatos y el partido, como alternativa tenemos una configuración default para la zona pero eso afecta a todos los queries.
- armar un @EntityGraph, que trae automáticamente todos los campos lazy y permite que el serializador default de Spring Boot no reviente.

