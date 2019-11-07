library(magrittr)
library(tidyverse)
library(ggthemes)
library(timeSeries)
library(forecast)

climate <- readr::read_csv("./data/climate.csv")

str(climate)

head(climate)

# We'll put this in a time series structure, specifying the start and end years
climate_ts <- ts(climate[, 2:3],
                 start = 1919,
                 end = 2013
                 )

head(climate_ts)

# Let's plot the time series
plot(climate_ts, main = "CO2 and Temperatures Deviation")


# check the correlations
cor(climate_ts)

# Let's check the ACF to understand the structure of Temperature time series
forecast::autoplot(acf(climate_ts[, 2], plot = F),
                   main = "Temperature ACF")

# Let's check the PACF to understand the structure of Temperaure time series
forecast::autoplot(pacf(climate_ts[, 2], plot = F),
                   main = "Temperature PACF")


# Let's check the ACF to understand the structure of CO2 time series
forecast::autoplot(acf(climate_ts[, 1], plot = F),
                   main = "CO2 ACF")

# Let's check the PACF to understand the structure of CO2 time series
forecast::autoplot(pacf(climate_ts[, 1], plot = F),
                   main = "CO2 PACF")

# Let's look at the Cross-Correlation Function.
#   Note we put our x before our y in the function
forecast::autoplot(ccf(climate_ts[, 1], climate_ts[, 2], plot = F),
                   main = "CCF")

# We need to test whether the data is stationary.
# We can prove this with the Augmented Dickey-Fuller (ADF) test available in the tseries package,
#   using adf.test() function

# Test CO2 time series
tseries::adf.test(climate_ts[, 1])

# Test temperatur time series
tseries::adf.test(climate_ts[, 2])

# For both series, we have insignificant p-values, so we cannot reject the null 
#   and conclude that they aren't stationary.


# Modeling and evaluation

# First step is ot produce a univariate forecast model applied to just the surface temperature.

# Univariate time series forecasting
temp_ts <- ts(climate$Temp, start = 1919, frequency = 1)
train <- window(temp_ts, end = 2007)
test <- window(temp_ts, start = 2008)

# To build our exponential smoothing model, we'll use the ets() function to find 
#   the best model with the lowest AIC.
fit.ets <- forecast::ets(train)
fit.ets

forecast::autoplot(fit.ets)



# We plot forecast and see how well it performed visually on the test data
plot(forecast::forecast(fit.ets, h = 6))

lines(test, type = "o")

# Check the accuracy
fit.ets %>% forecast::forecast(h = 6) %>%
  forecast::accuracy(temp_ts)
