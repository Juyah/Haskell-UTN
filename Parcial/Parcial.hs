{-
Nombre: Yarbuh, Juan Ignacio
Legajo: 169077-2
-}

module Parcial where
import Text.Show.Functions

----------------------
-- Código inicial
----------------------

maximoSegun :: Ord a => (b -> a) -> [b] -> b
maximoSegun f = foldl1 (mayorSegun f)

mayorSegun :: Ord a => (p -> a) -> p -> p -> p
mayorSegun f a b
  | f a > f b = a
  | otherwise = b

-- Esto inicialmente es esperable que no compile
-- porque no existen los tipos Rol y Participante.
-- Definilos en el punto 1a
data Desafio = Desafio {
    rolesDisponibles :: [Rol],
    pruebaASuperar :: Participante -> Bool
  }

----------------------------------------------
-- Definí tus tipos de datos y funciones aquí
-- indicando a qué punto pertenecen
----------------------------------------------

-- Punto 1a
data Participante = UnParticipante{
  nombre :: String,
  experiencia :: Int,
  inteligencia :: Int,
  destrezaFisica :: Int,
  rol :: Rol
} deriving (Show)

type Rol = Participante -> Int

rolIndeterminado :: Rol
rolIndeterminado persona = inteligencia persona + destrezaFisica persona

rolSoporte :: Rol
rolSoporte persona = 7 * inteligencia persona + experiencia persona

rolPrimeraLinea :: Int -> Participante -> Int
rolPrimeraLinea potenciaArma persona =  (*) (experiencia persona `div` 100) . (+) (destrezaFisica persona) $ potenciaArma

-- Punto 1b
participantePrueba :: Participante
participantePrueba = UnParticipante {
  nombre = "Carlos",
  experiencia = 10,
  inteligencia = 20,
  destrezaFisica = 12,
  rol = rolIndeterminado
}

-- Punto 1c
poderDelParticipante :: Participante -> Int
poderDelParticipante persona = experiencia persona * rol persona persona

-- Punto 1d
rolEscudo :: Int -> Rol
rolEscudo calidadEscudo persona = destrezaFisica persona * 5 + calidadEscudo * 10
{-
No desarrolle ningun cambio porque la forma en que se crean los roles son en funcinoes, por lo que
se pueden añadir de manera muy sencilla.
-}

-- Punto 2
eleccionDeRol :: Participante -> [Rol] -> Participante
eleccionDeRol persona roles = persona {rol = maximoSegun (flip ($) persona) roles}
{-
poderDelParticipante . eleccionDeRol participantePrueba $ [rolIndeterminado, rolSoporte, rolPrimeraLinea 30, rolEscudo 25]
Nos da: 3100
-}

-- Punto 3a
participantePerteneceGrupo :: Participante -> [Participante] -> Bool
participantePerteneceGrupo persona personas = any (== nombre persona) (map nombre personas)

-- Punto 3b
experienciaParaGanadores :: [Participante] -> [Participante] -> Int
experienciaParaGanadores participantes participantesGanadores = (+) 100 . flip div (length participantesGanadores) . sum . map (experiencia) . participantesPerdedores participantesGanadores $ participantes

participantesPerdedores ::[Participante] -> [Participante] -> [Participante]
participantesPerdedores participantesGanadores participantes = filter (\x -> not (participantePerteneceGrupo x participantesGanadores)) participantes

-- Test con el ejemplo
listaParticipantes = [(UnParticipante "a" 1000 1 1 rolIndeterminado), (UnParticipante "b" 1500 1 1 rolIndeterminado), (UnParticipante "c" 1200 1 1 rolIndeterminado), (UnParticipante "d" 150 1 1 rolIndeterminado) ,(UnParticipante "e" 1800 1 1 rolIndeterminado)]
listaParticipantesGanadores = [(UnParticipante "c" 1200 1 1 rolIndeterminado),(UnParticipante "d" 150 1 1 rolIndeterminado),(UnParticipante "e" 1800 1 1 rolIndeterminado)]
test = experienciaParaGanadores listaParticipantes listaParticipantesGanadores 
-- Al correr la funcion test en la consola, da 933, la operacion es correcta. (1000 + 1500) / 3 + 100

-- Punto 3c
repartirExperiencia :: [Participante] -> [Participante] -> [Participante]
repartirExperiencia participantes participantesGanadores = map ((darleExperiencia . experienciaParaGanadores participantes) participantesGanadores) participantesGanadores

darleExperiencia :: Int -> Participante -> Participante
darleExperiencia experienciaGanadora persona = persona {experiencia = experiencia persona + experienciaGanadora}

-- Test con el ejemplo
test2 = repartirExperiencia listaParticipantes listaParticipantesGanadores 
-- Se le añadio a los participantes ganadores, los 933 de experiencia.

-- Punto 4a
encararUnDesafio :: [Participante] -> Desafio ->  [Participante]
encararUnDesafio participantes desafio = repartirExperiencia participantes . filter (pruebaASuperar desafio) . participantesEligenRol participantes $ desafio

participantesEligenRol :: [Participante] -> Desafio ->  [Participante]
participantesEligenRol participantes desafio = map (flip eleccionDeRol (rolesDisponibles desafio)) participantes

-- Test con roles basicos
listaRoles = [rolIndeterminado, rolSoporte, rolPrimeraLinea 10, rolEscudo 25]
f :: Participante -> Bool
f = undefined
test3 = participantesEligenRol listaParticipantes (Desafio listaRoles f)

-- Punto 4b
hayGanadoresConMasDeMilDeExperiencia :: [Participante] -> Desafio -> Bool
hayGanadoresConMasDeMilDeExperiencia participantes desafio = any (> 1000) . map (experiencia) $ (encararUnDesafio participantes desafio)

ganadorMasPoderoso :: [Participante] -> Desafio -> Participante
ganadorMasPoderoso participantes desafio = maximoSegun poderDelParticipante (encararUnDesafio participantes desafio)

-- Punto 4c
{-
Para el primer punto, hayGanadoresConMasDeMilDeExperiencia, no podria saber si hay ganadores o no pues al ser una lista infinita y yo necesitar de todos los participantes en encararUnDesafio
para poder realizar las cuentas y saber cuanto repatir, esto no terminaria nunca. 
De la forma que podria terminar es, si directamente se pasa la lista de ganadores infinita, es decir $ listaGanadoresInfinita.
Porque podria? Pues porque si de esos ganadores ninguno tiene una experiencia >1000, esto va a seguir ejecutando indefinidamente, pues así es como actua any (Si encuentra alguno, devuelve true, sino devuelve False)
En este caso, no puede devolver false porque no termino de analizar toda la lista.
Pero si hubiese algun ganador, any (Ya que es lazy evaluation) directamente terminaria con ese participante y devolviendo el True, sin seguir analizando el resto.

Para el segundo punto, ganadorMasPoderoso, no hay forma de que recibamos un resultado pues lo que hara esa funcion es comparar los participantes hasta elegir cual tiene mas poder, para lograr eso debe de analizar toda la lista.
Por lo tanto, para determinar quien es el mas poderoso necesitara terminar la lista.
-}

-- Punto 5

competicionTorneo :: [Participante] -> [Desafio] -> [Participante]
competicionTorneo participantes = last . etapasDesafio participantes
-- Con etapas del desafio, lo que obtenemos son los ganadores que quedaron a medida que se iban haciendo los desafios de utilidad. Como utilizaremos los ganadores del torneo, entonces hacemos el last.
etapasDesafio :: [Participante] -> [Desafio] -> [[Participante]]
etapasDesafio _ [] = []
etapasDesafio participantes (desafio : desafios) = (encararUnDesafio participantes desafio) : (etapasDesafio (encararUnDesafio participantes desafio) desafios)

-- Tambien lo habia pensado con map (encararUnDesafio participantes) pero creo que no arrastraria a los ganadores, sino que siempre utiliza todos los participantes
