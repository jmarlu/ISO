# Unidades organizativas

Las unidades organizativas son objetos de directorio que contienen **a otros objetos**, pero que cuentan con la particularidad de que se pueden **subordinar** unas a otras. Además, el número de unidades organizativas que se pueden crear en el dominio Active Directory es **ilimitado**. Una vez que se ha creado una es posible poblarla con otros objetos, como usuarios, equipos, grupos y otras unidades organizativas.

Cuando se traslada un objeto contenedor a una nueva ubicación, se trasladan automáticamente todos los objetos incluidos en el contenedor al mismo tiempo y también se modifican las referencias a esos objetos en el resto de objetos del directorio. Cuando se **elimina** un objeto contenedor, **todos los objetos incluidos en el contenedor se eliminan también**. Algo a tener en cuenta es que las políticas de grupo, concepto que se tratará en lo sucesivo, permisos y atributos serán **propagados** al contenido de la unidad organizativa que los ostenta. Es decir, si se aplica cierto conjunto de restricciones a una unidad organizativa, esas restricciones afectará a todos los objetos que contiene.

Volviendo al ejemplo anterior de la pequeña empresa, la organización de los recursos de la empresa no tiene por qué coincidir con los del dominio, aunque si así fuese todo funcionaría de una forma más orgánica. Cada departamento está compuesto por una serie de objetos de dominio: cuentas de usuario, equipos, grupos y recursos compartidos. Una buena organización sería crear una unidad organizativa para cada departamento y que esta contenga todos los objetos que le pertenezcan. Tras dicha organización será mucho más sencillo dotar de permisos a los recursos de un departamento.

Al contrario que ocurre con las cuentas de usuario y los grupos, un objeto de dominio solo puede estar contenido en una única unidad organizativa. Recuerda que **cada objeto es único en todo el directorio**, no se pueden duplicar.

Se puede utilizar la herramienta <span class="menu">Usuarios y equipos de Active Directory</span> para remodelar el árbol en cualquier momento trasladando objetos a diferentes contenedores, cambiándoles el nombre y eliminándolos.

Además de suponer una interesante herramienta para la organización de los objetos del dominio, las unidades organizativas cuentan con la ventaja de poder ostentar conjuntos de directivas de grupo de forma personalizada. Las directivas de grupo son una potente herramienta de administración que será tratada en lo sucesivo. Si se aplica un conjunto de estas directivas, afectarán a todos los objetos que contiene.

En Ubuntu Server estas operaciones también se pueden realizar desde CLI. Además de LDIF, Samba dispone actualmente del subcomando `samba-tool ou` para crear, listar, renombrar, mover y eliminar unidades organizativas.
