## Read data and save as variable "data"
data<-read.table("household_power_consumption.txt",
                 header=TRUE, sep=";", na.strings="?")

## Save data from relevant date range (2007-02-01 and 2007-02-02) as variable "subset"
subset<-data[data$Date=="1/2/2007" | data$Date=="2/2/2007",]

# Combine Date and Time
subset$DateTime <- strptime(paste(subset$Date, subset$Time, sep=" "), 
                          format="%d/%m/%Y %H:%M:%S")

# Plot "subset"
plot(subset$DateTime, subset$Global_active_power, type="l", 
     xlab="", ylab="Global Active Power (kilowatts)")

## Save plot to a 480x480 PNG file
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()