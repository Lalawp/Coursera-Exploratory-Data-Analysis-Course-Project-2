(##Subsets data for Baltimore City
NEIBaltimore <- NEI[which(NEI$fips=="24510"), ]

##Uses ddply to subset, apply sum function, and recombine
Total <- ddply(NEIBaltimore, .(type, year), function(x) sum(x$Emissions))

qplot(year, V1, data=Total, color=type, geom="line") + 
  xlab("Year") + 
  ylab("Total Emissions") +
  ggtitle("Baltimore Emissions by type")

dev.copy(png, "plot3.png")
dev.off()