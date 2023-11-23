# Variables de entorno

En cualquier sistema operativo, las variables de entorno son un conjunto de valores que obtienen su valor de forma dinámica durante la sesión del usuario. De esta forma cualquier proceso, programa o incluso usuario puede hacer referencia a estas variables de entorno y ellas contener un valor distinto en cada sesión.

Verbigracia, la variable de entorno **%USERNAME%** contendrá el nombre de usuario que ha iniciado la sesión actual. Al finalizar esta sesión y ser iniciada por otro usuario, el valor de esta variable cambiará por el nombre del nuevo usuario, pero su denominación seguirá intacta. De esta forma se puede acceder a información que va cambiando a lo largo del tiempo de ejecución a través de una sola variable.

Este tipo de variables se usarán profusamente en la unidad destinada a procesos por lotes y shellscript, pero que también son importantes en el apartado actual. Un ejemplo de ello es la configuración de la carpeta personal. Si en lugar de utilizar el nombre de un usuario en concreto para crear su carpeta personal se usa la variable de entorno que lo contiene, **%USERNAME%** en este caso, en cada inicio de sesión cambiará esta variable por el nombre del usuario
`\\servidor\nombre_carpeta_compartida\%USERNAME%
`
Se dispone de numerosas variables de entorno, de entre las que destacan, para los sistemas operativos Microsoft Windows:

- `%homedrive%` , letra de la unidad de disco que contiene el directorio principal del sistema operativo. Normalmente C:.
- `%homepath%` ruta de acceso absoluta al directorio principal del usuario.
- `%os%` nombre del sistema operativo del usuario.
- `%processor_architecture%` tipo de arquitectura del equipo del usuario.
- `%userdomain%` nombre del dominio donde existe la cuenta del usuario.
- `%username%` nombre del usuario de la cuenta.
- `%path%` rutas de los ficheros ejecutables.

Para los sistemas operativos basados en GNU/Linux se dispone de , entre otras:

- `$SHELL`, el tipo de shell en uso actualmente.
- `$TERM`, el tipo de terminal.
- `$USER`, el nombre de usuario.
- `$PWD`, la ruta absoluta actual del usuario en el sistema de archivos.
- `$LANG`, el juego de caracteres de idioma que emplea el usuario.
- `$DESKTOP_SESSION`, el tipo de entorno de escritorio.
- `$PATH`, las rutas de los ficheros ejecutables.

Es posible comprobar el valor de estas variables de entorno. Abriendo un terminal y escribiendo la palabra echo seguida del nombre de la variable a continuación

```bash title=""
echo %path%
echo $PATH
```

Este tipo de variables se pueden crear en función de las necesidades del sistema ya que alguno programas pueden usar estas variables para personalizar la experiencia que ofrecen al usuario. Esta tarea se puede realizar tanto en sistemas operativos de Microsoft Windows como los basados en GNU/Linux, no obstante es una cuestión que excede de las pretensiones de este manual.
