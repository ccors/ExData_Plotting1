## Getting full dataset
sourceData <- "./household_power_consumption.txt";
fullData <- read.csv(sourceData, header=TRUE, sep=';', na.strings="?", dec=".",
                      check.names=FALSE, stringsAsFactors=F)

## Subsetting only the data we need
data <- fullData[fullData$Date %in% c("1/2/2007", "2/2/2007"),]
rm(fullData)

## Converting dates
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
datetime <- as.POSIXct(paste(as.Date(data$Date), data$Time)) 

subMetering1 <- as.numeric(data$Sub_metering_1)
subMetering2 <- as.numeric(data$Sub_metering_2)
subMetering3 <- as.numeric(data$Sub_metering_3)

## Plot and save to file
png(file="plot4.png", width=480, height=480)
par(mfrow = c(2, 2))

plot(datetime, data$Global_active_power, type="l", ylab="Global Active Power", xlab="")
plot(datetime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=, lwd=2.5, col=c("black", "red", "blue"), bty="n")

plot(datetime, data$Global_reactive_power, type="l", xlab="datetime", 
     ylab="Global_reactive_power")

dev.off()
