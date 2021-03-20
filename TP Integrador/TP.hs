module TP where
import Data.Char
import Text.Show.Functions

----------------------
-- Código inicial
----------------------

ordenarPor :: Ord a => (b -> a) -> [b] -> [b]
ordenarPor ponderacion =
  foldl (\ordenada elemento -> filter ((< ponderacion elemento).ponderacion) ordenada
                                  ++ [elemento] ++ filter ((>= ponderacion elemento).ponderacion) ordenada) []

data Demonio = Demonio {
    deudores :: [String],
    subordinados :: [Demonio]
} deriving (Show, Eq)

----------------------------------------------
-- Definí tus tipos de datos y funciones aquí
----------------------------------------------
data Humano = Humano {
  nombre :: String,
  reconocimiento :: Int,
  felicidad :: Int,
  deseos :: [Deseo]
}deriving (Show)

type Deseo = Humano -> Humano

pazMundial :: Humano -> Humano
pazMundial humano = humano {felicidad = 20 * felicidad humano}

serFamoso :: Humano -> Humano
serFamoso humano = humano {reconocimiento = 1000 + reconocimiento humano, felicidad = 50}

recibirseCarrera :: String -> Humano -> Humano
recibirseCarrera carrera humano = humano{felicidad = felicidad humano + 250, reconocimiento = reconocimiento humano + 3 * length carrera}

humanoTest :: Humano
humanoTest = Humano "Test1" 50 100 [pazMundial, recibirseCarrera "Ingeniería en Sistemas de Información", recibirseCarrera "Medicina",serFamoso]
--serFamoso . recibirseCarrera "Medicina" . recibirseCarrera "Ingeniería en Sistemas de Información" . pazMundial $ humanoTest




espiritualidadDeseo :: Humano -> Deseo -> Int
espiritualidadDeseo humano deseo = ganaFelicidad humano deseo - ganaReconocimiento humano deseo
--espiritualidadDeseo  humanoTest (recibirseCarrera "Medicina")   

ganaFelicidad :: Humano -> Deseo -> Int
ganaFelicidad humano deseo = gana felicidad humano deseo

ganaReconocimiento :: Humano -> Deseo -> Int
ganaReconocimiento humano deseo = gana reconocimiento humano deseo

gana :: (Humano -> Int) -> Humano -> Deseo -> Int
gana criterio humano deseo = (criterio.deseo) humano - criterio humano


{-masFeliz :: Humano -> Bool
masFeliz humano = felicidad (aplicarDeseos humano) > felicidad humano -}
masFeliz :: Humano -> Bool
masFeliz humano = (felicidad . aplicarDeseos) humano > felicidad humano

aplicarDeseos :: Humano -> Humano
aplicarDeseos humano = foldl (flip ($)) humano (deseos humano)



deseosTerrenales :: Humano -> [Deseo]
deseosTerrenales humano = ordenarPor (espiritualidadDeseo humano) . filter (deseoTerrenal humano) $ (deseos humano)

deseoTerrenal :: Humano -> Deseo -> Bool
deseoTerrenal humano = (<150).espiritualidadDeseo humano

mejorHumano :: Humano -> Humano
mejorHumano humano = last.ordenarPor sumaFelicidadReconocimiento. deseosAplicadosHumanos $ humano

deseosAplicadosHumanos :: Humano -> [Humano]
deseosAplicadosHumanos humano = map ($ humano) (deseos humano) 

sumaFelicidadReconocimiento :: Humano -> Int
sumaFelicidadReconocimiento humano = felicidad humano + reconocimiento humano



deudorDemonio :: Demonio -> Humano -> Bool
deudorDemonio demonio humano = elem (palabraAminuscula.nombre $ humano) (listaAminuscula.deudores $ demonio)

palabraAminuscula :: String -> String 
palabraAminuscula = map toLower

listaAminuscula :: [String] -> [String]
listaAminuscula = map palabraAminuscula

-- No utilizo head y lo compruebo con length, porque si es una lista vacia no se le puede sacar el head, por ello veo directamente si hay elementos o no pues si hay, son verdaderos por el filtro.
deudorSubordinado :: Demonio -> Humano -> Bool
deudorSubordinado demonio humano =  any (`deudorDemonio` humano) (subordinados demonio)

bonus = undefined

demonioTest :: Demonio
demonioTest = Demonio ["test","TEEsT1","Test2","tEst3"] [Demonio ["test","TEsTt1","Test2","tEst3"][], Demonio ["a","TEsT1","c"][], Demonio["d","e","f"][]]

{- Respuesta teórica: En mi caso, esto se romperia, pues elem analiza con todos los elementos de la lista hasta que sea verdadero, y pues si no se encuentra en la lista, esto nunca terminara ya que la lista es infinita.
Si el humano se encuentra en alguna de ellas, si pararia y devolveria lo solicitado.-}


ayudarSiLeConviene:: Humano -> Demonio -> (Humano, Demonio)
ayudarSiLeConviene humano demonio
  | (not.tienePoder demonio $ humano) && tieneDeseosTerrenales humano = (demonioCumpleDeseoMasTerrenal humano , añadirADeudor humano demonio)
  | otherwise = (humano, demonio)

tienePoder :: Demonio -> Humano -> Bool
tienePoder demonio humano = deudorDemonio demonio humano || deudorSubordinado demonio humano

demonioCumpleDeseoMasTerrenal :: Humano -> Humano
demonioCumpleDeseoMasTerrenal humano = flip ($) humano . head . deseosTerrenales $ humano

tieneDeseosTerrenales :: Humano -> Bool
tieneDeseosTerrenales = (>0).length.deseosTerrenales

añadirADeudor :: Humano -> Demonio -> Demonio
añadirADeudor humano demonio = demonio{deudores = nombre humano : deudores demonio}