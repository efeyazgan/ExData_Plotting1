library(ggplot2)
library(scales)
hdata<-read.table("household_power_consumption.txt", sep=";", header= TRUE, na.strings="?")
hdata$Date <- as.Date(hdata$Date, format="%d/%m/%Y")
hdata$datetime <- with(hdata, as.POSIXct(paste(hdata$Date, hdata$Time), format="%Y-%m-%d %H:%M:%S"))
hdatasub<-subset(hdata, Date >= "2007-02-01" & Date <= "2007-02-02")
png("plot3.png")
efep<-ggplot(hdatasub, aes(x=hdatasub$datetime, y=hdatasub$Sub_metering_1, colour="Sub_metering_1")) + 
        geom_line() + 
        geom_line(data=hdatasub,aes(x=hdatasub$datetime, y=hdatasub$Sub_metering_2, colour="Sub_metering_2")) + 
        geom_line(data=hdatasub,aes(x=hdatasub$datetime, y=hdatasub$Sub_metering_3, colour="Sub_metering_3")) + 
        labs(x="")+labs(y="Energy sub metering") + 
        scale_colour_manual("",breaks=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),values=c("black","red","blue"))+
        theme(legend.justification = c(0.9, 0.75), legend.position = c(1, 1),legend.background=element_rect(fill='transparent'))+
        scale_x_datetime(breaks = date_breaks("1 day"),labels=date_format("%A", tz = Sys.timezone(location = TRUE)))
print(efep)
dev.off()