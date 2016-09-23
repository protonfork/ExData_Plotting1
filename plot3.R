# Plot3.R
#
# 
# This script operate an analysis of HouseHold Power Consumption data set
# It draws Energy Sub Metering over the two days of study
#

# library loading for data frame management and date format
library(dplyr)
library(lubridate)

# download of the data file, if needed
if(!(dir.exists("data"))){
        dir.create("data")
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./data/ElecPowerConsumption.zip")
        unzip("./data/ElecPowerConsumption.zip", exdit="./data")
}


# selection of a subset of the dataset (only the date from 2007-02-01 to 2007-02-02)
dataset <- read.table("./data/household_power_consumption.txt", sep=";", header=T) %>%
        filter((dmy(Date)>=ymd("2007-02-01"))&(dmy(Date)<=ymd("2007-02-02")))

# draw the plot in main device
plot(dmy_hms(paste(dataset$Date,dataset$Time)), 
     as.numeric(as.character(dataset$Sub_metering_1)), type="l",
     ylab="Energy sub metering", xlab="")

lines(dmy_hms(paste(dataset$Date,dataset$Time)),
      as.numeric(as.character(dataset$Sub_metering_2)), col="Red", type="l")

lines(dmy_hms(paste(dataset$Date,dataset$Time)),
      as.numeric(as.character(dataset$Sub_metering_3)), col="Blue", type="l")

legend("topright",col=c("Black", "Red", "Blue"), lwd=1, cex=0.7,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# copy to png device file and closure
dev.copy(device=png, "plot3.png", width=480, height=480)
dev.off()