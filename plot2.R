#### Exploratory Data Analysis Project #1: Plot #2 ####
library (stringr)
library (lubridate)

## Load the Electric Power Consumption data for the household 
##   from 2007-02-01 and 2007-02-02

# Load column headings
columnHeadings <- read.table ("./household_power_consumption.txt",
                              sep = ";", header = FALSE, as.is=TRUE,
                              nrows = 1)

# Load just the data for 1-2 Feb 2007; assign column headings
PowerConsumption <- read.table ("./household_power_consumption.txt",
                                header = FALSE, as.is=TRUE,
                                col.names = columnHeadings[1,],
                                sep = ";", 
                                na.strings = "?",
                                skip = 66637,
                                nrows = 2880)

# Convert Date and Time variables to Date/Time classes
tempDates <- str_c(PowerConsumption[,1], PowerConsumption[,2], sep=" ", collapse = NULL)
datetime <- dmy_hms(tempDates)
PowerConsumption <- cbind(PowerConsumption, datetime) #add to data frame

## Write out PNG file of Plot
png(file = "plot2.png") ## Open PNG device; create 'plot2.png' file

## Create plot and send to a file (no plot appears on screen)
## Plot of Global Active Power across the 2-day period

# Establish the plot's "canvas"
with (PowerConsumption, plot(datetime, Global_active_power, 
                             ylab = "Global Active Power (kilowatts)",
                             xlab = "",
                             type="n"))

## Draw line to show Global Active Power across the 2-day period
lines(datetime, PowerConsumption$Global_active_power)

dev.off() #close the PNG file device
