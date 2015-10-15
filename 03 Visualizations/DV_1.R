require(jsonlite)
require(RCurl)
require(tidyr)
require(dplyr)
require(ggplot2)

geo <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from GEO"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_kwl377', PASS='orcl_kwl377', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

cuisine <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from CUISINE"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_kwl377', PASS='orcl_kwl377', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

dplyr::inner_join(geo, cuisine, by="PLACEID") %>% select(CUISINE, PRICE, STATES) %>% ggplot(aes(x=CUISINE, y=PRICE)) + geom_point() + geom_jitter(alpha=1, width=.1)


