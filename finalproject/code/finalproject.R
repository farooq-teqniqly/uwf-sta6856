data <- read.csv("fhvhv_tripdata_2024_uber_timeseries.csv")
ts_data <- ts(data$avg_duration_min, frequency = 366, start = c(2024, 1))


library(ggplot2)

plot(ts_data,
     main = "Daily Average Uber Trip Duration (2024)",
     xlab = "Day of Year",
     ylab = "Average Duration (min)",
     col = "blue")


data$pickup_date <- as.Date(data$pickup_date)

library(lubridate)
library(dplyr)

data <- data %>%
  mutate(weekday = weekdays(pickup_date))

fridays <- filter(data, weekday == "Friday")
saturdays <- filter(data, weekday == "Saturday")
sundays <- filter(data, weekday == "Sunday")

holidays <- data.frame(
  date = as.Date(c(
    "2024-01-01",  # New Year's Day
    "2024-01-15",  # Martin Luther King Jr. Day
    "2024-02-19",  # Presidents' Day
    "2024-05-27",  # Memorial Day
    "2024-07-04",  # Independence Day
    "2024-09-02",  # Labor Day
    "2024-10-14",  # Columbus Day
    "2024-11-11",  # Veterans Day
    "2024-11-28",  # Thanksgiving
    "2024-12-25"   # Christmas
  )),
  label = c(
    "New Year's Day", "MLK Jr. Day", "Presidents' Day", "Memorial Day", "Independence Day",
    "Labor Day", "Columbus Day", "Veterans Day", "Thanksgiving", "Christmas"
  )
)

holidays$avg_duration_min <- data$avg_duration_min[match(holidays$date, data$pickup_date)]

ggplot(data, aes(x = pickup_date, y = avg_duration_min)) +
  geom_line(color = "gray", alpha = 0.5) +
  geom_line(data = fridays, aes(color = "Friday")) +
  geom_line(data = saturdays, aes(color = "Saturday")) +
  geom_line(data = sundays, aes(color = "Sunday")) +
  geom_point(data = holidays, aes(x = date, y = avg_duration_min), color = "black", fill = "yellow", size = 2, shape = 21) +
  geom_text(data = holidays, aes(x = date, y = avg_duration_min, label = label), vjust = -1, size = 3, angle = 45) +
  geom_smooth(aes(x = pickup_date, y = avg_duration_min), method = "loess", se = FALSE, color = "black", linetype = "dashed") +
  labs(
    title = "Daily Average Trip Duration (2024)",
    x = "Date", y = "Average Duration (minutes)",
    color = "Day"
  ) +
  theme_minimal() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )
