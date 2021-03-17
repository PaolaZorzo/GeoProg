library(sp)
library(raster)
library(adehabitatMA)
library(SDMTools)
#ra abre os arquivos de ral?mpagos por linha da tabela
ra<-read.table("pontos.txt",header=TRUE, sep=',', dec='.')
#j recebe a demins?o (linhas [1] x colunas [2]) do aquivo de rel?mpagos
j<-dim(ra)
# Criando o SpatialPointsDataFrame a partir da tabela.
coord<-data.frame(ra$lon,ra$lat)
pontos_ra<-SpatialPointsDataFrame(coord,ra)
#definindo o arquivo raster(raster)
r<-raster("MASC.tif")
#convertendo para asc(SDMTools)
a<-asc.from.raster(r)
# Converte um objeto da classe asc em um objeto da classe SpatialGridDataFrame(adehabitatMA)
grd<-asc2spixdf(a) 
#testar funcionamento
class(grd)
#conferindo atributos
attr(grd,"package")
#numeros de pontos em cada pixel do raster(rgdal)
cp<-count.points(pontos_ra,grd)
writeRaster(cp, "out.tif", format="GTiff", overwrite = TRUE)

#outro método mais facíl, mas o campo interpolado não pode possuir valores nulos e o resultado deve ser mascarado (masc)
pp<-rasterize(pontos_ra, r, fun='count', background=NA)