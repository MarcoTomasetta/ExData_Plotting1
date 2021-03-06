
if(!file.exists("data")){dir.create("data")} # create a data dir and url connection
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dateDownloaded<-date() #register the date of download
download.file(url, destfile="./data/household_power_consumption.zip", method="curl") #download the zip file
unzip(zipfile="./data/household_power_consumption.zip",exdir="./data") #unzip the file

getdata <- read.table("./data/household_power_consumption.txt",sep=";", header = TRUE) #read
x<-subset(getdata, Date=="2/2/2007")
y<-subset(getdata, Date=="1/2/2007")
z<-rbind(x,y)

z$Global_active_power=as.numeric(as.character(z$Global_active_power))
z$Global_reactive_power=as.numeric(as.character(z$Global_reactive_power))
z$Voltage=as.numeric(as.character(z$Voltage))
z$Global_intensity=as.numeric(as.character(z$Global_intensity))
z$Sub_metering_1=as.numeric(as.character(z$Sub_metering_1))
z$Sub_metering_2=as.numeric(as.character(z$Sub_metering_2))

z$Date=as.Date(as.character(z$Date), format = "%e/%m/%Y")
z$datetime=paste(z$Date, z$Time, sep = ",")
z$datetime=strptime(z$datetime, format = "%e/%m/%Y,%H:%M:%S", tz = "America/Los_Angeles")
z$day = weekdays(as.Date(z$datetime))

png(filename = "./data/Plot4.png",
    width = 480, height = 480)

par(mfrow = c(2, 2)) 

plot(z$datetime, z$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(z$datetime, z$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(z$datetime, z$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(z$datetime, z$Sub_metering_2, type="l", col="red")
lines(z$datetime, z$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(z$datetime, z$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
