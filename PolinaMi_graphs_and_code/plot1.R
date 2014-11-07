# Script that:
# loads energy consumption data from 2007-02-01 to 2007-02-02,
# creates plot1 of energy parameters
# and saves it as plot1.png file

# constants: 
d1 <- as.Date("2007-02-01"); # start date 
d2 <- as.Date("2007-02-02") # end date
fp <- "household_power_consumption.txt" # data file path (local)

# read file in current directory
df <- read.table(fp, nrows = 2, sep = ";", header = TRUE) # read header and first string
# acquire data classes for each column
classes <- sapply(df, class) # acquire data classes
# read the whole table
t1 <- Sys.time() # beginning of loading
# set separator value to ";"
# indicate that first line is header
# indicate that "?" is treated as NA values
df <- read.table(fp, 
                 sep = ";", header = TRUE, na.strings = "?", colClasses = classes) 
t2 <- Sys.time() # end of loading
print (t2 - t1) # table loading time (just for curiousity)
# convert Date and Time
t <- paste (df$Date, df$Time) # merge time and date
df$Time <- strptime (t, format = "%d/%m/%Y %H:%M:%S") # convert column to time type
df$Date <- as.Date(df$Date, format = "%d/%m/%Y") # convert column to Date type

# subset data frame for required dates
df <- df [d1 <= df$Date & df$Date <= d2, ] 

# plot graph1 using base plot system and save as *.png file
png("graph1.png", width = 480, heigth = 480) # open graphic device
hist(df$Global_active_power,
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)",  
     col = "red")
dev.off() # close graphic device
