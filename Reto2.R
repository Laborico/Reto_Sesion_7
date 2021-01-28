library(rvest)

archivo <- read_html("https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm")

tabla <-html_nodes(archivo, "table")  

tabla.df <- html_table(tabla[1], fill = TRUE)

tabla.df <- as.data.frame(tabla.df)

tabla.df <- na.omit(tabla.df)

salarios <- gsub("MXN","", tabla.df$Sueldo)

salarios <- gsub("/mes","", salarios)

salarios <- gsub("[^[:alnum:][:blank:]?]", "", salarios)

salarios <- as.numeric(salarios)

tabla.df$Sueldo <-salarios

#¿Cuál es la empresa que más paga y la que menos paga?
#Max
sueldo.max <-which.max(tabla.df$Sueldo)
tabla.df[sueldo.max,]

#Min
sueldo.min <-which.min(tabla.df$Sueldo)
tabla.df[sueldo.min,]
