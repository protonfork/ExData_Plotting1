# Plot2.R
#
# 
# This script operate an analysis of HouseHold Power Consumption data set
# It draws a 4 plots picture :
#       Global Active Power (kilowatts) over the two days of study
#       Energy Sub Metering over the two days of study
#       Voltage evolution over the two days of study
#       Global Reactive Power over the two days of study
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

# create 4 area of plot
par(mfrow=c(2,2))


# draw the plot 1 in main device
plot(dmy_hms(paste(dataset$Date,dataset$Time)), 
     as.numeric(as.character(dataset$Global_active_power)), type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")


# draw the plot 3 in main device
plot(dmy_hms(paste(dataset$Date,dataset$Time)), 
     as.numeric(as.character(dataset$Voltage)), type="l", 
     ylab="Voltage", xlab="datetime")


# draw the plot 2 in main device
plot(dmy_hms(paste(dataset$Date,dataset$Time)), 
     as.numeric(as.character(dataset$Sub_metering_1)), type="l", 
     ylab="Energy sub metering", xlab="")

lines(dmy_hms(paste(dataset$Date,dataset$Time)),
      as.numeric(as.character(dataset$Sub_metering_2)), col="Red", type="l")

lines(dmy_hms(paste(dataset$Date,dataset$Time)),
      as.numeric(as.character(dataset$Sub_metering_3)), col="Blue", type="l")

legend("topright",col=c("Black", "Red", "Blue"), lwd=1, cex=0.7,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# draw the plot 4 in main device
plot(dmy_hms(paste(dataset$Date,dataset$Time)), 
     as.numeric(as.character(dataset$Global_reactive_power)), type="l", bty = "n",
     ylab="Global_reactive_power", xlab="datetime")

# copy to png device file and closure
dev.copy(device=png, "plot4.png", width=480, height=480)
dev.off()