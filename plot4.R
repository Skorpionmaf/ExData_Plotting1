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
png('plot4.png', width = 480, height = 480)
par(mfrow = c(2,2))
with(df, {
  plot(x = DateTime, y = Global_active_power, type='l', xlab = '', ylab = 'Global Active Power (kilowatts)')
  plot(x = DateTime, y = Voltage, type = 'l', ylab = 'Voltage')
  plot(x = DateTime, y = Sub_metering_1, type = 'l', ylab = 'Energy sub metering', xlab ='')
  lines(x = DateTime, y = Sub_metering_2, ylab='', xlab='', col = 'red')
  lines(x = DateTime, y = Sub_metering_3, ylab='', xlab='', col = 'blue')
  legend("topright", bty = 'n', lty = 1, col=c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')) 
  plot(x = DateTime, y = Global_reactive_power, type = 'l', ylab = 'Global reactive power') 
  })

dev.off()