# Prueba de función mapCom para realizar mapa de valores comunales
# Francisco Zambrano Bigiarini (frzambra@gmail.com)
# agosto 2014

require('maptools')
source('modisDate.R')
source('mapCom.R')

#data.frame en que cada columna corresponde a un periodo y cada fila a una comuna de la región
data<-read.csv2('data/data.csv')

#objeto Date que corresponde a las fechas de cada columna
dates<-modisDate(as.Date(c('2000-02-18','2014-07-28')))

#poligono de la región del Bío-Bío con las 54 comunas
shp<-readShapePoly('shp/r8.shp')

#aplica función mapCom para generar mapa con valores continuos
mapCom(shp,data,fill='X1',shp.u='COD_COMUNA',data.u='cod')

#Defino clases de valores para mapear de forma discreta
data2map<-data.frame(cod=data$cod,value=cut(data$X1*100,seq(0,100,10),include.lowest=TRUE))

#Define colores para las clases
values<-c("[0,10]"="#8B0000","(10,20]"="#A43800","(20,30]"="#BE7100","(30,40]"="#D8AA00",
          "(40,50]"="#F2E200","(50,60]"="#E2ED00","(60,70]"="#AACB00","(70,80]"="#71A800",
          "(80,90]"="#388600","(90,100]"="#006400")

mapCom(shp,data=data2map,fill='value',shp.u='COD_COMUNA',data.u='cod',fill.values=values)
