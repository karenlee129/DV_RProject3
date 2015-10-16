dplyr::full_join(geo, ratings, by="PLACEID") %>% select(SMOKING_AREA, STATES, RATING) %>% filter (STATES %in% c("Mexico", "Morelos", "San Luis Potosi", "Tamaulipas")) %>% ggplot(aes(x=STATES, y=SMOKING_AREA, color = RATING)) + geom_point() + geom_jitter(alpha=1, width=1)


