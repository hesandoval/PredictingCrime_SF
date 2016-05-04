sf_crime_data = read.csv("SFPD_Incidents_-_Previous_Year__2015_.csv")
summary(sf_crime_data$Descript)
dates = unlist(lapply(as.character(sf_crime_data$Date), function(x) strsplit(x, "\\s+")[[1]][1]))
barplot(sort(table(sf_crime_data$DayOfWeek)), horiz = TRUE, las=2)
sf_crime_data$Date = as.factor(dates)
crime_dates = as.Date(dates,format = "%m/%d/%Y")
sf_crime_data$Date = crime_dates

#plots crimes reported on days in january
barplot(table(format(sf_crime_data$Date[format(sf_crime_data$Date, "%m")=='01'], "%A")
              ), las=2, horiz = T)