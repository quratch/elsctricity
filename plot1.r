setwd("D:/R/Coursera/Assignment")
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
tail(hhp3)
for (i in 1 : ncol(hhp1)) print(class(hhp3[,i]))
for (i in 3 : ncol(hhp1)) class(hhp3[,i])="numeric"
class(hhp3[2,3])
names(hhp3)
dev.set(1)
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.cur()
with(hhp3, hist(hhp3[,3],freq = TRUE, col = "red",xlab = "Global Active Power (kilowatts)", main = "Global Active Power" ))

dev.off()
getwd()