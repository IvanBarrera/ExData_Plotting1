library("data.table")
library("datasets")

# Download file
temp <- tempfile() # Create a temporal file
download.file ("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
unzip(temp) # Unzip temporal file
unlink(temp) # Delete temporal file
rm(temp) # Removes temporal file from Global Environment of R

# Load data
electric <- fread("household_power_consumption.txt",
                  header = TRUE,
                  sep = ";",
                  na.strings = '?')

# Set correct data type of colums
electric$Date <- as.Date(electric$Date, "%d/%m/%Y")
electric$Global_active_power <- as.numeric(electric$Global_active_power)
electric$Global_reactive_power <- as.numeric(electric$Global_reactive_power)
electric$Voltage <- as.numeric(electric$Voltage)
electric$Global_intensity <- as.numeric(electric$Global_intensity)
electric$Sub_metering_1 <- as.numeric(electric$Sub_metering_1)
electric$Sub_metering_2 <- as.numeric(electric$Sub_metering_2)
electric$Sub_metering_3 <- as.numeric(electric$Sub_metering_3)

# Subset data frame
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")
electric <- electric[electric$Date >= date1 & electric$Date <= date2,]

# Create datetime column
electric$datetime <- as.POSIXct(paste(electric$Date, electric$Time), format = "%Y-%m-%d %H:%M:%S")

# Plot line graphic datetime ~ Global_active_power (Plot 3)
plot(
        electric$datetime,
        electric$Sub_metering_1,
        type = "l",
        xlab = "",
        ylab = "Energy sub metering"
)
lines(
        electric$datetime,
        electric$Sub_metering_2,
        col = "red"
)
lines(
        electric$datetime,
        electric$Sub_metering_3,
        col = "blue"
)
legend("topright",
       lty = 1,
       col = c("black","blue", "red"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       border = "white",
       cex = 0.70,
       bty = "n",
       x.intersp = 0.5,
       y.intersp = 0.8
)


# PNG Device 
dev.copy(png, file = "plot3.png", width = 480, height = 480) #Copy my plot to a PNG file
dev.off()
