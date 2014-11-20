##subsets SCC dataset for onroad emissions
SCCVehicle <- SCC[which(grepl("Onroad", SCC$Data.Category)==TRUE), ]

##Merges SCC Coal dataset with NEI Emissions dataset
NEIVehicle <- merge(NEI, SCCVehicle, by="SCC")

##Subsets Data for Baltimore City
NEIBaltimore <- NEIVehicle[which(NEIVehicle$fips=="24510"), ]

##Subsets Data for LA County
NEILA <- NEIVehicle[which(NEIVehicle$fips=="06037"), ]

##Function subsets National Emissions Inventory by year for Baltimore City
NEI99B <- NEIBaltimore[which(NEIBaltimore$year=="1999"), ]
NEI02B <- NEIBaltimore[which(NEIBaltimore$year=="2002"), ]
NEI05B <- NEIBaltimore[which(NEIBaltimore$year=="2005"), ]
NEI08B <- NEIBaltimore[which(NEIBaltimore$year=="2008"), ]

##Function subsets National Emissions Inventory by year for LA County
NEI99LA <- NEILA[which(NEILA$year=="1999"), ]
NEI02LA <- NEILA[which(NEILA$year=="2002"), ]
NEI05LA <- NEILA[which(NEILA$year=="2005"), ]
NEI08LA <- NEILA[which(NEILA$year=="2008"), ]

##Code averages the emissions for each subset for Baltimore
NEI99BMean <- as.numeric(sum(NEI99B$Emissions))
NEI02BMean <- as.numeric(sum(NEI02B$Emissions))
NEI05BMean <- as.numeric(sum(NEI05B$Emissions))
NEI08BMean <- as.numeric(sum(NEI08B$Emissions))

##Code averages the emissions for each subset for LA
NEI99LAMean <- as.numeric(sum(NEI99LA$Emissions))
NEI02LAMean <- as.numeric(sum(NEI02LA$Emissions))
NEI05LAMean <- as.numeric(sum(NEI05LA$Emissions))
NEI08LAMean <- as.numeric(sum(NEI08LA$Emissions))

##Adds the year variable to each calculated mean for Baltimore
NEI99BMean <- cbind(NEI99BMean, "1999")
NEI02BMean <- cbind(NEI02BMean, "2002")
NEI05BMean <- cbind(NEI05BMean, "2005")
NEI08BMean <- cbind(NEI08BMean, "2008")

##Adds the year variable to each calculated mean for LA
NEI99LAMean <- cbind(NEI99LAMean, "1999")
NEI02LAMean <- cbind(NEI02LAMean, "2002")
NEI05LAMean <- cbind(NEI05LAMean, "2005")
NEI08LAMean <- cbind(NEI08LAMean, "2008")

##Rbinds the new dataframes together and adds a column name for the year for Baltimore
NEIBMean <- as.data.frame(rbind(NEI99BMean, NEI02BMean, NEI05BMean, NEI08BMean))
NEIBMean$Region <- "Baltimore City"
colnames(NEIBMean)[[1]]="PollutantMean"
colnames(NEIBMean)[[2]]="Year"

##Rbinds the new dataframes together and adds a column name for the year for LA
NEILAMean <- as.data.frame(rbind(NEI99LAMean, NEI02LAMean, NEI05LAMean, NEI08LAMean))
NEILAMean$Region <- "LA County"
colnames(NEILAMean)[[1]]="PollutantMean"
colnames(NEILAMean)[[2]]="Year"

NEIBMean$PollutantMean <- as.numeric(as.character(NEIBMean$PollutantMean))
NEIBMean$Year <- as.numeric(as.character(NEIBMean$Year))
NEILAMean$PollutantMean <- as.numeric(as.character(NEILAMean$PollutantMean))
NEILAMean$Year <- as.numeric(as.character(NEILAMean$Year))

NEIMerged <- rbind(NEILAMean, NEIBMean)

qplot(Year, PollutantMean, data=NEIMerged, color=Region) + 
  geom_line() +
  xlab("Year") +
  ylab("Total Emissions") +
  ggtitle("Baltimore City and LA County Emissions")

dev.copy(png, "plot6.png")
dev.off()
