#### Exploratory Data Analysis Project #1: Plot #4 ####
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

## Write out PNG file of Plots
png(file = "plot4.png") ## Open PNG device; create 'plot4.png' file

## Create plots and send to a file (no plots appears on screen)
par (mfcol = c(2,2))

### Panel 1: Global Active Power (same as Plot #2) ###
with (PowerConsumption, plot(datetime, Global_active_power, 
                             ylab = "Global Active Power (kilowatts)",
                             xlab = "",
                             type="n"))

# Draw line to show Global Active Power across the 2-day period
lines(datetime, PowerConsumption$Global_active_power)

### Panel 2: Energy Sub Metering (same as Plot #3) ###
with (PowerConsumption, plot(datetime, Sub_metering_1, 
                             ylab = "Energy Sub Metering",
                             xlab = "",
                             type="n"))

# Add lines for each level of sub_metering
lines(datetime, PowerConsumption$Sub_metering_1)
lines(datetime, PowerConsumption$Sub_metering_2, col="red")
lines(datetime, PowerConsumption$Sub_metering_3, col="blue")

# Add legend
legend("topright", lty = "91", col = c("black", "red", "blue"), bty = "n",
       legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"))

### Panel 3: Voltage ###
with (PowerConsumption, plot(datetime, Voltage, type="n"))

# Draw line to show Voltage across the 2-day period
lines(datetime, PowerConsumption$Voltage)

### Panel 4: Global Reactive Power ###
with (PowerConsumption, plot(datetime, Global_reactive_power, type="n"))

# Draw line to show Global Active Power across the 2-day period
lines(datetime, PowerConsumption$Global_reactive_power)


dev.off() #close the PNG file device

