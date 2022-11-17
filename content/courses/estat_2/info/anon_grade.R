library(tidyverse)

grades = "./content/courses/estat_2/info/estat2.csv" %>% 
  read_csv() %>%
  select(NUSP, P1, P2) %>% 
  mutate(
    NUSP = gsub("(P) ", "", NUSP, fixed = TRUE),
    NUSP = as.numeric(NUSP),
    NUSP = NUSP %% 1000
  )

write_csv(grades, "./content/courses/estat_2/info/grades.csv")
