#Jovan Allen 
#V00835819
#Math 477 Asian Option


#Creates a matrix of n simulations of stock realizations 
asianOptions=function(s,D,K,r,sd,n) {
  xd=matrix(c(rnorm((D)*n,(r-(sd^2/2))/252,sd/sqrt(252))),n,D) 
  sd=s*exp(t(apply(xd,1,cumsum)))
  avg=apply(sd,1,mean)
  callpv=pmax(avg-K,0)*exp(-r*D/252)
  
  return(c(mean(callpv),var(callpv)))
}
system.time(asianOptions(61,126,63,0.08,0.3,1000000))

system.time(for( i in 1:1000) {
  asianOptions(61,126,63,0.08,0.3,1000)
  
})


#Black Scholes for European call. Asian should be less than Euro
euroOption=function(s,K,r,sd,t) {
  w=((r+sd^2/2)*t-log(K/s))/(sd*sqrt(t))
  c=s*pnorm(w)-K*exp(-r*t)*pnorm(w-sd*sqrt(t))
  return(c)
}
euroOption(61,63,0.08,0.3,0.5)

plot()



#Some plots
asianOptions1=function(s,D,K,r,sd,n) {
  xd=matrix(c(rnorm((D)*n,(r-(sd^2/2))/252,sd/sqrt(252))),n,D) 
  sd=s*exp(t(apply(xd,1,cumsum)))
  avg=apply(sd,1,mean)
  callpv=pmax(avg-K,0)*exp(-r*D/252)
  
  return(mean(callpv))
}

plotData=function(points) {
  D=matrix(nrow=5,ncol=points)

  for(i in 1:points) {
    D[1,i]=asianOptions1(50+i,126,63,0.08,0.3,10000)
    D[2,i]=asianOptions1(61,126,63+i,0.08,0.3,10000)
    D[3,i]=asianOptions1(61,126,63,0.01*i,0.3,10000)
    D[4,i]=asianOptions1(61,126,63,0.08,0.01*i,10000)
    D[5,i]=asianOptions1(61,10*i,63,0.08,0.3,10000)
  }
  par(mfrow=c(2, 2))
  plot(51:(51+points-1),D[1,],xlab="Underlying Security Price (s)",ylab="Asian Option Value")
  plot(63:(63+points-1),D[2,],xlab="Strike Price (K)",ylab="Asian Option Value")
  plot(seq(0.01,0.01*points,0.01),D[3,],xlab="Interest Rate (r)",ylab="Asian Option Value")
  plot(seq(0.01,0.01*points,0.01),D[4,],xlab=expression(paste("Volatility Parameter (",sigma,")")),ylab="Asian Option Value")
  plot(seq(10,10*points,10),D[5,],xlab="Exercise Time (Days)",ylab="Asian Option Value")
}
plotData(30)


