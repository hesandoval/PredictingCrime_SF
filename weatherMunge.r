weather = read.csv('C:/Users/Matthew/Desktop/New folder/weatherData.txt')

#change format of data
weather$date = sapply(weather$DateUTC, function(x) strsplit(as.character(x), " ")[[1]][1])
weather$date = gsub('([0-9]+)-([0-9]+)-([0-9]+)' , '\\2/\\3/\\1', weather$date)

#convert timePST to 0-23 (hour of day)
changeTime = function(x){
  lengthString = nchar(as.character(x))
  if(substr(x, lengthString - 1, lengthString) == 'AM')
  {
    if(substr(x, 1,2) == '12')
    {
      x = '0'
    }
    else
    {
      x = (gsub('([0-9]+).*' , '\\1', as.character(x)))
    }
    
  }  
  
  else if(substr(x, lengthString - 1, lengthString) == 'PM')
  {
    if(substr(x, 1,2) == '12')
    {
      x = '12'
    }
    
    else
    {
      x = (gsub('([0-9]+).*' , '\\1', as.character(x)))
      x = as.numeric(x) + 12
    }
  }
  return(x)
}

weather$changedTime = sapply(weather$TimePST, changeTime)
weather$changedTime = as.numeric(weather$changedTime)

#remove duplicate hourly measures (some hours have more than just hr:56)
index = with(weather, grepl('2015-[0-9]+-[0-9]+ [0-9]+:56.*',DateUTC))

weather = weather[index, ]

write.csv(file = "changed.txt", x = weather)