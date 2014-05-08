########################################################################
#
#  plot3.R
#
#  Author: Guillermo J. Corominas. 
#
#  Loads power consumption data from a household and plots a graph 
#  of the energy sub metering over the course of three days
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
png("plot3.png", width=480, height=480)

#Actual plotting
plot(powcns$Date, powcns$Sub_metering_1, type="n", xlab="", ylab="Global Active Power (kilowatts)")
lines(powcns$Date, powcns$Sub_metering_1)
lines(powcns$Date, powcns$Sub_metering_2, col="red")
lines(powcns$Date, powcns$Sub_metering_3, col="blue")

legend("topright", lty=1, col=c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Release the device. 
dev.off()
