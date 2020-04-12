"
  @script:      covid19_global
  @autor:       Jesús Manuel Nieto Carracedo
  @email1:      jesusmanuel.nieto@etani.es
  @email2:      jesusmanuel.nieto@gmail.com
  @web   :      https://etani.es
  @linkedin:    https://es.linkedin.com/in/jes%C3%BAs-manuel-nieto-carracedo-77128424
  @github:      https://github.com/jesusmanuelnieto
  @description: Script para la manipulación y generación de varías gráficas sobre la evolución del
  virus COVID-19 a nivel mundial.

  @repository:  https://github.com/jesusmanuelnieto/covid19.git
  @sources:
  {
    @data:         https://www.kaggle.com/sudalairajkumar/novel-corona-virus-2019-dataset#covid_19_data.csv
    @deathTax:     http://www.telemadrid.es/coronavirus-covid-19/mortalidad-COVID-19-Wuhan-menor-estimado-0-2214678548--20200319021221.html
  }
"

# Libraries ---------------------------------------------------------------

fnLoad_libraries <- function(){
  library(tidyverse)
  library(modelr)
  options(na.action = na.warn) # No tenemos en cuenta los NA
}

# Import Data -------------------------------------------------------------

fnImportData_global <- function (path_dataset,deathTax) {
  
  read.csv(path_dataset) %>%
    rename (
      confirmed  = Confirmed,
      death      = Deaths,
      recovered  = Recovered,
      obs_date   = ObservationDate,
      country    = Country.Region
    ) %>% 
    group_by(
      country,
      obs_date
    ) %>%
    summarise(
      confirmed             = sum(confirmed),
      death                 = sum(death),
      recovered             = sum(recovered)
    ) %>%
    mutate (
      perc_exit              = (death * 100)/(death+recovered),
      confirmedrecovered     = confirmed - recovered,
      confirmed_estimated    = (death * 100) /  deathTax
    ) %>%
    return()
}


# Plots -------------------------------------------------------------------

fnPlotGlobal_confirmed <- function(covid19){
  
  filename = "./data/png/global/covid19_global_plotGlobal_confirmed.png"
  
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
      title   = "COVID- Global Evolution for Covid-19  Script in R (confirmed)",
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

fnPlotGlobalDetail_confirmed <- function(covid19){
  
  filename = "./data/png/global/covid19_global_plotGlobalDetail_confirmed.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>%
    arrange(
      obs_date
    ) %>%
    ggplot(aes(x = obs_date, y=confirmed)) +
    geom_col() +
    facet_wrap(~country, nrow=7) +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = " Global Detail Evolution for Covid-19  Script in R (confirmed)",
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

fnPlotGlobalCountyDetail_confirmed <- function(covid19, countries){
  
  filename = "./data/png/global/covid19_global_plotGlobalCountryDetail_confirmed.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>%
    filter(
      country %in% countries
    ) %>%
    arrange(
      obs_date
    ) %>%
    ggplot(aes(x = obs_date, y=confirmed)) +
    geom_col() +
    facet_wrap(~country, nrow=3) +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "Global Filter By Country, Detail Evolution for Covid-19  Script in R (confirmed)",
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

fnPlotGlobal_confirmedrecovered <- function(covid19){
  
  filename = "./data/png/global/covid19_global_plotGlobal_confirmedrecovered.png"
  
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
      title   = "COVID- Global Evolution for Covid-19  Script in R (confirmedrecovered)",
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

fnPlotGlobalDetail_confirmedrecovered <- function(covid19){
  
  filename = "./data/png/global/covid19_global_plotGlobalDetail_confirmedrecovered.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>%
    arrange(
      obs_date
    ) %>%
    ggplot(aes(x = obs_date, y=confirmedrecovered)) +
    geom_col() +
    facet_wrap(~country, nrow=7) +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = " Global Detail Evolution for Covid-19  Script in R (confirmedrecovered)",
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

fnPlotGlobalCountyDetail_confirmedrecovered <- function(covid19, countries){
  
  filename = "./data/png/global/covid19_global_plotGlobalCountryDetail_confirmedrecovered.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>%
    filter(
      country %in% countries
    ) %>%
    arrange(
      obs_date
    ) %>%
    ggplot(aes(x = obs_date, y=confirmedrecovered)) +
    geom_col() +
    facet_wrap(~country, nrow=3) +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "Global Filter By Country, Detail Evolution for Covid-19  Script in R (confirmedrecovered)",
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


fnPlotGlobal_confirmed_estimated <- function(covid19){
  
  filename = "./data/png/global/covid19_global_plotGlobal_confirmed_estimated.png"
  
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
      title   = "COVID- Global Evolution for Covid-19  Script in R (confirmed_estimated)",
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

fnPlotGlobalDetail_confirmed_estimated <- function(covid19){
  
  filename = "./data/png/global/covid19_global_plotGlobalDetail_confirmed_estimated.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>%
    arrange(
      obs_date
    ) %>%
    ggplot(aes(x = obs_date, y=confirmed_estimated)) +
    geom_col() +
    facet_wrap(~country, nrow=7) +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = " Global Detail Evolution for Covid-19  Script in R (confirmed_estimated)",
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

fnPlotGlobalCountyDetail_confirmed_estimated <- function(covid19, countries){
  
  filename = "./data/png/global/covid19_global_plotGlobalCountryDetail_confirmed_estimated.png"
  
  if (file.exists(filename)) 
    file.remove(filename)
  
  covid19 %>%
    filter(
      country %in% countries
    ) %>%
    arrange(
      obs_date
    ) %>%
    ggplot(aes(x = obs_date, y=confirmed_estimated)) +
    geom_col() +
    facet_wrap(~country, nrow=3) +
    theme(
      plot.caption = element_text(hjust = 0.5, color="blue", face="bold")
    )+
    labs(
      title   = "Global Filter By Country, Detail Evolution for Covid-19  Script in R (confirmed_estimated)",
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

fnPlotGlobalLastdate <- function(covid19){
  
  filename = "./data/png/global/covid19_global_plotGlobalLastdate.png"
  
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
      !is.na(death),
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
      title   = "Global Evolution for Covid-19  Script in R (Last Date)",
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

fnMain <- function (path_wd, path_dataset,path_dataframe,deathTax,countries){
  
  fnLoad_libraries()
  setwd(path_wd)
  
  covid19_global <-fnImportData_global(path_dataset,deathTax)
  
  if (file.exists(path_dataframe)) 
    file.remove(path_dataframe)
  write_csv2(covid19_global,path = path_dataframe)
  
  # Plots -------------------------------------
  
  # confirmed
  fnPlotGlobal_confirmed(covid19_global)
  fnPlotGlobalDetail_confirmed(covid19_global)
  fnPlotGlobalCountyDetail_confirmed(covid19_global, countries)
  
  # confirmedrecovered
  fnPlotGlobal_confirmedrecovered(covid19_global)
  fnPlotGlobalDetail_confirmedrecovered(covid19_global)
  fnPlotGlobalCountyDetail_confirmedrecovered(covid19_global, countries)
  
  # confirmed_estimated
  fnPlotGlobal_confirmed_estimated(covid19_global)
  fnPlotGlobalDetail_confirmed_estimated(covid19_global)
  fnPlotGlobalCountyDetail_confirmed_estimated(covid19_global, countries)
  
  # lastdate
  fnPlotGlobalLastdate(covid19_global)

  return ("Execution OK")
}

# Main --------------------------------------------------------------------

"
  fnMain:
    path_wd         : Path working directory,
    path_dataset    : Path for dataset IN,
    path_dataframe  : Path for dataframe OUT,
    deathTax        : Death tax for Covid-19,
    countries       : List of countries for filters porpouse
"

fnMain("~/Nextcloud/Documents/Apuntes Actuales/R/covid19",
       "./data/csv/global/covid19_global_dataset.csv",
       "./data/csv/global/covid19_global_dataframe.csv",
       1.4,
       c("Spain","Italy","Mainland China", "South Korea", "US","UK","Iran")
      )
