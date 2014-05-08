########################################################################
#
#  plot4.R
#
#  Author: Guillermo J. Corominas. 
#
#  Loads power consumption data from a household and plots four different 
#  graphs of different variable measures over the course of three days
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
png("plot4.png", width=480, height=480)

#Actual plotting
par(mfrow = c(2, 2))
with(powcns, {
    plot(Date, Global_active_power, xlab="", ylab="Global Active Power", type="n")
    lines(Date, Global_active_power)
    plot(Date, Voltage, xlab="datetime", ylab="Voltage", type="n")
    lines(Date, Voltage)
    plot(Date, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
    lines(Date, Sub_metering_1)
    lines(Date, Sub_metering_2, col="red")
    lines(Date, Sub_metering_3, col="blue") 
    legend("topright", lty=1, col=c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Date, Global_reactive_power, type="n", ylab="Global_reactive_power", xlab="datetime")
    lines(Date, Global_reactive_power)
})


#Release the device. 
dev.off()
