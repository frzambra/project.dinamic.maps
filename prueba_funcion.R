# Prueba de funci?n mapCom para realizar mapa de valores comunales
# Francisco Zambrano Bigiarini (frzambra@gmail.com)
# agosto 2014

require('maptools')
require('rgeos')
source('modisDate.R')
source('mapCom.R')

#objeto Date que corresponde a las fechas en cada columna
dates<-modisDate(as.Date(c('2000-02-18','2014-07-28')))

#region para la cual se desea hacer el mapa entre "r4" (cuarta region)
#a "r10" (decima region)
reg<-"r4"
fecha<-1 #corresponde a dates[1]

#data.frame en que cada columna corresponde a un periodo y cada fila a una comuna de la regi?n
data<-read.csv2(paste0('data/',reg,'_data.csv'))

#poligono de la regi?n del B?o-B?o con las 54 comunas
shp<-readShapePoly(paste0('shp/',reg,'.shp'))

#aplica funci?n mapCom para generar mapa con valores continuos
#names(data)[3] para que plotee la tercera columna del data.frame
mapCom(shp,data,fill="V1",shp.u='COD_COMUNA',data.u='cod')

#Defino clases de valores para mapear de forma discreta
#Busca la ubicacion 
data2map<-data.frame(cod=data$cod,value=cut(data[,2+fecha]*100,seq(0,100,10),include.lowest=TRUE))

#Define colores para las clases
values<-c("[0,10]"="#8B0000","(10,20]"="#A43800","(20,30]"="#BE7100","(30,40]"="#D8AA00",
          "(40,50]"="#F2E200","(50,60]"="#E2ED00","(60,70]"="#AACB00","(70,80]"="#71A800",
          "(80,90]"="#388600","(90,100]"="#006400")

mapCom(shp,data=data2map,fill='value',shp.u='COD_COMUNA',data.u='cod',fill.values=values)


