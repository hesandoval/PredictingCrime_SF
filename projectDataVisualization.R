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
par(cex.axis=1, cex.lab=1, cex.main=1.2, cex.sub=1)
sapply(months, function(m)
  barplot(table(sf_crime_data[format(sf_crime_data$Date, "%B") == m,]$Category), 
          las=2, horiz=T,cex.names=.35, cex.axis = .5, main = paste("Crime Categories for the", m)))

hours = substr(sf_crime_data$Time, 1,2)
sf_crime_data$Hour = hours
hours=unique(hours)

#displays at what time of the day assaults occur
barplot(table(sf_crime_data[sf_crime_data$Category == "ASSAULT",]$Hour))

#displayes the times when crimes occur given their category
par(mar=c(3, 3, 2, 1)+.1)
sapply(crime_categories, function(c)
  barplot(table(sf_crime_data[sf_crime_data$Category == c,]$Hour), main = paste("Times when", c, "has been reported")))
