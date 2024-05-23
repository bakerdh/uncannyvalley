
if (file.exists('local/GroupDataRobots.RData')){load('local/GroupDataRobots.RData')}  
targetelectrodes <- c(28,54,58,64)

pdf(paste0('Figures/allERProbot.pdf'), bg="transparent", height = 12, width = 12)

par(mfrow=c(5,5))

for (s in 1:24){
plotlims <- c(-200,1000,-12,12)  
ticklocsx <- seq(-200,1000,200)    # locations of tick marks on x axis
ticklocsy <- seq(-12,12,4)    # locations of tick marks on y axis
ticklabelsx <- ticklocsx        # set labels for x ticks
ticklabelsy <- ticklocsy    # set labels for y ticks

plot(x=NULL,y=NULL,axes=FALSE, ann=FALSE, xlim=plotlims[1:2], ylim=plotlims[3:4])  
axis(1, at=ticklocsx, tck=0.01, lab=F, lwd=2)     # plot tick marks (no labels)
axis(2, at=ticklocsy, tck=0.01, lab=F, lwd=2)
mtext(text = ticklabelsx, side = 1, at=ticklocsx, line=0.2, cex=1)    
mtext(text = ticklabelsy, side = 2, at=ticklocsy, line=0.2, las=1, cex=1)  
title(xlab="Time (ms)", col.lab=rgb(0,0,0), line=1.5, cex.lab=1)   
title(ylab="Amplitude (µV)", col.lab=rgb(0,0,0), line=2.2, cex.lab=1)

lines(c(-200,1000),c(0,0),lty=1)
lines(c(0,0),c(-20,20),lty=1)

lines(-200:1000, colMeans(subjmeanERP[s,targetelectrodes,]), lwd=3)     

}

plotlims <- c(-200,1000,-12,12)  
ticklocsx <- seq(-200,1000,200)    # locations of tick marks on x axis
ticklocsy <- seq(-12,12,4)    # locations of tick marks on y axis
ticklabelsx <- ticklocsx        # set labels for x ticks
ticklabelsy <- ticklocsy    # set labels for y ticks

plot(x=NULL,y=NULL,axes=FALSE, ann=FALSE, xlim=plotlims[1:2], ylim=plotlims[3:4])  
axis(1, at=ticklocsx, tck=0.01, lab=F, lwd=2)     # plot tick marks (no labels)
axis(2, at=ticklocsy, tck=0.01, lab=F, lwd=2)
mtext(text = ticklabelsx, side = 1, at=ticklocsx, line=0.2, cex=1)    
mtext(text = ticklabelsy, side = 2, at=ticklocsy, line=0.2, las=1, cex=1)  
title(xlab="Time (ms)", col.lab=rgb(0,0,0), line=1.5, cex.lab=1)   
title(ylab="Amplitude (µV)", col.lab=rgb(0,0,0), line=2.2, cex.lab=1)

lines(c(-200,1000),c(0,0),lty=1)
lines(c(0,0),c(-20,20),lty=1)

includeds <- 1:24
lines(-200:1000, apply(subjmeanERP[includeds,targetelectrodes,],3,mean), lwd=3)     


# includeds <- c(2,4,5,9,13)
lines(-200:1000, apply(subjmeanERP[includeds,targetelectrodes,],3,mean), lwd=3, col='red')     

dev.off()



pdf(paste0('Figures/allMVPArobot.pdf'), bg="transparent", height = 12, width = 12)

par(mfrow=c(5,5))

plotlims <- c(-200,1000,0,100)  
ticklocsx <- seq(-200,1000,200)    # locations of tick marks on x axis
ticklocsy <- seq(0,100,25)    # locations of tick marks on y axis
ticklabelsx <- ticklocsx        # set labels for x ticks
ticklabelsy <- ticklocsy    # set labels for y ticks

for (s in 1:24){

  plot(x=NULL,y=NULL,axes=FALSE, ann=FALSE, xlim=plotlims[1:2], ylim=plotlims[3:4])  
  axis(1, at=ticklocsx, tck=0.01, lab=F, lwd=2)     # plot tick marks (no labels)
  axis(2, at=ticklocsy, tck=0.01, lab=F, lwd=2)
  mtext(text = ticklabelsx, side = 1, at=ticklocsx, line=0.2, cex=1)    
  mtext(text = ticklabelsy, side = 2, at=ticklocsy, line=0.2, las=1, cex=1)  
  title(xlab="Time (ms)", col.lab=rgb(0,0,0), line=1.5, cex.lab=1)   
  title(ylab="Amplitude (µV)", col.lab=rgb(0,0,0), line=2.2, cex.lab=1)
  
  lines(c(-200,1000),c(50,50),lty=1)
  lines(c(0,0),c(0,100),lty=1)
  
  lines(-200:1000, 100*(allmvpa[s,1,]), lwd=3,col='red')     
  lines(-200:1000, 100*(allmvpa[s,2,]), lwd=3,col='green')     
  lines(-200:1000, 100*(allmvpa[s,3,]), lwd=3,col='blue')     
  
}


plot(x=NULL,y=NULL,axes=FALSE, ann=FALSE, xlim=plotlims[1:2], ylim=plotlims[3:4])  
axis(1, at=ticklocsx, tck=0.01, lab=F, lwd=2)     # plot tick marks (no labels)
axis(2, at=ticklocsy, tck=0.01, lab=F, lwd=2)
mtext(text = ticklabelsx, side = 1, at=ticklocsx, line=0.2, cex=1)    
mtext(text = ticklabelsy, side = 2, at=ticklocsy, line=0.2, las=1, cex=1)  
title(xlab="Time (ms)", col.lab=rgb(0,0,0), line=1.5, cex.lab=1)   
title(ylab="Amplitude (µV)", col.lab=rgb(0,0,0), line=2.2, cex.lab=1)

lines(c(-200,1000),c(50,50),lty=1)
lines(c(0,0),c(0,100),lty=1)

includeds <- 1:24  #c(1,3,6,7,8,10,11,12,14:29)
lines(-200:1000, 100*apply(allmvpa[includeds,,],3,mean), lwd=3)     


# includeds <- c(2,4,5,9,13)
lines(-200:1000, 100*apply(allmvpa[includeds,,],3,mean), lwd=3, col='red')     

dev.off()






if (file.exists('local/GroupDataMasks.RData')){load('local/GroupDataMasks.RData')}  
targetelectrodes <- c(28,54,58,64)

pdf(paste0('Figures/allERPmask.pdf'), bg="transparent", height = 12, width = 12)

par(mfrow=c(5,5))

for (s in 1:25){
  plotlims <- c(-200,1000,-12,12)  
  ticklocsx <- seq(-200,1000,200)    # locations of tick marks on x axis
  ticklocsy <- seq(-12,12,4)    # locations of tick marks on y axis
  ticklabelsx <- ticklocsx        # set labels for x ticks
  ticklabelsy <- ticklocsy    # set labels for y ticks
  
  plot(x=NULL,y=NULL,axes=FALSE, ann=FALSE, xlim=plotlims[1:2], ylim=plotlims[3:4])  
  axis(1, at=ticklocsx, tck=0.01, lab=F, lwd=2)     # plot tick marks (no labels)
  axis(2, at=ticklocsy, tck=0.01, lab=F, lwd=2)
  mtext(text = ticklabelsx, side = 1, at=ticklocsx, line=0.2, cex=1)    
  mtext(text = ticklabelsy, side = 2, at=ticklocsy, line=0.2, las=1, cex=1)  
  title(xlab="Time (ms)", col.lab=rgb(0,0,0), line=1.5, cex.lab=1)   
  title(ylab="Amplitude (µV)", col.lab=rgb(0,0,0), line=2.2, cex.lab=1)
  
  lines(c(-200,1000),c(0,0),lty=1)
  lines(c(0,0),c(-20,20),lty=1)
  
  lines(-200:1000, colMeans(subjmeanERP[s,targetelectrodes,]), lwd=3)     
  
}

dev.off()



pdf(paste0('Figures/allMVPAmask.pdf'), bg="transparent", height = 12, width = 12)

par(mfrow=c(5,5))

plotlims <- c(-200,1000,0,100)  
ticklocsx <- seq(-200,1000,200)    # locations of tick marks on x axis
ticklocsy <- seq(0,100,25)    # locations of tick marks on y axis
ticklabelsx <- ticklocsx        # set labels for x ticks
ticklabelsy <- ticklocsy    # set labels for y ticks

for (s in 1:25){
  
  plot(x=NULL,y=NULL,axes=FALSE, ann=FALSE, xlim=plotlims[1:2], ylim=plotlims[3:4])  
  axis(1, at=ticklocsx, tck=0.01, lab=F, lwd=2)     # plot tick marks (no labels)
  axis(2, at=ticklocsy, tck=0.01, lab=F, lwd=2)
  mtext(text = ticklabelsx, side = 1, at=ticklocsx, line=0.2, cex=1)    
  mtext(text = ticklabelsy, side = 2, at=ticklocsy, line=0.2, las=1, cex=1)  
  title(xlab="Time (ms)", col.lab=rgb(0,0,0), line=1.5, cex.lab=1)   
  title(ylab="Amplitude (µV)", col.lab=rgb(0,0,0), line=2.2, cex.lab=1)
  
  lines(c(-200,1000),c(50,50),lty=1)
  lines(c(0,0),c(0,100),lty=1)
  
  lines(-200:1000, 100*(allmvpa[s,1,]), lwd=3,col='red')     
  lines(-200:1000, 100*(allmvpa[s,2,]), lwd=3,col='green')     
  lines(-200:1000, 100*(allmvpa[s,3,]), lwd=3,col='blue')     
  
}


dev.off()



