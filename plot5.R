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

# Q5
MotorSource <- SCC[grep("[Vv]ehicle", SCC$EI.Sector), "SCC"]
sub3 <- subset(NEI,fips=="24510" & SCC%in%MotorSource)
MotorEmission <- aggregate(Emissions~year,sub3,sum)
png("plot5.png", width=480, height=480)
ggplot(MotorEmission,aes(x=factor(year),y=Emissions,fill=year))+
geom_bar(stat="identity")+ggtitle("Total Emissions PM2.5 in the Baltimore City of Motor Vehicle Source")+
xlab("year")+ylab("Total Emissions of PM2.5 (tons)")
dev.off()

