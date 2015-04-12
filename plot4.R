library('dplyr')

w1<-read.table("household_power_consumption.txt", sep= ';', header = T)

m1<-subset(w1,grepl('^1/2/2007',w1$Date))
m2<-subset(w1,grepl('^2/2/2007',w1$Date))

total <- rbind(m1, m2)

total$newdate <- strptime(as.character(total$Date), "%d/%m/%Y")
total$newdate <- format(total$newdate, "%Y-%m-%d")

total$DT <- paste(total$newdate, total$Time)

total$DT1 <- as.POSIXct(total$DT)
x <- total$DT1

y_1 <- as.numeric(as.character(total$Global_active_power))
y_2 <- as.numeric(as.character(total$Voltage))
y_4 <- as.numeric(as.character(total$Global_reactive_power))

y_3_1 <- as.numeric(as.character(total$Sub_metering_1))
y_3_2 <- as.numeric(as.character(total$Sub_metering_2))
y_3_3 <- as.numeric(as.character(total$Sub_metering_3))


par(mfrow = c(2,2), mar = c(4,4,2,1))
plot(x, y_1 ,type = "l",xlab="",  ylab = "Global Active Power",  cex.axis=0.6)
plot(x ,y_2 ,type = "l",xlab="datetime",  ylab = "Voltage",  cex.axis=0.6)

plot(x ,y_3_1 ,type = "l",xlab="",  ylab = "Energy sub metering",  cex.axis=0.6)
par(new = TRUE)
plot(x, y_3_2, ylim=range(c(y_3_1,y_3_2)),type = "l", axes = FALSE, xlab = "", ylab = "", col = "red")
par(new = TRUE)
plot(x, y_3_3, ylim=range(c(y_3_1,y_3_2, y_3_3)),type = "l", axes = FALSE, xlab = "", ylab = "", col = "blue")
legend('topright', lty=c(1,1), col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.5)

plot(x ,y_4 ,type = "l",xlab="datetime",  ylab = "Global_reactive_power", cex.axis=0.6)

dev.copy(png, file = "plot4.png", width=480,height=480,units="px")
dev.off()