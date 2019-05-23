library(dplyr)
library(fuzzyjoin)

delmarAdd <- select(delmarAdd, ADDRRECNUM, HOUSENUM, COMPLETESTREET) %>%
  filter(COMPLETESTREET == "DELMAR BLVD")

delmarBlocks <- select(Census_drop, TLID, RFROMHN, RTOHN, COMPLETESTREET) %>%
  filter(COMPLETESTREET == "DELMAR BLVD") %>%
  mutate(RTOHN = as.numeric(RTOHN), RFROMHN = as.numeric(RFROMHN)) %>%
  filter(RTOHN != 0)

delmarJoin <- fuzzy_left_join(delmarAdd, delmarBlocks,
                               by = c(
                                 "HOUSENUM" = "RFROMHN",
                                 "HOUSENUM" = "RTOHN",
                                 "COMPLETESTREET" = "COMPLETESTREET"),
                               match_fun = list(`<=`, `>=`, `==`))
