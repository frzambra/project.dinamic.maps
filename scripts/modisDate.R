#author : Francisco Zambrano Bigiarini (frzambra@gmail.com)
#date : september 2013
#description: function to manage modis date

if (!isGeneric("modisDate")) {
  setGeneric("modisDate", function(x, ...)
    standardGeneric("modisDate"))
}

setMethod('modisDate', signature(x='character'), 
          function(x){
            origin<-as.Date(paste0(substr(x,1,4),'-01-01'))
            date<-origin+as.numeric(substr(x,5,7),unit="days")-1
            return(date)
          }
)

setMethod('modisDate',signature(x='Date'),
          function(x, by='16 days'){

            if (length(x)<2){
              dates<-julian(as.Date(x))-julian(as.Date(paste0(format(x,"%Y"),"-01-01")))
              dates<-paste0(format(x,"%Y"),sprintf("%03d",as.numeric(dates)+1))
              } else {
                
                year_b<-as.numeric(format(x[1],"%Y"))
                year_e<-as.numeric(format(x[2],"%Y"))
                
                if (year_b!=year_e){
                  ini<-paste0((year_b+1):year_e,'-',rep("01-01",length((year_b+1):year_e)))
                  term<-as.Date(paste0(year_b:(year_e-1),'-',rep("12-31",length(year_b:(year_e-1)))))
                  ini<-c(x[1],as.Date(ini))
                  term<-c(term,x[2])
                  } else {
                    ini<-x[1]
                    term<-x[2]
                  }
                dates<-data.frame(ini=ini,term=term)
                
                if (year_b==year_e){
                  dates<-seq(dates$ini,dates$term, by=by)
                  } else {
                    dates<-do.call('c',mapply(seq,dates$ini,dates$term, by=by))
                  }
              }
            return(dates)
                         }
) 