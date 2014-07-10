library(data.table)

read.data <- function() {
    data <- fread("household_power_consumption.txt", colClasses="character")
    data <- as.data.frame(data)
    data <- cbind(data.frame(DateTime=strptime(do.call("paste", data[, c(1,2)]), 
                                               format="%d/%m/%Y %H:%M:%S", 
                                               tz="UTC")),
                  lapply(data[ c(-1,-2)], as.numeric))
    data[data$DateTime >= as.POSIXlt("2007-02-01", tz="UTC") &
             data$DateTime < as.POSIXlt("2007-02-03", tz="UTC"), ]
}

data <- read.data()


png(filename="plot3.png", width=480, height=480)
plot(data$DateTime, data$Sub_metering_1, type="n",
     main="",
     xlab="",
     ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", legend=names(data[6:8]), col=c("black","red","blue"), lty=1)
dev.off()
