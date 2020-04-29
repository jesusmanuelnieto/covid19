#!/bin/bash
# -*- ENCODING: UTF-8 -*-

#  @script:         covid19_cyl
#  @autor:          Jesús Manuel Nieto Carracedo
#  @email1:         jesusmanuel.nieto@etani.es
#  @email2:         jesusmanuel.nieto@gmail.com
#  @web   :         https://etani.es
#  @description:    script para reubicar ficheros del repositorio covid-19

# ZONA DE VARIABLES

PATH_IN_DATA_ZIP="/home/jesus/Nextcloud/Documents/Apuntes Actuales/R/covid19/data/zip" 
PATH_OUT_DATA_ZIP="/var/www/html/etaniweb/data/zip/covid-19"

PATH_IN_DATA_CSV_GLOBAL="/home/jesus/Nextcloud/Documents/Apuntes Actuales/R/covid19/data/csv/global" 
PATH_OUT_DATA_CSV_GLOBAL="/var/www/html/etaniweb/data/csv/covid-19/global"
PATH_IN_DATA_CSV_ESP="/home/jesus/Nextcloud/Documents/Apuntes Actuales/R/covid19/data/csv/esp" 
PATH_OUT_DATA_CSV_ESP="/var/www/html/etaniweb/data/csv/covid-19/esp"
PATH_IN_DATA_CSV_CYL="/home/jesus/Nextcloud/Documents/Apuntes Actuales/R/covid19/data/csv/cyl" 
PATH_OUT_DATA_CSV_CYL="/var/www/html/etaniweb/data/csv/covid-19/cyl"

PATH_IN_DATA_PNG_GLOBAL="/home/jesus/Nextcloud/Documents/Apuntes Actuales/R/covid19/data/png/global" 
PATH_OUT_DATA_PNG_GLOBAL="/var/www/html/etaniweb/images/covid-19/global"
PATH_IN_DATA_PNG_ESP="/home/jesus/Nextcloud/Documents/Apuntes Actuales/R/covid19/data/png/esp" 
PATH_OUT_DATA_PNG_ESP="/var/www/html/etaniweb/images/covid-19/esp"
PATH_IN_DATA_PNG_CYL="/home/jesus/Nextcloud/Documents/Apuntes Actuales/R/covid19/data/png/cyl" 
PATH_OUT_DATA_PNG_CYL="/var/www/html/etaniweb/images/covid-19/cyl"

PATH_EXECUTE_R="/home/jesus/Nextcloud/Documents/Apuntes Actuales/R/covid19/scripts/covid19_console.R"
PATH_CONFIG_R_WORKING_DIRECTORY="/home/jesus/Nextcloud/Documents/Apuntes Actuales/R/covid19"
PATH_CONFIG_R_GLOBAL="${PATH_IN_DATA_CSV_GLOBAL}/covid19_global_config.csv" 
PATH_CONFIG_R_ESP="${PATH_IN_DATA_CSV_ESP}/covid19_esp_config.csv" 
PATH_CONFIG_R_CYL="${PATH_IN_DATA_CSV_CYL}/covid19_cyl_config.csv" 


clear
echo "**** INICIO DEL SCRIPT ****"

# EJECUCIÓN SCRIPT R
echo "Ejecutamos el script R para generar los datos ..."

Rscript "${PATH_EXECUTE_R}" "${PATH_CONFIG_R_WORKING_DIRECTORY}" "${PATH_CONFIG_R_GLOBAL}" "${PATH_CONFIG_R_ESP}" "${PATH_CONFIG_R_CYL}"

# ZONA DE ZIPS

echo "Borrado los ficheros .ZIP ..."

rm -r "${PATH_OUT_DATA_ZIP}"
mkdir "${PATH_OUT_DATA_ZIP}"

echo "Copia los ficheros .ZIP ..."

cp "${PATH_IN_DATA_ZIP}/global_png.zip" "${PATH_OUT_DATA_ZIP}/global_png.zip"
cp "${PATH_IN_DATA_ZIP}/esp_png.zip" "${PATH_OUT_DATA_ZIP}/esp_png.zip"
cp "${PATH_IN_DATA_ZIP}/cyl_png.zip" "${PATH_OUT_DATA_ZIP}/cyl_png.zip"


# ZONA DE CSVS

echo "Borrado los ficheros .CSV ..."

rm -r "${PATH_OUT_DATA_CSV_GLOBAL}"
mkdir "${PATH_OUT_DATA_CSV_GLOBAL}"
rm -r "${PATH_OUT_DATA_CSV_ESP}"
mkdir "${PATH_OUT_DATA_CSV_ESP}"
rm -r "${PATH_OUT_DATA_CSV_CYL}"
mkdir "${PATH_OUT_DATA_CSV_CYL}"

echo "Copia los ficheros .CSV ..."

cp "${PATH_IN_DATA_CSV_GLOBAL}/covid19_global_dataset.csv" "${PATH_OUT_DATA_CSV_GLOBAL}/covid19_global_dataset.csv"
cp "${PATH_IN_DATA_CSV_GLOBAL}/covid19_global_dataframe.csv" "${PATH_OUT_DATA_CSV_GLOBAL}/covid19_global_dataframe.csv"
cp "${PATH_IN_DATA_CSV_ESP}/covid19_esp_dataset.csv" "${PATH_OUT_DATA_CSV_ESP}/covid19_esp_dataset.csv"
cp "${PATH_IN_DATA_CSV_ESP}/covid19_esp_dataframe.csv" "${PATH_OUT_DATA_CSV_ESP}/covid19_esp_dataframe.csv"
cp "${PATH_IN_DATA_CSV_CYL}/covid19_cyl_dataset1.csv" "${PATH_OUT_DATA_CSV_CYL}/covid19_cyl_dataset1.csv"
cp "${PATH_IN_DATA_CSV_CYL}/covid19_cyl_dataset2.csv" "${PATH_OUT_DATA_CSV_CYL}/covid19_cyl_dataset2.csv"
cp "${PATH_IN_DATA_CSV_CYL}/covid19_cyl_dataframe.csv" "${PATH_OUT_DATA_CSV_CYL}/covid19_cyl_dataframe.csv"

# ZONA DE PNGS

echo "Borrado los ficheros .PNG ..."

## GLOBAL ##
#confirmed
if [ -f "${PATH_OUT_DATA_PNG_GLOBAL}/confirmed/covid19_global_plotGlobal_confirmed.png" ];
then
    rm "${PATH_OUT_DATA_PNG_GLOBAL}/confirmed/covid19_global_plotGlobal_confirmed.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_GLOBAL}/confirmed/covid19_global_plotGlobalCountryDetail_confirmed.png" ];
then
    rm "${PATH_OUT_DATA_PNG_GLOBAL}/confirmed/covid19_global_plotGlobalCountryDetail_confirmed.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_GLOBAL}/confirmed/covid19_global_plotGlobalDetail_confirmed.png" ];
then
    rm "${PATH_OUT_DATA_PNG_GLOBAL}/confirmed/covid19_global_plotGlobalDetail_confirmed.png"
fi
#confirmed-estimated
if [ -f "${PATH_OUT_DATA_PNG_GLOBAL}/confirmed-estimated/covid19_global_plotGlobal_confirmed_estimated.png" ];
then
    rm "${PATH_OUT_DATA_PNG_GLOBAL}/confirmed-estimated/covid19_global_plotGlobal_confirmed_estimated.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_GLOBAL}/confirmed-estimated/covid19_global_plotGlobalCountryDetail_confirmed_estimated.png" ];
then
    rm "${PATH_OUT_DATA_PNG_GLOBAL}/confirmed-estimated/covid19_global_plotGlobalCountryDetail_confirmed_estimated.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_GLOBAL}/confirmed-estimated/covid19_global_plotGlobalDetail_confirmed_estimated.png" ];
then
    rm "${PATH_OUT_DATA_PNG_GLOBAL}/confirmed-estimated/covid19_global_plotGlobalDetail_confirmed_estimated.png"
fi
#confirmedrecovered
if [ -f "${PATH_OUT_DATA_PNG_GLOBAL}/confirmedrecovered/covid19_global_plotGlobal_confirmedrecovered.png" ];
then
    rm "${PATH_OUT_DATA_PNG_GLOBAL}/confirmedrecovered/covid19_global_plotGlobal_confirmedrecovered.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_GLOBAL}/confirmedrecovered/covid19_global_plotGlobalCountryDetail_confirmedrecovered.png" ];
then
    rm "${PATH_OUT_DATA_PNG_GLOBAL}/confirmedrecovered/covid19_global_plotGlobalCountryDetail_confirmedrecovered.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_GLOBAL}/confirmedrecovered/covid19_global_plotGlobalDetail_confirmedrecovered.png" ];
then
    rm "${PATH_OUT_DATA_PNG_GLOBAL}/confirmedrecovered/covid19_global_plotGlobalDetail_confirmedrecovered.png"
fi
#general
if [ -f "${PATH_OUT_DATA_PNG_GLOBAL}/general/covid19_global_plotGlobalLastdate.png" ];
then
    rm "${PATH_OUT_DATA_PNG_GLOBAL}/general/covid19_global_plotGlobalLastdate.png"
fi

## ESP ##
#confirmed
if [ -f "${PATH_OUT_DATA_PNG_ESP}/confirmed/covid19_esp_plotEspccaanameDetail_confirmed.png" ];
then
    rm "${PATH_OUT_DATA_PNG_ESP}/confirmed/covid19_esp_plotEspccaanameDetail_confirmed.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_ESP}/confirmed/covid19_esp_plotEsp_confirmed.png" ];
then
    rm "${PATH_OUT_DATA_PNG_ESP}/confirmed/covid19_esp_plotEsp_confirmed.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_ESP}/confirmed/covid19_esp_plotEspDetail_confirmed.png" ];
then
    rm "${PATH_OUT_DATA_PNG_ESP}/confirmed/covid19_esp_plotEspDetail_confirmed.png"
fi
#confirmed-estimated
if [ -f "${PATH_OUT_DATA_PNG_ESP}/confirmed-estimated/covid19_esp_plotEspccaanameDetail_confirmed_estimated.png" ];
then
    rm "${PATH_OUT_DATA_PNG_ESP}/confirmed-estimated/covid19_esp_plotEspccaanameDetail_confirmed_estimated.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_ESP}/confirmed-estimated/covid19_esp_plotEsp_confirmed_estimated.png" ];
then
    rm "${PATH_OUT_DATA_PNG_ESP}/confirmed-estimated/covid19_esp_plotEsp_confirmed_estimated.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_ESP}/confirmed-estimated/covid19_esp_plotEspDetail_confirmed_estimated.png" ];
then
    rm "${PATH_OUT_DATA_PNG_ESP}/confirmed-estimated/covid19_esp_plotEspDetail_confirmed_estimated.png"
fi
#confirmedrecovered
if [ -f "${PATH_OUT_DATA_PNG_ESP}/confirmedrecovered/covid19_esp_plotEspccaanameDetail_confirmedrecovered.png" ];
then
    rm "${PATH_OUT_DATA_PNG_ESP}/confirmedrecovered/covid19_esp_plotEspccaanameDetail_confirmedrecovered.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_ESP}/confirmedrecovered/covid19_esp_plotEsp_confirmedrecovered.png" ];
then
    rm "${PATH_OUT_DATA_PNG_ESP}/confirmedrecovered/covid19_esp_plotEsp_confirmedrecovered.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_ESP}/confirmedrecovered/covid19_esp_plotEspDetail_confirmedrecovered.png" ];
then
    rm "${PATH_OUT_DATA_PNG_ESP}/confirmedrecovered/covid19_esp_plotEspDetail_confirmedrecovered.png"
fi
#general
if [ -f "${PATH_OUT_DATA_PNG_ESP}/general/covid19_esp_plotEspLastdate.png" ];
then
    rm "${PATH_OUT_DATA_PNG_ESP}/general/covid19_esp_plotEspLastdate.png"
fi
#lines
if [ -f "${PATH_OUT_DATA_PNG_ESP}/lines/covid19_esp_plotEspCcaanameDetail_lines.png" ];
then
    rm "${PATH_OUT_DATA_PNG_ESP}/lines/covid19_esp_plotEspCcaanameDetail_lines.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_ESP}/lines/covid19_esp_plotEspDetail_lines.png" ];
then
    rm "${PATH_OUT_DATA_PNG_ESP}/lines/covid19_esp_plotEspDetail_lines.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_ESP}/lines/covid19_esp_plotEsp_lines.png" ];
then
    rm "${PATH_OUT_DATA_PNG_ESP}/lines/covid19_esp_plotEsp_lines.png"
fi

## CYL ##
#confirmed
if [ -f "${PATH_OUT_DATA_PNG_CYL}/confirmed/covid19_cyl_plotcyl_confirmed.png" ];
then
    rm "${PATH_OUT_DATA_PNG_CYL}/confirmed/covid19_cyl_plotcyl_confirmed.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_CYL}/confirmed/covid19_cyl_plotcylDetail_confirmed.png" ];
then
    rm "${PATH_OUT_DATA_PNG_CYL}/confirmed/covid19_cyl_plotcylDetail_confirmed.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_CYL}/confirmed/covid19_cyl_plotcylnameDetail_confirmed.png" ];
then
    rm "${PATH_OUT_DATA_PNG_CYL}/confirmed/covid19_cyl_plotcylnameDetail_confirmed.png"
fi
#confirmed-estimated
if [ -f "${PATH_OUT_DATA_PNG_CYL}/confirmed-estimated/covid19_cyl_plotcyl_confirmed_estimated.png" ];
then
    rm "${PATH_OUT_DATA_PNG_CYL}/confirmed-estimated/covid19_cyl_plotcyl_confirmed_estimated.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_CYL}/confirmed-estimated/covid19_cyl_plotcylDetail_confirmed_estimated.png" ];
then
    rm "${PATH_OUT_DATA_PNG_CYL}/confirmed-estimated/covid19_cyl_plotcylDetail_confirmed_estimated.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_CYL}/confirmed-estimated/covid19_cyl_plotcylnameDetail_confirmed_estimated.png" ];
then
    rm "${PATH_OUT_DATA_PNG_CYL}/confirmed-estimated/covid19_cyl_plotcylnameDetail_confirmed_estimated.png"
fi
#confirmedrecovered
if [ -f "${PATH_OUT_DATA_PNG_CYL}/confirmedrecovered/covid19_cyl_plotcyl_confirmedrecovered.png" ];
then
    rm "${PATH_OUT_DATA_PNG_CYL}/confirmedrecovered/covid19_cyl_plotcyl_confirmedrecovered.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_CYL}/confirmedrecovered/covid19_cyl_plotcylDetail_confirmedrecovered.png" ];
then
    rm "${PATH_OUT_DATA_PNG_CYL}/confirmedrecovered/covid19_cyl_plotcylDetail_confirmedrecovered.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_CYL}/confirmedrecovered/covid19_cyl_plotcylnameDetail_confirmedrecovered.png" ];
then
    rm "${PATH_OUT_DATA_PNG_CYL}/confirmedrecovered/covid19_cyl_plotcylnameDetail_confirmedrecovered.png"
fi
#general
if [ -f "${PATH_OUT_DATA_PNG_CYL}/general/covid19_cyl_plotcylLastdate.png" ];
then
    rm "${PATH_OUT_DATA_PNG_CYL}/general/covid19_cyl_plotcylLastdate.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_CYL}/general/covid19_cyl_plotcylSalamancaLastdate.png" ];
then
    rm "${PATH_OUT_DATA_PNG_CYL}/general/covid19_cyl_plotcylSalamancaLastdate.png"
fi
#lines
if [ -f "${PATH_OUT_DATA_PNG_CYL}/lines/covid19_cyl_plotcylDetail_lines.png" ];
then
    rm "${PATH_OUT_DATA_PNG_CYL}/lines/covid19_cyl_plotcylDetail_lines.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_CYL}/lines/covid19_cyl_plotcyl_lines.png" ];
then
    rm "${PATH_OUT_DATA_PNG_CYL}/lines/covid19_cyl_plotcyl_lines.png"
fi
if [ -f "${PATH_OUT_DATA_PNG_CYL}/lines/covid19_cyl_plotcylNameDetail_lines.png" ];
then
    rm "${PATH_OUT_DATA_PNG_CYL}/lines/covid19_cyl_plotcylNameDetail_lines.png"
fi



echo "Copia los ficheros .PNG ..."

## GLOBAL ##
#confirmed
cp "${PATH_IN_DATA_PNG_GLOBAL}/covid19_global_plotGlobal_confirmed.png" "${PATH_OUT_DATA_PNG_GLOBAL}/confirmed/covid19_global_plotGlobal_confirmed.png"
cp "${PATH_IN_DATA_PNG_GLOBAL}/covid19_global_plotGlobalCountryDetail_confirmed.png" "${PATH_OUT_DATA_PNG_GLOBAL}/confirmed/covid19_global_plotGlobalCountryDetail_confirmed.png"
cp "${PATH_IN_DATA_PNG_GLOBAL}/covid19_global_plotGlobalDetail_confirmed.png" "${PATH_OUT_DATA_PNG_GLOBAL}/confirmed/covid19_global_plotGlobalDetail_confirmed.png"
#confirmed-estimated
cp "${PATH_IN_DATA_PNG_GLOBAL}/covid19_global_plotGlobal_confirmed_estimated.png" "${PATH_OUT_DATA_PNG_GLOBAL}/confirmed-estimated/covid19_global_plotGlobal_confirmed_estimated.png"
cp "${PATH_IN_DATA_PNG_GLOBAL}/covid19_global_plotGlobalCountryDetail_confirmed_estimated.png" "${PATH_OUT_DATA_PNG_GLOBAL}/confirmed-estimated/covid19_global_plotGlobalCountryDetail_confirmed_estimated.png"
cp "${PATH_IN_DATA_PNG_GLOBAL}/covid19_global_plotGlobalDetail_confirmed_estimated.png" "${PATH_OUT_DATA_PNG_GLOBAL}/confirmed-estimated/covid19_global_plotGlobalDetail_confirmed_estimated.png"
#confirmedrecovered
cp "${PATH_IN_DATA_PNG_GLOBAL}/covid19_global_plotGlobal_confirmedrecovered.png" "${PATH_OUT_DATA_PNG_GLOBAL}/confirmedrecovered/covid19_global_plotGlobal_confirmedrecovered.png"
cp "${PATH_IN_DATA_PNG_GLOBAL}/covid19_global_plotGlobalCountryDetail_confirmedrecovered.png" "${PATH_OUT_DATA_PNG_GLOBAL}/confirmedrecovered/covid19_global_plotGlobalCountryDetail_confirmedrecovered.png"
cp "${PATH_IN_DATA_PNG_GLOBAL}/covid19_global_plotGlobalDetail_confirmedrecovered.png" "${PATH_OUT_DATA_PNG_GLOBAL}/confirmedrecovered/covid19_global_plotGlobalDetail_confirmedrecovered.png"
#general
cp "${PATH_IN_DATA_PNG_GLOBAL}/covid19_global_plotGlobalLastdate.png" "${PATH_OUT_DATA_PNG_GLOBAL}/general/covid19_global_plotGlobalLastdate.png"

## ESP ##
#confirmed
cp "${PATH_IN_DATA_PNG_ESP}/covid19_esp_plotEspccaanameDetail_confirmed.png" "${PATH_OUT_DATA_PNG_ESP}/confirmed/covid19_esp_plotEspccaanameDetail_confirmed.png"
cp "${PATH_IN_DATA_PNG_ESP}/covid19_esp_plotEsp_confirmed.png" "${PATH_OUT_DATA_PNG_ESP}/confirmed/covid19_esp_plotEsp_confirmed.png"
cp "${PATH_IN_DATA_PNG_ESP}/covid19_esp_plotEspDetail_confirmed.png" "${PATH_OUT_DATA_PNG_ESP}/confirmed/covid19_esp_plotEspDetail_confirmed.png"
#confirmed-estimated
cp "${PATH_IN_DATA_PNG_ESP}/covid19_esp_plotEspccaanameDetail_confirmed_estimated.png" "${PATH_OUT_DATA_PNG_ESP}/confirmed-estimated/covid19_esp_plotEspccaanameDetail_confirmed_estimated.png"
cp "${PATH_IN_DATA_PNG_ESP}/covid19_esp_plotEsp_confirmed_estimated.png" "${PATH_OUT_DATA_PNG_ESP}/confirmed-estimated/covid19_esp_plotEsp_confirmed_estimated.png"
cp "${PATH_IN_DATA_PNG_ESP}/covid19_esp_plotEspDetail_confirmed_estimated.png" "${PATH_OUT_DATA_PNG_ESP}/confirmed-estimated/covid19_esp_plotEspDetail_confirmed_estimated.png"
#confirmedrecovered
cp "${PATH_IN_DATA_PNG_ESP}/covid19_esp_plotEspccaanameDetail_confirmedrecovered.png" "${PATH_OUT_DATA_PNG_ESP}/confirmedrecovered/covid19_esp_plotEspccaanameDetail_confirmedrecovered.png"
cp "${PATH_IN_DATA_PNG_ESP}/covid19_esp_plotEsp_confirmedrecovered.png" "${PATH_OUT_DATA_PNG_ESP}/confirmedrecovered/covid19_esp_plotEsp_confirmedrecovered.png"
cp "${PATH_IN_DATA_PNG_ESP}/covid19_esp_plotEspDetail_confirmedrecovered.png" "${PATH_OUT_DATA_PNG_ESP}/confirmedrecovered/covid19_esp_plotEspDetail_confirmedrecovered.png"
#general
cp "${PATH_IN_DATA_PNG_ESP}/covid19_esp_plotEspLastdate.png" "${PATH_OUT_DATA_PNG_ESP}/general/covid19_esp_plotEspLastdate.png"
#lines
cp "${PATH_IN_DATA_PNG_ESP}/covid19_esp_plotEspCcaanameDetail_lines.png" "${PATH_OUT_DATA_PNG_ESP}/lines/covid19_esp_plotEspCcaanameDetail_lines.png"
cp "${PATH_IN_DATA_PNG_ESP}/covid19_esp_plotEspDetail_lines.png" "${PATH_OUT_DATA_PNG_ESP}/lines/covid19_esp_plotEspDetail_lines.png"
cp "${PATH_IN_DATA_PNG_ESP}/covid19_esp_plotEsp_lines.png" "${PATH_OUT_DATA_PNG_ESP}/lines/covid19_esp_plotEsp_lines.png"

## CYL ##
#confirmed
cp "${PATH_IN_DATA_PNG_CYL}/covid19_cyl_plotcyl_confirmed.png" "${PATH_OUT_DATA_PNG_CYL}/confirmed/covid19_cyl_plotcyl_confirmed.png"
cp "${PATH_IN_DATA_PNG_CYL}/covid19_cyl_plotcylDetail_confirmed.png" "${PATH_OUT_DATA_PNG_CYL}/confirmed/covid19_cyl_plotcylDetail_confirmed.png"
cp "${PATH_IN_DATA_PNG_CYL}/covid19_cyl_plotcylnameDetail_confirmed.png" "${PATH_OUT_DATA_PNG_CYL}/confirmed/covid19_cyl_plotcylnameDetail_confirmed.png"
#confirmed-estimated
cp "${PATH_IN_DATA_PNG_CYL}/covid19_cyl_plotcyl_confirmed_estimated.png" "${PATH_OUT_DATA_PNG_CYL}/confirmed-estimated/covid19_cyl_plotcyl_confirmed_estimated.png"
cp "${PATH_IN_DATA_PNG_CYL}/covid19_cyl_plotcylDetail_confirmed_estimated.png" "${PATH_OUT_DATA_PNG_CYL}/confirmed-estimated/covid19_cyl_plotcylDetail_confirmed_estimated.png"
cp "${PATH_IN_DATA_PNG_CYL}/covid19_cyl_plotcylnameDetail_confirmed_estimated.png" "${PATH_OUT_DATA_PNG_CYL}/confirmed-estimated/covid19_cyl_plotcylnameDetail_confirmed_estimated.png"
#confirmedrecovered
cp "${PATH_IN_DATA_PNG_CYL}/covid19_cyl_plotcyl_confirmedrecovered.png" "${PATH_OUT_DATA_PNG_CYL}/confirmedrecovered/covid19_cyl_plotcyl_confirmedrecovered.png"
cp "${PATH_IN_DATA_PNG_CYL}/covid19_cyl_plotcylDetail_confirmedrecovered.png" "${PATH_OUT_DATA_PNG_CYL}/confirmedrecovered/covid19_cyl_plotcylDetail_confirmedrecovered.png"
cp "${PATH_IN_DATA_PNG_CYL}/covid19_cyl_plotcylnameDetail_confirmedrecovered.png" "${PATH_OUT_DATA_PNG_CYL}/confirmedrecovered/covid19_cyl_plotcylnameDetail_confirmedrecovered.png"
#general
cp "${PATH_IN_DATA_PNG_CYL}/covid19_cyl_plotcylLastdate.png" "${PATH_OUT_DATA_PNG_CYL}/general/covid19_cyl_plotcylLastdate.png"
cp "${PATH_IN_DATA_PNG_CYL}/covid19_cyl_plotcylSalamancaLastdate.png" "${PATH_OUT_DATA_PNG_CYL}/general/covid19_cyl_plotcylSalamancaLastdate.png"
#lines
cp "${PATH_IN_DATA_PNG_CYL}/covid19_cyl_plotcylDetail_lines.png" "${PATH_OUT_DATA_PNG_CYL}/lines/covid19_cyl_plotcylDetail_lines.png"
cp "${PATH_IN_DATA_PNG_CYL}/covid19_cyl_plotcyl_lines.png" "${PATH_OUT_DATA_PNG_CYL}/lines/covid19_cyl_plotcyl_lines.png"
cp "${PATH_IN_DATA_PNG_CYL}/covid19_cyl_plotcylNameDetail_lines.png" "${PATH_OUT_DATA_PNG_CYL}/lines/covid19_cyl_plotcylNameDetail_lines.png"

echo "**** FIN DEL SCRIPT ****"