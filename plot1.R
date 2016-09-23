# plot1.R
#
# 
# This script operate an analysis of HouseHold Power Consumption data set
# It extracts an histogram of Global Active Power (kilowatts)
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

# draw the histogram in main device
hist(as.numeric(as.character(dataset$Global_active_power)), col="Red",
     main="Global Active Power", xlab="Global Active Power (kilowatts)")

# copy to png device file and closure
dev.copy(device=png, "plot1.png", width=480, height=480)
dev.off()



