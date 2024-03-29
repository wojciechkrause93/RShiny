#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(tmap) 
library(rgdal)
library(rmapshaper)
library(scales)
library(mapplots)
library(RColorBrewer)
library(sf)
library(spData)
library(tmap)
library(cartogram)
library(readxl)
library(dplyr)
library(rlist)
library(shiny)
library(RColorBrewer) 
setwd("C:/Users/Yogi/Desktop/Wizualizacje")
danebezr <- read_excel("bezrobocie.xlsx", 
                       sheet = "TABLICA", col_names = c("TERYT","POWIAT","Kobiety","M�czy�ni","KODR"))
danebezr = danebezr[-c(1),]
setwd("C:/Users/Yogi/Desktop/Wizualizacje/Mapy")
mapa.pl <- readOGR(dsn = "PRG_jednostki_administracyjne_v15",
                   layer = "Panstwo") 
mapa.woj <- readOGR(dsn = "PRG_jednostki_administracyjne_v15",
                    layer = "wojewodztwa") # ręcznie zmienić nazwy wszystkich plików na bez polskich znaków
setwd("C:/Users/Yogi/Desktop/Wizualizacje")
load(file = "Mapy.RData") # dane do map podkładowych
wojewodztwa = list("Dolno�l�skie"="02",
                   "Kujawsko-Pomorskie"="04",
                   "��dzkie" = "10",
                   "Lubelskie" = "06",
                   "Lubuskie" = "08",
                   "Ma�opolskie" = "12",
                   "Mazowieckie" = "14",
                   "Opolskie" = "16",
                   "Podkarpackie" = "18",
                   "Podlaskie" = "20",
                   "Pomorskie" = "22",
                   "�l�skie" = "24",
                   "�wi�tokrzyskie" = "26",
                   "Warmi�sko-Mazurskie" = "28",
                   "Wielkopolskie" = "30",
                   "Zachodniopomorskie" = "32")
doln.pow = mapa.pow[substr(mapa.pow$jpt_kod_je, 1, 2) == wojewodztwa[[1]], ] 
kuj.pow = mapa.pow[substr(mapa.pow$jpt_kod_je, 1, 2) == wojewodztwa[[2]], ] 
lodz.pow = mapa.pow[substr(mapa.pow$jpt_kod_je, 1, 2) == wojewodztwa[[3]], ] 
lubel.pow = mapa.pow[substr(mapa.pow$jpt_kod_je, 1, 2) == wojewodztwa[[4]], ] 
lubus.pow = mapa.pow[substr(mapa.pow$jpt_kod_je, 1, 2) == wojewodztwa[[5]], ] 
malo.pow = mapa.pow[substr(mapa.pow$jpt_kod_je, 1, 2) == wojewodztwa[[6]], ] 
mazow.pow = mapa.pow[substr(mapa.pow$jpt_kod_je, 1, 2) == wojewodztwa[[7]], ] 
opol.pow = mapa.pow[substr(mapa.pow$jpt_kod_je, 1, 2) == wojewodztwa[[8]], ] 
podkar.pow = mapa.pow[substr(mapa.pow$jpt_kod_je, 1, 2) == wojewodztwa[[9]], ] 
podla.pow = mapa.pow[substr(mapa.pow$jpt_kod_je, 1, 2) == wojewodztwa[[10]], ] 
pomors.pow = mapa.pow[substr(mapa.pow$jpt_kod_je, 1, 2) == wojewodztwa[[11]], ] 
slaskie.pow = mapa.pow[substr(mapa.pow$jpt_kod_je, 1, 2) == wojewodztwa[[12]], ] 
swieto.pow = mapa.pow[substr(mapa.pow$jpt_kod_je, 1, 2) == wojewodztwa[[13]], ] 
warm.pow = mapa.pow[substr(mapa.pow$jpt_kod_je, 1, 2) == wojewodztwa[[14]], ] 
wielko.pow = mapa.pow[substr(mapa.pow$jpt_kod_je, 1, 2) == wojewodztwa[[15]], ] 
zachodnio.pow = mapa.pow[substr(mapa.pow$jpt_kod_je, 1, 2) == wojewodztwa[[16]], ] 

doln.pow.s = ms_simplify(input = doln.pow, keep = 0.005,  keep_shapes = T,weighting = 0.3)
kuj.pow.s = ms_simplify(input = kuj.pow, keep = 0.005,  keep_shapes = T,weighting = 0.3)
lodz.pow.s = ms_simplify(input = lodz.pow, keep = 0.005,  keep_shapes = T,weighting = 0.3) 
lubel.pow.s = ms_simplify(input = lubel.pow, keep = 0.005,  keep_shapes = T,weighting = 0.3)
lubus.pow.s = ms_simplify(input = lubus.pow, keep = 0.005,  keep_shapes = T,weighting = 0.3)
malo.pow.s = ms_simplify(input = malo.pow, keep = 0.005,  keep_shapes = T,weighting = 0.3)
mazow.pow.s = ms_simplify(input = mazow.pow, keep = 0.005,  keep_shapes = T,weighting = 0.3)
opol.pow.s = ms_simplify(input = opol.pow, keep = 0.005,  keep_shapes = T,weighting = 0.3)
podkar.pow.s = ms_simplify(input = podkar.pow, keep = 0.005,  keep_shapes = T,weighting = 0.3) 
podla.pow.s = ms_simplify(input = podla.pow, keep = 0.005,  keep_shapes = T,weighting = 0.3) 
pomors.pow.s = ms_simplify(input = pomors.pow, keep = 0.005,  keep_shapes = T,weighting = 0.3)
slaskie.pow.s = ms_simplify(input = slaskie.pow, keep = 0.005,  keep_shapes = T,weighting = 0.3)
swieto.pow.s = ms_simplify(input = swieto.pow, keep = 0.005,  keep_shapes = T,weighting = 0.3) 
warm.pow.s = ms_simplify(input = warm.pow, keep = 0.005,  keep_shapes = T,weighting = 0.3)
wielko.pow.s = ms_simplify(input = wielko.pow, keep = 0.005,  keep_shapes = T,weighting = 0.3) 
zachodnio.pow.s = ms_simplify(input = zachodnio.pow, keep = 0.005,  keep_shapes = T,weighting = 0.3) 

danebezr$Kobiety = as.numeric(danebezr$Kobiety)
danebezr$M�czy�ni = as.numeric(danebezr$M�czy�ni)
przedzialy.kobiety <- round(quantile(danebezr$Kobiety),2)
przedzialy.mezczyzni <- round(quantile(danebezr$M�czy�ni),2)
danebezr$odcieciekobiet <- cut(danebezr$Kobiety, 
                               breaks= round(przedzialy.kobiety,2), 
                               include.lowest=T, 
                               dig.lab=nchar(max(danebezr$Kobiety)))
danebezr$odcieciemezczyzn <- cut(danebezr$M�czy�ni, 
                                 breaks= round(przedzialy.mezczyzni,2), 
                                 include.lowest=T, 
                                 dig.lab=nchar(max(danebezr$M�czy�ni)))


paleta <- brewer.pal(n =4, 
                     name = "OrRd")

kolory.k <- paleta[danebezr$odcieciekobiet] # przypisanie kolor�w do danych

kolory.doln.k <- kolory.k[match(doln.pow.s$jpt_kod_je, 
                                substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 

kolory.kuj.k <- kolory.k[match(kuj.pow.s$jpt_kod_je, 
                               substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 
kolory.lodz.k <- kolory.k[match(lodz.pow.s$jpt_kod_je, 
                                substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 

kolory.lubel.k <- kolory.k[match(lubel.pow.s$jpt_kod_je, 
                                 substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 
kolory.lubus.k <- kolory.k[match(lubus.pow.s$jpt_kod_je, 
                                 substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 

kolory.malo.k <- kolory.k[match(malo.pow.s$jpt_kod_je, 
                                substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 
kolory.mazow.k <- kolory.k[match(mazow.pow.s$jpt_kod_je, 
                                 substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 

kolory.opol.k <- kolory.k[match(opol.pow.s$jpt_kod_je, 
                                substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 
kolory.podkar.k <- kolory.k[match(podkar.pow.s$jpt_kod_je, 
                                  substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 

kolory.podla.k <- kolory.k[match(podla.pow.s$jpt_kod_je, 
                                 substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 
kolory.pomors.k <- kolory.k[match(pomors.pow.s$jpt_kod_je, 
                                  substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 

kolory.slaskie.k <- kolory.k[match(slaskie.pow.s$jpt_kod_je, 
                                   substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 
kolory.swieto.k <- kolory.k[match(swieto.pow.s$jpt_kod_je, 
                                  substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 

kolory.warm.k <- kolory.k[match(warm.pow.s$jpt_kod_je, 
                                substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 
kolory.wielko.k <- kolory.k[match(wielko.pow.s$jpt_kod_je, 
                                  substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 

kolory.zachodnio.k <- kolory.k[match(zachodnio.pow.s$jpt_kod_je, 
                                     substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 

paleta <- brewer.pal(n =4, 
                     name = "OrRd")

kolory.m <- paleta[danebezr$odcieciemezczyzn] # przypisanie kolor�w do danych

kolory.doln.m <- kolory.m[match(doln.pow.s$jpt_kod_je, 
                                substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 

kolory.kuj.m <- kolory.m[match(kuj.pow.s$jpt_kod_je, 
                               substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 
kolory.lodz.m <- kolory.m[match(lodz.pow.s$jpt_kod_je, 
                                substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 

kolory.lubel.m <- kolory.m[match(lubel.pow.s$jpt_kod_je, 
                                 substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 
kolory.lubus.m <- kolory.m[match(lubus.pow.s$jpt_kod_je, 
                                 substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 

kolory.malo.m <- kolory.m[match(malo.pow.s$jpt_kod_je, 
                                substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 
kolory.mazow.m <- kolory.m[match(mazow.pow.s$jpt_kod_je, 
                                 substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 

kolory.opol.m <- kolory.m[match(opol.pow.s$jpt_kod_je, 
                                substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 
kolory.podkar.m <- kolory.m[match(podkar.pow.s$jpt_kod_je, 
                                  substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 

kolory.podla.m <- kolory.m[match(podla.pow.s$jpt_kod_je, 
                                 substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 
kolory.pomors.m <- kolory.m[match(pomors.pow.s$jpt_kod_je, 
                                  substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 

kolory.slaskie.m <- kolory.m[match(slaskie.pow.s$jpt_kod_je, 
                                   substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 
kolory.swieto.m <- kolory.m[match(swieto.pow.s$jpt_kod_je, 
                                  substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 

kolory.warm.m <- kolory.m[match(warm.pow.s$jpt_kod_je, 
                                substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 
kolory.wielko.m <- kolory.m[match(wielko.pow.s$jpt_kod_je, 
                                  substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 

kolory.zachodnio.m <- kolory.m[match(zachodnio.pow.s$jpt_kod_je, 
                                     substr(x = danebezr$KODR, start = 1,stop = 4))] # wed�ug kolejno�ci na mapie 



# Define UI for application that draws a histogram
ui <- fluidPage(
    h3("Mapki interaktywne - Wojciech Krause S52-11"),
    
    fluidRow(
        column(width = 6 ,
               radioButtons(inputId = "P�e�",
                label = "Wybierz p�e�",
                choices = list("Kobiety"="Kobiety",
                               "M�czy�ni"= "M�czy�ni"))),
        column(width = 6,selectInput(inputId = "Wojew�dztwo",
                label = "Wybierz wojew�dztwo",
                choices = list("Dolno�l�skie" = "Dolno",
                               "Kujawsko-Pomorskie" = "Kujaw",
                               "L�dzkie" = "Lodz",
                               "Lubelskie" = "Lubel",
                               "Lubuskie" = "Lubus",
                               "Ma�opolskie" = "Malo",
                               "Mazowieckie" = "Mazow",
                               "Opolskie" = "Opol",
                               "Podkarpackie" = "Podkar",
                               "Podlaskie" = "Podlas",
                               "Pomorskie" = "Pomor",
                               "�l�skie" = "�l�sk",
                               "�wi�tokorzystkie" = "�wieto",
                               "Warmi�sko-Mazurskie" = "Warmia",
                               "Wielkopolskie" = "Wielkop",
                               "Zachodnio-Pomorskie" = "ZachodPom"))
   
    
)),
column(width = 12,
       plotOutput(outputId = "Mapa"))
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$Mapa = renderPlot({
        if(input$P�e� == "Kobiety")
        {
            if(input$Wojew�dztwo == "Dolno")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(doln.pow.s, col = kolory.k, border = "grey35", main = ""))
                #legend(legend = paste0(levels(danebezr$odcieciekobiet)[1:4]), fill = paleta[1:4], "bottomleft")
                okno.doln <- doln.pow.s@bbox
                n.dol = 4
                pole.dol = pole<-c(420000, 430000, 335000, 270000)
                wys <- (przedzialy.kobiety - min(przedzialy.kobiety)) / (max(przedzialy.kobiety) - min(przedzialy.kobiety))
                przerwa <- (pole.dol[4] - pole.dol[3]) * 0.1 / n.dol  # wysoko�� przerwy (10% ��cznej, dlatego ni�ej 0.9)
                podstawy <- pole.dol[3] + (pole.dol[4] - pole.dol[3]) * 0.9 * wys[1:n.dol] + przerwa * 0:(n.dol-1) # ybottoms
                gory <- pole.dol[3] + (pole.dol[4] - pole.dol[3]) * 0.9 * wys[2:(n.dol+1)] + przerwa * 0:(n.dol-1) # ytops
                
                rect(xleft = rep(pole.dol[1], n.dol),  # boxy
                     xright = rep(pole.dol[2], n.dol),
                     ybottom = podstawy,
                     ytop = gory,
                     border = "grey35",
                     col = paleta)
                
                srodki <- (gory - podstawy) / 2 + podstawy  # y middle's dla opis�w
                opisy <- paste(format(przedzialy.kobiety[-(n.dol+1)] + c(0, rep(0.1, n.dol-1)), decimal = ","),
                               "�", format(przedzialy.kobiety[-1], digits = 2, decimal = ","))
                opisy[n.dol] <- paste(opisy[n.dol], "%", sep = "")
                
                text(x = pole.dol[2] + (pole.dol[2] - pole.dol[1]) * 0.01,
                     y = srodki,
                     labels = opisy,
                     pos = 4,
                     cex = 0.9)
                
                skala <- 50000  # d�ugo�� linii w metrach
                x0 <- 400960.4; y0 <- 256529.4  # manualnie, z pomoc� locator()
                segments(x0, y0, x0 + skala, y0)  # pozioma   
                segments(c(x0, x0 + skala), c(y0, y0), c(x0, x0 + skala), c(y0, y0) + 3000) # pionowe ticki
                text(x = c(x0, x0+skala+5000),  # po�o�enie na oko
                     y = y0 + 3000,
                     labels = c(0, paste(skala/1000, "km")),
                     pos = 3,  # nad punktem
                     cex = 0.85,  # zmniejszenie czcionki
                     offset = 0.2) # przesuni�cie nad punktem
                
                mtext(text = "Stopa bezrobocia rejestrowanego w powiatach w wojew�dztwie dolno�l�skim w 2018 r.",
                      side = 3)
            }
            if(input$Wojew�dztwo == "Kujaw")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(kuj.pow.s, col = kolory.k, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciekobiet)[1:4]), fill = paleta[1:4], "bottomright")
            }
            if(input$Wojew�dztwo == "Lodz")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(lodz.pow.s, col = kolory.k, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciekobiet)[1:4]), fill = paleta[1:4], "bottomright")
            }
            if(input$Wojew�dztwo == "Lubel")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(lubel.pow.s, col = kolory.k, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciekobiet)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "Malo")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(malo.pow.s, col = kolory.k, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciekobiet)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "Lubus")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(lubus.pow.s, col = kolory.k, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciekobiet)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "Mazow")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(mazow.pow.s, col = kolory.k, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciekobiet)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "Opol")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(opol.pow.s, col = kolory.k, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciekobiet)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "Podkar")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(podkar.pow.s, col = kolory.k, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciekobiet)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "Podlas")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(podla.pow.s, col = kolory.k, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciekobiet)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "Pomor")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(pomors.pow.s, col = kolory.k, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciekobiet)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "�l�sk")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(slaskie.pow.s, col = kolory.k, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciekobiet)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "�wieto")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(swieto.pow.s, col = kolory.k, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciekobiet)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "Warmia")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(warm.pow.s, col = kolory.k, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciekobiet)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "Wielkop")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(wielko.pow.s, col = kolory.k, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciekobiet)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "ZachodPom")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(zachodnio.pow.s, col = kolory.k, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciekobiet)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
        }
        if(input$P�e� == "M�czy�ni")
        {
            if(input$Wojew�dztwo == "Dolno")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(doln.pow.s, col = kolory.m, border = "grey35", main = ""))
                #legend(legend = paste0(levels(danebezr$odcieciekobiet)[1:4]), fill = paleta[1:4], "bottomleft")
                okno.doln <- doln.pow.s@bbox
                n.dol = 4
                pole.dol = pole<-c(420000, 430000, 335000, 270000)
                wys <- (przedzialy.mezczyzni - min(przedzialy.mezczyzni)) / (max(przedzialy.mezczyzni) - min(przedzialy.mezczyzni))
                przerwa <- (pole.dol[4] - pole.dol[3]) * 0.1 / n.dol  # wysoko�� przerwy (10% ��cznej, dlatego ni�ej 0.9)
                podstawy <- pole.dol[3] + (pole.dol[4] - pole.dol[3]) * 0.9 * wys[1:n.dol] + przerwa * 0:(n.dol-1) # ybottoms
                gory <- pole.dol[3] + (pole.dol[4] - pole.dol[3]) * 0.9 * wys[2:(n.dol+1)] + przerwa * 0:(n.dol-1) # ytops
                
                rect(xleft = rep(pole.dol[1], n.dol),  # boxy
                     xright = rep(pole.dol[2], n.dol),
                     ybottom = podstawy,
                     ytop = gory,
                     border = "grey35",
                     col = paleta)
                
                srodki <- (gory - podstawy) / 2 + podstawy  # y middle's dla opis�w
                opisy <- paste(format(przedzialy.mezczyzni[-(n.dol+1)] + c(0, rep(0.1, n.dol-1)), decimal = ","),
                               "�", format(przedzialy.mezczyzni[-1], digits = 2, decimal = ","))
                opisy[n.dol] <- paste(opisy[n.dol], "%", sep = "")
                
                text(x = pole.dol[2] + (pole.dol[2] - pole.dol[1]) * 0.01,
                     y = srodki,
                     labels = opisy,
                     pos = 4,
                     cex = 0.9)
                
                skala <- 50000  # d�ugo�� linii w metrach
                x0 <- 400960.4; y0 <- 256529.4  # manualnie, z pomoc� locator()
                segments(x0, y0, x0 + skala, y0)  # pozioma   
                segments(c(x0, x0 + skala), c(y0, y0), c(x0, x0 + skala), c(y0, y0) + 3000) # pionowe ticki
                text(x = c(x0, x0+skala+5000),  # po�o�enie na oko
                     y = y0 + 3000,
                     labels = c(0, paste(skala/1000, "km")),
                     pos = 3,  # nad punktem
                     cex = 0.85,  # zmniejszenie czcionki
                     offset = 0.2) # przesuni�cie nad punktem
                
                mtext(text = "Stopa bezrobocia rejestrowanego w powiatach w wojew�dztwie dolno�l�skim w 2018 r.",
                      side = 3)
            }
            if(input$Wojew�dztwo == "Kujaw")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(kuj.pow.s, col = kolory.m, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciemezczyzn)[1:4]), fill = paleta[1:4], "bottomright")
            }
            if(input$Wojew�dztwo == "Lodz")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(lodz.pow.s, col = kolory.m, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciemezczyzn)[1:4]), fill = paleta[1:4], "bottomright")
            }
            if(input$Wojew�dztwo == "Lubel")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(lubel.pow.s, col = kolory.m, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciemezczyzn)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "Malo")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(malo.pow.s, col = kolory.m, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciemezczyzn)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "Lubus")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(lubus.pow.s, col = kolory.m, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciemezczyzn)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "Mazow")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(mazow.pow.s, col = kolory.m, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciemezczyzn)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "Opol")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(opol.pow.s, col = kolory.m, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciemezczyzn)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "Podkar")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(podkar.pow.s, col = kolory.m, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciemezczyzn)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "Podlas")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(podla.pow.s, col = kolory.m, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciemezczyzn)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "Pomor")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(pomors.pow.s, col = kolory.m, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciemezczyzn)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "�l�sk")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(slaskie.pow.s, col = kolory.m, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciemezczyzn)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "�wieto")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(swieto.pow.s, col = kolory.m, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciemezczyzn)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "Warmia")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(warm.pow.s, col = kolory.m, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciemezczyzn)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "Wielkop")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(wielko.pow.s, col = kolory.m, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciemezczyzn)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
            if(input$Wojew�dztwo == "ZachodPom")
            {
                stare <- par(mar = c(1, 1, 1, 2))
                print(plot(zachodnio.pow.s, col = kolory.m, border = "grey35", main = ""))
                legend(legend = paste0(levels(danebezr$odcieciemezczyzn)[1:4]), fill = paleta[1:4], "bottomright")
                
            }
        }
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
