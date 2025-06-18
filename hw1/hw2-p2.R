flips <- rbinom(1000, 1, 0.5)
e_t <- ifelse(flips == 0, -1, 1)
Y_t <- cumsum(e_t)
time <- 1:length(Y_t)

plot(time, Y_t, type = "l", xlab = "Time (t)", main = "Random Walk Plot")
grid()
