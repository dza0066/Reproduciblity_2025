##create a vector named z, and include values 1 to 200 using : sign in between the range of numbers you want 
z = (1:200)

##print mean of the numbers inside the z vector, using the mean function
print(mean(z))

## Calulates the standard deviation of the vector z
print(sd(z))

## Creates a logical vector named zlog with values True and False
zlog= c(TRUE, FALSE)

# Ask R to show only the values greater than 30 in the z vector using z log
zlog= z >30
print(zlog)
## Ask R to create a dataframe named zdf where numbers from z are in row and numbers from z log are in column 
zdf = data.frame(z,zlog)
print(zdf)
## For creating a new column inside zdf use dplyr pacakge use{ %>% piping } to get something from zdf and create name of column using mutate. Think like mutation here is to add something in the data format
library(dplyr)
zdf = zdf %>% mutate(zsquared = z^2)
head(zdf)

subset_zdf1 = subset(zdf, zsquared > 10 & zsquared < 100) ## create subset from zdf using subset function 
subset_zdf2 = zdf[zdf$zsquared > 10 & zdf$zsquared < 100, ] ##create subset from zdf without using subset function

z_26 = zdf[26, ] ##extract values from row 26 from zdf

zsquared_180 = zdf$zsquared[180] ##extract values from row 180
print(zsquared_180)


