#Script para crear mapa de valores comunales con ggplot2
#author: Francisco Zambrano Bigiarini (frzambra@gmail.com)
#agosto 2014

mapCom<-function(shp,data,fill=NA,shp.u=NA,data.u=NA,fill.values=NA,...){
  
  require(ggplot2)
  
  shp.f<-fortify(shp,region=shp.u)
  
  plot<-ggplot(data,aes(map_id=cod))+
    geom_map(aes_string(fill=fill),colour='black',map = shp.f)+
    expand_limits(x = shp.f$long, y = shp.f$lat)
  
    if (!missing(fill.values)){
      plot<-plot+scale_fill_manual(values=fill.values)
    }
  
  plot<-plot+
    scale_x_continuous(name=expression(paste("Longitud (",degree,")")), expand=c(0,0)) +
    scale_y_continuous(name=expression(paste("Latitud (",degree,")")), expand=c(0,0)) +
    coord_equal()+
    labs(x=NULL,y=NULL) +theme_bw()+
    theme(axis.ticks = element_blank(),
          axis.title = element_blank(), 
          axis.text =  element_blank(),
          panel.grid.minor = element_blank(), 
          panel.grid.major = element_blank(),
          title=element_text(size=15),
          legend.title = element_text(size = 10),
          panel.border = element_blank(),
          strip.background = element_rect(fill = "transparent",colour=NA),
          strip.text = element_text(size = 7),
          legend.position='bottom')
  print(plot)
}


