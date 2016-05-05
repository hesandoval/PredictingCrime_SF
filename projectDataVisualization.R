sf_crime_data = read.csv("SFPD_Incidents_-_Previous_Year__2015_.csv")
summary(sf_crime_data)
dates = unlist(lapply(as.character(sf_crime_data$Date), function(x) strsplit(x, "\\s+")[[1]][1]))
par(mar=c(5,6,3,2))
barplot(sort(table(sf_crime_data$DayOfWeek)), horiz = TRUE, las=2)
#sf_crime_data$Date = as.factor(dates)
crime_dates = as.Date(dates,format = "%m/%d/%Y")
sf_crime_data$Date = crime_dates

#plots the number of crimes reported per day of the week in jan-dec
months = unique(format(sf_crime_data$Date, "%B"))
par(mar=c(5,6,3,2))
sapply(months, function(m) 
  barplot(table(format(sf_crime_data$Date[format(sf_crime_data$Date, "%B")==m], "%A")),
                                   las=2, horiz = T, main = paste("Crime for", m, "by day of the week")))
#default margins
par(mar=c(5.1, 4.1, 4.1, 2.1))

#plots the categories of crimes
par(mar=c(4, 6, 1, 1)+.1)
crime_categories = unique(sf_crime_data$Category)
barplot(sort(table(sf_crime_data$Category)), las=2, horiz=T, cex.names=.35, cex.axis = .5)

#plot categories of crimes per month per day of the week
par(mar=c(4, 6, 1, 1)+.1)
sapply(months, function(m)
  barplot(sort(table(sf_crime_data[format(sf_crime_data$Date, "%B") == m,]$Category)), 
          las=2, horiz=T,cex.names=.35, cex.axis = .5, main = paste("Crime Categories for the", m)))
