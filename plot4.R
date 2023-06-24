library(lubridate)

# set url for the data file
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# download and unzip
download.file(fileurl, "./data.zip", method = "curl")
unzip("./data.zip")

# read data file
df <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";")

# chose required part of data
df$Date <- dmy(df$Date)

df <- subset(df, year(df$Date) == 2007 & month(df$Date) == 2 & (day(df$Date) == 1 | day(df$Date) == 2))

# convert to numeric
df$Global_active_power <- as.numeric(df$Global_active_power)

# prepare output file
png("./plot4.png", width = 480, height = 480)

# draw graph
par(mfrow = c(2, 2))

# prepare label fo X axis
N <- length(df$Global_active_power)

# 1st graph
plot(df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", xaxt = "n")
axis(1, at = 1, labels = "Thu"); axis(1, at = N/2, labels = "Fri"); axis(1, at = N, labels = "Sat")

# 2nd graph
plot(df$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", xaxt = "n")
axis(1, at = 1, labels = "Thu"); axis(1, at = N/2, labels = "Fri"); axis(1, at = N, labels = "Sat")

# 3rd graph
my_col = c("black", "red", "blue")
matplot( df[,7:9], type = "l", lty = 1, col = my_col, ylab = "Energy sub metering", xaxt = "n")

legend(x = "topright", legend = names(df)[7:9], col = my_col, lty = 1, box.lty = 0)
axis(1, at = 1, labels = "Thu"); axis(1, at = N/2, labels = "Fri"); axis(1, at = N, labels = "Sat")

# 4th graph
plot(df$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", xaxt = "n")
axis(1, at = 1, labels = "Thu"); axis(1, at = N/2, labels = "Fri"); axis(1, at = N, labels = "Sat")

# device off
dev.off()