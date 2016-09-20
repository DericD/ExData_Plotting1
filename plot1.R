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
                            
png( file = "plot1.png", bg = "transparent", width = 480, height = 480)                                    
hist(dates$Global_active_power, col = "red", xlab = "Global Active Power (Kilowatts)", main = "Global Active Power")
dev.off()