data <- read.csv("E:/Projects/Learning/Principal Component Analysis/pca_gsp.csv")
                 
head(data)

attach(data)
names(data)

dataPCA <- cbind(Ag,Mining,Constr,Manuf,Transp,Comm,Energy,TradeW,TradeR,Services,RE,Govt)

cor(dataPCA)

pca <- princomp(dataPCA, cor = TRUE, scores = TRUE)

summary(pca)

biplot(pca)
plot(pca)
plot(pca, type="l")

attributes(pca)

