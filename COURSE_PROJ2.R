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

# Q1
EmissionByYear <- aggregate(Emissions~year,NEI,sum)
png("plot1.png", width=480, height=480)
barplot(EmissionByYear$Emissions,
	main="Total Emissions PM2.5 in the United States",
	xlab="Year",
	ylab="Total Emissions of PM2.5 (tons)",
	names.arg=EmissionByYear$year,
	ylim=c(0,8000000)
	)
dev.off()

# Q2
sub1 <- subset(NEI,fips=="24510")
EmissionByYear_sub1 <- aggregate(Emissions~year,sub1,sum)
png("plot2.png", width=480, height=480)
barplot(EmissionByYear_sub1$Emissions,
	main="Total Emissions PM2.5 in the Baltimore City, Maryland",
	xlab="Year",
	ylab="Total Emissions of PM2.5 (tons)",
	names.arg=EmissionByYear_sub1$year,
	ylim=c(0,4000)
	)
dev.off()

# Q3
library(ggplot2)
EmissionByYearType_sub1 <- aggregate(Emissions~year+type,sub1,sum)
png("plot3.png", width=500, height=480)
ggplot(EmissionByYearType_sub1,aes(x=year,y=Emissions,color=type))+
geom_line()+ggtitle("Total Emissions PM2.5 in the Baltimore City, Maryland by Source Type")+
xlab("year")+ylab("Total Emissions of PM2.5 (tons)")
dev.off()

# Q4
CoalSource <- SCC[grep("[Cc][Oo][Aa][Ll]", SCC$EI.Sector), "SCC"]
sub2 <- subset(NEI,SCC%in%CoalSource)
CoalEmission <- aggregate(Emissions~year,sub2,sum)
png("plot4.png", width=500, height=480)
ggplot(CoalEmission,aes(x=factor(year),y=Emissions))+
geom_bar(stat="identity")+ggtitle("Total Emissions PM2.5 in the United States of Coal Combustion Source")+
xlab("year")+ylab("Total Emissions of PM2.5 (tons)")
dev.off()

# Q5
MotorSource <- SCC[grep("[Vv]ehicle", SCC$EI.Sector), "SCC"]
sub3 <- subset(NEI,fips=="24510" & SCC%in%MotorSource)
MotorEmission <- aggregate(Emissions~year,sub3,sum)
png("plot5.png", width=480, height=480)
ggplot(MotorEmission,aes(x=factor(year),y=Emissions,fill=year))+
geom_bar(stat="identity")+ggtitle("Total Emissions PM2.5 in the Baltimore City of Motor Vehicle Source")+
xlab("year")+ylab("Total Emissions of PM2.5 (tons)")
dev.off()

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










