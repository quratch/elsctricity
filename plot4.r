setwd("D:/R/Coursera/Assignment")
library(lubridate)
if(!file.exists("./data1")) file.create("./data1") 
if(!file.exists("./household_power.zip")) download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",mode = "wb", destfile = "./household_power.zip")
unzip("./household_power.zip", overwrite = FALSE, exdir = "./data1")
list.files("./data1")
destfile<-list.files("./data1")[2]
hhp1 <- read.csv(file.path(getwd(),"data1",destfile), sep = ';')
#file size in MB
object.size(hhp1)/(1e+6)
#memory used in R
pryr::mem_used() 
#memory available
memory.size()

#understanding data
head(hhp1)
dim(hhp1)
nrow(hhp1)

match1<-grep("^1/2/2007$|^2/2/2007$", hhp1$Date)
hhp2<-hhp1[match1,]  
dim(hhp2)
grep("\\?", hhp2[,3])
hhp3<-hhp2
funt<-function(x,i) gsub("^\\?$","", x[i], fixed=TRUE)
for (i in 3 : ncol(hhp3)) funt(hhp3,i)
dim(hhp3)
head(hhp3)
for (i in 1 : ncol(hhp1)) print(class(hhp3[,i]))
for (i in 3 : ncol(hhp1)) class(hhp3[,i])="numeric"
#hhp3[,1] <- as.Date(hhp3[,1],format='%d/%m/%Y')
za<-strptime(paste(hhp3[1,1],hhp3[1,2]),"%d/%m/%Y %H:%M:%S", tz = "GMT")
hhp3[,10]<-NA
hhp3[,10] <- as.POSIXct (hhp3[,10])
hhp3[,10]<-as.POSIXct(paste(hhp3[,1],hhp3[,2]),"%d/%m/%Y %H:%M:%S", tz = "GMT")
#wday(hhp3[1,10],label = TRUE)
dev.set(2)
dev.set(2)
dev.copy(png, file = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
#Plot 1
plot(hhp3[,10],hhp3[,3] ,type = "l",xlab = "",ylab = "Gloabl Active Power (kilowatts)" )
#plot 2
plot(hhp3[,10],hhp3[,5] ,type = "l",xlab = "",ylab = "Gloabl Active Power (kilowatts)" )
#plot 3
plot(hhp3[,10],hhp3[,7] ,type = "l",xlab = "",ylab = "Energy sub metering" )
lines(hhp3[,10],hhp3[,8] ,type = "l",col="red")
lines(hhp3[,10],hhp3[,9] ,type = "l",col="blue")
legend("topright",legend = names(hhp3[,][7:9]),lty=1,lwd=2,col=c("black","red","blue"),cex = 0.75)
#plot 4
plot(hhp3[,10],hhp3[,4] ,type = "l",xlab = "",ylab = names(hhp3)[4] )

dev.off()