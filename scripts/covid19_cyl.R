"
  @script:      covid19_cyl
  @autor:       Jesús Manuel Nieto Carracedo
  @email1:      jesusmanuel.nieto@etani.es
  @email2:      jesusmanuel.nieto@gmail.com
  @web   :      https://etani.es
  @linkedin:    https://es.linkedin.com/in/jes%C3%BAs-manuel-nieto-carracedo-77128424
  @github:      https://github.com/jesusmanuelnieto
  @description: Script para la manipulación y generación de varías gráficas sobre la evolución del
  virus COVID-19 a nivel de la comunidad de Castilla & León en el Reino de cylaña.

  @repository:  https://github.com/jesusmanuelnieto/covid19.git
  @sources:
  {
    @data:         https://analisis.datosabiertos.jcyl.es/pages/coronavirus/descarga-de-datasets#descargas,
    @dataset1      https://analisis.datosabiertos.jcyl.es/explore/dataset/situacion-de-hospitalizados-por-coronavirus-en-castilla-y-leon/download/?format=csv&timezone=Europe/Madrid&lang=es&use_labels_for_header=true&csv_separator=%3B,
    @dataset2      https://analisis.datosabiertos.jcyl.es/explore/dataset/situacion-epidemiologica-coronavirus-en-castilla-y-leon/download/?format=csv&timezone=Europe/Madrid&lang=es&use_labels_for_header=true&csv_separator=%3B
    @deathTax:     http://www.telemadrid.es/coronavirus-covid-19/mortalidad-COVID-19-Wuhan-menor-estimado-0-2214678548--20200319021221.html
  }
"

# Libraries ---------------------------------------------------------------

fnLoad_libraries_cyl <- function(){
  library(tidyverse)
}

# Import Data -------------------------------------------------------------

fnImportData_cyl <- function (path_dataset,deathTax) {
  
  read.csv(path_dataset[1], sep =";") %>%
    group_by(
      fecha,
      provincia
    ) %>%
    summarise(
      hospitalizados_planta  = sum(hospitalizados_planta),
      hospitalizados_uci     = sum(hospitalizados_uci),
      hospitalizados_altas   = sum(altas),
      hospitalizados_muertos = sum(fallecimientos)
    ) %>%
    inner_join(read.csv(path_dataset[2], sep = ";"),by = c("fecha","provincia")) %>%
    rename (
      obs_date           = fecha,
      confirmed          = casos_confirmados,
      confirmed_new      = nuevos_positivos,
      hospitalized       = hospitalizados_planta,
      uci                = hospitalizados_uci,
      death              = hospitalizados_muertos,
      recovered          = hospitalizados_altas,
      name               = provincia
    ) %>%
    mutate (
      perc_exit           = (death * 100)/(death+recovered),
      confirmedrecovered  = confirmed - recovered,
      confirmed_estimated = (death * 100) /  deathTax
    ) %>%
    return()
  
}

# Utils -------------------------------------------------------------------

fnGetNamesList <- function (covid19,n_names){
  
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
      n_names
    ) %>%
    arrange(
      name
    )-> covid19_top_names_confirmed
  
  return (covid19_top_names_confirmed$name)
}

# Plots -------------------------------------------------------------------

fnPlotcyl_confirmed <- function(covid19){
  
  filename = "./data/png/cyl/covid19_cyl_plotcyl_confirmed.png"
  
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
      title   = "COVID- Castilla & León Evolution for Covid-19  Script in R (confirmed)",
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

fnPlotcylDetail_confirmed <- function(covid19){
  
  filename = "./data/png/cyl/covid19_cyl_plotcylDetail_confirmed.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>%
    arrange(
      obs_date
    ) %>%
    ggplot(aes(x = obs_date, y=confirmed)) +
    geom_col() +
    facet_wrap(~name, nrow=7) +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "COVID- Castilla & León Detail Evolution for Covid-19  Script in R (confirmed)",
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

fnPlotcylNameDetail_confirmed <- function(covid19, n_names){
  
  filename = "./data/png/cyl/covid19_cyl_plotcylnameDetail_confirmed.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>%
    filter(
      name %in% fnGetNamesList(covid19,n_names)
    ) %>%
    arrange(
      obs_date
    ) %>%
    ggplot(aes(x = obs_date, y=confirmed)) +
    geom_col() +
    facet_wrap(~name, nrow=2) +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "COVID- Castilla & León Filter Most Confirmed Names, Detail Evolution for Covid-19  Script in R (confirmed)",
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

fnPlotcyl_confirmedrecovered <- function(covid19){
  
  filename = "./data/png/cyl/covid19_cyl_plotcyl_confirmedrecovered.png"
  
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
      title   = "COVID- Castilla & León Evolution for Covid-19  Script in R (confirmedrecovered)",
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

fnPlotcylDetail_confirmedrecovered <- function(covid19){
  
  filename = "./data/png/cyl/covid19_cyl_plotcylDetail_confirmedrecovered.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>%
    arrange(
      obs_date
    ) %>%
    ggplot(aes(x = obs_date, y=confirmedrecovered)) +
    geom_col() +
    facet_wrap(~name, nrow=7) +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "COVID- Castilla & León Detail Evolution for Covid-19  Script in R (confirmedrecovered)",
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

fnPlotcylNameDetail_confirmedrecovered <- function(covid19, n_names){
  
  filename = "./data/png/cyl/covid19_cyl_plotcylnameDetail_confirmedrecovered.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>%
    filter(
      name %in% fnGetNamesList(covid19,n_names)
    ) %>%
    arrange(
      obs_date
    ) %>%
    ggplot(aes(x = obs_date, y=confirmedrecovered)) +
    geom_col() +
    facet_wrap(~name, nrow=2) +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "COVID- Castilla & León Filter Most Confirmed Names, Detail Evolution for Covid-19  Script in R (confirmedrecovered)",
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

fnPlotcyl_confirmed_estimated <- function(covid19){
  
  filename = "./data/png/cyl/covid19_cyl_plotcyl_confirmed_estimated.png"
  
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
      title   = "COVID- Castilla & León- Global Evolution for Covid-19  Script in R (confirmed_estimated)",
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

fnPlotcylDetail_confirmed_estimated <- function(covid19){
  
  filename = "./data/png/cyl/covid19_cyl_plotcylDetail_confirmed_estimated.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>%
    arrange(
      obs_date
    ) %>%
    ggplot(aes(x = obs_date, y=confirmed_estimated)) +
    geom_col() +
    facet_wrap(~name, nrow=7) +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "COVID- Castilla & León Detail Evolution for Covid-19  Script in R (confirmed_estimated)",
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

fnPlotcylNameDetail_confirmed_estimated <- function(covid19, n_names){
  
  filename = "./data/png/cyl/covid19_cyl_plotcylnameDetail_confirmed_estimated.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>%
    filter(
      name %in% fnGetNamesList(covid19,n_names)
    ) %>%
    arrange(
      obs_date
    ) %>%
    ggplot(aes(x = obs_date, y=confirmed_estimated)) +
    geom_col() +
    facet_wrap(~name, nrow=2) +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "COVID- Castilla & León Filter Most Confirmed Names, Detail Evolution for Covid-19  Script in R (confirmed_estimated)",
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

fnPlotcylLastdate <- function(covid19){
  
  filename = "./data/png/cyl/covid19_cyl_plotcylLastdate.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>% 
    arrange(
      desc(obs_date)
    ) %>%
    filter (
      !is.na(confirmed),
      !is.na(confirmed_new),
      !is.na(confirmed_estimated),
      !is.na(recovered),
      !is.na(death),
      !is.na(uci),
      !is.na(hospitalized)
    ) %>% 
    head(
      1              # Nos quedamos con la última
    ) %>%
    gather(
      "type_cases",
      "cases",
      3:8
    )%>%
    ggplot() +
    geom_bar(aes (x=type_cases, fill = type_cases, y=cases),stat = "identity") +
    coord_polar() +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "Castilla & León Evolution for Covid-19  Script in R (Last Date)",
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

fnPlotcylSalamancaLastdate <- function(covid19){
  
  filename = "./data/png/cyl/covid19_cyl_plotcylSalamancaLastdate.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>% 
    arrange(
      desc(obs_date)
    ) %>%
    filter (
      !is.na(confirmed),
      !is.na(confirmed_new),
      !is.na(confirmed_estimated),
      !is.na(recovered),
      !is.na(death),
      !is.na(uci),
      !is.na(hospitalized),
      name == 'Salamanca'
    ) %>% 
    head(
      1              # Nos quedamos con la última
    ) %>%
    gather(
      "type_cases",
      "cases",
      3:8
    )%>%
    ggplot() +
    geom_bar(aes (x=type_cases, fill = type_cases, y=cases),stat = "identity") +
    coord_polar() +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "Salamanca Evolution for Covid-19  Script in R (Last Date)",
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

fnPlotcyl_lines <- function(covid19){
  
  filename = "./data/png/cyl/covid19_cyl_plotcyl_lines.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>% 
    arrange(
      obs_date
    ) %>%
    group_by(
      obs_date
    ) %>%
    filter (
      !is.na(confirmed),
      !is.na(confirmed_new),
      !is.na(uci),
      !is.na(recovered),
      !is.na(hospitalized),
      !is.na(death)
    ) %>%
    summarise(
      confirmed      = sum(confirmed),
      confirmed_new  = sum(confirmed_new),
      uci            = sum(uci),
      recovered      = sum(recovered),
      hospitalized   = sum(hospitalized),
      death          = sum(death)
    )%>%
    ggplot(aes(x = obs_date, group = 1)) +
    geom_line(aes(y = confirmed)     ,  color = "black")   +
    geom_line(aes(y = uci)           ,  color = "yellow")  +
    geom_line(aes(y = recovered)     ,  color = "green")   +
    geom_line(aes(y = hospitalized)  ,  color = "blue")    +
    geom_line(aes(y = death)         ,  color = "red")     +
    geom_line(aes(y = confirmed_new) ,  color = "orange")  +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "COVID-19 Castilla & León Evo General Lines for Covid-19  Script in R",
      x       = "Cases",
      y       = "Date",
      color   = "Data",
      caption = "INFO: confirmed (Black), new_confirmed(Orange), hospitalized (Blue), uci (Yellow), recovered (Green), death (Red) Git: https://github.com/jesusmanuelnieto/covid19.git, @autor: https://etani.es"
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

fnPlotcylDetail_lines <- function(covid19){
  
  filename = "./data/png/cyl/covid19_cyl_plotcylDetail_lines.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>% 
    arrange(
      obs_date
    ) %>%
    filter (
      !is.na(confirmed),
      !is.na(confirmed_new),
      !is.na(uci),
      !is.na(recovered),
      !is.na(hospitalized),
      !is.na(death)
    ) %>%
    ggplot(aes(x = obs_date, group = 1)) +
    geom_line(aes(y = confirmed)     ,  color = "black")   +
    geom_line(aes(y = confirmed_new) ,  color = "orange")  +
    geom_line(aes(y = uci)           ,  color = "yellow")  +
    geom_line(aes(y = recovered)     ,  color = "green")   +
    geom_line(aes(y = hospitalized)  ,  color = "blue")    +
    geom_line(aes(y = death)         ,  color = "red")     +
    facet_wrap(~name, nrow=6)  +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "COVID-19 Castilla & León Evo General Detail Lines for Covid-19  Script in R",
      x       = "Cases",
      y       = "Date",
      color   = "Data",
      caption = "INFO: confirmed (Black), new_confirmed(Orange), hospitalized (Blue), uci (Yellow), recovered (Green), death (Red) Git: https://github.com/jesusmanuelnieto/covid19.git, @autor: https://etani.es"
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

fnPlotcylNameDetail_lines <- function(covid19, n_names){
  
  filename = "./data/png/cyl/covid19_cyl_plotcylNameDetail_lines.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>%
    filter(
      name %in% fnGetNamesList(covid19,n_names)
    )  %>% 
    arrange(
      obs_date
    ) %>%
    filter (
      !is.na(confirmed),
      !is.na(confirmed_new),
      !is.na(uci),
      !is.na(recovered),
      !is.na(hospitalized),
      !is.na(death)
    ) %>%
    ggplot(aes(x = obs_date, group = 1)) +
    geom_line(aes(y = confirmed)     ,  color = "black")   +
    geom_line(aes(y = confirmed_new) ,  color = "orange")  +
    geom_line(aes(y = uci)           ,  color = "yellow")  +
    geom_line(aes(y = recovered)     ,  color = "green")   +
    geom_line(aes(y = hospitalized)  ,  color = "blue")    +
    geom_line(aes(y = death)         ,  color = "red")     +
    facet_wrap(~name, nrow=4)  +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "COVID- Castilla & León Filter Most Confirmed CCAA,Names, Detail Evolution for Covid-19  Script in R",
      x       = "Cases",
      y       = "Date",
      color   = "Data",
      caption = "INFO: confirmed (Black), new_confirmed(Orange), hospitalized (Blue), uci (Yellow), recovered (Green), death (Red) Git: https://github.com/jesusmanuelnieto/covid19.git, @autor: https://etani.es"
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

fnMaincyl <- function (path_wd, path_dataset,path_dataframe,deathTax,n_names){

  fnLoad_libraries_cyl()
  setwd(path_wd)
  
  covid19_cyl <-fnImportData_cyl(path_dataset,deathTax)
  
  if (file.exists(path_dataframe)) 
    file.remove(path_dataframe)
  write_csv2(covid19_cyl,path = path_dataframe)
  
  # Plots -------------------------------------
  
  # confirmed
  fnPlotcyl_confirmed(covid19_cyl)
  fnPlotcylDetail_confirmed(covid19_cyl)
  fnPlotcylNameDetail_confirmed(covid19_cyl, n_names)
  
  # confirmedrecovered
  fnPlotcyl_confirmedrecovered(covid19_cyl)
  fnPlotcylDetail_confirmedrecovered(covid19_cyl)
  fnPlotcylNameDetail_confirmedrecovered(covid19_cyl, n_names)
  
  # confirmed_estimated
  fnPlotcyl_confirmed_estimated(covid19_cyl)
  fnPlotcylDetail_confirmed_estimated(covid19_cyl)
  fnPlotcylNameDetail_confirmed_estimated(covid19_cyl, n_names)
  
  # lastdate
  fnPlotcylLastdate(covid19_cyl)
  fnPlotcylSalamancaLastdate(covid19_cyl)
  
  # lines
  fnPlotcyl_lines(covid19_cyl)
  fnPlotcylDetail_lines(covid19_cyl)
  fnPlotcylNameDetail_lines(covid19_cyl, n_names)
  
  return ("Execution OK")
}


# Main --------------------------------------------------------------------

"
  fnMain:
    path_wd         : Path working directory,
    path_dataset    : Paths for dataset IN,
    path_dataframe  : Path for dataframe OUT,
    deathTax        : Death tax for Covid-19,
    n_names         : Number of cca.names who show in detail wrap
"

fnMaincyl("~/Nextcloud/Documents/Apuntes Actuales/R/covid19",
       c("./data/csv/cyl/covid19_cyl_dataset1.csv","./data/csv/cyl/covid19_cyl_dataset2.csv"),
       "./data/csv/cyl/covid19_cyl_dataframe.csv",
       1.4,
       4
      )
