
#Call price selection
share = 61
day = 126
strike = 63
rate = 0.08
sigma = 0.3

#Creates a matrix of n simulations of stock realizations 
asianOptions=function(s,D,K,r,sd,n) {
    xd=matrix(c(rnorm((D)*n,(r-(sd^2/2))/252,sd/sqrt(252))),n,D) 
    sd=s*exp(t(apply(xd,1,cumsum)))
    avg=apply(sd,1,mean)
    callpv=pmax(avg-K,0)*exp(-r*D/252)
    return(mean(callpv))
}

#Create Euro Call option
euroOption=function(s,K,r,sd,t) {
  w=((r+sd^2/2)*t/252-log(K/s))/(sd*sqrt(t/252))
  c=s*pnorm(w)-K*exp(-r*t/252)*pnorm(w-sd*sqrt(t/252))
  return(c)
}

x=0;for(i in 1:1000) {
  x=x+asianOptions(share,day,strike,rate,sigma,1000)
}
print(x/1000)

euroOption(share,strike,rate,sigma,day)


realization = function(s,D,K,r,sd,n){
    xd=matrix(c(rnorm((D)*n,(r-(sd^2/2))/252,sd/sqrt(252))),n,D) 
    sd=s*exp(t(apply(xd,1,cumsum)))
    return(sd)
}

x = seq(1:126)
y =realization(share,day,strike,rate,sigma,10)
plot(x,y[1,], xlim = c(0,126), ylim=c(20,100), type = 'l')
abline(h=63)

max((mean(y[1,]) - 63),0)*exp(-rate*day/252)

x = seq(1:126)
y =realization(share,day,strike,rate,sigma,10)
plot(x,y[1,], main = "Plot of Simulation of Stock prices over 126 days",
     xlab = "Days",
     ylab = "Share Price $",
     xlim = c(0,126), 
     ylim=c(20,100), 
     type = 'l')
abline(h= strike, col='red' )
for( i in 2:10){
    lines(x,y[i,], col = i)
}
avg=apply(y,1,mean)

mean(pmax((avg - strike),0)*exp(-rate*day/252))
    
