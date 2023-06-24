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

# prepare output file
png("./plot3.png", width = 480, height = 480)

# draw graph
my_col = c("black", "red", "blue")
matplot( df[,7:9], type = "l", lty = 1, col = my_col, ylab = "Energy sub metering", xaxt = "n")

legend(x = "topright", legend = names(df)[7:9], col = my_col, lty = 1)

N <- length(df$Global_active_power)
axis(1, at = 1, labels = "Thu"); axis(1, at = N/2, labels = "Fri"); axis(1, at = N, labels = "Sat")

# device off
dev.off()