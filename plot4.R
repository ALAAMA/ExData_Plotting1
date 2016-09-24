##optional step setWD('Your working directory')
#setwd("/Volumes/C/Coursera/Electric power consumption-Assgnmt")
##Download dataset to sub-directory "data"
if(!file.exists( "./data") ) { dir.create("./data") }
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/dataset.zip")


## Unzip dataSet under the sub-directory "data"
unzip(zipfile="./data/dataset.zip",exdir="./data")

dataset1 <- read.table("./data/household_power_consumption.txt"
                       ,sep = ';',header=TRUE
                       ,na.strings='?',stringsAsFactors=FALSE,
                       colClasses=c("Global_active_power"="numeric"))
#head(dataset1) 
#tail(dataset1)
#select only a  data range :date between "2007-02-01" and "2007-02-02"
dataset1 <- subset(dataset1, 
                   as.POSIXlt(dataset1$Date,format="%d/%m/%Y") >= as.POSIXlt("2007-02-01") 
                   &as.POSIXlt(dataset1$Date,format="%d/%m/%Y") <= as.POSIXlt("2007-02-02"))

#head(dataset1) 
#tail(dataset1)

dateTime<- strptime(paste(dataset1$Date, dataset1$Time),"%d/%m/%Y  %H:%M:%S") 
# append the new date col
dataset1 <- cbind(dateTime ,dataset1)
##Remove charater date cols ;
dataset1$Date<-NULL ; dataset1$Time<-NULL
######################
######################
#graphing parameters 4 2by2
par(mfcol = c(2,2))
par(mar=c(3,3,3,3))##setting margins
#1-------------------------------------
plot(dataset1$dateTime, dataset1$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power(kilowatts)")
 
#2-------------------------------------
plot(dataset1$dateTime, dataset1$Sub_metering_1, 
     type = "l", xlab = "", ylab = "Energy sub metering")
points(dataset1$dateTime, dataset1$Sub_metering_2, 
       type = "l", xlab = "", ylab = "Energy sub metering", 
       col = "red")
points(dataset1$dateTime, dataset1$Sub_metering_3,
       type = "l", xlab = "", ylab = "Energy sub metering", 
       col = "blue")
legend("topright", lty = 1,  cex=0.5, pch=0.5, pt.cex = 0.5,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", 
                  "Sub_metering_2", 
                  "Sub_metering_3"))
#3-------------------------------------
 
plot(dataset1$dateTime, dataset1$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage")

#4-------------------------------------
plot( dataset1$dateTime, dataset1$Global_reactive_power, type = "l", 
      xlab = "datetime", ylab = "Global_reactive_power")

## Save file and close device
dev.copy(png,"plot4.png", width=480, height=480 )
dev.off()


