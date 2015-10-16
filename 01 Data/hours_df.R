hours <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from HOURS"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_kwl377', PASS='orcl_kwl377', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

head(hours)
summary(hours)
