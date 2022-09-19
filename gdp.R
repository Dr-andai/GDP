# Health Expenditure % GDP

#setwd
setwd('C:/Users/user/Documents/R/GDP')

#load packages
pacman::p_load(
  rio,        # importing data  
  mice,        # missing data imputation
  janitor,    # data cleaning and tables
  tidyverse,   # data management and visualization
  ggthemes, # setting theme
  stringr,
  dplyr
)

myColours2 = c("#040c04", "#4d372c", "#FF0000", "#5cac94", "#4d3ec0","#acc6d8",
               "#24a4d4")

#import data
gdp <- import('API_SH.XPD.CHEX.GD.ZS_DS2_en_csv_v2_4499032.csv')

names(gdp)

#reshape data frame 2009-2019 columns
gdp2 <- gdp[-c(5:53)]
names(gdp2) <- NULL
names(gdp2) <- gdp2[1,]

#remove first row and rename The Columns
gdp2 <- gdp2 [-c(1),]
gdp2 <- gdp2 %>%
  janitor::clean_names()

#East Africa Countries
ea_gdp <- gdp2 [gdp2$country_name %in% c("Kenya", "Tanzania", "Uganda",
                "Rwanda", "Congo, Dem. Rep.", "Burundi", "South Sudan"),]

#Pivot data;  Wide-to-long
#drop unnecessary columns
ea_gdp <- ea_gdp [ , !names(ea_gdp)%in%
         c("country_code", "indicator_name", "indicator_code", "na", "x2020", "x2021")]

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
  theme_igray()+
  scale_linetype_manual(values = c ("dashed", "solid"), guide ="none")+
  scale_color_manual(values = myColours2)
