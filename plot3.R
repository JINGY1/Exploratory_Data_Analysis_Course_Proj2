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

# Q3
library(ggplot2)
EmissionByYearType_sub1 <- aggregate(Emissions~year+type,sub1,sum)
png("plot3.png", width=500, height=480)
ggplot(EmissionByYearType_sub1,aes(x=year,y=Emissions,color=type))+
geom_line()+ggtitle("Total Emissions PM2.5 in the Baltimore City, Maryland by Source Type")+
xlab("year")+ylab("Total Emissions of PM2.5 (tons)")
dev.off()
