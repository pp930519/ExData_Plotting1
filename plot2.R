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

## plot 2
dat_plot2 <- cbind(paste(as.character(dat_need$Date), as.character(dat_need$Time)), as.character(dat_need$Global_active_power))
names(dat_plot2) <- c("Date-Time", "Global Active Power (kilowatts)")
dat_plot2_new <- data.frame(DateTime = strptime(as.character(dat_plot2[,1]),format = "%d/%m/%Y %H:%M:%S"), Global_Active_Power = as.numeric(dat_plot2[,2]))
png(filename = "plot2.png", width = 480, height = 480)
plot(dat_plot2_new[,1][1:14399], dat_plot2_new[,2][1:14399], type = "l", ylab = "Global Active Power (kilowatts)", xlab = NA)
dev.off()


