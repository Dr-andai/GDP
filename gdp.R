# Health Expenditure % GDP

#Obtaining Data
##setwd
setwd('C:/Users/user/Documents/R/GDP/GDP')

##load packages
pacman::p_load(
  rio, #import data
  janitor,    # data cleaning and tables
  tidyverse, # data management and visualization
  ggthemes, # setting theme
  dplyr #data manipilation
)
#import data
gdp <- import('API_SH.XPD.CHEX.GD.ZS_DS2_en_csv_v2_4499032.csv')

#Data Cleaning
##reshape data frame 2009-2019 columns
gdp2 <- gdp[-c(5:53)]
names(gdp2) <- NULL
names(gdp2) <- gdp2[1,]
##remove first row and rename The Columns
gdp2 <- gdp2 [-c(1),]
gdp2 <- gdp2 %>%
  janitor::clean_names()
#delete empty columns
gdp2 <- gdp2 [ , !names(gdp2)%in%
                     c("country_code", "indicator_name", "indicator_code", "na", "x2020", "x2021")]

#Obtain East Africa Countries
ea_gdp <- gdp2 [gdp2$country_name %in% c("Kenya", "Tanzania", "Uganda",
                "Rwanda", "Congo, Dem. Rep.", "Burundi", "South Sudan", "Ethiopia"),]

##Data Visualization of HE $ of GDP in 2019
ea_gdp_19 <- ea_gdp [ , c('country_name', 'x2019')]
##round to 2 decimal places
ea_gdp_19[,'x2019']=round(ea_gdp_19[,'x2019'],2)

ggplot(ea_gdp_19,
       aes(x = reorder(country_name,-x2019), y= x2019, fill = reorder(country_name,-x2019)))+
  geom_bar(stat = 'identity',show.legend = FALSE)+
  scale_fill_manual(values = c("Kenya" = "#FF0000",
                               "Tanzania" = "#5cac94",
                               "Uganda" = "#5cac94",
                               "Rwanda"= "#5cac94", 
                               "Congo, Dem. Rep."= "#5cac94", 
                               "Burundi"= "#5cac94",
                               "South Sudan"= "#5cac94",
                               "Ethiopia"= "#5cac94"))+
  theme_few()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  geom_text(aes(label = paste(format(x2019, nsmall = 2), "%")), vjust = -0.2)+
  labs(title="Healthcare Expenditure as Percentage of GDP", 
        subtitle ="In 2019 in EastAfrican Countries")+
  labs(x = "",
       y = "")


#Trend of HE % of GDP in 10years
#Pivot data;  Wide-to-long
##pivot_data
ea_gdp2 <- ea_gdp%>%
  pivot_longer(
    cols = "x2009":"x2019",
    names_to = "year",
    values_to = "gdp"
  )

#Convert year column to numeric
years <- as.numeric(str_match(ea_gdp2$year,"[0-9]+"))

ea_gdp2 <- cbind(ea_gdp2, years)

#Data Visualization
myColours2 = c("#040c04", "#4d372c", "#FF0000", "#5cac94", "#4d3ec0","#acc6d8",
               "#24a4d4")
ea_gdp2%>%
  mutate(isKenya = (country_name == "Kenya"))%>%
  ggplot(aes(x=years, y=gdp, color=country_name))+
  geom_line( aes (linetype = isKenya), size =1, alpha = 0.6)+
  labs (title = "East Africa Health Expenditure  (% of GDP)",
        subtitle = "In 2019, health expenditure as a share of GDP for Kenya was 4.6 %",
        y = "HE (% 0f GDP)",
        x = "years",
        color = "Country")+
  scale_x_continuous(breaks = 2009:2019)+
  theme_tufte()+
  scale_linetype_manual(values = c ("dashed", "solid"), guide ="none")+
  scale_color_manual(values = myColours2)
