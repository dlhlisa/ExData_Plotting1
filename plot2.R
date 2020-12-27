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

png(filename = "plot2.png", width = 480, height = 480, units = "px")

with(sdata, plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))

dev.off()