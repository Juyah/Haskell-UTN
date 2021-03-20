module TP1 where

esMes :: Int -> Bool
esMes mes = 1 <= mes && mes <= 12


esMultiploDe :: Int -> Int -> Bool
esMultiploDe dividendo divisor = dividendo `mod` divisor == 0


hayCambioDeEstacion :: Int -> Bool
hayCambioDeEstacion mes = esMes mes && mes `esMultiploDe` 3


anteriorMes :: Int -> Int
anteriorMes 1 = 12
anteriorMes mes = mes - 1


siguienteMes  :: Int -> Int
siguienteMes 12 = 1
siguienteMes mes = mes + 1


estacion :: Int -> String
estacion 1 = "verano"
estacion 4 = "otoño"
estacion 7 = "invierno"
estacion 10 = "primavera"
estacion mes
    | hayCambioDeEstacion mes = estacion (anteriorMes mes) ++ "/" ++ estacion (siguienteMes mes)
    | esMes mes = estacion (anteriorMes mes)