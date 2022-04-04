## Question 4


# Load dplyr and ggplot2 libraries
library(dplyr)
library(ggplot2)


SCCFile <- "C:/Users/200062/Downloads/exdata_data_NEI_data/Source_Classification_Code.rds"
summarySCC_PM25File <- "C:/Users/200062/Downloads/exdata_data_NEI_data/summarySCC_PM25.rds"

# Read files
NEI <- readRDS(summarySCC_PM25File)
SCC <- readRDS(SCCFile)

# Fetch coal-combustion only
CoalCombustionSCC0 <- subset(SCC, EI.Sector %in% c("Fuel Comb - Comm/Instutional - Coal",
                                                   "Fuel Comb - Electric Generation - Coal",
                                                   "Fuel Comb - Industrial Boilers, ICEs - Coal"))

# Compare to Short.Name matching both Comb and Coal
CoalCombustionSCC1 <- subset(SCC, grepl("Comb", Short.Name) & 
                               grepl("Coal", Short.Name))

# 
print(paste("Number of subsetted lines via EI.Sector:", nrow(CoalCombustionSCC0)))
print(paste("Number of subsetted lines via Short.Name:", nrow(CoalCombustionSCC1)))

# set the differences
diff0 <- setdiff(CoalCombustionSCC0$SCC, CoalCombustionSCC1$SCC)
diff1 <- setdiff(CoalCombustionSCC1$SCC, CoalCombustionSCC0$SCC)

print(paste("Number of setdiff (data via EI.Sector & Short.Name):", length(diff0)))
print(paste("Number of setdiff (data via Short.Name & EI.Sector):", length(diff1)))

# Create the union of SCCs via EI.Sector & Short.Name
CoalCombustionSCCCodes <- union(CoalCombustionSCC0$SCC, CoalCombustionSCC1$SCC)
print(paste("Number of SCCs:", length(CoalCombustionSCCCodes)))


CoalCombustion <- subset(NEI, SCC %in% CoalCombustionSCCCodes)

# Calculating the sum of emissions by the type & year
coalCombustionPM25ByYear <- CoalCombustion %>% select(year, type, Emissions) %>%
  group_by(year, type) %>%
  summarise_each(funs(sum))

#Creating the plot to show the answer of the 4th question
qplot(year, Emissions, data = coalCombustionPM25ByYear, color = type, geom = "line") + 
  stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", color = "purple", aes(shape="total"), geom="line") +
  # geom_line(aes(size="total", shape = NA, col = "purple")) + 
  ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) + 
  xlab("Year") + 
  ylab(expression  ("Total" ~ PM[2.5] ~ "Emissions (tons)"))

# Plotting the result of the changes in coal emissions 1999-2008
qplot(year, Emissions, data = coalCombustionPM25ByYear, color = type, geom = "line") + 
  stat_summary(fun.y = "sum", aes(year, Emissions, color = "Total"), geom="line") +
  ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) + 
  xlab("Year") + 
  ylab(expression  ("Total" ~ PM[2.5] ~ "Emissions (tons)"))


# Plot4.png
dev.copy(device = png, filename = 'plot4.png', width = 500, height = 400)
