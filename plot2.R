## Getting full dataset
sourceData <- "./household_power_consumption.txt";
fullData <- read.csv(sourceData, header=TRUE, sep=';', na.strings="?", dec=".",
                      check.names=FALSE, stringsAsFactors=F)

## Subsetting only the data we need
data <- fullData[fullData$Date %in% c("1/2/2007", "2/2/2007"),]
rm(fullData)

## Converting dates
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$Datetime <- as.POSIXct(paste(as.Date(data$Date), data$Time)) 

## Plot and save to file
png(file="plot2.png", width=480, height=480)
plot(data$Datetime, data$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")
dev.off()
