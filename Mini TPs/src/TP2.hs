module TP2 where
import Video

-- Definir las funciones de acuerdo a lo indicado en las consignas del TP2
-- y explicitar su tipo

esMasLargo :: Video -> Video -> Bool
esMasLargo primerVideo segundoVideo = duracion primerVideo > duracion segundoVideo

duracionEnMinutos :: Video -> Int
duracionEnMinutos unVideo = obtenerDuracionEnMinutos (duracion unVideo)


obtenerDuracionEnMinutos :: (Int, Int, Int) -> Int  -- Funcion #1
obtenerDuracionEnMinutos (horas,minutos,_) = horasAMinutos horas + minutos


horasAMinutos :: Int -> Int
horasAMinutos horas = horas * 60

porcentajeDeReproduccionPromedio :: Int -> (Int, Int, Int) -> Video -> Int
porcentajeDeReproduccionPromedio cantVisitas tiempoTotal unVideo = ((obtenerDuracionEnMinutos tiempoTotal) * 100 `div` cantVisitas) `div` duracionEnMinutos unVideo