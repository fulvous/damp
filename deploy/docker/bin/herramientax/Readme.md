Herramientax
===

1. Copia herramientax al directorio raiz de tu script

2. Importar de la siguiente manera:

```
 real_path=$(dirname $(readlink -f $0))
 
 for i in $( find ${real_path}/herramientax/libs -type f ) ; do
  source $i
 done

```


