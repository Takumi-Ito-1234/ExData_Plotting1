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
png("./plot2.png", width = 480, height = 480)

# draw graph
plot(df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", xaxt = "n")

N <- length(df$Global_active_power)
axis(1, at = 1, labels = "Thu"); axis(1, at = N/2, labels = "Fri"); axis(1, at = N, labels = "Sat")

# device off
dev.off()