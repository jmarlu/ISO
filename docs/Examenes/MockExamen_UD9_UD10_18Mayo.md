# Mock examen UD9 y UD10

**Fecha del examen real:** 18 de mayo  
**Duración:** 2 horas  
**Valor total:** 10 puntos

!!! note "Entrega"

    Debéis entregar los ficheros solicitados en cada ejercicio. Los scripts deben ejecutarse sin errores y deben incluir comentarios breves cuando sea necesario para entender el código.

## Ejercicio 1. Control básico de rutas y permisos en Bash (3 puntos)

Genera un script con el nombre `ejercicio1.sh`.

El script debe pedir al usuario por teclado una ruta absoluta y realizar las siguientes comprobaciones:

- Si la ruta no existe, debe mostrar el mensaje `La ruta no existe` y terminar. **(0,5 pts)**
- Si la ruta es un directorio, debe mostrar `Es un directorio` y listar su contenido con `ls -la`. **(0,75 pts)**
- Si la ruta es un fichero, debe mostrar `Es un fichero` y comprobar sus permisos para el usuario actual. **(0,75 pts)**
- Para los ficheros, debe indicar únicamente los permisos que tenga activos: lectura, escritura y ejecución. Si no tiene un permiso, no debe mostrar nada sobre ese permiso. **(0,75 pts)**
- El script debe tener permisos de ejecución y usar correctamente la estructura `if`, `elif`, `else`. **(0,25 pts)**

Ejemplo de ejecución:

```bash title="Uso"
./ejercicio1.sh
Introduce una ruta absoluta: /home/usuario/prueba.txt
Es un fichero
Tiene permiso de lectura
Tiene permiso de escritura
```

## Ejercicio 2. Creación de estructura desde fichero en Bash (6 puntos)

Genera un script con el nombre `ejercicio2.sh`.

El script recibirá exactamente dos argumentos:

1. Un directorio de trabajo.
2. Un fichero de configuración.

El fichero de configuración tendrá una estructura similar a la siguiente:

```bash title="estructura.txt"
dir alumnos
dir profesores
fic notas.txt
fic resumen.txt
perm notas.txt 640
perm resumen.txt 600
```

El script debe cumplir los siguientes requisitos:

- Comprobar que se han recibido exactamente dos argumentos. Si no se cumple, debe mostrar `ERROR: número de argumentos incorrecto` y terminar. **(0,75 pts)**
- Comprobar que el primer argumento es un directorio y que el segundo argumento es un fichero. Si no se cumple, debe mostrar un error claro y terminar. **(0,75 pts)**
- Leer el fichero línea por línea. **(0,75 pts)**
- Por cada línea que empiece por `dir`, crear el directorio indicado dentro del directorio de trabajo. **(1 pts)**
- Por cada línea que empiece por `fic`, crear el fichero indicado dentro del directorio de trabajo. **(1 pts)**
- Por cada línea que empiece por `perm`, aplicar los permisos indicados al fichero o directorio correspondiente dentro del directorio de trabajo. **(1 pts)**
- Al finalizar, mostrar por pantalla el número de directorios creados, el número de ficheros creados y el número de cambios de permisos realizados. **(0,75 pts)**

Ejemplo de ejecución:

```bash title="Uso"
./ejercicio2.sh /home/usuario/examen estructura.txt
Directorios creados: 2
Ficheros creados: 2
Permisos modificados: 2
```

!!! warning

    Si el script no valida correctamente los dos argumentos iniciales, no se continuará corrigiendo el resto del ejercicio.

## Ejercicio 3. Comandos con tuberías en PowerShell (1 punto)

Resuelve el ejercicio directamente en la consola de PowerShell, utilizando una sucesión de comandos enlazados mediante tuberías.

El objetivo es obtener un listado de los procesos del sistema y mostrar únicamente la información relevante para identificar los procesos que más memoria están consumiendo.

- Debe obtener los procesos del sistema. **(0,25 pts)**
- Debe ordenar los resultados por consumo de memoria, de mayor a menor. **(0,25 pts)**
- Debe mostrar únicamente los 10 primeros resultados. **(0,25 pts)**
- La salida debe mostrar solo el nombre del proceso, su identificador y la memoria consumida. **(0,25 pts)**

!!! note "Entrega"

    Debéis entregar una captura o un fichero de texto con la línea de comandos utilizada y la salida obtenida. No se pide crear un script `.ps1`.

!!! note "Puntuación"

    - Ejercicio 1: 3 puntos
    - Ejercicio 2: 6 puntos
    - Ejercicio 3: 1 punto
    - Total: 10 puntos
