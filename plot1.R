hdata<-read.table("household_power_consumption.txt", sep=";", header= TRUE, na.strings="?")
hdata$Date <- as.Date(hdata$Date, format="%d/%m/%Y")
hdatasub<-subset(hdata, Date >= "2007-02-01" & Date <= "2007-02-02")
png(file = "plot1.png", width = 480, height = 480)
hist(hdasub$Global_active_power,xlab="Global Active Power (kilowatts)",main="Global Active Power",col="red",ylim=c(0.,1200.))
dev.off()
