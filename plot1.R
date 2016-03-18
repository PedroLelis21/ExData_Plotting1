setwd("./household_power_consumption")

#Download, unzip and convert Date with as.Date() 

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
download.file(fileUrl, "./household_power_consumption.zip", method = "internal")
unzip("household_power_consumption.zip")
data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";")
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

#Select the rows and columns of the table and creat a tidy dataset

rowId <- c(grep("2007-02-01", as.character(data$DateTime)), grep("2007-02-02", as.character(data$DateTime)))
tidyData1 <- as.numeric(data[rowId, grep("Global_active_power", names(data))])

# PNG and plot

png("plot1.png", width = 480, height = 480, pointsize = 12, bg = "transparent")
xLabel = "Global Active Power (kilowatts)"
yLabel = "Frequency"
hist(tidyData1, col = "red", xlab = xLabel, ylab = yLabel, main = "Global Active Power")
dev.off()
