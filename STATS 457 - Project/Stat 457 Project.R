title: "Untitled"
author: "Joseph Leong, Sam Whittaker, Ryan Isherwood"
date: "November 10, 2016"
output: html_document
---
  
  This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:
  
  Data Import 
```{r}
#load Data set
AAPL = read.csv("AAPL-NASDAQ-10Y.csv", header = T)
#check first/ last values, and data type
head(AAPL)
tail(AAPL)
sapply(AAPL, typeof)
#converte dates into Date objects, corrects for todays date as well
AAPL$date=as.Date(format(AAPL$date),format = "%Y/%m/%d")
AAPL$date[1] = as.Date('2016/11/10')

#reorder data from oldest to newest
AAPL$date = rev(AAPL$date)
AAPL$close = rev(AAPL$close)
AAPL$volume = rev(AAPL$volume)
AAPL$open = rev(AAPL$open)
AAPL$high = rev(AAPL$high)
AAPL$low = rev(AAPL$low)

head(AAPL)
tail(AAPL)
#create time series object (Yearly) 
table(format(AAPL$date,'%Y')) # how many obs in each year
AAPL.mean=(AAPL$close+AAPL$open)/2
AAPL.ts =  ts(AAPL.mean, start=c(2006,200), frequency = 252) # need to correct the frequency and start date
ts.plot(AAPL.ts)
plot(AAPL$date, AAPL$close, xlab = "Year", ylab = "AAPL Closing price", main = "Performance of AAPL over a 10 year cycle", type="l")
time(AAPL.ts)
head(time(AAPL.ts))
#check if dataset matches up
head(AAPL.ts)
head(AAPL.mean)
tail(AAPL.ts)
tail(AAPL.mean)
```

Time Series Part
```{r}
par(mfrow=c(0,1))
library(forecast)
library(astsa)
ndiffs(AAPL.ts)
summary(AAPL.ts)
acf(AAPL.ts,lag.max = 50)
pacf(AAPL.ts, lag.max = 50)
AAPL[35,1]

#try Log diff model
AAPL.ts.log = log(AAPL.ts )
plot(diff(AAPL.ts.log))
plot.ts(AAPL.ts.log)
diff(AAPL.ts.log)
acf(diff(AAPL.ts.log), max.lag = 50)
pacf(diff(AAPL.ts.log), max.lag=50)
sarima(AAPL.ts.log, 0,1,2)
sarima(AAPL.ts.log, 10,1,0)

##Testing using a GARCH model (Handles Volatility)

install.packages(c("timeSeries","tseries","fBasics", "MASS", "fGarch", "astsa"))
library(tseries)
library(timeSeries)
library(fBasics)
library(MASS)
library(fGarch)
library(astsa)

summary((AAPL.g <- garchFit(~arma(0,1)+garch(1,1), diff(AAPL.ts.log)))) #Could use either this one
summary((AAPL.g.2 <- garchFit(~arma(2,0)+garch(1,1),diff(AAPL.ts.log)))) #or this one,  both got rid of the autocorrelation in residuals.  Neither are normally distributed
plot(diff(AAPL.ts.log), ylab="AAPL Daily Averages")
AAPL.g@formula
AAPL.g.2@formula

resid=AAPL.g@residuals
plot(resid, type = "l")
qqnorm(resid)
qqline(resid)
acf(resid)
pacf(resid)

##Should we standardize the residuals?

#Forecasts: (I'm not actually sure how to properly forecast using GARCH)
par(mfrow=c(1,1))
fore = predict(AAPL.g.2 ,n.ahead=15,interval="prediction")
fore
ts.plot(AAPL.ts, fore$meanForecast, col=1:2, ylab= "Mortality")
plot(fore$meanForecast)

