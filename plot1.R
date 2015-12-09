# set US localTime in order to have days name in english
Sys.setlocale("LC_TIME", "en_US")

# read the dataframe
df = read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

# convert Date and Time in all-in-one DateTime column os Posisxlt type
df$DateTime = strptime(paste(df$Date, df$Time), format = "%d/%m/%Y %H:%M:%S")
df = df[, !(names(df) %in% c("Date", "Time") )]

# subset the dataframe on the DateTime range of interest
df = subset(df, df$DateTime >= '2007-02-01 00:00:00' & df$DateTime < '2007-02-03 00:00:00')

# convert all the columns except DateTime to numeric
cond = sapply(names(df), function(x){ x!= "DateTime"})
for (name in names(df)[cond]){
  df[, name] = as.numeric(df[, name])
}

# making the plot
hist(df$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")

# copy the plot to png device
dev.copy(png, 'plot1.png', width=480, height=480)
dev.off()