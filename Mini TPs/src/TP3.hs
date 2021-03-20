module TP3 where
import Cafe

armarCafe :: Vaso -> Gramos -> Cafe
armarCafe vaso =  servirEnVaso vaso . moledorGranosPreparadorCafe 1000

armarFrapu :: Gramos -> Cafe
armarFrapu = servirEnVaso 400 . licuar 60 120 . agregarHielo 6 . moledorGranosPreparadorCafe 80

moledorGranosPreparadorCafe :: Agua -> Gramos -> Cafe -- #1
moledorGranosPreparadorCafe cantAgua  = prepararCafe cantAgua . molerGranos