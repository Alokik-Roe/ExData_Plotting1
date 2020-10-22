
library(dplyr)
library(tidyr)
library(datasets)


##  read the data
data1 <- read.table("household_power_consumption.txt", sep = ";",
                    header = TRUE)

#change the date class
data1[,"Date"] <- as.Date(data1[,'Date'], format = "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
data1 <- subset(data1,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))


## Remove incomplete observation
data1 <- data1[complete.cases(data1),]

## Combine Date and Time column
dateTime <- paste(data1$Date, data1$Time)

##remove date and time column
data1 <- cbind(dateTime, data1[,c(3:9)])

##format dateTime 
data1$dateTime <- as.POSIXct(data1$dateTime)

##plotting the line graph of GLOBAL ACTIVE POWER
data1[,"Global_active_power"] <- as.numeric(data1[,"Global_active_power"])

with(data1,{plot(Sub_metering_1~dateTime, type = "l",
                 ylab = "Energy Sub Metering", xlab=" ")
  lines(Sub_metering_2 ~ dateTime, col = "red")
  lines(Sub_metering_3 ~ dateTime, col = "blue")
  
  
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Copy my plot to a PNG file
dev.copy(png, file = "plot3.png")

## close the PNG device!
dev.off()

