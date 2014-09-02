rm(list=ls())
library(plyr)
library(stringr)
options(stringsAsFactors = FALSE)
source('modisDate.R')
source('mapCom.R')

data <- ldply(dir("../data/", pattern =  "csv$", full.names = TRUE), function(file){ # file <- dir("../data/",  pattern =  "csv$", full.names = TRUE)[1]
  d <- read.csv2(file)
  d <- cbind(region = as.numeric(str_extract(file, "\\d+")), d)
  names(d)[which(names(d)=="X")] <- "Comuna"
  d
})

regiones_select <- c("Arica y Parinatoca" = 14, "Tarapacá" = 1, "Antofagasta" = 2, "Atacama" = 3, "Coquimbo" = 4,
                     "Valparaíso" = 5, "Metropolitana" = "13", "Libertador Bernardo O'Higgins" = 6, "Maule" = 7,
                     "Bío-Bío" = 8, "Araucanía" = 9, "Los Ríos" = 15, "Los Lagos" = 10,
                     "Aysén del General Ibañez del Campo" = 11, "Magallanes y Antártica Chilena" = 13)

dates_select <- modisDate(as.Date(c('2000-02-18','2017-07-28')))
dates_select <- dates_select[1:sum(str_detect(names(data), "^V\\d+"))]
save(data, regiones_select, dates_select, mapCom, file = "../data/data_app.RData")

load("../data/data_app.RData")

color_palette <-c("[0,10]"="#8B0000","(10,20]"="#A43800","(20,30]"="#BE7100","(30,40]"="#D8AA00",
                  "(40,50]"="#F2E200","(50,60]"="#E2ED00","(60,70]"="#AACB00","(70,80]"="#71A800",
                  "(80,90]"="#388600","(90,100]"="#006400")

save(data, regiones_select, dates_select, mapCom, color_palette, file = "../data/data_app2.RData")

load("../data/data_app2.RData")

indice_select<-c('VCI'='VCI','Anom. Std. NDVI'='SNDVI')

data_vci<-data
rm(data)
load("../data/sndvi.RData")

color_palette2 <-c("[-10,-2]"="#8B0000","(-2,-1.5]"="#A43800",
                   "(-1.5,-1]"="#BE7100","(-1,-0.5]"="#D8AA00",
                   "(-0.5,0]"="#F2E200","(0,0.5]"="#E2ED00",
                   "(0.5,1]"="#AACB00","(1,1.5]"="#71A800",
                   "(1.5,2]"="#388600","(2,10]"="#006400")

save(data_vci,data_sndvi,indice_select, regiones_select, dates_select, mapCom, color_palette,color_palette2, file = "../data/data_app2.RData")
