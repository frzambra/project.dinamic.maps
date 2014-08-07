# Prueba de función mapCom para realizar mapa de valores comunales
# Francisco Zambrano Bigiarini (frzambra@gmail.com)
# agosto 2014

require(maptools)

setwd('~/Dropbox/scripts/R/project.dinamic.maps')
data<-read.csv2('data/data.csv')
regshp<-readShapePoly('shp/r8.shp')

data<-data.frame(cod=regshp$COD_COMUNA,data2[,1:331])


values<-c("[0,10]"="#8B0000","(10,20]"="#A43800","(20,30]"="#BE7100","(30,40]"="#D8AA00","(40,50]"="#F2E200","(50,60]"="#E2ED00","(60,70]"="#AACB00","(70,80]"="#71A800","(80,90]"="#388600","(90,100]"="#006400")
mapCom(shp,data,fill='VCI',shp.u='COD_COMUNA',data.u='cod',fill.values=values)
