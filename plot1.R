########################################################################
#
#  plot1.R
#
#  Author: Guillermo J. Corominas. 
#
#  Loads power consumption data from a household and plots a 
#  a histogram of global active power over the course of three days
#  
########################################################################

#Load column names
nms = names(read.csv("household_power_consumption.txt", nrow = 1, header = TRUE, sep=";"))

#Load data 
powcns <- read.csv("household_power_consumption.txt", 
                   skip = 66637, 
                   nrow = 2880, 
                   sep = ";", 
                   col.names = nms)

#Transform date and time (factors) to POSIX date format.
powcns$Date <- paste(powcns$Date, powcns$Time)
powcns$Date <- strptime(powcns$Date, "%d/%m/%Y %H:%M:%S")

#Open the png device to write. 
png("plot1.png", width=480, height=480)

#Actual plotting
hist(powcns$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

#Release the device. 
dev.off()



