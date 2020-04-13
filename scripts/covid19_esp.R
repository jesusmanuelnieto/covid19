"
  @script:      covid19_esp
  @autor:       Jesús Manuel Nieto Carracedo
  @email1:      jesusmanuel.nieto@etani.es
  @email2:      jesusmanuel.nieto@gmail.com
  @web   :      https://etani.es
  @linkedin:    https://es.linkedin.com/in/jes%C3%BAs-manuel-nieto-carracedo-77128424
  @github:      https://github.com/jesusmanuelnieto
  @description: Script para la manipulación y generación de varías gráficas sobre la evolución del
  virus COVID-19 a nivel del Reino de España.

  @repository:  https://github.com/jesusmanuelnieto/covid19.git
  @sources:
  {
    @data:         https://covid19.isciii.es/
    @deathTax:     http://www.telemadrid.es/coronavirus-covid-19/mortalidad-COVID-19-Wuhan-menor-estimado-0-2214678548--20200319021221.html
  }
"

# Libraries ---------------------------------------------------------------

fnLoad_libraries_esp <- function(){
  library(tidyverse)
  library(lubridate)
}

# Import Data -------------------------------------------------------------

fnImportData_esp <- function (path_dataset,deathTax) {
  
  # Tribble con los nombres de las comunidades autónomas
  tribble(
    ~CCAA             , ~CCAA.Name,
    "AN"              , "Andalucia",
    "AR"              , "Aragón",
    "AS"              , "Asturias",
    "CB"              , "Cantabria",
    "CE"              , "Ceuta",
    "CL"              , "Castilla y León",
    "CM"              , "Castilla la Mancha",
    "CN"              , "Canarias",
    "CT"              , "Cataluña",
    "EX"              , "Extremadura",
    "GA"              , "Galicia",
    "IB"              , "Islas Baleares",
    "MC"              , "Murcia",
    "MD"              , "Madrid",
    "ME"              , "Melilla",
    "NC"              , "Navarra",
    "PV"              , "País Vasco",
    "RI"              , "La Rioja",
    "VC"              , "Valencia"
  ) -> ccaa
  
  read.csv(path_dataset) %>%
    filter(
      CCAA != "Los datos de estas comunidades son datos de prevalencia (personas ingresadas a fecha de hoy). No reflejan el total de personas que han sido hospitalizadas o ingresadas en UCI<a0> a lo largo del periodo de notificaci<f3>n(CL) (CM) (MD) (VC) y (MC)",
      CCAA != "NOTA: El objetivo de los datos que se publican en esta web es saber el n<fa>mero de casos acumulados a la fecha y que por tanto no se puede deducir que la diferencia entre un d<ed>a y el anterior es el n<fa>mero de casos nuevos ya que esos casos pueden haber sido recuperados de fechas anteriores. Cualquier inferencia que se haga sobre las diferencias de un d<ed>a para otro deben hacerse con precauci<f3>n y son <fa>nicamente la responsabilidad el autor."
    ) %>%
    inner_join(ccaa, by="CCAA") %>% 
    rename(
      ccaa.codigo.iso    = CCAA,
      obs_date           = FECHA,
      confirmed          = CASOS,
      hospitalized       = Hospitalizados,
      uci                = UCI,
      death              = Fallecidos,
      recovered          = Recuperados,
      ccaa.name          = CCAA.Name
    ) %>% 
    mutate(
      perc_exit           = (death * 100)/(death+recovered),
      obs_date            = dmy(obs_date),
      confirmedrecovered  = confirmed - recovered,
      confirmed_estimated = (death * 100) /  deathTax
      
    ) %>%
    return()
}

# Utils -------------------------------------------------------------------

fnGetCcaanamesList <- function (covid19,n_ccaa.names){
  
  covid19 %>%
    arrange(
      desc(obs_date)
    ) %>% 
    head(
      1
    ) -> covid19_lastObs_date
  
  
  covid19 %>%
    filter(
      obs_date == covid19_lastObs_date$obs_date
    ) %>%
    arrange(
      desc(confirmed)
    ) %>%
    head(
      n_ccaa.names
    ) %>%
    arrange(
      ccaa.name
    )-> covid19_top_ccaa.names_confirmed
  
  return (covid19_top_ccaa.names_confirmed$ccaa.name)
}

# Plots -------------------------------------------------------------------

fnPlotEsp_confirmed <- function(covid19){
  
  filename = "./data/png/esp/covid19_esp_plotEsp_confirmed.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>%
    arrange(
      obs_date
    ) %>%
    ggplot(aes(x = obs_date, y=confirmed)) +
    geom_col() +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "COVID- Spain Evolution for Covid-19  Script in R (confirmed)",
      x       = "Date",
      y       = "Condirmed",
      caption = "INFO: Git: https://github.com/jesusmanuelnieto/covid19.git, @autor: https://etani.es"
    )
  
    ggsave(
      filename = filename,
      device   = "png",
      # 1920x1080 conversion pixel to cm
      width    = 50.8,  
      height   = 28.575,
      units    = "cm"
    )
}

fnPlotEspDetail_confirmed <- function(covid19){
  
  filename = "./data/png/esp/covid19_esp_plotEspDetail_confirmed.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>%
    arrange(
      obs_date
    ) %>%
    ggplot(aes(x = obs_date, y=confirmed)) +
    geom_col() +
    facet_wrap(~ccaa.name, nrow=7) +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "COVID- Spain Detail Evolution for Covid-19  Script in R (confirmed)",
      x       = "Date",
      y       = "Condirmed",
      caption = "INFO: Git: https://github.com/jesusmanuelnieto/covid19.git, @autor: https://etani.es"
    )
  
  ggsave(
    filename = filename,
    device   = "png",
    # 1920x1080 conversion pixel to cm
    width    = 50.8,  
    height   = 28.575,
    units    = "cm"
  )
}

fnPlotEspCcaanameDetail_confirmed <- function(covid19, n_ccaanames){
  
  filename = "./data/png/esp/covid19_esp_plotEspccaanameDetail_confirmed.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>%
    filter(
      ccaa.name %in% fnGetCcaanamesList(covid19,n_ccaanames)
    ) %>%
    arrange(
      obs_date
    ) %>%
    ggplot(aes(x = obs_date, y=confirmed)) +
    geom_col() +
    facet_wrap(~ccaa.name, nrow=2) +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "COVID- Spain Filter Most Confirmed CCAA.Names, Detail Evolution for Covid-19  Script in R (confirmed)",
      x       = "Date",
      y       = "Condirmed",
      caption = "INFO: Git: https://github.com/jesusmanuelnieto/covid19.git, @autor: https://etani.es"
    )
  
  ggsave(
    filename = filename,
    device   = "png",
    # 1920x1080 conversion pixel to cm
    width    = 50.8,  
    height   = 28.575,
    units    = "cm"
  )
}

fnPlotEsp_confirmedrecovered <- function(covid19){
  
  filename = "./data/png/esp/covid19_esp_plotEsp_confirmedrecovered.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>%
    arrange(
      obs_date
    ) %>%
    ggplot(aes(x = obs_date, y=confirmedrecovered)) +
    geom_col() +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "COVID- Spain Evolution for Covid-19  Script in R (confirmedrecovered)",
      x       = "Date",
      y       = "Condirmedrecovered",
      caption = "INFO: Git: https://github.com/jesusmanuelnieto/covid19.git, @autor: https://etani.es"
    )
  
  ggsave(
    filename = filename,
    device   = "png",
    # 1920x1080 conversion pixel to cm
    width    = 50.8,  
    height   = 28.575,
    units    = "cm"
  )
}

fnPlotEspDetail_confirmedrecovered <- function(covid19){
  
  filename = "./data/png/esp/covid19_esp_plotEspDetail_confirmedrecovered.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>%
    arrange(
      obs_date
    ) %>%
    ggplot(aes(x = obs_date, y=confirmedrecovered)) +
    geom_col() +
    facet_wrap(~ccaa.name, nrow=7) +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "COVID- Spain Detail Evolution for Covid-19  Script in R (confirmedrecovered)",
      x       = "Date",
      y       = "Confirmedrecovered",
      caption = "INFO: Git: https://github.com/jesusmanuelnieto/covid19.git, @autor: https://etani.es"
    )
  
  ggsave(
    filename = filename,
    device   = "png",
    # 1920x1080 conversion pixel to cm
    width    = 50.8,  
    height   = 28.575,
    units    = "cm"
  )
}

fnPlotEspCcaanameDetail_confirmedrecovered <- function(covid19, n_ccaanames){
  
  filename = "./data/png/esp/covid19_esp_plotEspccaanameDetail_confirmedrecovered.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>%
    filter(
      ccaa.name %in% fnGetCcaanamesList(covid19,n_ccaanames)
    ) %>%
    arrange(
      obs_date
    ) %>%
    ggplot(aes(x = obs_date, y=confirmedrecovered)) +
    geom_col() +
    facet_wrap(~ccaa.name, nrow=2) +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "COVID- Spain Filter Most Confirmed CCAA.Names, Detail Evolution for Covid-19  Script in R (confirmedrecovered)",
      x       = "Date",
      y       = "Condirmedrecovered",
      caption = "INFO: Git: https://github.com/jesusmanuelnieto/covid19.git, @autor: https://etani.es"
    )
  
  ggsave(
    filename = filename,
    device   = "png",
    # 1920x1080 conversion pixel to cm
    width    = 50.8,  
    height   = 28.575,
    units    = "cm"
  )
}

fnPlotEsp_confirmed_estimated <- function(covid19){
  
  filename = "./data/png/esp/covid19_esp_plotEsp_confirmed_estimated.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>%
    arrange(
      obs_date
    ) %>%
    ggplot(aes(x = obs_date, y=confirmed_estimated)) +
    geom_col() +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "COVID- Spain- Global Evolution for Covid-19  Script in R (confirmed_estimated)",
      x       = "Date",
      y       = "Condirmed_Estimated",
      caption = "INFO: Git: https://github.com/jesusmanuelnieto/covid19.git, @autor: https://etani.es"
    )
  
  ggsave(
    filename = filename,
    device   = "png",
    # 1920x1080 conversion pixel to cm
    width    = 50.8,  
    height   = 28.575,
    units    = "cm"
  )
}

fnPlotEspDetail_confirmed_estimated <- function(covid19){
  
  filename = "./data/png/esp/covid19_esp_plotEspDetail_confirmed_estimated.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>%
    arrange(
      obs_date
    ) %>%
    ggplot(aes(x = obs_date, y=confirmed_estimated)) +
    geom_col() +
    facet_wrap(~ccaa.name, nrow=7) +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "COVID- Spain Detail Evolution for Covid-19  Script in R (confirmed_estimated)",
      x       = "Date",
      y       = "Condirmed_Estimated",
      caption = "INFO: Git: https://github.com/jesusmanuelnieto/covid19.git, @autor: https://etani.es"
    )
  
  ggsave(
    filename = filename,
    device   = "png",
    # 1920x1080 conversion pixel to cm
    width    = 50.8,  
    height   = 28.575,
    units    = "cm"
  )
}

fnPlotEspCcaanameDetail_confirmed_estimated <- function(covid19, n_ccaanames){
  
  filename = "./data/png/esp/covid19_esp_plotEspccaanameDetail_confirmed_estimated.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>%
    filter(
      ccaa.name %in% fnGetCcaanamesList(covid19,n_ccaanames)
    ) %>%
    arrange(
      obs_date
    ) %>%
    ggplot(aes(x = obs_date, y=confirmed_estimated)) +
    geom_col() +
    facet_wrap(~ccaa.name, nrow=2) +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "COVID- Spain Filter Most Confirmed Countries, Detail Evolution for Covid-19  Script in R (confirmed_estimated)",
      x       = "Date",
      y       = "Condirmed_Estimated",
      caption = "INFO: Git: https://github.com/jesusmanuelnieto/covid19.git, @autor: https://etani.es"
    )
  
  ggsave(
    filename = filename,
    device   = "png",
    # 1920x1080 conversion pixel to cm
    width    = 50.8,  
    height   = 28.575,
    units    = "cm"
  )
}

fnPlotEspLastdate <- function(covid19){
  
  filename = "./data/png/esp/covid19_esp_plotEspLastdate.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>% 
    arrange(
      desc(obs_date)
    ) %>%
    filter (
      !is.na(confirmed),
      !is.na(confirmed_estimated),
      !is.na(recovered),
      !is.na(death)
    ) %>% 
    head(
      1              # Nos quedamos con la última
    ) %>%
    gather(
      "type_cases",
      "cases",
      3:7
    )%>%
    ggplot() +
    geom_bar(aes (x=type_cases, fill = type_cases, y=cases),stat = "identity") +
    coord_polar() +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "Spain Evolution for Covid-19  Script in R (Last Date)",
      x       = "Cases",
      y       = "Last Date",
      color   = "Data",
      caption = "INFO: Git: https://github.com/jesusmanuelnieto/covid19.git, @autor: https://etani.es"
    )
  
  ggsave(
    filename = filename,
    device   = "png",
    # 1920x1080 conversion pixel to cm
    width    = 50.8,  
    height   = 28.575,
    units    = "cm"
  )
}

# Main Function ---------------------------------------------------------

fnMainEsp <- function (path_wd, path_dataset,path_dataframe,deathTax,n_ccaanames){

  fnLoad_libraries_esp()
  setwd(path_wd)
  
  covid19_esp <-fnImportData_esp(path_dataset,deathTax)
  
  if (file.exists(path_dataframe)) 
    file.remove(path_dataframe)
  write_csv2(covid19_esp,path = path_dataframe)
  
  # Plots -------------------------------------
  
  # confirmed
  fnPlotEsp_confirmed(covid19_esp)
  fnPlotEspDetail_confirmed(covid19_esp)
  fnPlotEspCcaanameDetail_confirmed(covid19_esp, n_ccaanames)
  
  # confirmedrecovered
  fnPlotEsp_confirmedrecovered(covid19_esp)
  fnPlotEspDetail_confirmedrecovered(covid19_esp)
  fnPlotEspCcaanameDetail_confirmedrecovered(covid19_esp, n_ccaanames)
  
  # confirmed_estimated
  fnPlotEsp_confirmed_estimated(covid19_esp)
  fnPlotEspDetail_confirmed_estimated(covid19_esp)
  fnPlotEspCcaanameDetail_confirmed_estimated(covid19_esp, n_ccaanames)
  
  # lastdate
  fnPlotEspLastdate(covid19_esp)

  return ("Execution OK")
}


# Main --------------------------------------------------------------------

"
  fnMain:
    path_wd         : Path working directory,
    path_dataset    : Path for dataset IN,
    path_dataframe  : Path for dataframe OUT,
    deathTax        : Death tax for Covid-19,
    n_ccaanames     : Number of cca.names who show in detail wrap
"

fnMainEsp("~/Nextcloud/Documents/Apuntes Actuales/R/covid19",
       "./data/csv/esp/covid19_esp_dataset.csv",
       "./data/csv/esp/covid19_esp_dataframe.csv",
       1.4,
       10
      )
