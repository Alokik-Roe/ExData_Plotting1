
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

##plotting the histogram of GLOBAL ACTIVE POWER
data1[,"Global_active_power"] <- as.numeric(data1[,"Global_active_power"])

hist(data1$Global_active_power, col = "Orange", main = "Global Active Power",
     xlab = "Global Active Power (kiloWatts)")

## Copy my plot to a PNG file
dev.copy(png, file = "plot1.png")

## close the PNG device!
dev.off()








