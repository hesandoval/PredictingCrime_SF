sf_crime_data = read.csv("~/Desktop/DataMining/project/SFPD_Incidents_-_Previous_Year__2015_.csv")
summary(sf_crime_data$Descript)
dates = unlist(lapply(as.character(sf_crime_data$Date), function(x) strsplit(x, "\\s+")[[1]][1]))
barplot(sort(table(sf_crime_data$DayOfWeek)), horiz = TRUE, las=2)
