#Processes Strava tracks (GPX and FIT files) in a data frame#

#Strava provides the option to export an archive of your account (Bulk Export).
#  - Choose "Settings," then find the "My Account" tab from the menu listed on the Left.
#  - Select “Get Started” under “Download or Delete Your Account.”
#  - Select “Request your archive” on the next page.
#  - You will receive an email with a link to download your data (this may take a few hours.)
#Your data archive will contain GPX or FIT files (depending if you use a Garmin, your phone...) and a CSV files that includes
#  - id, date, name, type, description, elapsed_time, distance, filename.

#Output of this routine#
#tr  : list object containg each track longitude (lon), latitude (lat), elevation (ele) and time in a dataframe.
#ty  : factor object of the type of track (Run, Ride,...) extracted from activities.csv.
#td  : vector of character containing the date of each track.
#lf  : vector of character containing the names of your GPX or FIT files.
#Lon : vector of all the longitudes combined.
#Lat : vector of all the latitudes combined.
#Ele : vector of all the elevations combined.

require(plotKML)     #for the function readGPX
require(cycleRtools) #for the function read_fit
require(stringr)     #for the function str_sub

setwd("your_working_directory")
M  = read.csv("activities.csv")
lf = list.files()

tr = list()
ty = NULL
td = NULL
for (i in 1:length(lf)){
  if(str_sub(lf[i], start= -3) == "gpx"){
    Alist       = readGPX(lf[i], metadata = F, bounds = F,waypoints = F, tracks = T, routes = F)$tracks
    tr[[i]]     = Alist[[1]][[1]]
    tr[[i]]$ele = as.numeric(tr[[i]]$ele)
    rm(Alist)
  }  
  if(str_sub(lf[i], start= -3) == "fit"){
    Alist   = read_fit(lf[i])
    tr[[i]] = data.frame(lon  = Alist$lon
                        ,lat  = Alist$lat
                        ,ele  = Alist$elevation.m
                        ,time = as.character(Alist$timestamp))
    rm(Alist)
  }
  ty[i] = as.character(M$type[which(str_sub(M$filename, start=12,end=25) == lf[i])])
  td[i] = as.character(M$date[which(str_sub(M$filename, start=12,end=25) == lf[i])])
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
save(tr,ty,td,lf,Lon,Lat,Ele,file = "Strava_tracks.RData")
