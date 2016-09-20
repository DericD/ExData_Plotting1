filename <- "household_power_consumption.zip"
foldername <- "power_consumption"
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileurl, filename)
unzip(filename)

power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
dates <- power[power$Date >= "2007-02-01" & power$Date <= "2007-02-02",]
remove(power)

dates$Global_active_power <- as.numeric(as.character(dates$Global_active_power))

dates$DateTime <- paste(dates$Date, dates$Time)
dates$DateTime <- strptime(dates$DateTime, format="%Y-%m-%d %H:%M:%S")


png( file = "plot2.png", bg = "transparent", width = 480, height = 480)                                    
plot(dates$DateTime, dates$Global_active_power, type="l", ylab = "Global Active Power (Kilowatts)", xlab = "")
dev.off()