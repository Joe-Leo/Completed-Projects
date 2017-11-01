library(astsa)
data<-read.csv("C:\\Users\\Sam\\Documents\\stat 457\\project\\AAPL-NASDAQ-10Y.csv", header=TRUE, stringsAsFactors = FALSE)
attach(data)
close.p=rev(close)
open.p=rev(open)
Raw.Data=(open.p+close.p)/2
Price=ts(Raw.Data, start=c(2006, 200), frequency=(252))
log.Price=log(Price)
log.diff=diff(log.Price)
diff.Price=diff(Price)

sarima(log.Price, 12,1,2)
sarima.for(Price, 30,12,1,2)