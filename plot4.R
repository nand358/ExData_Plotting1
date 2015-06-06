plot4 <- function() {
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
    
    png(file = "plot4.png", width = 480, height = 480, units = "px")
    par(mfrow = c(2,2))
    plot(dateTime, powerdata$Global_active_power, 
         type = "l", 
         xlab = "",
         ylab = "Global Active Power")
    
    plot(dateTime, powerdata$Voltage, 
         type = "l", 
         xlab = "datetime",
         ylab = "Voltage")
    
    plotColors <- c("black", "red", "blue")
    subMeteringNames <- c(names(powerdata)[7], names(powerdata)[8], names(powerdata)[9])
    
    plot(dateTime, powerdata$Sub_metering_1, 
         type = "l", 
         xlab = "",
         ylab = "Energy sub metering", 
         col = plotColors[1])
    
    lines(dateTime, powerdata$Sub_metering_2, 
          type = "l",
          col = plotColors[2])
    
    lines(dateTime, powerdata$Sub_metering_3,
          type = "l",
          col = plotColors[3])
    
    legend("topright", col = plotColors, lty=1, lwd=2, bty="n",
           legend = subMeteringNames)
    
    plot(dateTime, powerdata$Global_reactive_power,
         type = "l",
         xlab = "datetime",
         ylab = "Global_reactive_power")
    
    
    dev.off()    
}
