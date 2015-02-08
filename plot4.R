#downloading the file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","data.zip")
#unzipping downlaoded file
unzip("data.zip")
#loading all data
all_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",na.strings = "?")
#changing Date from factor to date type
all_data$Date <- as.Date(all_data$Date, format = "%d/%m/%Y")
#narrowing down all_data only to informaiton we are interested in
data <- filter(all_data, 
               as.numeric(format(Date, "%Y")) == 2007 & 
                   as.numeric(format(Date, "%m")) == 2    & 
                   (
                       as.numeric(format(Date, "%d"))==1  |
                           as.numeric(format(Date, "%d"))==2  
                   )
)

png("plot4.png") #png device
par(mfrow=c(2,2))
#top-left
with(data,plot(strptime(x=paste(as.character(Date),as.character(Time)),format = "%Y-%m-%d %H:%M:%S" ),Global_active_power,type="l",xlab="",ylab="Global Active Power"))
#top-right
with(data,plot(strptime(x=paste(as.character(Date),as.character(Time)),format = "%Y-%m-%d %H:%M:%S" ),Voltage,type="l",xlab="datetime",ylab="Voltage"))
#bottom-left
with(data,plot(strptime(x=paste(as.character(Date),as.character(Time)),format = "%Y-%m-%d %H:%M:%S" ),
               Sub_metering_1,
               type="l",xlab="",ylab="Energy sub metering",col="black"))
with(data,lines(strptime(x=paste(as.character(Date),as.character(Time)),format = "%Y-%m-%d %H:%M:%S" ),
                Sub_metering_2,
                col="red"))
with(data,lines(strptime(x=paste(as.character(Date),as.character(Time)),format = "%Y-%m-%d %H:%M:%S" ),
                Sub_metering_3,
                col="blue"))
legend(x="topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"),
       lty=c(1,1,1), 
       lwd=c(1,1,1),
       box.lwd = 0,box.col = "transparent",bg = "transparent"
)
#bottom-right
with(data,plot(strptime(x=paste(as.character(Date),as.character(Time)),format = "%Y-%m-%d %H:%M:%S" ),Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power"))
dev.off()