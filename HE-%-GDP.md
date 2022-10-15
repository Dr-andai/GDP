Health Expenditure % GDP
================
David Andai
10/15/2022

When trying to figure out how to allocate our financial resources, we
more often than not asses our expenses so as to develop a guided budget.
Some items on the budget list might have a bigger share of the portion
depending on our various priorities. When it comes to matters health at
a National level, we use the Current Health Expenditure as a share of
GDP to provide an indication on the level of resources channeled to
health relative to other uses.

As GDP factors in the National outlook of the economy, health spending
measures the final consumption of health care goods and services
(i.e. current health expenditure). This includes personal health care
(curative care, rehabilitative care, long-term care, ancillary services
and medical goods) and collective services (prevention and public health
services as well as health administration), but excluding spending on
investments.

``` r
setwd('C:/Users/user/Documents/R/GDP/GDP')
gdp <- import('API_SH.XPD.CHEX.GD.ZS_DS2_en_csv_v2_4499032.csv')
head(gdp, 5)
```

    ##                            V1           V2
    ## 1                Country Name Country Code
    ## 2                       Aruba          ABW
    ## 3 Africa Eastern and Southern          AFE
    ## 4                 Afghanistan          AFG
    ## 5  Africa Western and Central          AFW
    ##                                      V3                V4   V5   V6   V7   V8
    ## 1                        Indicator Name    Indicator Code 1960 1961 1962 1963
    ## 2 Current health expenditure (% of GDP) SH.XPD.CHEX.GD.ZS   NA   NA   NA   NA
    ## 3 Current health expenditure (% of GDP) SH.XPD.CHEX.GD.ZS   NA   NA   NA   NA
    ## 4 Current health expenditure (% of GDP) SH.XPD.CHEX.GD.ZS   NA   NA   NA   NA
    ## 5 Current health expenditure (% of GDP) SH.XPD.CHEX.GD.ZS   NA   NA   NA   NA
    ##     V9  V10  V11  V12  V13  V14  V15  V16  V17  V18  V19  V20  V21  V22  V23
    ## 1 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978
    ## 2   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA
    ## 3   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA
    ## 4   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA
    ## 5   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA
    ##    V24  V25  V26  V27  V28  V29  V30  V31  V32  V33  V34  V35  V36  V37  V38
    ## 1 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993
    ## 2   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA
    ## 3   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA
    ## 4   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA
    ## 5   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA
    ##    V39  V40  V41  V42  V43  V44         V45         V46         V47         V48
    ## 1 1994 1995 1996 1997 1998 1999 2000.000000 2001.000000 2002.000000 2003.000000
    ## 2   NA   NA   NA   NA   NA   NA          NA          NA          NA          NA
    ## 3   NA   NA   NA   NA   NA   NA    6.252428    6.390627    5.969416    6.635666
    ## 4   NA   NA   NA   NA   NA   NA          NA          NA    9.443390    8.941258
    ## 5   NA   NA   NA   NA   NA   NA    3.771302    3.770256    3.387634    4.681099
    ##           V49         V50         V51         V52         V53         V54
    ## 1 2004.000000 2005.000000 2006.000000 2007.000000 2008.000000 2009.000000
    ## 2          NA          NA          NA          NA          NA          NA
    ## 3    6.710734    6.528098    6.492506    6.468483    6.299643    6.881512
    ## 4    9.808474    9.948290   10.622766    9.904675   10.256495    9.818487
    ## 5    4.481882    4.277262    4.139578    3.908460    3.731591    3.786792
    ##           V55         V56         V57         V58         V59         V60
    ## 1 2010.000000 2011.000000 2012.000000 2013.000000 2014.000000 2015.000000
    ## 2          NA          NA          NA          NA          NA          NA
    ## 3    6.922891    6.773979    6.562794    6.565689    6.152063    6.482263
    ## 4    8.569672    8.561907    7.897176    8.805941    9.528871   10.105348
    ## 5    3.521739    3.550677    3.505065    3.621925    3.614749    3.834676
    ##           V61         V62         V63         V64  V65  V66 V67
    ## 1 2016.000000 2017.000000 2018.000000 2019.000000 2020 2021  NA
    ## 2          NA          NA          NA          NA   NA   NA  NA
    ## 3    6.390654    6.317654    6.286829    6.266386   NA   NA  NA
    ## 4   11.818562   12.620817   14.126743   13.242202   NA   NA  NA
    ## 5    3.811248    3.789624    3.393160    3.366100   NA   NA  NA
