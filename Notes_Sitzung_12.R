library(rJava)
library(iplots)
iplot(mtcars$mpg)
iplot(mtcars$disp)
iplot(mtcars$drat, mtcars$disp)
iplot(mtcars$wt, mtcars$cyl)
iplot(mtcars$carb, mtcars$gear)
ihist(mtcars$wt, mtcars$disp)



library(mapview)
library(rgdal)
library(raster)
library(sp)
setwd("/home/florian/Schreibtisch/UNI/Master/1_Semester/Datenmanagement/Basisdaten/Fogo")
Vector<-readOGR("data_2014_subset1.shp", layer = "data_2014_subset1")
plot(Vector)
spplot(Vector)
mapview(Vector)
Vector@data
## zum übereinanderlegen von 2 Dateien, bspw NDVI und Normal
slideview ( Raster1 ,Raster2)
