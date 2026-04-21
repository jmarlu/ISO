---
search:
  exclude: true
---
# Soluciones UD9. Scripts en Linux

> Borrador de soluciones para revisar antes de publicarlo en la navegacion de los apuntes.
>
> En los scripts se usa `#!/bin/bash`. Si se ejecutan desde terminal, recuerda dar permisos:
>
> ```bash
> chmod u+x nombre_script.sh
> ./nombre_script.sh
> ```

---

## Introduccion

### 1. Crear `~/bin`, script `micomando` y modificar `PATH`

```bash
mkdir -p ~/bin
cd ~/bin
nano micomando
```

Contenido de `micomando`:

```bash
#!/bin/bash
echo "Ejecucion de micomando"
```

Permisos y prueba:

```bash
chmod u+x ~/bin/micomando
export PATH="$PATH:$HOME/bin"
micomando
```

Para que funcione siempre al abrir una terminal:

```bash
echo 'export PATH="$PATH:$HOME/bin"' >> ~/.bashrc
source ~/.bashrc
```

### 2. `Script1_1.sh` y `Script1_1_2.sh`

`Script1_1.sh`:

```bash
#!/bin/bash

echo "Bienvenido, introduce tu nombre y apellidos:"
read nombre
echo "Que tengas un prospero dia $nombre"
```

`Script1_1_2.sh`:

```bash
#!/bin/bash

echo "Inserta un nombre:"
read nombre
echo "Inserta un apellido:"
read apellido
echo "Bienvenido $nombre, tu apellido es $apellido"
```

### 3. `Script1_2.sh`: crear usuario

```bash
#!/bin/bash

echo "Inserta un nombre de usuario:"
read usuario
echo "Inserta una ruta de directorio home:"
read home
echo "Elige un shell de comandos:"
read shell

sudo useradd -m -d "$home" -s "$shell" "$usuario"

if [ $? -eq 0 ]; then
    echo "Usuario creado correctamente."
else
    echo "No se ha podido crear el usuario."
fi
```

### 4. Explicacion de expansiones y comillas

Partimos de un directorio que contiene `f1`, `f2` y `f3`.

```bash
mkdir prueba_echo
cd prueba_echo
touch f1 f2 f3
```

| Comando | Resultado esperado | Explicacion |
| --- | --- | --- |
| `echo \*` | `*` | La barra invertida evita que `*` sea interpretado por el shell. |
| `echo *` | `f1 f2 f3` | El shell expande el comodin con los nombres del directorio. |
| `echo "*"` | `*` | Las comillas dobles evitan la expansion de comodines. |
| `echo '*'` | `*` | Las comillas simples muestran el contenido literalmente. |
| `edad=20` | no muestra nada | Define la variable `edad`. |
| `echo $edad` | `20` | Muestra el valor de la variable. |
| `echo \$edad` | `$edad` | La barra evita la expansion de variable. |
| `echo "$edad"` | `20` | Las comillas dobles permiten expandir variables. |
| `echo '$edad'` | `$edad` | Las comillas simples no expanden variables. |
| `echo "Tu eres $(logname) y tienes -> $edad anos"` | frase completa | Se expande `$(logname)` y `$edad`; `->` queda dentro de las comillas. |
| `echo Tu eres $(logname) y tienes -> $edad anos` | puede crear/vaciar un fichero | Sin comillas, `>` se interpreta como redireccion. Para mostrarlo debe escaparse: `\>`. |

### 5. Tests con cadenas

```bash
s1=si
s2=no
vacia=""
arch1=informe.pdf

[ "$s1" = "$s2" ] && echo "s1 y s2 son iguales" || echo "s1 y s2 son distintos"
[ "$s1" != "$s2" ] && echo "s1 y s2 son distintos"
[ -z "$vacia" ] && echo "vacia esta vacia"
[ -n "$vacia" ] && echo "vacia no esta vacia"
```

### 6. Tests numericos con `[ ]`, `[[ ]]` y `(( ))`

```bash
num1=2
num2=100

[ "$num1" -gt "$num2" ] && echo "$num1 es mayor que $num2" || echo "$num1 no es mayor que $num2"
[[ "$num1" -gt "$num2" ]] && echo "$num1 es mayor que $num2" || echo "$num1 no es mayor que $num2"
(( num1 > num2 )) && echo "$num1 es mayor que $num2" || echo "$num1 no es mayor que $num2"
```

### 7. Operadores logicos y permisos

```bash
> arch
chmod 444 arch
```

Si el archivo no es ejecutable:

```bash
arch=arch

[ ! -x "$arch" ] && echo "Permiso x no indicado"
```

Si el archivo no es ejecutable ni accesible para escritura:

```bash
[ ! -x "$arch" ] && [ ! -w "$arch" ] && echo "Permisos wx no indicados"
[[ ! -x "$arch" && ! -w "$arch" ]] && echo "Permisos wx no indicados"
```

---

## IF

### 1. `Script_IF_1.sh`: par o impar

```bash
#!/bin/bash

echo "Introduce un numero:"
read numero

if (( numero % 2 == 0 )); then
    echo "$numero es par"
else
    echo "$numero es impar"
fi
```

### 2. `Script_IF_2.sh`: calculadora basica

```bash
#!/bin/bash

echo "Introduce un numero:"
read num1
echo "Introduce otro numero:"
read num2
echo "Introduce un signo (+,-,*,/):"
read signo

if [ "$signo" = "+" ]; then
    echo $(( num1 + num2 ))
elif [ "$signo" = "-" ]; then
    echo $(( num1 - num2 ))
elif [ "$signo" = "*" ]; then
    echo $(( num1 * num2 ))
elif [ "$signo" = "/" ]; then
    if [ "$num2" -eq 0 ]; then
        echo "No se puede dividir entre cero"
    else
        echo $(( num1 / num2 ))
    fi
else
    echo "Operacion no valida"
fi
```

### 3. `Script_IF_3.sh`: calculadora con decimales opcionales

```bash
#!/bin/bash

echo "Introduce un numero:"
read num1
echo "Introduce un numero:"
read num2
echo "Introduce un signo (+,-,/,*):"
read signo
echo "Quieres decimales (s/n)?"
read decimales

if [ "$decimales" != "s" ] && [ "$decimales" != "n" ]; then
    echo "no has seleccionado ninguna opcion"
    exit 1
fi

if [ "$signo" = "+" ]; then
    operacion="$num1 + $num2"
elif [ "$signo" = "-" ]; then
    operacion="$num1 - $num2"
elif [ "$signo" = "*" ]; then
    operacion="$num1 * $num2"
elif [ "$signo" = "/" ]; then
    if [ "$num2" -eq 0 ]; then
        echo "No se puede dividir entre cero"
        exit 1
    fi
    operacion="$num1 / $num2"
else
    echo "Operacion no valida"
    exit 1
fi

if [ "$decimales" = "s" ]; then
    echo "scale=6; $operacion" | bc
else
    echo "$operacion" | bc
fi
```

### 4. `Script_IF_4.sh`: herramientas de red

```bash
#!/bin/bash

echo "Introduzca una IP:"
read ip

echo "seleccione una opcion:"
echo "1. ping"
echo "2. traceroute"
echo "3. whois"
read opcion

if [ "$opcion" = "1" ]; then
    ping -c 4 "$ip"
elif [ "$opcion" = "2" ]; then
    traceroute "$ip"
elif [ "$opcion" = "3" ]; then
    whois "$ip"
else
    echo "No has seleccionado ninguna opcion valida"
fi
```

### 5. `Script_IF_5.sh`: tipo de ruta y permisos

```bash
#!/bin/bash

echo "Introduzca una ruta absoluta:"
read ruta

echo "informacion sobre $ruta"

if [ -d "$ruta" ]; then
    echo "1. Es un directorio"
elif [ -f "$ruta" ]; then
    echo "1. Es un fichero"

    if [ -w "$ruta" ]; then
        echo "2. Tiene permisos de escritura"
    fi

    if [ -r "$ruta" ]; then
        echo "3. Tiene permisos de lectura"
    fi

    if [ -x "$ruta" ]; then
        echo "4. Tiene permisos de ejecucion"
    fi
else
    echo "1. no existe"
fi
```

---

## Argumentos

### 1. Propietario y permisos del resto

`scriptArgs_2.sh`:

```bash
#!/bin/bash

if [ $# -ne 1 ]; then
    echo "ERROR NUMERO DE ARGUMENTOS INCORRECTO"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "EL ARGUMENTO DEBE SER UN FICHERO"
    exit 1
fi

propietario=$(stat -c "%U" "$1")
permisos_otros=$(stat -c "%A" "$1" | cut -c8-10)
nombre=$(basename "$1")

echo "El propietario de $nombre es $propietario y los permisos para el resto de los usuarios son $permisos_otros"
```

### 2. UID y shell de un usuario

`scriptArgs_3.sh`:

```bash
#!/bin/bash

if [ $# -ne 1 ]; then
    echo "ERROR, NUMERO DE ARGUMENTOS INCORRECTOS"
    exit 1
fi

linea=$(getent passwd "$1")

if [ -z "$linea" ]; then
    echo "El usuario $1 no existe"
    exit 1
fi

uid=$(echo "$linea" | cut -d: -f3)
shell=$(echo "$linea" | cut -d: -f7)

echo "el uid de $1 es :$uid y tiene el shell $shell"
```

### 3. `blacklist.sh`

```bash
#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Debes pasar un nombre de usuario como argumento"
    exit 1
fi

usuario=$1
fichero="blacklist.txt"
touch "$fichero"

echo "seleccione una opcion"
echo "1. Agregar usuario a blacklist"
echo "2. Eliminar usuario de blacklist."
read opcion

if [ "$opcion" = "1" ]; then
    if grep -qx "$usuario" "$fichero"; then
        echo "Usuario ya bloqueado con anterioridad"
        exit 1
    fi

    echo "$usuario" >> "$fichero"
    sudo usermod -L "$usuario"
    echo "Usuario $usuario bloqueado"
elif [ "$opcion" = "2" ]; then
    sudo usermod -U "$usuario"
    grep -vx "$usuario" "$fichero" > "$fichero.tmp"
    mv "$fichero.tmp" "$fichero"
    echo "Usuario $usuario desbloqueado"
else
    echo "OPCION INCORRECTA"
fi
```

---

## Case y While

### 1. Menu de red con `case` y bucle

```bash
#!/bin/bash

if [ $# -ne 1 ]; then
    echo "ERROR: debes introducir una unica IP como argumento"
    exit 1
fi

ip=$1

while true
do
    echo "Seleccione una opcion:"
    echo "1. ping"
    echo "2. tracepath"
    echo "3. nslookup"
    echo "4. whois"
    echo "5. salir"
    read opcion

    case "$opcion" in
        1) ping -c 4 "$ip" ;;
        2) tracepath "$ip" ;;
        3) nslookup "$ip" ;;
        4) whois "$ip" ;;
        5) exit 0 ;;
        *) echo "OPCION DESCONOCIDA" ;;
    esac
done
```

### 2. Validar credenciales desde `usuarios.log`

Formato esperado de `usuarios.log`, separado por tabuladores:

```text
salva	miContrasena
pepe	1234Password
jose	81237594
```

Script:

```bash
#!/bin/bash

intentos=0

while [ "$intentos" -lt 3 ]
do
    echo "Usuario:"
    read usuario
    echo "Contrasena:"
    read -s password

    if tr '\t' ':' < usuarios.log | grep -qx "$usuario:$password"; then
        echo "Bienvenido $usuario"
        exit 0
    fi

    intentos=$(( intentos + 1 ))
done

echo "Usuario Incorrecto"
exit 1
```

### 3. `CrearUsuarios.sh`

```bash
#!/bin/bash

fichero="cuentas.log"
touch "$fichero"

while true
do
    echo "a. Log in."
    echo "b. Registrarse."
    echo "c. Salir."
    read opcion

    case "$opcion" in
        a)
            intentos=0
            while [ "$intentos" -lt 3 ]
            do
                echo "Usuario:"
                read usuario
                echo "Contrasena:"
                read -s password

                if grep -qx "$usuario $password" "$fichero"; then
                    echo "Bienvenido $usuario"
                    exit 0
                else
                    echo "Login Incorrecto"
                    intentos=$(( intentos + 1 ))
                fi
            done
            ;;
        b)
            echo "Nombre de usuario:"
            read usuario
            echo "Contrasena:"
            read -s pass1
            echo "Repite la contrasena:"
            read -s pass2

            if [ "$pass1" != "$pass2" ]; then
                echo "Contrasenas no coinciden"
            else
                echo "$usuario $pass1" >> "$fichero"
            fi
            ;;
        c)
            exit 0
            ;;
        *)
            echo "OPCION INCORRECTA"
            ;;
    esac
done
```

---

## For

### 1. Traza de `ejemploContinue.sh`

Ejecutado exactamente como indica el enunciado:

```bash
bash ./ejemploContinue.sh
```

el script falla porque no se pasa `$1`. Ademas, la condicion tiene un error de sintaxis: falta un espacio antes de `]`.

Linea incorrecta:

```bash
if [ $resto -ne 0]
```

Linea corregida:

```bash
if [ "$resto" -ne 0 ]
```

Version corregida del script:

```bash
#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Uso: $0 numero"
    exit 1
fi

echo "A continuacion solo mostraremos los numeros divisibles del 1 al 10 de $1"

for (( i=1; i<=10; i++ ))
do
    resto=$(( i % $1 ))
    if [ "$resto" -ne 0 ]; then
        continue
    fi
    echo "$i"
done
```

Traza de ejemplo con `bash ./ejemploContinue.sh 2`:

| Iteracion | `$i` | `$resto` | Accion |
| --- | --- | --- | --- |
| 1 | 1 | 1 | No divisible, ejecuta `continue`, no muestra nada. |
| 2 | 2 | 0 | Divisible, muestra `2`. |
| 3 | 3 | 1 | No divisible, ejecuta `continue`, no muestra nada. |
| 4 | 4 | 0 | Divisible, muestra `4`. |
| 5 | 5 | 1 | No divisible, ejecuta `continue`, no muestra nada. |
| 6 | 6 | 0 | Divisible, muestra `6`. |
| 7 | 7 | 1 | No divisible, ejecuta `continue`, no muestra nada. |
| 8 | 8 | 0 | Divisible, muestra `8`. |
| 9 | 9 | 1 | No divisible, ejecuta `continue`, no muestra nada. |
| 10 | 10 | 0 | Divisible, muestra `10`. |

### 2. Expiracion de contrasenas desde `expira.log`

`expira.log` contiene un usuario por linea:

```text
usuario1
usuario2
usuario3
```

Script:

```bash
#!/bin/bash

if [ $# -ne 1 ]; then
    echo "ERROR: debes pasar el numero de dias como argumento"
    exit 1
fi

dias=$1
mapfile -t usuarios < expira.log

for (( i=0; i<${#usuarios[@]}; i++ ))
do
    usuario=${usuarios[$i]}
    if [ -n "$usuario" ]; then
        sudo chage -M "$dias" "$usuario"
        echo "Configurada expiracion de $usuario a $dias dias"
    fi
done
```

### 3. Tabla de asteriscos con `for (( ... ))`

```bash
#!/bin/bash

if [ $# -ne 2 ]; then
    echo "ERROR: debes pasar filas y columnas"
    exit 1
fi

filas=$1
columnas=$2

for (( i=1; i<=filas; i++ ))
do
    for (( j=1; j<=columnas; j++ ))
    do
        echo -n "* "
    done
    echo
done
```

---

## ForIn

### 1. Dar ejecucion al grupo solo en ficheros

```bash
#!/bin/bash

for elemento in *
do
    if [ -f "$elemento" ]; then
        chmod g+x "$elemento"
    fi
done

ls -l
```

### 2. Mover o copiar ficheros por extension

```bash
#!/bin/bash

if [ $# -ne 3 ]; then
    echo "ERROR: debes pasar extension, directorio origen y directorio destino"
    exit 1
fi

extension=$1
origen=$2
destino=$3

if [ ! -d "$origen" ] || [ ! -d "$destino" ]; then
    echo "ERROR: el segundo y tercer argumento deben ser directorios"
    exit 1
fi

echo "Selecciona una opcion:"
echo "1. mover"
echo "2. copiar"
read opcion

case "$opcion" in
    1|mover)
        for fichero in "$origen"/*."$extension"
        do
            [ -f "$fichero" ] && mv "$fichero" "$destino/"
        done
        ;;
    2|copiar)
        for fichero in "$origen"/*."$extension"
        do
            [ -f "$fichero" ] && cp "$fichero" "$destino/"
        done
        ;;
    *)
        echo "OPCION INCORRECTA"
        ;;
esac
```

### 3. Alertas desde `equipos.txt`

Formato esperado:

```text
192.168.1.10 equipo1 50 8
192.168.1.11 equipo2 10 4
192.168.1.12 equipo3 120 16
```

Script:

```bash
#!/bin/bash

if [ $# -ne 1 ]; then
    echo "ERROR: debes introducir una capacidad minima"
    exit 1
fi

minimo=$1

while read ip nombre disco ram
do
    if [ -n "$ip" ] && [ "$disco" -lt "$minimo" ]; then
        echo "ALERTA: $nombre ($ip) solo tiene $disco GB libres de disco. RAM total: $ram GB"
    fi
done < equipos.txt
```

### 4. `creaUsuarios.sh` con SSH

Preparacion de la maquina base:

```bash
sudo apt update
sudo apt install -y ssh sshpass openssh-server
sudo service ssh start
sudo nano /etc/ssh/sshd_config
```

En `/etc/ssh/sshd_config`:

```text
PermitRootLogin yes
```

Despues:

```bash
sudo service ssh restart
sudo passwd root
```

`hosts.txt`:

```text
192.168.1.101
192.168.1.102
192.168.1.103
```

`usuarios.txt`:

```text
usuario1
usuario2
usuario3
```

`creaUsuarios.sh`:

```bash
#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Uso: $0 contrasena_root"
    exit 1
fi

password_root=$1

for host in $(cat hosts.txt)
do
    for usuario in $(cat usuarios.txt)
    do
        echo "Configurando $usuario en $host"
        sshpass -p "$password_root" ssh -o StrictHostKeyChecking=no root@"$host" "userdel -r '$usuario' 2>/dev/null; useradd -m -s /bin/bash '$usuario'"
    done
done
```

Comprobacion:

```bash
bash creaUsuarios.sh CONTRASENA_ROOT
```

!!! warning

    `PermitRootLogin yes` y `sshpass` se usan aqui solo para la practica. En un entorno real se debe usar autenticacion con claves SSH, cuentas nominales y `sudo`.
