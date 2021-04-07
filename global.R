# Activated Library
library(shinydashboard)
library(tidyverse)
library(plotly)
library(scales)
library(lubridate)
library(shiny)
library(shinythemes)
library(DT)
library(glue)


#===SET UP DATA===
#Read Dataset
raw_data_supermarket <- read.csv("supermarket_sales - Sheet1.csv", sep=",")
raw_data_supermarket <- raw_data_supermarket %>% rename(Unit_price = Unit.price,
                                                        Product_line = Product.line)
supermarket <- 
  raw_data_supermarket %>% 
  select("City","Quantity","Total","Gender","Product_line", "Date", "Payment","Unit_price","Rating","Time")


#===SALES===
#Subsetting datasales
datasales <- supermarket[,c("Date","City","Unit_price","Quantity","Total","Rating")]
datasales <- aggregate.data.frame(x = list(Total = round(datasales$Total,1),
                                       Unit_Price = datasales$Unit_price,
                                       Quantity = datasales$Quantity,
                                       Rating = datasales$Rating),
                                  by = list(Date = datasales$Date,City = datasales$City),sum)
datasales$Date <- mdy(datasales$Date)


#===PRODUCT===
#Subsetting dataproduct1
dataproduct1 <- aggregate(Total~Product_line,supermarket,FUN=sum)
dataproduct1 <- dataproduct1 %>% 
  mutate(label=glue(
    "Product: {Product_line}
    Total: $ {Total}"))

#Subsetting dataproduct2
dataproduct2 <- supermarket[,c("Gender","Product_line")]
dataproduct2 <- as.data.frame(table(dataproduct2$Gender,dataproduct2$Product_line))
dataproduct2 <- setNames(dataproduct2,c("Gender","Product","Quantity"))
dataproduct2 <- dataproduct2 %>% 
  mutate(label=glue(
    "Gender: {Gender}
    Product: {Product}
    Quantity: {Quantity} unit"))


#Subsetting dataproduct3
dataproduct3 <- supermarket[,c("City","Product_line")]
dataproduct3 <- as.data.frame(table(dataproduct3$City,dataproduct3$Product_line))
dataproduct3 <- setNames(dataproduct3,c("City","Product","Quantity"))
dataproduct3 <- dataproduct3 %>% 
  mutate(label=glue(
    "City: {City}
    Product: {Product}
    Quantity: {Quantity} unit"))

#Subsetting dataproduct4
dataproduct4 <- supermarket[,c("Payment","Product_line")]
dataproduct4 <- as.data.frame(table(dataproduct4$Payment,dataproduct4$Product_line))
dataproduct4 <- setNames(dataproduct4,c("Payment","Product","Quantity"))
dataproduct4 <- dataproduct4 %>% 
  mutate(label=glue(
    "Payment: {Payment}
    Product: {Product}
    Quantity: {Quantity} unit"))


#===PAYMENT===
#Subsetting datapayment1
datapayment1 <- supermarket[,c("Date","Payment")]
datapayment1 <- as.data.frame(table(datapayment1$Payment,datapayment1$Date))
datapayment1 <- setNames(datapayment1,c("Payment","Date","Quantity"))
datapayment1$Date <- mdy(datapayment1$Date)
datapayment1$Month <- month(datapayment1$Date,label=T,abbr = F)

##Subsetting datapayment2
datapayment2 <- supermarket[,c("Payment","Time")]
datapayment2$Time <- hm(datapayment2$Time)
datapayment2$Hour <- hour(datapayment2$Time)
datapayment2 <- as.data.frame(table(datapayment2$Payment,datapayment2$Hour))
datapayment2 <- setNames(datapayment2,c("Payment","Hour","Quantity"))
datapayment2 <- aggregate.data.frame(x = list(Quantity = datapayment2$Quantity),
                                     by = list(Hour = datapayment2$Hour,
                                               Payment = datapayment2$Payment),sum)

##Subsetting datapayment3
datapayment3 <- supermarket[,c("Date","Payment")]
datapayment3$Date <- mdy(datapayment3$Date)
datapayment3$Day <- wday(datapayment3$Date,label=T,abbr = F)
datapayment3 <- as.data.frame(table(datapayment3$Payment,datapayment3$Day))
datapayment3 <- setNames(datapayment3,c("Payment","Day","Quantity"))
datapayment3 <- aggregate.data.frame(x = list(Quantity = datapayment3$Quantity),
                                     by = list(Day = datapayment3$Day,
                                               Payment = datapayment3$Payment),sum)


#===RAW DATA===
dataraw <- supermarket[,]