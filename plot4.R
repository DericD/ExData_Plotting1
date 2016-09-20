filename <- "household_power_consumption.zip"
foldername <- "power_consumption"
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileurl, filename)
unzip(filename)

power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
dates <- power[power$Date >= "2007-02-01" & power$Date <= "2007-02-02",]
remove(power)

dates$DateTime <- paste(dates$Date, dates$Time)
dates$DateTime <- strptime(dates$DateTime, format="%Y-%m-%d %H:%M:%S")

dates$Sub_metering_1 <- as.numeric(as.character(dates$Sub_metering_1))
dates$Sub_metering_2 <- as.numeric(as.character(dates$Sub_metering_2))
dates$Sub_metering_3 <- as.numeric(as.character(dates$Sub_metering_3))
dates$Global_reactive_power <- as.numeric(as.character(dates$Global_reactive_power))da
dates$Voltage <- as.numeric(as.character(dates$Voltage))
plot_colors <- c("black", "red", "blue")
dates$Global_active_power <- as.numeric(as.character(dates$Global_active_power))


png( file = "plot4.png", bg = "transparent", width = 480, height = 480)
par(mfrow=c(2,2))
#top left
plot(dates$DateTime, dates$Global_active_power, type="l", ylab = "Global Active Power (Kilowatts)", xlab = "")
#top right
plot(dates$DateTime, dates$Voltage, type="l", ylab = "Voltage", xlab = "datetime")
#bottom left
plot(dates$DateTime, dates$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(dates$DateTime, dates$Sub_metering_2, col = "red")
lines(dates$DateTime, dates$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       border = "black", col = plot_colors, lwd = c(2.5, 2.5, 2.5))
#bottom right
plot(dates$DateTime, dates$Global_reactive_power, xlab =  "datetime", ylab = "Global_reactive_power", type = "l")

dev.off()

