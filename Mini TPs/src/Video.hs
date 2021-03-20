module Video where

-- Definir acá el data Video usando la notación que vimos en clase
data Video = Video {
    titulo :: String,
    duracion :: (Int, Int, Int),
    hashtags :: String
} deriving (Show, Eq)
-- Crear los siguientes videos de prueba con las duraciones
-- que se indicaban en la consigna:
videoMuyLargo :: Video
videoMuyLargo = Video "video1" (1,15,45) "#1"

videoNormal :: Video
videoNormal = Video "video2" (0,32,12) "#2"

videoCorto :: Video
videoCorto = Video "video3" (0,10,59) "#3"

otroVideoCorto :: Video
otroVideoCorto = Video "video4" (0,10,20) "#4"