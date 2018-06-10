load("Strava_tracks.RData") #generated with Read_Strava.R

#Simple Map#
plot(tr[[1]]$lon,tr[[1]]$lat,xlim = range(Lon,na.rm = T),ylim = range(Lat,na.rm = T),typ = "l"
  ,xlab = "",ylab = "",axes = F)
for (i in 2:length(lf)){
  lines(tr[[i]]$lon,tr[[i]]$lat)
}

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
