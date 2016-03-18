setwd("./household_power_consumption")

#Download, unzip and creat DataTime with strptime() 

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
download.file(fileUrl, "./household_power_consumption.zip", method = "internal")
unzip("household_power_consumption.zip")
data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";")
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

#Select the rows and columns of the table and creat a tidy dataset

rowId <- c(grep("2007-02-01", as.character(data$DateTime)), grep("2007-02-02", as.character(data$DateTime)))
DateTime <- as.POSIXct(data[rowId, grep("DateTime", names(data))])
Sub_metering_1 <- as.numeric(as.character(data[rowId, grep("Sub_metering_1", names(data))]))
Sub_metering_2 <- as.numeric(as.character(data[rowId, grep("Sub_metering_2", names(data))]))
Sub_metering_3 <- as.numeric(as.character(data[rowId, grep("Sub_metering_3", names(data))]))

tidyData3 <- data.frame(DateTime, Sub_metering_1, Sub_metering_2, Sub_metering_3)
colnames(tidyData3) <- c("DateTime", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# PNG and plot

png("plot3.png", width = 480, height = 480, pointsize = 12, bg = "transparent")
xLabel = ""
yLabel = "Energy sub metering"
plot(tidyData3$DateTime, tidyData3$Sub_metering_1, type="l", col="black", xlab = xLabel, ylab = yLabel)
lines(tidyData3$DateTime, tidyData3$Sub_metering_2, col="red", type="l")
lines(tidyData3$DateTime, tidyData3$Sub_metering_3, col="blue", type="l")
legend("topright", legend = names(tidyData3[2:4]), col = c("black", "red", "blue"), lty = c(1,1))
dev.off()
