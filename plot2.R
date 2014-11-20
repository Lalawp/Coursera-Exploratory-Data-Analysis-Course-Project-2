##Subsets data for Baltimore City
NEIBaltimore <- NEI[which(NEI$fips=="24510"), ]


##Function subsets National Emissions Inventory by year
NEI99 <- NEIBaltimore[which(NEIBaltimore$year=="1999"), ]
NEI02 <- NEIBaltimore[which(NEIBaltimore$year=="2002"), ]
NEI05 <- NEIBaltimore[which(NEIBaltimore$year=="2005"), ]
NEI08 <- NEIBaltimore[which(NEIBaltimore$year=="2008"), ]

##Code averages the emissions for each subset
NEI99Mean <- as.numeric(sum(NEI99$Emissions))
NEI02Mean <- as.numeric(sum(NEI02$Emissions))
NEI05Mean <- as.numeric(sum(NEI05$Emissions))
NEI08Mean <- as.numeric(sum(NEI08$Emissions))

##Adds the year variable to each calculated mean
NEI99Mean <- cbind(NEI99Mean, "1999")
NEI02Mean <- cbind(NEI02Mean, "2002")
NEI05Mean <- cbind(NEI05Mean, "2005")
NEI08Mean <- cbind(NEI08Mean, "2008")

##Rbinds the new dataframes together and adds a column name for the year
NEIMean <- as.data.frame(rbind(NEI99Mean, NEI02Mean, NEI05Mean, NEI08Mean))
colnames(NEIMean)[[1]]="PollutantMean"
colnames(NEIMean)[[2]]="Year"

NEIMean$PollutantMean <- as.numeric(as.character(NEIMean$PollutantMean))
NEIMean$Year <- as.numeric(as.character(NEIMean$Year))

plot(NEIMean$Year, NEIMean$PollutantMean, main="Baltimore Emissions", type="l", xlab="Year", ylab="Total Emissions by Tonne")

dev.copy(png, "plot2.png")
dev.off()