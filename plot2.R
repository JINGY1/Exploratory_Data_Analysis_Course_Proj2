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

