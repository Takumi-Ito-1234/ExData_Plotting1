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
df$Time <- hms(df$Time)

df <- subset(df, year(df$Date) == 2007 & month(df$Date) == 2 & (day(df$Date) == 1 | day(df$Date) == 2))

# convert to numeric
df$Global_active_power <- as.numeric(df$Global_active_power)

# prepare output file
png("./plot1.png", width = 480, height = 480)

# draw graph
hist(df$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

# device off
dev.off()