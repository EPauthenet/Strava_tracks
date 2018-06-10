library(plotKML)
library(cycleRtools)
library(oce)
library(stringr)
#######################################################Open and save in a RData all the tracks
#Strava provides GPX or FIT files of your individual tracks together with an "activities.csv" file containing the id numbers, dates etc...

M = read.csv("activities.csv")
lf = list.files()

tr = list()
ty = NULL
td = NULL
for (i in 1:length(lf)){
  if(str_sub(lf[i], start= -3) == "gpx"){
    Alist = readGPX(lf[i], metadata = F, bounds = F,waypoints = F, tracks = T, routes = F)$tracks
    tr[[i]] = Alist[[1]][[1]]
    tr[[i]]$ele = as.numeric(tr[[i]]$ele)
    rm(Alist)
  }  
  if(str_sub(lf[i], start= -3) == "fit"){
    Alist = read_fit(lf[i])
    tr[[i]] = data.frame(lon = Alist$lon
      ,lat = Alist$lat
      ,ele = Alist$elevation.m
      ,time = as.character(Alist$timestamp))
    rm(Alist)
  }
  ty[i] = as.character(M$type[which(str_sub(M$filename, start= 12,end = 25)==lf[i])])
  td[i] = as.character(M$date[which(str_sub(M$filename, start= 12,end = 25)==lf[i])])
  cat(paste(as.character(M$date[i]),"|",as.character(M$type[i])),sep = "\n")
}

Lon = NULL
Lat = NULL
Ele = NULL
for (i in 1:length(lf)){
  Lon = c(Lon,tr[[i]]$lon)
  Lat = c(Lat,tr[[i]]$lat)
  Ele = c(Ele,tr[[i]]$ele)
}
ty = as.factor(ty)
rm(M)
save(tr,ty,td,lf,Lon,Lat,Ele,file = "Strava_tracks.RData")
