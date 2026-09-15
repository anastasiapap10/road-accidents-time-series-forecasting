######LINEAR TIME SERIES FORECASTING#######
######DATASET: MONTHLY ROAD TRAFFIC ACCIDENTS 2010-2026#####

#Useful libraries
library(readxl)
library(itsmr)
#1.Import the dataset
road_accidents <- read_excel("A2102_SDT03_TS_MM_01_2010_04_2026_01_P_EN.xlsx",
                             col_names = F)
road_accidents <- road_accidents[-c(1,2,3),]
colnames(road_accidents) <- c(
  "Month",
  "RoadTrafficAccidents",
  "Killed",
  "SeriouslyInjured",
  "SlightlyInjured"
)
#Transform road accidents into numeric values
road_accidents$RoadTrafficAccidents <- as.numeric(road_accidents$RoadTrafficAccidents)

#Elimination of the NA values in the year 2026
road_accidents<- na.omit(road_accidents)

#Convert data into time series
road_accidents_ts <- ts(road_accidents$RoadTrafficAccidents,
                        start = c(2010,1),
                        frequency = 12)
road_accidents_ts

#2.Transform the time series

# a)Classical decomposition
M <- c("season",12,"trend",1)
e <- Resid(road_accidents_ts, M)

# b)Differencing
diff <- diff(road_accidents_ts, lag = 12)
diff_1 <- diff(diff)

#3. Plot 
#Original time series
plot(road_accidents_ts,
     main = "Original time series",
     xlab = "year",
     ylab = "Road traffic Accidents")

#a)classical decomposition
plot(e, main = "Transformed time series - Classical Decomposition",
     xlab = "Year",
     ylab = "Residuals")

#b)Differencing
plot(diff_1, main = "Transformed time series - Differencing",
     xlab = "year",
     ylab = "Differenced values")

#4. ACF and PACF
#a) Classical decomposition
acf(e, main = "ACF of classical decomposition")
pacf(e, main = "PACF of classical decomposition")

#b) Differencing
acf(diff_1, main = "ACF - Differenced time series")
pacf(diff_1, main = "PACF - Differenced time series")

#5. ARMA and ARIMA MODELS
#Try Yule-Walker algorithm
yw_e1 <-yw(e,1)
yw_e2<-yw(e,2)
yw_e3 <-yw(e,3)

#Burg algorithm
burg_e1 <-burg(e,1)
burg_e2 <-burg(e,2)
burg_e3 <-burg(e,3)

#ARMA Models
arma_e11 <-arma(e,1,1)
arma_e21 <-arma(e,2,1)
arma_e22 <-arma(e,2,2)

#Autofit
autofit_e <-autofit(e,p = 0:5,q = 0:5)
autofit_e
#6. optimal model
#we will check the aicc of each model 
arma_e11$aicc
arma_e21$aicc
arma_e22$aicc
autofit_e$aicc
#best aicc: ARMA(1,2)

#7. Stationary
arma12 <- arma(e,1,2)
ee <- Resid(road_accidents_ts, M, arma12)
test(ee)

#8. Forecast the future 10 values 
forecast(road_accidents_ts, M, arma12, 10)


