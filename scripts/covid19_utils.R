### INFO
#  @script:      covid19_utils.R
#  @autor:       Jesús Manuel Nieto Carracedo
#  @email1:      jesusmanuel.nieto@etani.es
#  @email2:      jesusmanuel.nieto@gmail.com
#  @web   :      https://etani.es
#  @linkedin:    https://es.linkedin.com/in/jes%C3%BAs-manuel-nieto-carracedo-77128424
#  @github:      https://github.com/jesusmanuelnieto
#  @description: Agrupar todas las funciones de utilidad comunes al resto de scripts
###

fnLoad_libraries <- function(){
  library(tidyverse)
  library(lubridate)
}


fnChangeNaTo0<- function(values){
  results <- c()
  for (value in values){
    if (is.na(value)){
      results <- c(results,0)
    } else {
      results <- c(results,value)
    }
  }
  return (results)
}