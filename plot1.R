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

## making plots
## plot 1
png(filename = "plot1.png", width = 480, height = 480)
hist(as.numeric(as.character(dat_need$Global_active_power)), xlab = "Global Active Power (kilowatts)", main = "Gloabl Active Power", col = "red")
dev.off()