# Actividades

## Introducción

201. Genera un Script que muestre los **procesos del sistema** ordenados por el **id**.

202. Muestra los servicios cuyo nombre empiece por la letra `n`, utilizando la creación de un script.

203. Crea un script que se le introduzca dos números como argumentos y los muestre por pantalla.

204. Diseña un script en Shell que pida al usuario dos números, los guarde en dos variables y los muestre por pantalla.

205. Crea un shell script que muestre por pantalla el resultado de de las siguientes operaciones. Debes tener en cuenta que a, b y c son variables enteras que son preguntadas al usuario al iniciar el script.


    * a%b
    * a/c
    * 2 * b + 3 * (a-c)
    * a * (b/c)
    * (a*c)%b

## Control de flujo

1. Crea un script que si no se la pasa ningún argumento nos lo diga.

2. Crea un script PowerShell que al ejecutarlo muestre por pantalla uno de estos mensajes **“Buenos días”**, **“Buenas tardes”** o **“Buenas noches”**, en función de la hora que sea en el sistema (de 8:00 de la mañana a 15:00 será mañana, de 15:00 a 20:00 será tarde y el resto será noche). Usa el `cmdlet Get-Date`.

3. Construye tres script PowerShell utilizando estructuras iterativas:
4. el primero **ej208A.ps1**, que imprima la **tabla de multiplicar** de un número preguntado al usuario. Este
   número debe ser entero positivo.
5. el segundo **ej208B.ps1**, que pida un número e indique si se trata de un número par y si es número primo.
6. el tercero **ej208C.ps1**, que muestre las diez primeras tablas de multiplicar por pantalla. Hay un tiempo de espera de un segundo entre ellas. Utiliza las estructuras **while, do while, for y foreach y el cmdlet Start-Sleep.**

## Vectores y Funciones

1. Diseña un script PowerShell que lea un vector con 365 temperaturas y calcule la media y cuantos días han estado por encima y cuantos por debajo de ella. Rellena el vector con valores aleatorios entre -5 y 35, para ello usa Get-Random.

2. Crea un script PowerShell para que haga una **copias de seguridad** de todos los archivos del directorio de trabajo del usuario actual. Deberá realizar las siguientes acciones:

   - **comprobará** si el archivo ya existe en la copia de seguridad, si es así comprobará cual de los dos es más reciente y que tamaño tienen. Si es más reciente o posee un tamaño mayor, lo copiará. En cualquier otro caso, no lo copia.
   - llevará un **registro** de todos los archivos copiados cada vez que se ejecute mediante un archivo de bitácora. Guarda este fichero el directorio que contiene el script.

Crea una **función** para cada tarea realizada en este script.

!!! warning

    Utiliza en la generación de los scripts los **cmdlets** de depuración si así lo consideras al haber encontrado problemas en la ejecución.

!!! note "NOTA"

    Escribe el código de los scripts en **PowerShell** que se detallan en cada ejercicio. Deberás crear un fichero de texto para cada ejercicio con el siguiente nombre: ejXXX.sh, donde las X representan el número de ejercicio. Una vez terminada la práctica, comprime todos estos ficheros en uno y súbelos al Moodle.
