library('dplyr')

w1<-read.table("household_power_consumption.txt", sep= ';', header = T)

m1<-subset(w1,grepl('^1/2/2007',w1$Date))
m2<-subset(w1,grepl('^2/2/2007',w1$Date))

total <- rbind(m1, m2)

total$newdate <- strptime(as.character(total$Date), "%d/%m/%Y")
total$newdate <- format(total$newdate, "%Y-%m-%d")

total$DT <- paste(total$newdate, total$Time)

total$DT1 <- as.POSIXct(total$DT)


plot(total$DT1, as.numeric(as.character(total$Global_active_power)),type = "l",xlab="",  ylab = "Global Active Power (Kilowatts)")
dev.copy(png, file = "plot2.png", width=480,height=480,units="px")
dev.off()