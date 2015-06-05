fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFileName <- "household_power_consumption.zip"
download.file(fileUrl, destfile = zipFileName , method = "curl")

dataFile <- unzip(zipFileName) 

library(sqldf)
powerdata <- read.csv.sql(dataFile, 
                          sql = "select * from file where Date in ('1/2/2007', '2/2/2007') ",
                          header = TRUE, sep = ";")
closeAllConnections()

dateTime<-strptime(paste(powerdata$Date,powerdata$Time),"%d/%m/%Y %H:%M:%S")

png(file = "plot2.png", width = 480, height = 480, units = "px")
plot(dateTime, powerdata$Global_active_power, 
     type = "l", 
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
box()
dev.off()