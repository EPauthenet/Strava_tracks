load("Strava_tracks.RData") #generated with Read_Strava.R

####################################################################################################
#Simple Map#
plot(tr[[1]]$lon,tr[[1]]$lat,xlim = range(Lon,na.rm = T),ylim = range(Lat,na.rm = T),typ = "l"
  ,xlab = "",ylab = "",axes = F)
for (i in 2:length(lf)){
  lines(tr[[i]]$lon,tr[[i]]$lat)
}

####################################################################################################
#Color by activity#
lev  = levels(ty)                   #the levels of factor in ty
colo = sample(colors()[!colors() %in% paste("grey",seq(3,97),sep = "")],length(lev)) #Random colors (without the greys)
plot(1,1,xlim = range(Lon,na.rm = T),ylim = range(Lat,na.rm = T),typ = "l"
  ,xlab = "",ylab = "",axes = F,col = "white")
for (i in 1:length(lf)){
  a = ty[i]
  lines(tr[[i]]$lon,tr[[i]]$lat,col = colo[a])
}
legend("bottomleft",legend = lev,col = colo,lty = 1,lwd =2)

####################################################################################################
#By season#
month = as.numeric(str_sub(td,6,7))
season = c("DJF","MAM","JJA","SON")

ind = list()
ind[[1]] = which(month==12 | month==1 | month==2)
ind[[2]] = which(month==3 | month==4 | month==5)
ind[[3]] = which(month==6 | month==7 | month==8)
ind[[4]] = which(month==9 | month==10 | month==11)

par(mfrow = c(2,2),mar = c(0,0,0,0))
for (t in 1:4){
  plot(1,1,xlim = range(Lon,na.rm = T),ylim = range(Lat,na.rm = T),main = season[t]
    ,xlab = "",ylab = "",axes = F,las = 1,col = "white")
  for (i in ind[[t]]){
    lines(tr[[i]]$lon,tr[[i]]$lat)
  }
}

####################################################################################################
#By season and activity#
lev = levels(ty)
colo = sample(colors()[!colors() %in% paste("grey",seq(3,97),sep = "")],length(lev)) #Random colors (without the greys)

month = as.numeric(str_sub(td,6,7))
season = c("DJF","MAM","JJA","SON")

ind = list()
ind[[1]] = which(month==12 | month==1 | month==2)
ind[[2]] = which(month==3 | month==4 | month==5)
ind[[3]] = which(month==6 | month==7 | month==8)
ind[[4]] = which(month==9 | month==10 | month==11)

par(mfrow = c(2,2),mar = c(0,0,0,0))
for (t in 1:4){
  plot(1,1,xlim = range(Lon,na.rm = T),ylim = range(Lat,na.rm = T),main = season[t]
    ,xlab = "",ylab = "",axes = F,xaxs = "i",yaxs = "i",las = 1,col = "white")
  for (i in ind[[t]]){
    a = ty[i]
    lines(tr[[i]]$lon,tr[[i]]$lat,col = colo[a])
  }
}
legend("bottomleft",legend = lev,col = colo,lty = 1,lwd =2)

