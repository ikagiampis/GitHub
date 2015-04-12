library('dplyr')
w1<-read.table("household_power_consumption.txt", sep= ';', header = T)

m1<-subset(w1,grepl('^1/2/2007',w1$Date))
m2<-subset(w1,grepl('^2/2/2007',w1$Date))

total <- rbind(m1, m2)

hist(as.numeric(as.character(total$Global_active_power)), col = "red", main = "Global Active Power", xlab = "Global Active Power (Kilowatts)" )
dev.copy(png, file = "plot1.png", width=480,height=480,units="px")
dev.off()


