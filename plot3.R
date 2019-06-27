#### Exploratory Data Analysis Project #1: Plot #3 ####
library(stringr)
library(lubridate)

## Load the Electric Power Consumption data for the household 
##   from 2007-02-01 and 2007-02-02

# Load column headings
columnHeadings <- read.table ("./household_power_consumption.txt",
                              sep = ";", header = FALSE, as.is=TRUE,
                              nrows = 1)

# Load just the data for 1-2 Feb 2007; assign column headings
PowerConsumption <- read.table ("./household_power_consumption.txt",
                                header = FALSE, as.is = TRUE,
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
png(file = "plot3.png") ## Open PNG device; create 'plot3.png' file

## Create plot and send to a file (no plot appears on screen)
## Plot the sub-metering for the kitchen (black), the laundry room (red),
#    and the electric water-heater & an air-conditioner (blue)

# Establish the plot's "canvas"
with (PowerConsumption, plot(datetime, Sub_metering_1, 
                             ylab = "Energy Sub Metering",
                             xlab = "",
                             type="n"))

## Annotate the plot
# Add lines for each level of sub_metering
lines(datetime, PowerConsumption$Sub_metering_1)
lines(datetime, PowerConsumption$Sub_metering_2, col="red")
lines(datetime, PowerConsumption$Sub_metering_3, col="blue")

# Add legend
legend("topright", lty = "91", col = c("black", "red", "blue"), 
       legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"))

dev.off() #close the PNG file device

