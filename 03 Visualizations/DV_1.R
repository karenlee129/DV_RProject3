require(jsonlite)
require(RCurl)
require(tidyr)
require(dplyr)
require(ggplot2)

geo <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from GEO"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_kwl377', PASS='orcl_kwl377', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))


cuisine <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from CUISINE"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_kwl377', PASS='orcl_kwl377', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
cuisine

parking <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from PARKING"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_kwl377', PASS='orcl_kwl377', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

ratings <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from RATINGS"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_kwl377', PASS='orcl_kwl377', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

dplyr::inner_join(geo, cuisine, by="PLACEID") %>% select(CUISINE, PRICE, STATES) %>% filter(CUISINE %in% c("American", "Greek", "Dutch-Belgian", "French", "Japanese", "Mexican", "Vegetarian", "Chinese", "Cafe_Coffee_Shop", "Bar_Pub_Brewery") ) %>% ggplot(aes(x=PRICE, y=STATES, color = PRICE)) + scale_x_discrete(limits=c("low", "medium", "high")) +geom_point() + geom_jitter(alpha=1, width=.05) + facet_wrap(~CUISINE)


dplyr::inner_join(geo, cuisine, by="PLACEID") %>% select(CUISINE, PRICE, STATES) %>% filter(CUISINE %in% c("American", "Italian", "Japanese","Chinese") ) %>% filter (STATES %in% c("Tamaulipas", "San Luis Potosi", "Morelos", "Mexico")) %>% ggplot(aes(x=PRICE, y=STATES, color = PRICE)) + scale_x_discrete(limits=c("low", "medium", "high")) +geom_point() + geom_jitter(alpha=1, width=.1) + facet_wrap(~CUISINE)

dplyr::inner_join(geo, cuisine, by="PLACEID") %>% select(PRICE, STATES) %>% filter (STATES %in% c("Tamaulipas", "San Luis Potosi", "Morelos", "Mexico")) %>% ggplot(aes(x=PRICE, y=STATES)) + scale_x_discrete(limits=c("low", "medium", "high")) +geom_point() + geom_jitter(alpha=1, width=.1) 

dplyr::left_join(geo, ratings, by="PLACEID") %>% select(SMOKING_AREA, ALCOHOL, RATING, FOOD_RATING, SERVICE_RATING, STATES) %>% ggplot(aes(x=STATES, y=SMOKING_AREA)) + geom_point() + geom_jitter(alpha=1, width=.05)

dplyr::right_join(parking, cuisine, by="PLACEID") %>% select(CUISINE, PARKING) %>% filter(CUISINE %in% c("American",  "Dutch-Belgian", "French", "Mexican", "Chinese", "Cafe_Coffee_Shop", "Bar_Pub_Brewery") ) %>% filter( PARKING %in% c("fee'", "none", "public", "street", "valet parking", "validated parking")) %>% ggplot(aes(x=PARKING, y=CUISINE, color = PARKING)) + geom_point() + geom_jitter(alpha=1, width=.05)

redwhite %>% select (QUALITY, CITRIC_ACID, COLOR) %>% filter(CITRIC_ACID <= 1.2) %>% group_by(QUALITY, CITRIC_ACID) %>% ggplot (aes (x=QUALITY, y=CITRIC_ACID)) +geom_boxplot(aes(color=factor(QUALITY)),fill=NA) + scale_x_continuous(breaks = c(3,4,5,6,7,8,9)) + geom_jitter(alpha = .1, aes(color=factor(QUALITY))) + facet_wrap(~COLOR)



