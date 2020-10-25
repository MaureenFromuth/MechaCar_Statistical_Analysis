# MechaCar_Statistical_Analysis

## Linear Regression to Predict MPG

To set up this analysis, we need to first create two hypothesis: a null hypothesis, representing an outcome that can be explained by chance, and an alternate hypothesis, representing an outcome that can be explained by non-random events.  

> H0 = The slope of the linear model is zero, or m = 0

> Ha = The slope of the linear model is no zero or ≠ 0

From there we use the tidyverse library and dply folder to read the [MechaCar_mpg CSV](https://github.com/MaureenFromuth/MechaCar_Statistical_Analysis/blob/main/MechaCar_mpg.csv) file, and then use the lm() and summary() functions within R to conduct our analysis.  Utilizing the output shown in the image below, we answered the following three questions:

```
# Perform linear regression using all six variables and the dataframe
lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD,data=mechacar_df)

# Determine the p-value and r-squared value for the lm model
summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD,data=mechacar_df))
```  

**A. MechaCar: Prediction of MPG Linear Regression - Coefficients, P-Value and R Squared Value**

![MechaCar: Prediction of MPG Linear Regression](https://github.com/MaureenFromuth/MechaCar_Statistical_Analysis/blob/main/MechaData_Linear%20Regression_Summary.png)


*1. Which Variables/Coefficients Provided Non-Random Amount of Variance to the MPG in the Dataset?*
To identify which variables/coefficients provide the a significant, or non-random, amount of variance we need to look at the p-value for each.  The p-value is represented in the table above as Pr(>|t|) and represents the probability that each variable/coefficient contributes a random amount of variance (e.g. not statistically significant) to the linear model.  If we select a significance code of .05, then we have two variables/coefficients who’s p-value is less than the significance code and therefore statistically relevant, i.e. provide a non-random amount of variance to the MPG dataset: vehicle_length (p-value = 2.60e-12) and ground_clearance (p-value = 5.21e-08).  Additionally, the intercept is also statistically relevant, as it’s p-value is also less that the significance code.      

*2. Is the Slop of the Linear Model Considered to be Zero; why or why not?*
To identify if the slope of the model is zero, we need to look to our hypothesis statements and see if we can reject our null hypothesis listed above.  The null hypothesis represents an outcome that can be explained by random chance, i.e. that the inputs are not statistically relevant.  The opposite, or alternative, hypothesis represents an outcome that that is influenced by non-random events, i.e. is statistically relevant.  Much like our analysis for the impact of the variables/coefficients, the p-value is the probability that we would see similar results to the original set output, if we tested our data again, i.e. that the null hypothesis is true and that any changes to the outcome can be explained by random chance.  Therefore, to determine if we can reject the null hypothesis, we need to compare the p-value for the overall linear regression analysis and the significance code just as we did for the variables/coefficients.  Once again, if we select a significance code of .05, then we have sufficient evidence to reject our null hypothesis as the p-value is less than the significance code (p-value = 5.35e-11).  As such, we can state that there is sufficient evidence that the slope of the linear model is not zero. 

*3. Does this Linear Model Predict MPG of MechaCar Prototypes Effectively; why or why not?*
To look at the effectiveness of a model, we’ll want to examine r-squared. R-squared provides us the probability that the model will correctly predict the output using the linear regression model calculated.  For this model, the r-squared is 0.7149, which means that the model correctly predicts the output 71.49% of the time.  Unlike Pearsons correlation coefficient, the break out of how accurate a model needs to be is not set in stone.  Instead it is based on the need of the model application.  That said, a model that is able to accurately predict 71% of the time is generally accepted as an effective model.  However, with the intercept being statistically relevant, there is a likelihood that other variables, not included in this model, could increase the overall accuracy if added.


## Summary Statistics on Suspension Coils

As part of our analysis, we needed to look at the suspension coils, both in summary across all lots but also for each individual lot (there are 3 lots in total).  To do this, we use the tidyverse library and dply folder to read the [Suspension_coils CSV](https://github.com/MaureenFromuth/MechaCar_Statistical_Analysis/blob/main/Suspension_Coil.csv) file.  We then employed the summarize() function for the overall analysis, specifically looking to identify the mean PSI, median PSI, variance of the PSI, and the standard deviation of the PSI measurements.  The results are depicted below in the first table.  To conduct the same analysis for each lot, however, we utilized both the summarize() and the group_by() functions, calling out the same four measures of analysis.  The results of the lot-specific analysis are depicted below in the second graphic.  

``` 
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
``` 

**A. MechaCar: Suspension Coil Analysis for All Lots - Mean, Median, Variance, Standard Deviation**

![MechaCar: Suspension Coil Analysis for All Lots - Mean, Median, Variance, Standard Deviation](https://github.com/MaureenFromuth/MechaCar_Statistical_Analysis/blob/main/Total%20Summary.png)

**B. MechaCar: Suspension Coil Analysis for Each Lot - Mean, Median, Variance, Standard Deviation**

![MechaCar: Suspension Coil Analysis for Each Lot - Mean, Median, Variance, Standard Deviation](https://github.com/MaureenFromuth/MechaCar_Statistical_Analysis/blob/main/Lot%20Summary.png)

*Of note: the module/challenge break out is inaccurate - it has SD for Lot 1 as 8.731242.  I used the following code to filter out just the Lot1 PSI data, and I was able to verify that the actual SD for Lot 1 is 1.070525, as is identified in the graphic above*

``` 
Lot1_PSI <- suspension %>% filter(Manufacturing_Lot=="Lot1") 
summarize(Lot1_PSI, sd=sd(PSI))
``` 

*1. Provide an Overall Summary of the Results*
In summary and with each lot, the data appears to be fairly consistent (i.e. median/mean are less than 1 away from the other lots and from the summary) and does not indicate any skewing (i.e. mean and median are very close for all lots and for each lot independently).  There is, however, a significant variance within Lot 3, which suggests that the data may not be as normalized compared to the other two, and compared to the data as a whole.  

*2. Does the Current Manufacturing Data Meet the Design specifications (i.e. variance of suspension coils must not exceed 100 lbs/sq inch) for all lots in total and within each lot; why or why not?*
Based on the analysis above, we can see the variance depicted for the total data and all lots as well as for each lot individually.  Understanding that 100 lbs/sq inch is the cut off measurement, we can determine that for all of the lots in total, the manufacturer meets the design specifications (variance = 76.23459).  For each individual lot, however, only Lot 1 and Lot 2 meet those specifications (Lot 1 = 1.146024; Lot 2 = 10.131511).  Lot 3 is over twice the limit with a variance of 220.010563.  


## T-Tests on Suspension Coils

As part of our analysis, we want to ensure that the data we have is in fact representative of the true population.  More specifically, we want to ensure that our analysis adequately represents the reality of suspension coils across all of the vehicles and lots.  To set up this analysis, we need to first create two hypothesis: a null hypothesis, representing no statistical difference between the sample and real mean, and an alternate hypothesis, representing a statistical difference between the sample and real mean.  

> H0 = There is no statistical difference between the observed sample mean and it’s presumed population mean

> Ha = There is a statistical difference between the observed sample mean and it’s presumed population mean

Before testing these hypothesis, however, we need to take a look at the data to understand how it is distributed, namely is it skewed and is it normalized.  There are two critical components in selecting the proper statistical approach to answering our overall question.  To do this, we used two different techniques: a visual approach and the Shapiro-Wilk assessment.  Using the outputs, listed below in the two graphics (A: visual, B: Shapiro), we can see that the data is not skewed but is not normalized, because the p-value is less than .05.  As such, we will need to normalize the data before conducting our analysis.  If you break down the lots, you can check the distribution as well.  Using the same Shapiro and visual test, you will see that Lot 1’s p-value is .01 meaning it is not normally distributed which is also clear in the ggplot, whereas Lot 2 and Lot 3 are (Lot 2 p-value = .3004, Lot 3 p-value = .637).  As such, we will only need to normalize the data for Lot 1 and not Lot 2 or 3. 

``` 
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
``` 

**A. Visualization of the Suspension Coil Data**

![Visualization of the Suspension Coil Data](https://github.com/MaureenFromuth/MechaCar_Statistical_Analysis/blob/main/Normalcy.png)


**B. Shapiro-Wilk Test of the Suspension Coil Data**

![Shapiro-Wilk Test of the Suspension Coil Data](https://github.com/MaureenFromuth/MechaCar_Statistical_Analysis/blob/main/Shapiro%20Test.png)


To determine whether or not we can reject our null hypothesis, we need to utilize a t.test() against the suspension coil dataset.  To execute this function, we use the suspension data set and specifically the PSI column.  We do this both for the overall data, but also use the subset field for the t.test() function to execute the same test for each of the separate lots.  Of note, since the data is not normalized, as we have identified above, we will be normalizing the data in our t.test using the log10 approach.  Below outlines the results of both the t.test for all of the lots in the first graphic (A) and the t.test for each of the separate lots in the second graphic (B).  

``` 
# Determine if the PSI across all manufacturing lots is statistically different 
# from the population mean of 1,500 pounds per square inch
t.test(log10(suspension$PSI),mu=mean(log10(1500)))

# Determine if the PSI for each manufacturing lot is statistically different 
# from the population mean of 1,500 pounds per square inch
t.test(subset(log10(suspension$PSI),mu=mean(log10(1500)),suspension$Manufacturing_Lot=='Lot1'))
t.test(subset(suspension, Manufacturing_Lot=='Lot2', select=PSI),mu=1500)
t.test(subset(suspension, Manufacturing_Lot=='Lot3', select=PSI),mu=1500)
``` 

**A. T-Test for Across All of the Manufacturing Lots**

![T-Test for Across All of the Manufacturing Lots](https://github.com/MaureenFromuth/MechaCar_Statistical_Analysis/blob/main/Total%20Summary.png)

**B. T-Test for Across Each of the Manufacturing Lots**

![B. T-Test for Across Each of the Manufacturing Lots](https://github.com/MaureenFromuth/MechaCar_Statistical_Analysis/blob/main/Lot%20Summary.png)

Yet again, we are interested in the p-value for each of out t.tests and see if they are greater than or less than our significance code.  If the p-value is greater than the significance code, then the there is not enough evidence to reject the null hypothesis.  Similarly, if the p-value is less than the significance code, then there is enough evidence to reject the null hypothesis and suggest that there is a statistical difference.  For our assessment as you can see above in graphic A, the p-value for analysis across all manufacturing lots is .4894, which is above .05.  As such, we cannot reject the null hypothesis, and we can assess there is evidence that there is no statistical difference between the overall sample mean the population sample mean (i.e. they are statistically similar).  Using graphic B, we can see that each of the three Lots have p-values also above .06 (Lot1 = .9067, Lot2 = .3451, and Lot3 = .637).  As such, we cannot reject the null hypothesis, and we can assess there is evidence that there is no statistical difference between the sample mean and the population mean (i.e. they, too, are statistically similar).  

## Study Design: MechaCar vs. Competition

To support MechaCar and their assessment of their business, they have asked for us to develop a strategy for another study looking specifically at their performance against the competition.   To allow us to compare two different samples from two different sources (e.g. car companies) of the same data, we need to use a two-sample pair t.test.  This type of test, specifically a pair t.test, differs from an unpaired t.test in that in a paired t.test the mean is determined from the differences between the means measured in each paired observation.  This results in a new mean value.  

For this test, we will use the following for our hypothesis:

> H0 = The difference between our paired observations (the true mean difference) is equal to zero

> Ha = The difference between our paired observations (the true mean difference) is not equal to zero

The two sample paired t.test requires numerical data that is continuous.  As such, the data we collect must be continuous data, and we must select appropriate metrics that can be measured as such.  For example, we could use the average, or mean, cost of a car between MechaCar and its competitor as that data is continuous.  Using this metric, the t.test would tell us if there was any statistical difference between the paired observations, i.e. is one higher/lower than the other.  This would allow us to provide MechaCar an understanding of how they compare to their competitors.  To satisfy that data type, below is a list of metrics we would like to test in this study:
- Initial cost
- Resale cost
- # of miles driven for 1 year
- Maintenance cost for 1 year
- Fuel cost for 1 year
- Average mile per gallon (city)
- Average mile per gallon (hwy)

Of note, there are several additional analytic studies you could do with this data as well that would allow for us to compare results between the MechaCar and it’s competitor.  For example, you could execute a linear regression model to see how much of an impact (i.e. the coefficient) the maintenance cost, miles per gallon, and/or # of miles are on a car’s resale value.  By conducting this analysis for both companies, you could compare the results and get additional insights.  
