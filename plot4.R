getwd()
list.files()
list.files("./exdata_data_household_power_consumption")

initial <- read.table("./exdata_data_household_power_consumption/household_power_consumption.txt", header = TRUE, sep = ";", nrows = 100, na.strings = "?")
classes <- sapply(initial, class)
classes
names(initial)


tabAll <- read.table("./exdata_data_household_power_consumption/household_power_consumption.txt", header = TRUE, sep = ";", colClasses = classes, na.strings = "?")

head(tabAll)
dim(tabAll)

tabAll$datetime <- paste(tabAll$Date, tabAll$Time, " ")
head(tabAll)

tabAll$Date <- as.Date(tabAll$Date, "%d/%m/%Y")
tabAll$datetime <- strptime(tabAll$datetime, "%d/%m/%Y %H:%M:%S")
# tabAll$Time <- strptime(tabAll$Time, "%H:%M:%S")
# tabAll$Time <- strptime(tabAll$Time, "%H:%M:%S")

head(tabAll)

sdata <- tabAll[tabAll$Date >= "2007-02-01" & tabAll$Date <= "2007-02-02",]
dim(sdata)

head(sdata)
tail(sdata)


png(filename = "plot4.png", width = 480, height = 480, units = "px")

names(par())
par("mfrow")
par("mar")
par("oma")

par(mfrow=c(2,2))

with(sdata, plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power", xlab = ""))

plot(sdata$datetime, sdata$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

plot(sdata$datetime, sdata$Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering", xlab = "")
lines(sdata$datetime, sdata$Sub_metering_2, col = "red")
lines(sdata$datetime, sdata$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), bty = "n", lty = 1, lwd = 1)

plot(sdata$datetime, sdata$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()

