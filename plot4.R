library(ggplot2)
library(grid)
library(gridExtra)
hdata<-read.table("household_power_consumption.txt", sep=";", header= TRUE, na.strings="?")
hdata$Date <- as.Date(hdata$Date, format="%d/%m/%Y")
hdata$datetime <- with(hdata, as.POSIXct(paste(hdata$Date, hdata$Time), format="%Y-%m-%d %H:%M:%S"))
hdatasub<-subset(hdata, Date >= "2007-02-01" & Date <= "2007-02-02")
png("plot4.png")
p1<-ggplot(hdatasub, aes(x=hdatasub$datetime, y=hdatasub$Global_active_power)) + geom_line() + labs(x="") + labs(y="Global Active Power (kilowatts)") + scale_x_datetime(breaks = date_breaks("1 day"),labels=date_format("%A", tz = Sys.timezone(location = TRUE)))

p2<-ggplot(hdatasub, aes(x=hdatasub$datetime, y=hdatasub$Voltage)) + geom_line() + labs(x="datetime") + labs(y="Voltage") + scale_x_datetime(breaks = date_breaks("1 day"),labels=date_format("%A", tz = Sys.timezone(location = TRUE)))

p3<-ggplot(hdatasub, aes(x=hdatasub$datetime, y=hdatasub$Sub_metering_1, colour="Sub_metering_1")) + 
        geom_line() + 
        geom_line(data=hdatasub,aes(x=hdatasub$datetime, y=hdatasub$Sub_metering_2, colour="Sub_metering_2")) + 
        geom_line(data=hdatasub,aes(x=hdatasub$datetime, y=hdatasub$Sub_metering_3, colour="Sub_metering_3")) + 
        labs(x="")+labs(y="Energy sub metering") + 
        scale_colour_manual("",breaks=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),values=c("black","red","blue"))+
        theme(legend.justification = c(0.9, 0.75), legend.position = c(1, 1),legend.background=element_rect(fill='transparent'))+
        scale_x_datetime(breaks = date_breaks("1 day"),labels=date_format("%A", tz = Sys.timezone(location = TRUE)))

p4<-ggplot(hdatasub, aes(x=hdatasub$datetime, y=hdatasub$Global_reactive_power)) + geom_line() + labs(x="datetime") + labs(y="Global_reactive_power") + scale_x_datetime(breaks = date_breaks("1 day"),labels=date_format("%A", tz = Sys.timezone(location = TRUE)))
grid.arrange(p1, p2, p3, p4, ncol=2)
dev.off()