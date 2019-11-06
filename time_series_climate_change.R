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

View(climate_ts)

# Let's plot the time series
plot(climate_ts, main = "CO2 and Temperatures Deviation")


# check the correlations
cor(climate_ts)

temp_ts <- ts(climate$Temp, start = 1919, frequency = 1)
train <- window(temp_ts, end = 2007)
test <- window(temp_ts, start = 2008)
fit_ets <- forecast::ets(train)
fit_ets

forecast::autoplot(fit_ets)

plot(forecast::forecast(fit_ets, h = 6))
lines(test, type = "o")


fit_ets %>% forecast::forecast(h = 6) %>%
  forecast::accuracy(temp_ts)
