## Plot 1

## Reads the file in a table
power_data <- read.table("household_power_consumption.txt",skip=1,sep=";")

## Renames the columns in a descrpitive way
names(power_data) <- c("Date","Time","Global_active_power","Global_reactive_power"
                       ,"Voltage","Global_intensity","Sub_metering_1","Sub_metering_2"
                       ,"Sub_metering_3")

## Subset the dataset for the required 2 dates
power_data <- subset(power_data, power_data$Date=="1/2/2007" | power_data$Date =="2/2/2007")

## Sets the dates as variables to format them later
date1 <- "2007-02-01"
date2 <- "2007-02-02"

## Formats the dates as Date class and Time in the posixt format
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")
power_data$Time <- strptime(power_data$Time, format = "%H:%M:%S")
power_data[power_data$Date == date1, "Time"] <- format(power_data[power_data$Date == date1, "Time"], "2007-02-01 %H:%M:%S")
power_data[power_data$Date == date1, "Time"] <- format(power_data[power_data$Date == date1, "Time"], "2007-02-02 %H:%M:%S")


## ------------------------------------------------

## Creates the four plots and exports it to png

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

{
  plot(power_data$Time,as.numeric(power_data$Global_active_power),type="l",  xlab="",ylab="Global Active Power")  
  plot(power_data$Time,as.numeric(power_data$Voltage), type="l",xlab="datetime",ylab="Voltage")
  plot(power_data$Time,power_data$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(power_data,lines(Time,as.numeric(Sub_metering_1)))
  with(power_data,lines(Time,as.numeric(Sub_metering_2),col="red"))
  with(power_data,lines(Time,as.numeric(Sub_metering_3),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(power_data$Time,as.numeric(power_data$Global_reactive_power),type="l",xlab="datetime",ylab="Global_reactive_power")
}

dev.off()