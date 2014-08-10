## Week 1 Exercise 2

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


###############################
## Plot2
##############################
y <- tabProj$Global_active_power
x <- tabProj$datetime
plot(x,y, type="n", ylab = "Global Active Power (kilowatts)", xlab = NA,, cex.axis = 0.9, cex.lab = 0.9)
lines(x, y)
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()
