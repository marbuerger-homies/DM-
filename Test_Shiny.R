library(rgdal)
library(sp)
setwd("/home/florian/Schreibtisch/UNI/Master/1_Semester/Datenmanagement/Basisdaten/Fogo")
df<- readOGR("data_2014_subset1.shp", layer = "data_2014_subset1")

# Definiere Inputvariable
names(df)


inputPanel(
  selectInput("attributes", label = "attribut",
              choices = names(df), selected = "ID"),
)



#Visualisiere das hier mit einer Variablen
rendereplot ({
  spplot(df, z = input$attributes)
  })
?spplot
