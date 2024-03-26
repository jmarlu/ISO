# Power Shell

## Introducción

- Los sistemas operativos basados en Microsoft Windows cuentan con la herramienta **PowerShell**, que surgió ante las carencias que presenta el viejo terminal basado en **MS-DOS**.
- **PowerShell** es una interfaz de consola (CLI) con posibilidad de escritura y unión de comandos por medio de instrucciones (scripts).
- Esta interfaz de consola está diseñada para su uso por parte de **administradores de sistemas**, con el propósito de automatizar tareas o realizarlas de forma más controlada.
- En abril de 2006 Microsoft lanzó una nueva interfaz CLI, con una sintaxis moderna que comparte similitudes con el lenguaje Perl.
  - **Perl** es un lenguaje de programación diseñado por Larry Wall en 1987. Perl toma características del lenguaje C, del lenguaje interpretado bourne shell, AWK, sed, Lisp y, en un grado inferior, de muchos otros lenguajes de programación.
- Se trata de una interfaz gratuita, y que antes de Microsoft **Windows 7** no se incluía con el sistema operativo.
- En la actualidad, está incluida en todos los sistemas operativos de Microsoft, aunque requiere la presencia de `.NET` framework del que hereda sus características orientadas a objetos.
- En agosto de 2016, Microsoft publicó su código en GitHub para que pueda portarse a otros sistemas como GNU/Linux y MAC OSX.

!!! info

    **cmdlets** Existen cientos de cdmlet en la _versión 5.1_ de PowerShell. Es posible consultar la ayuda de cada uno de ellos en la página oficial de Microsoft.

## Primer Script

- Al igual que ocurre en GNU/Linux un script de PowerShell no es más que un archivo de texto plano que contiene una secuencia de comando y de **cmdlets** para realizar una tarea.
- La diferencia con ellos es que aquí será necesario dotarlos de una extensión; `ps1`.

!!! example

    ``` PowerShell
        Write-Host "Hola!. Esto es mi primer script en PowerShell"
        Write-Host "Y esto es una segunda línea"
    ```

- A continuación, se guarda el script desde el menú `Acción → Guardar Como…` asignándole un nombre.
- Para ejecutarlo tan sólo es necesario escribir su nombre en el terminal de PowerShell anteponiendo un punto y una barra.

!!! example

    ``` PowerShell
      ./Script.ps1
    ```

## PowerShell ISE

- PowerShell viene acompañado de una **herramienta gráfica** que facilita la administración de todos los scripts. Se denomina Microsoft **PowerShell ISE (Integrated Scripting Environment)**, y se accede a través de: `Administrador del servidor → Herramientas → Windows PowerShell ISE`.
- El uso de esta herramienta gráfica va a facilitar la creación de los scripts de forma significativa.
- Es práctico comenzar con esta ayuda ya que la sintaxis de los cmdlets, aunque sea lógica y sencilla, también lo es amplia y desconocida.

<figure>
  <img src="../imagenes/02/InterfazPowerShell.png" width="800"/>
  <figcaption>Interfaz de la herramienta Windows PowerShell ISE</figcaption>
</figure>

!!! info

    - Uno de los aspectos más interesantes que posee esta aplicación es la barra de información que muestra un listado de todos los **cmdlets** de esta herramienta. Permite filtrarlos por función y consultar la ayuda de cada uno de ellos.
    - También posee un formulario destinado a generar el código de un **cmdlet** de forma automática.

!!! example

    - Creación de un comando que realice una copia de seguridad de los scripts de trabajo en una memoria externa. Es necesario el uso de Copy-Item para ello, pero no se conoce su sintaxis.
    - Si escribimos este **cmdlet** en el recuadro `Nombre` y se pulsa sobre `Mostrar Ayuda`, aparecerá un formulario con sus opciones. Tras completar las necesarias y pulsando el botón `Insertar` situado en la parte inferior, el código completo será escrito la parte destinada al terminal.

<figure>
  <img src="../imagenes/02/PS_ISE_EJEM.png" width="800"/>
  <figcaption>Creación automática de scripts en Windows PowerShell ISE.</figcaption>
</figure>

- Es posible ejecutar el script desde la **herramienta gráfica** pulsando la tecla `F5`, ejecutar una parte de él con `F8` o detener la ejecución con `Ctrl+Intro`.

## Comentarios

!!! note

    Los comentarios en **PowerShell** se realizan precediendo a la línea con el carácter `#` si se trata de una sola línea y `<#` y `#>` si es multi-línea.

## Depuración

- La depuración es el proceso de examinar un script mientras se ejecuta para identificar y corregir errores en las instrucciones del script.
- El depurador de PowerShell puede ayudarle a examinar e identificar errores e ineficiencias en los scripts, funciones, comandos, configuraciones o expresiones de PowerShell Desired State Configuration (DSC).

El depurador de PowerShell incluye el siguiente conjunto de cmdlets:

- **Set-PSBreakpoint**: establece puntos de interrupción en líneas, variables y comandos.
- **Get-PSBreakpoint**: obtiene puntos de interrupción en la sesión actual.
- **Disable-PSBreakpoint**: desactiva los puntos de interrupción en la sesión actual.
- **Enable-PSBreakpoint**: vuelve a habilitar los puntos de interrupción en la sesión actual.
- **Remove-PSBreakpoint**: elimina puntos de interrupción de la sesión actual.
- **Get-PSCallStack**: muestra la pila de llamadas actual.
