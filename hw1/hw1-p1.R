csv_path <- file.path(getwd(), "KwhConsumptionBlower.csv")
data <- read.csv(csv_path)
ts_data <- data$Consumption

plot(ts_data, type = "l", xlab = "Reading Index", ylab = "Consumption", main = "Energy Consumption")
grid()

acf(ts_data, main = "ACF Plot")
grid()
