# Examen de la Segunda Evaluación

## Ejercicio 1

Genera un script con el nombre `script1.sh` de tal manera que cuando lo ejecutes salgo el siguiente menú:

```bash title=""
 a. Espacio en disco libre (comando df).
 b. Espacio de memoria RAM libre (comando free).
 c. Apagar el sistemas.
 d. Salir.
```

**La opción a**. debe mostrar el porcentaje de disco en uso donde se encuentra instalado el sistema operativo (/). Sólo el porcentaje. **(4pts)**

**La opción b**. debe mostrar la memoria RAM disponible (free). Únicamente la memoria ram, no la de intercambio (swap).**(4pts)**

**La opción c**. debe apagar el sistema.**(1 pts)**

**La opción d**. sale del script. Si no se selecciona la opción correcta mostrará un error de opción incorrecta y volverá a solicitar una opción mostrando de nuevo el menú. **(1pts)**

!!!note

      El menú debe repetirse indefinidamente aunque se escoja una opción correcta. Sólo se debe salir del script al seleccionar la opción “d”. **Si no se produce esta condición no se continua corrigiendo**

## Ejercicio 2

Genera un script con el nombre `script2.sh` que:

- Espere **dos argumentos**, el primero de ellos será un directorio y el segundo un fichero. Se debe comprobar que se han pasado exactamente 2 argumentos y que el primero de ellos es
  un directorio y el segundo un fichero.**Condición para corregir el ejercicio.(2pts)**
- El fichero contendrá la siguiente estructura o similar.

      ```bash
          dir alumnos
          fic notas
          dir profesor
          dir equipos
          fic hola
      ```

- Acto seguido el script debe acceder al directorio pasado como primer argumento y recorrer el fichero pasado como segundo argumento. Por cada línea con dir debe crear un directorio
  con el nombre correspondiente, por cada línea con fic debe crear un fichero con el nombre correspondiente. **(4pts)**
- Al finalizar el script debe de indicar el número de ficheros/directorios creados. Por un lado debe indicar los ficheros creados y por otro los directorios, NO LA SUMA DE AMBOS. Por
  ejemplo Ficheros creados: 2 Directorios creados: 2 **(4pts)**
