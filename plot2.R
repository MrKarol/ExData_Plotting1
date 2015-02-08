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

#creating the chart
par(mfrow=c(1,1))
with(data,plot(strptime(x=paste(as.character(Date),as.character(Time)),format = "%Y-%m-%d %H:%M:%S" ),Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))
#copying from screen to png
dev.copy(png,"plot2.png")
dev.off()