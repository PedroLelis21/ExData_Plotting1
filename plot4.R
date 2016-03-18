setwd("./household_power_consumption")

#Download, unzip and creat DataTime with strptime() 

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
download.file(fileUrl, "./household_power_consumption.zip", method = "internal")
unzip("household_power_consumption.zip")
data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";")
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

#Select the rows and columns of the table and creat a tidies datasets

rowId <- c(grep("2007-02-01", as.character(data$DateTime)), grep("2007-02-02", as.character(data$DateTime)))
DateTime <- as.POSIXct(data[rowId, grep("DateTime", names(data))])
Global_active_power <- as.numeric(as.character(data[rowId, grep("Global_active_power", names(data))]))
Voltage <- as.numeric(as.character(data[rowId, grep("Voltage", names(data))]))
Sub_metering_1 <- as.numeric(as.character(data[rowId, grep("Sub_metering_1", names(data))]))
Sub_metering_2 <- as.numeric(as.character(data[rowId, grep("Sub_metering_2", names(data))]))
Sub_metering_3 <- as.numeric(as.character(data[rowId, grep("Sub_metering_3", names(data))]))
Global_reactive_power <- as.numeric(as.character(data[rowId, grep("Global_reactive_power", names(data))]))

tidyData4 <- data.frame(DateTime, Global_active_power, Voltage, Sub_metering_1,
                        Sub_metering_2, Sub_metering_3, Global_reactive_power)
colnames(tidyData4) <- c("DateTime", "Global_active_power", "Voltage", "Sub_metering_1",
                          "Sub_metering_2", "Sub_metering_3", "Global_reactive_power")
# PNG and plots

png("plot4.png", width = 480, height = 480, pointsize = 12, bg = "transparent")
par(mfrow = c(2, 2))

xLabel = ""
yLabel = "Global Active Power (kilowatts)"
plot(tidyData4$DateTime, tidyData4$Global_active_power, xlab = xLabel, ylab = yLabel, type="l")

xLabel = "datetime"
yLabel = "Voltage"
plot(tidyData4$DateTime, tidyData4$Voltage, xlab = xLabel, ylab = yLabel, type="l")

xLabel = ""
yLabel = "Energy sub metering"
plot(tidyData4$DateTime, tidyData4$Sub_metering_1, type="l", col="black", xlab = xLabel, ylab = yLabel)
lines(tidyData4$DateTime, tidyData4$Sub_metering_2, col="red", type="l")
lines(tidyData4$DateTime, tidyData4$Sub_metering_3, col="blue", type="l")
legend("topright", legend = names(tidyData4)[4:6], col = c("black", "red", "blue"), lty = c(1,1), bty = "n")

xLabel = "datetime"
yLabel = "Global_reactive_power"
plot(tidyData4$DateTime, tidyData4$Global_reactive_power, xlab = xLabel, ylab = yLabel, type="l")
dev.off()
