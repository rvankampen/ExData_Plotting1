## Read data and save as variable "data"
data<-read.table("household_power_consumption.txt",
                 header=TRUE, sep=";", na.strings="?")

## Save data from relevant date range (2007-02-01 and 2007-02-02) as variable "subset"
subset<-data[data$Date=="1/2/2007" | data$Date=="2/2/2007",]

# Combine Date and Time
subset$DateTime <- strptime(paste(subset$Date, subset$Time, sep=" "), 
                            format="%d/%m/%Y %H:%M:%S")

# Plot "subset"
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(subset, {
        plot(Global_active_power~DateTime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        plot(Voltage~DateTime, type="l", 
             ylab="Voltage (volt)", xlab="")
        plot(Sub_metering_1~DateTime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~DateTime,col='Red')
        lines(Sub_metering_3~DateTime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~DateTime, type="l", 
             ylab="Global Rective Power (kilowatts)",xlab="")
})
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
# 1
plot(subset$DateTime, subset$Global_active_power, type="l",
     xlab="", ylab="Global Active Power")
# 2
plot(subset$DateTime, subset$Voltage, type="l",
     xlab="datetime", ylab="Voltage")
# 3
plot(subset$DateTime, subset$Sub_metering_1, type="l", col="black",
     xlab="", ylab="Energy sub metering")
lines(subset$DateTime, subset$Sub_metering_2, col="red")
lines(subset$DateTime, subset$Sub_metering_3, col="blue")
legend("topright",
       col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1,
       box.lwd=0)
# 4
plot(subset$DateTime, subset$Global_reactive_power, type="n",
     xlab="datetime", ylab="Global_reactive_power")
lines(subset$DateTime, subset$Global_reactive_power)

## Save plot to a 480x480 PNG file
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()