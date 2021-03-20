module TP4 where
import Video
import EdicionVideos
import Data.Char

-- Definir las funciones de acuerdo a lo indicado en las consignas del TP4

-------------------------
-- Hashtags
-------------------------

tieneHashtag :: String -> Video -> Bool
tieneHashtag hashtagAnalizar videoAnalizar = elem (palabraAminuscula hashtagAnalizar) (hashtagsComparables videoAnalizar)

-- Mapea la lista de palabras ["HoLA","bOla","RODAR","dAdO"] con la funcion (map toLower). Entonces a cada elemento de la lista le
-- aplica map toLower, "HoLA" es uen elemento que es String = [Char] y como es una lista de caracteres, se le aplica el map toLower asi cada letra cambia
-- a minuscula 'H'='h' 'o'='o' 'L'='l' 'A'='a', luego el primer map va al siguiente elemento "bOla" y se aplica devuelta map toLower.-
listaAminuscula :: [String] -> [String]
listaAminuscula = map palabraAminuscula

hashtagsComparables :: Video -> [String]
hashtagsComparables = listaAminuscula.words.hashtags 

palabraAminuscula :: String -> String 
palabraAminuscula = map toLower

estanRelacionados :: Video -> Video -> Bool
estanRelacionados videoPrimario videoSecundario = length (listaHashtagsRelacionados videoPrimario videoSecundario) >= 3

listaHashtagsRelacionados:: Video -> Video -> [String]
listaHashtagsRelacionados videoPrimario videoSecundario = filter (flip tieneHashtag videoPrimario) (hashtagsComparables videoSecundario)

agregarHashtag :: String -> Video -> Video
agregarHashtag hashtagIncluir videObjetivo
    | tieneHashtag hashtagIncluir videObjetivo = videObjetivo
    | otherwise = videObjetivo {hashtags = incluirHashtag hashtagIncluir (hashtags videObjetivo)} 

incluirHashtag :: String -> String -> String
incluirHashtag hashtagIncluir listaHashtag = listaHashtag ++ " " ++ hashtagIncluir

agregarHashtags :: [String] -> Video -> Video
agregarHashtags hashtagsIncluir videObjetivo = foldr agregarHashtag videObjetivo hashtagsIncluir

-------------------------
-- Edicion de videos
-------------------------

subir :: Video -> VideoVersionado
subir primerVideo = Version primerVideo []

editar :: (Video -> Video) -> VideoVersionado -> VideoVersionado
editar f vidVers
    | f (versionActual vidVers) == versionActual vidVers =  vidVers
    | otherwise = Version{versionActual = (f (versionActual vidVers)), versionesAnteriores = (incluirActualAnteriores vidVers)}

incluirActualAnteriores :: VideoVersionado -> [Video]
incluirActualAnteriores video = (versionActual video) : (versionesAnteriores video)


postProcesamiento :: String -> (Int, Int, Int) -> Video -> VideoVersionado
postProcesamiento nombre duracion = editar(recortar duracion).editar (renombrar nombre).subir