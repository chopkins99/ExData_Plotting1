#### Exploratory Data Analysis Project #1: Plot #1 ####

## Load the Electric Power Consumption data for the household 
##   from 2007-02-01 and 2007-02-02

# Load column headings
columnHeadings <- read.table ("./household_power_consumption.txt",
                           sep = ";", header = FALSE, as.is=TRUE,
                           nrows = 1)

# Load just the data for 1-2 Feb 2007; assign column headings
PowerConsumption <- read.table ("./household_power_consumption.txt",
                                header = FALSE,
                                col.names = columnHeadings[1,],
                                sep = ";", 
                                na.strings = "?",
                                skip = 66637,
                                nrows = 2880)

## Write out PNG file of Histogram
png(file = "plot1.png") ## Open PNG device; create 'plot1.png' file

## Create plot and send to a file (no plot appears on screen)
## Plot Histogram of the household's global minute-averaged active power (in kW)
with (PowerConsumption, hist (Global_active_power, col = "orangered",
                              main = "Global Active Power",
                              xlab = "Global Active Power (kilowatts)",
                              ylab = "Frequency"))

dev.off() #close the PNG file device
