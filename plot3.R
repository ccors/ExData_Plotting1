## Getting full dataset
if (!file.exists("household_power_consumption.txt")) {
        untar("household_power_consumption.tar.gz")
}
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
png(file="plot3.png", width=480, height=480)
plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=2.5, col=c("black", "red", "blue"), bty="n")
dev.off()
