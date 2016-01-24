# Parameter festlegen

setwd("/home/florian/Schreibtisch/UNI/Master/1_Semester/Datenmanagement/Basisdaten/Fogo")
library(sp)
library(rgdal)
library(raster)
library("lattice", lib.loc="~/R/x86_64-pc-linux-gnu-library/3.2")
library("latticeExtra", lib.loc="~/R/x86_64-pc-linux-gnu-library/3.2")

raster <- raster("LC82100502014328LGN00_B3.tif")
vector <- readOGR("data_2014_subset1.shp", layer = "data_2014_subset1")
vector_utm <- spTransform(vector, CRS(projection(raster)))
color_maps <- c("Greens", "Red", "Blue")
vector_attributes <- vector(names)
min <- max(mean(getValues(raster)) - sd(getValues(raster)), 0)
max <- mean(getValues(raster)) + sd(getValues(raster))
# choose_gridlines <- seq(1:25)
yat = seq(extent(raster)@ymin, 
          extent(raster)@ymax, length.out = 5)
xat = seq(extent(raster)@xmin, 
          extent(raster)@xmax, length.out = 5)


# Auswahlbereich im interaktiven Shiny Format
# bis auf den selctInput von Gridlines sollte das soweit schonmal passen
inputPanel(
  selectInput("attributes", label = "attribut",
              choices = names(vector_attributes), selected = "ID"),
  
  selectInput("Colors", label = "Color",
              choices = color_maps, selected = "Red"),
  
  selectInput("GRIDLI", label = "Number of Gridlines",
              choices = (scales = list(x = list(at = xat),
                                      y = list(at = yat)), selected = 5))
  # voher choices = choose_gridlines
)


# Zeichenfläche von Shiny

  renderplot ({
    spplot(raster, col.regions = color_maps(256), at = breaks,
                      key = list(space = 'left', text = list(levels(vector_classes)), 
                                 points = list(pch = 21, cex = 2, fill = vector_colors)),
                      colorkey=list(space="right"),
                      panel = function(...){
                        panel.levelplot(...)
                        panel.abline(h = yat, v = xat, col = "grey0", lwd = 0.8, lty = 3) 
                      },
                      scales = list(x = list(at = xat),
                                    y = list(at = yat)))
  })

  
  
  
#   # plot <- spplot(prediction_raster,col.regions = clrs.ndvi,
#                   colorkey = list(at = seq(0, 11, length.out = 256)),
#                   main = "Predicted species richness \n based on Landsat 8 data",
#                   sub = paste0("Result is based on ",input$ndvi, "% of 2014 NDVI values"),
#                   scales = list(draw = TRUE))
#   change_raster = (1-prediction_raster / prediction_original) * 100
#   plot2 <- spplot(change_raster,col.regions = clrs.change, 
#                   colorkey = list(at = seq(-100, 100, length.out = 256)),
#                   main = "Percentage change in prediction \n results compared to 100% NDVI",
#                   scales = list(draw = TRUE))
#   grid.arrange(plot1, plot2, ncol = 2)
# })
