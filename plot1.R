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
