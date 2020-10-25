# Load tidyverse for dply package
library(tidyverse)

# Import and read the MechaCar_mps csv file as a dataframe
mechacar_df <- read.csv(file='MechaCar_mpg.csv',check.names=F,stringsAsFactors = F)

# Perform linear regression using all six variables and the dataframe
lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD,data=mechacar_df)

# Determine the p-value and r-squared value for the lm model
summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD,data=mechacar_df))

# Import and read the Suspension_coil csv file as a table
suspension <- read.csv(file='Suspension_coil.csv',check.names=F,stringsAsFactors = F)

# Create a dataframe to get the mean, median, variance, and standard deviation of the 
# suspension coil’s PSI column
total_summary <- summarize(suspension, Mean=mean(PSI), Median=median(PSI), Variance=var(PSI), SD=sd(PSI))
total_summary 

# Create a dataframe to group each manufacturing lot by the mean, median, 
# variance, and standard deviation of the suspension coil’s PSI column
lot_summary <- suspension %>% group_by(Manufacturing_Lot) %>% summarize(Mean=mean(PSI), Median=median(PSI), Variance=var(PSI), SD=sd(PSI))
lot_summary

# Determine if the suspension coil data is normally distributed
ggplot(suspension,aes(x=PSI)) + geom_density()
shapiro.test(suspension$PSI)

# Determine if the suspension coil data is normally distributed for each of the lots
Lot1_PSI <- suspension %>% filter(Manufacturing_Lot=="Lot1")
ggplot(Lot1_PSI,aes(x=PSI)) + geom_density()
shapiro.test(Lot1_PSI$PSI)

Lot2_PSI <- suspension %>% filter(Manufacturing_Lot=="Lot2")
ggplot(Lot2_PSI,aes(x=PSI)) + geom_density()
shapiro.test(Lot2_PSI$PSI)

Lot3_PSI <- suspension %>% filter(Manufacturing_Lot=="Lot3")
ggplot(Lot3_PSI,aes(x=PSI)) + geom_density()
shapiro.test(Lot3_PSI$PSI)

# Determine if the PSI across all manufacturing lots is statistically different 
# from the population mean of 1,500 pounds per square inch
t.test(log10(suspension$PSI),mu=mean(log10(1500)))

# Determine if the PSI for each manufacturing lot is statistically different 
# from the population mean of 1,500 pounds per square inch
t.test(log10(subset(suspension, Manufacturing_Lot=='Lot1', select=PSI)),mu=mean(log10(1500)))
t.test(log10(subset(suspension, Manufacturing_Lot=='Lot2', select=PSI)),mu=mean(log10(1500)))
t.test(log10(subset(suspension, Manufacturing_Lot=='Lot3', select=PSI)),mu=mean(log10(1500)))

Lot2_PSI <- suspension %>% filter(Manufacturing_Lot=="Lot2")
shapiro.test(Lot2_PSI$PSI)
