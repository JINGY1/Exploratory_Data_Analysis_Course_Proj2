# load data 
unzip(zipfile="exdata_data_NEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# understanding data
dim(NEI)
head(NEI)
str(NEI)
dim(SCC)
head(SCC)
str(SCC)

# Q4
CoalSource <- SCC[grep("[Cc][Oo][Aa][Ll]", SCC$EI.Sector), "SCC"]
sub2 <- subset(NEI,SCC%in%CoalSource)
CoalEmission <- aggregate(Emissions~year,sub2,sum)
png("plot4.png", width=500, height=480)
ggplot(CoalEmission,aes(x=factor(year),y=Emissions))+
geom_bar(stat="identity")+ggtitle("Total Emissions PM2.5 in the United States of Coal Combustion Source")+
xlab("year")+ylab("Total Emissions of PM2.5 (tons)")
dev.off()
