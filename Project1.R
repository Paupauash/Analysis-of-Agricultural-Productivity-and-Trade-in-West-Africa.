##Project 1: Analysis of Agricultural Productivity and Trade in West Africa from 2014 to 2022.

#Importing the database
library(readxl)
Gross_production_values_in_USD <- read_excel("C:/Users/Hp/Desktop/Agroeconomie/Gross_production_values_in_USD_Western_Africa_FAOSTAT_data_en_8-23-2024.xls")
View(Gross_production_values_in_USD)


#Data preparation
#Loading the package dplyr for data manipulation
library(dplyr)

#Extracting the data
A <- Gross_production_values_in_USD[ , c(4,6,8,10,11,12)] 

#Computing the mean for western Africa per item from 2010 to 2022  
df1.western_africa <- A %>%                  #hold the data 
  group_by(Area, Item) %>%                   #uses the previous data to group by country and   item 
  filter( Area=="Western Africa" &  Year %in% c("2014", "2015", "2016" , "2017" , "2018", "2019" , "2020", "2021", "2022"))   %>%        #uses the previous data to filter by western Africa country and per item  
  summarize(mean1= mean(Value))  %>%     #uses the previous data to compute the mean  
  arrange(Item)  #sorting the data with respect to items alphabetically in an ascending order

#exporting the previous data set to plot in Tableau
write.csv(df1.western_africa, "C:/Users/Hp/Desktop/Agroeconomie/df1_western_africa.csv")

#Determining trade balances for the top 3 agricultural products.
#Importing the database
Import_Export_West_Africa <- read_excel("C:/Users/Hp/Desktop/Agroeconomie/Import_Export_Crops_West_Africa_total_FAOSTAT_data_en_8-23-2024.xls")

#Determining trade balance for,yams,rice and maize
#Extracting the needed data
B <- Import_Export_West_Africa[ , c(2,4,6,8,10,11,12)] 
df2.western_africa <- B  %>%
  filter(B$Item %in% c("Yams","Rice","Maize (corn)") & B$Element %in% c("Import Quantity", "Export Quantity" ) 
         &  Year %in% c("2014", "2015", "2016" , "2017" , "2018", "2019" , "2020", "2021", "2022")) 

#Creating  two subsets of data respectively for the exported quantity and the imported quantity
#Exported quantity set
df1.western_africa.Export=df2.western_africa %>%
  filter(Element == "Export Quantity" ) 

#Import quantity set
df1.western_africa.Import=df2.western_africa %>%
  filter(Element == "Import Quantity" ) 

#Calculating the trade balance between both
df1.trade <- df1.western_africa.Import[, c(1,2,4,5)]%>%
  mutate( df1.western_africa.Export$Value-df1.western_africa.Import$Value)%>%
  rename_with(.cols = 5, ~"Trade Balance") 

write.csv(df1.trade,"C:/Users/Hp/Desktop/Agroeconomie/df1.trade.csv") #Exporting

#Relationship between the trade and the gross production
# Creating trade sign as a categorical variable taking "positive" and "negative" modality
df1.trade$Trade_Sign <- ifelse(df1.trade$`Trade Balance` >= 0, "Positive", "Negative")
df1.trade$Trade_Sign <- factor(df1.trade$Trade_Sign, levels = c("Positive", "Negative"))

##Adding the corresponding gross column
##Since there is no ID column from both table to join them, we will create an ID for each df1.trade and Gross_production_values_in_USD tables
df1.trade$ID <- paste(df1.trade$Year, df1.trade$Item, sep = "_")  #Creating ID in df1.trade
Gross_production_values_in_USD$ID<-paste(Gross_production_values_in_USD$Year, 
                                         Gross_production_values_in_USD$Item, sep = "_")  #Creating ID in Gross_production_values_in_USD

Gross_production_values_in_USD_selected <- Gross_production_values_in_USD %>%
  select(ID, Value)  # Select only the columns I need
joined_trade_Gross <- df1.trade %>%
  left_join(Gross_production_values_in_USD_selected, by = "ID")%>%
  rename_with(.cols = 8, ~"Value_in_USD")


#Binomial logistic regression 
#H0:There is no difference in the log-odds of the outcome between the trade sign and the gross production in USD / the difference between the two groups equals zero
#H1:There is a difference between the two groups of positive and negative
#If p less than 0.5, then we reject H0


model_logistic <- glm(joined_trade_Gross$Trade_Sign ~ joined_trade_Gross$Value_in_USD, data = joined_trade_Gross, family = binomial())
summary(model_logistic)

#Checking the global significance of the model with the model with the deviance test.
Global_sign <- pchisq(213.71-195.85, df = 1, lower.tail=F)
Global_sign
#p = 2.377665e-05 with is less than 0.005 then we reject Ho,the model is globally significant.

#The overall performance of the model


#Computing confidence interval of the coefficients using the log likelihood
Confidence_interv <- confint(model_logistic)


#Since the previous coefficients are in the form of log of the odd ration we need no apply exponential 
#on them in order to interpret the probabilities
cbind( exp(model_logistic$coefficients)/(1+exp(model_logistic$coefficients)), exp(Confidence_interv)/(1+exp(Confidence_interv)))


#Interpretations
#p is 0.000247 and less than 0.05 so we reject Ho, that we the coefficient is significantly different from 0 means 
#that gross production is significantly associated with the positive trade balance (at the 5% significance level).
#An increase in one dollar in the gross production increases the probability of having a positive trade balance 
#by 50 percent. Meaning that having a large production of crop for the rice, maize and yams  will increase their chance of being exported more than being imported by 50%.
