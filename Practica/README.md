# Práctica: A Quemar Esas Grasitas

## Dominio :mag:

Se desea desarrollar un sistema para un popular gimnasio que permita predecir el efecto de los ejercicios que realizarían sus socios con las máquinas que dispone. Las máquinas tienen ciertos ejercicios de fábrica (algunos son customizables), los cuales pueden realizarse durante una cantidad de minutos determinada, y sirven para tonificar músculos y/o quemar calorías.

De cada gimnasta nos interesa saber su edad, su peso y su coeficiente de tonificación.

> Para simplificar, representaremos esos valores con números enteros, por ese motivo cuando sea necesario hacer divisiones usaremos división entera `div`, para evitar problemas de tipos que no son relevantes a esta práctica.

Los ejercicios que se pueden hacer en el gimnasio **los modelaremos con funciones** que dada una cantidad de minutos y un gimnasta, retorna al gimnasta luego de realizar dicho ejercicio.

Un ejemplo simple de ejercicio en el cual el gimnasta no hace nada (y por ende queda igual que al principio sin importar cuánto tiempo lo realice) podría ser:

```haskell
relax minutos gimnasta = gimnasta
```

## Precalentamiento :hotsprings:

Declarar el tipo de dato `Gimnasta` como creas conveniente, teniendo en cuenta que debe ser posible comparar dos gimnastas con la función `(==)`.

También se pide explicitar el tipo de la función `relax` y declarar una constante `gimnastaDePrueba` para poder probar el programa.

## Punto 1: Gimnastas saludables :ok_hand:

Necesitamos saber si alguien está saludable, lo cual se cumple si no está obeso y tiene una tonificación mayor a 5. Alguien es obeso si pesa más de 100 kilos.

Definir las funciones para saber si alguien es obeso y si alguien está saludable.

## Punto 2: Quemar calorías :sweat_drops:

Hacer que una función para que un gimnasta queme una cantidad de calorías, y en consecuencia, que baje de peso.

* Si el gimnasta es obeso, baja 1 kilo cada 150 calorías quemadas.
* Si no es obeso pero tiene más de 30 años y las calorías quemadas son más de 200, baja siempre un kilo.
* En cualquier otro caso se baja la cantidad de calorías quemadas dividido por el producto entre el peso y la edad del gimnasta.

## Punto 3: Ejercicios :bicyclist:

Ahora sí, a quemar esas grasitas!

Desarrollar las funciones `pesas`, `caminataEnCinta`, `entrenamientoEnCinta`, `colina` y `montania` sabiendo que queremos usarlas para que un gimnasta ejercite.

### Levantar pesas  :muscle:

Las **pesas** tonifican la décima parte de los kilos a levantar si se realiza por más de 10 minutos, sino nada.

### Ejercicios en cinta  :running:

Cualquier ejercicio que se haga en una cinta quema calorías en función de la velocidad promedio alcanzada durante el ejercicio, quemando 1 caloría por la velocidad promedio por minuto.

* La **caminata** es un ejercicio en cinta con velocidad constante de 5 km/h.
* El **entrenamiento en cinta** arranca en 6 km/h y cada 5 minutos incrementa la velocidad en 1 km/h, con lo cual la velocidad máxima dependerá de los minutos de entrenamiento.

### Escalar :mount_fuji:

La **colina** quema 2 calorías por minuto multiplicado por la inclinación de la colina.

La **montaña** son 2 colinas sucesivas (cada una con la mitad de duración respecto de los minutos totales indicados), donde la segunda colina tiene una inclinación de 3 más que la inclinación inicial elegida. Además de hacer perder peso por las calorías quemadas por las colinas, este ejercicio incrementa en una unidad la tonificación del gimnasta.
