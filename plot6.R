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

# Q6
MotorSource <- SCC[grep("[Vv]ehicle", SCC$EI.Sector), "SCC"]
sub4 <- subset(NEI,SCC%in%MotorSource & (fips=="24510" | fips=="06037"))
MotorEmission1 <- aggregate(Emissions~year+fips,sub4,sum)
country <- c("Baltimore","Los Angeles")
names(country) <- c("24510","06037")
png("plot6.png", width=500, height=480)
ggplot(MotorEmission1,aes(x=factor(year),y=Emissions,fill=year)) +
    geom_bar(stat="identity") + 
    facet_grid(.~fips,labeller=labeller(fips=country)) +
    ylab("Total Emissions of PM2.5 (tons)") + 
    xlab("year") +
    ggtitle(expression("Total Emissions PM2.5 in the Los Angeles and Baltimore City of Motor Vehicle Source"))
dev.off()

