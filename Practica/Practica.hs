module Practica where

---------------------------
-- Precalentamiento
---------------------------

-- Declarar el tipo de dato Gimnasta
data Gimnasta = UnGimnasta {
    edad :: Int,
    peso :: Int,
    tonificacion :: Int
} deriving (Show, Eq) 

type Ejercicio = Int -> Gimnasta -> Gimnasta  -- Usado por la profe :D



-- Explicitar el tipo de esta función en base al uso esperado:
relax :: Ejercicio
relax minutos gimnasta = gimnasta



-- Declarar la constante gimnastaDePrueba de tipo Gimnasta, para usarlo desde las pruebas (Spec.hs) y/o desde la consola
gimnastaDePrueba :: Gimnasta
gimnastaDePrueba = UnGimnasta 22 75 10
gimnastaDePrueba' = UnGimnasta {tonificacion = 10, peso = 75, edad = 22} -- Mas expresivo y Maleable (by Profe)

-------------------------------------
-- Punto 1: Gimnastas saludables
-------------------------------------
esObeso :: Gimnasta -> Bool
esObeso unGimnasta = peso unGimnasta > 100
--esObeso = (>100) . peso -- Forma Infija (by Profe)

tonificacionMayor5 :: Gimnasta -> Bool
tonificacionMayor5 unGimnasta = tonificacion unGimnasta > 5
--tonificacionMayor5 = (>5) . tonificacion -- Forma Infija (by Profe)

estaSaludable :: Gimnasta -> Bool
estaSaludable unGimnasta = not (esObeso unGimnasta) && tonificacionMayor5 unGimnasta
--estaSaludable unGimnasta = (not.esObeso) unGimnasta && tonificacionMayor5 unGimnasta --Forma Infija (by Profe)
---------------------------
-- Punto 2: Quemar calorías
---------------------------
quemarCalorias :: Int -> Gimnasta -> Gimnasta
quemarCalorias calorias gimnasta
    | esObeso gimnasta = bajarPeso gimnasta . div calorias $ 150
    | edad gimnasta > 30 && calorias > 200 = bajarPeso gimnasta 1
    | otherwise = bajarPeso gimnasta . div calorias $ (peso gimnasta * edad gimnasta)

bajarPeso :: Gimnasta -> Int -> Gimnasta
bajarPeso gimnasta kilos = gimnasta{peso = peso gimnasta - kilos}


---------------------------
-- Punto 3: Ejercicios
---------------------------
pesas :: Int -> Ejercicio
pesas kilos minutos gimnasta
    | minutos > 10 = tonificar gimnasta  . div kilos $ 10
    | otherwise = gimnasta

tonificar :: Gimnasta -> Int -> Gimnasta
tonificar gimnasta tonificacionGanada = gimnasta{tonificacion = tonificacion gimnasta + tonificacionGanada}

------------------------------------------------------------------------

ejercicioEnCinta :: Int -> Ejercicio
ejercicioEnCinta velPromedio minutos = quemarCalorias (minutos * velPromedio)

caminataEnCinta :: Ejercicio
caminataEnCinta = ejercicioEnCinta 5

entrenamientoEnCinta :: Ejercicio
entrenamientoEnCinta minutos = ejercicioEnCinta velocidadPromedio minutos
    where 
        velocidadInicial = 6
        velocidadFinal = velocidadInicial + minutos `div` 5
        velocidadPromedio = (velocidadFinal - velocidadInicial) `div` 2

---------------------------------------------------------------
colina :: Int -> Ejercicio
colina inclinacionColina minuto = quemarCalorias (2 * minuto * inclinacionColina)

montania :: Int -> Ejercicio
montania inclinacionColina minuto  = flip tonificar 1 . colina (inclinacionColina + 3) (minuto `div` 2) . colina inclinacionColina (minuto `div` 2)


