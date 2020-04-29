#!/usr/bin/env Rscript

### INFO
#  @script:      covid19_global_console.R
#  @autor:       Jesús Manuel Nieto Carracedo
#  @email1:      jesusmanuel.nieto@etani.es
#  @email2:      jesusmanuel.nieto@gmail.com
#  @web   :      https://etani.es
#  @linkedin:    https://es.linkedin.com/in/jes%C3%BAs-manuel-nieto-carracedo-77128424
#  @github:      https://github.com/jesusmanuelnieto
#  @description: Ejecutor del script covid19_global.R
###


# Main --------------------------------------------------------------------

args = commandArgs(trailingOnly=TRUE)

if (length(args)==4) {
  print ("Carga de directorio de trabajo")
  setwd(args[1])

  print("Carga de ficheros fuente")
  source(file="./scripts/covid19_utils.R")
  source(file="./scripts/covid19_global.R")
  source(file="./scripts/covid19_esp.R")
  source(file="./scripts/covid19_cyl.R")
  
  print ("Carga de liberías...")
  fnLoad_libraries()
  
  
  print ("Resultados globales...")
  fnMainGlobal(read.csv(args[2], sep =";"))
  
  print ("Resultados España...")
  fnMainEsp(read.csv(args[3], sep =";"))
  
  print ("Resultados Castilla y León...")
  fnMainCyl(read.csv(args[4], sep =";"))
  
} else {
  stop("No se encontraron ni el path al working directory, ni las rutas a los fichero de configuración.n", call.=FALSE)
}
