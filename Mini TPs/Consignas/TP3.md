# Consigna TP3: Composición y Aplicación Parcial

## Objetivos

- Definir funciones en términos de otras funciones, usando composición y aplicación parcial.
- Resolver problemas complejos combinando adecuadamente funciones más chicas.

## Cafetería

Tenemos un programa que cuenta con las siguientes abstracciones.

```haskell
data Cafe = Cafe {
  intensidad :: Int,
  temperatura :: Int,
  ml :: Int
} deriving (Show, Eq)


molerGranos :: Gramos -> Gramos
prepararCafe :: Agua -> Gramos -> Cafe
servirEnVaso :: Vaso -> Cafe -> Cafe
licuar :: Segundos -> Leche -> Cafe -> Cafe
agregarHielo :: Hielos -> Cafe -> Cafe
```

La implementación de esas funciones ya está resuelta y no es relevante para el problema a resolver, pero a partir de las mismas queremos armar otras funciones que sirvan para determinar cómo saldrá el café de una máquina.

Definir las siguientes funciones en el archivo `src/TP3.hs`:

 - `armarCafe :: Vaso -> Gramos -> Cafe` que muela los gramos de café, luego prepare el café en una cafetera con 1000 ml de agua y finalmente lo sirva en el vaso del tamaño indicado.

 - `armarFrapu :: Gramos -> Cafe` que muela los gramos de café, luego prepare el café con sólo 80 ml de agua, le agregue 6 hielos, lo licúe durante 60 segundos con 120 ml de leche y finalmente lo sirva en un vaso de 400 ml.

> Las funciones `armarFrapu` y `armarCafe` deben definirse combinando las funciones provistas de modo que se aprovechen los conceptos de composición y aplicación parcial.

> Todos los tipos que se mencionan más allá de Cafe son simplemente un alias de Int, a modo orientantivo.
