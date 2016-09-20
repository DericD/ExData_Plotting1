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

plot_colors <- c("black", "red", "blue")

png( file = "plot3.png", bg = "transparent", width = 480, height = 480)                                    
plot(dates$DateTime, dates$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(dates$DateTime, dates$Sub_metering_2, col = "red")
lines(dates$DateTime, dates$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       border = "black", col = plot_colors, lwd = c(2.5, 2.5, 2.5), pt.cex = .75, x.intersp = 4, y.intersp = 1.25, adj = .3)
dev.off()