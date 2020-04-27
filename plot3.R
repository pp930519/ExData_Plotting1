install.packages("dplyr")
install.packages("ggplot")
library(dplyr)
library(ggplot2)

## load the file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "exdata_data_household_power_consumption.zip")
unzip("exdata_data_household_power_consumption.zip", exdir = "household power consumption Dataset")
files <- list.files("household power consumption Dataset", full.names = TRUE)
dat <- read.table("./household power consumption Dataset/household_power_consumption.txt",header = TRUE)

## reconstruct the dataset
## reformat the header
header = unlist(strsplit(names(dat), "[.]"))
dat_new <- matrix(ncol=9, nrow=0)
colnames(dat_new) <- header
for (i in 1:nrow(dat)) {
  dat_new<- rbind(dat_new, unlist(strsplit(as.character(dat[i,1]), ";")))
}
dat_need  <- filter(data.frame(dat_new), Date == "1/2/2007" | Date == "2/2/2007")

## plot 3
dat_plot3 <- cbind(dat_plot2_new, as.numeric(as.character(dat_need$Sub_metering_1)), as.numeric(as.character(dat_need$Sub_metering_2)), as.numeric(as.character(dat_need$Sub_metering_3)))
png(filename = "plot3.png", width = 480, height = 480)
plot(dat_plot3[,1], dat_plot3[,3],  type = "l", ylab = "Engergy sub metering", xlab = NA)
lines(dat_plot3[,1], dat_plot3[,4],  type = "l", col = "red")
lines(dat_plot3[,1], dat_plot3[,5],  type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, cex = 0.6)
dev.off()





