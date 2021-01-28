library(DBI)
library(RMySQL)
library(dplyr)
library(ggplot2)

#Ahora en RStudio crea un script llamado queries.Ren donde se conecte a la BDD 
#shinydemo

BaseDatos <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

DataDB <- dbGetQuery(BaseDatos, "select * from CountryLanguage")

#Una vez hecha la conexión a la BDD, generar una busqueda con dplyr que devuelva
#el porcentaje de personas que hablan español en todos los países


TotalEsp <-as.data.frame(DataDB %>% filter(Language == "Spanish"))

#Realizar una gráfica con ggplot que represente este porcentaje de tal modo que 
#en el eje de las Y aparezca el país y en X el porcentaje, y que diferencíe 
#entre aquellos que es su lengua oficial y los que no con diferente color 
#(puedes utilizar la geom_bin2d() y coord_flip())
TotalEsp %>% ggplot(aes( x = CountryCode, y=Percentage, fill = IsOfficial )) + 
  geom_bin2d() +
  coord_flip()
