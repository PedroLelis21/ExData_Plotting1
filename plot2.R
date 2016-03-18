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
Global_active_power <- as.numeric(as.character(data[rowId, grep("Global_active_power", names(data))]))

tidyData2 <- data.frame(DateTime, Global_active_power)
colnames(tidyData2) <- c("DateTime", "Global_active_power")
    
# PNG and plot

png("plot2.png", width = 480, height = 480, pointsize = 12, bg = "transparent")
xLabel = ""
yLabel = "Global Active Power (kilowatts)"
plot(tidyData2$DateTime, tidyData2$Global_active_power, xlab = xLabel, ylab = yLabel, type="l")
dev.off()
