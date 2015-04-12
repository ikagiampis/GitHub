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
y1 <- as.numeric(as.character(total$Sub_metering_1))
y2 <- as.numeric(as.character(total$Sub_metering_2))
y3 <- as.numeric(as.character(total$Sub_metering_3))

plot(x ,y1 ,type = "l",xlab="",  ylab = "Energy sub metering")
par(new = TRUE)
plot(x, y2, ylim=range(c(y1,y2)),type = "l", axes = FALSE, xlab = "", ylab = "", col = "red")
par(new = TRUE)
plot(x, y3, ylim=range(c(y1,y2, y3)),type = "l", axes = FALSE, xlab = "", ylab = "", col = "blue")
legend('topright', lty=c(1,1), col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.copy(png, file = "plot3.png", width=480,height=480,units="px")
dev.off()
#adline(total$DT1, as.numeric(as.character(total$Sub_metering_3)))
