##subsets SCC dataset for onroad emissions
SCCVehicle <- SCC[which(grepl("Onroad", SCC$Data.Category)==TRUE), ]

##Merges SCC Coal dataset with NEI Emissions dataset
NEIVehicle <- merge(NEI, SCCVehicle, by="SCC")

##Function subsets National Emissions Inventory by year
NEI99 <- NEIVehicle[which(NEIVehicle$year=="1999"), ]
NEI02 <- NEIVehicle[which(NEIVehicle$year=="2002"), ]
NEI05 <- NEIVehicle[which(NEIVehicle$year=="2005"), ]
NEI08 <- NEIVehicle[which(NEIVehicle$year=="2008"), ]

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

qplot(Year, PollutantMean, data=NEIMean) + 
  geom_line() +
  xlab("Year") +
  ylab("Total Emissions") + 
  ggtitle("Total On-Road Emissions")



dev.copy(png, "plot5.png")
dev.off()
