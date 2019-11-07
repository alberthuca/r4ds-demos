library(forecast)

set.seed(1966, sample.kind = "Rounding")

ar1 <- arima.sim(list(order = c(1, 0, 0),
                      ar = 0.5),
                 n = 200)

View(ar1)

forecast::autoplot(ar1, main = "AR1")

# Let's examine ACF
forecast::autoplot(acf(ar1, plot = F),
                   main = "ACF of simulated AR1")

# Let's check PACF
forecast::autoplot(pacf(ar1, plot = F),
                   main = "PACF of simulated AR1")

# Simulate  a MR(1) model
set.seed(123, sample.kind = "Rounding")

ma1 <- arima.sim(list(order = c(0, 0, 1), ma = -0.5), n = 200)
forecast::autoplot(ma1, main = "MA1")

# Let's check ACF for this MR1 model
forecast::autoplot(acf(ma1, plot = F),
                   main = "ACF of simulated MA1")

# Let's check the PACF plot
forecast::autoplot(pacf(ma1, plot = F),
                   main = "PACF of simulated MA1")
