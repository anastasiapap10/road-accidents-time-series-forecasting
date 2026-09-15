# road-accidents-time-series-forecasting
Time series analysis and forecasting of monthly road traffic accidents using R.
## Overview

This project analyzes monthly road traffic accidents from 2010 to 2026 using statistical time series methods.

## Methods

- Data cleaning and preparation
- Classical time series decomposition
- Seasonal and first differencing
- ACF and PACF analysis
- ARMA model estimation
- Model comparison using AICc
- Residual analysis
- Forecasting

## Technologies

- R
- readxl
- itsmr

## Results

Several ARMA models were evaluated using AICc. The ARMA(1,2) model was selected as the optimal model and used to forecast the next 10 values of the time series.
