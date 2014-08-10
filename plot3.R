## Week 1 Exercise 3

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./hosehold_power_consumption.zip")
uz <- unzip("./hosehold_power_consumption.zip")

##tabFile <- file("household_power_consumption.txt")
tabFile <- file(uz)
attr(tabFile, "file.format") <- list(header = TRUE, sep = ";", dec = ".", as.is = TRUE, colClasses = c(rep("character",2), rep("numeric", 7)))

install.packages("sqldf")
library(sqldf)
tabProj <- sqldf("select * from tabFile where Date = '1/2/2007'or Date = '2/2/2007'")
tabProj[ tabProj == "?" ] = NA

dates <- tabProj$Date
times <- tabProj$Time
datetime <- paste(dates, times)
datetime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")
tabProj$datetime <- datetime
tabProj$Date <- as.Date(tabProj$Date, format="%d/%m/%Y")


######################################
## Plot3
######################################
y1 <- tabProj$Sub_metering_1
y2 <- tabProj$Sub_metering_2
y3 <- tabProj$Sub_metering_3
x <- tabProj$datetime

plot(x,y1, type = "n",ylab = "Energy sub metering", xlab = NA,ylim=c(0,max(y1)), cex.axis = 0.9, cex.lab = 0.9)
lines(x,y1, type="l")
lines( x, y2, type="l", col="red" )
lines( x, y3, type="l", col="blue")
legend("topright", lty = 1, col = c("black", "red", "blue"),legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png,"plot3.png", width=480, height=480)
dev.off()
