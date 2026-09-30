library(tidyverse)
library("rstan")

data("bball1970", package = "rstanarm")
bball1970 <- bball1970 %>%
  mutate(
    BatAvg1 = Hits / AB,
    BatAvg2 = RemainingHits / RemainingAB
  )

head(tibble(bball1970))

bball1970_data <- list(
  N = nrow(bball1970),
  K = bball1970$AB,
  y = bball1970$Hits,
  K_new = bball1970$RemainingAB,
  y_new = bball1970$RemainingHits
)

aux = stan(
  file = "content/courses/analise_bayesiana/code/stan_batting_no_pool.stan",
  data = bball1970_data,
  iter = 2000,
  chains = 4
)
theta_no_pool = extract(aux, pars = c("theta"))
theta_no_pool = colMeans(theta_no_pool$theta)

aux = stan(
  file = "content/courses/analise_bayesiana/code/stan_batting_pool.stan",
  data = bball1970_data,
  iter = 2000,
  chains = 4
)
theta_pool = extract(aux, pars = c("phi"))$phi
theta_pool = rep(mean(theta_pool), 18)

aux = stan(
  file = "content/courses/analise_bayesiana/code/stan_batting_part_pool.stan",
  data = bball1970_data,
  iter = 2000,
  chains = 4
)
theta_part = extract(aux, pars = c("alpha"))$alpha
theta_part = colMeans(exp(theta_part)/(1+exp(theta_part)))

data = tibble(bball1970) |>
  select(Player, media_1 = BatAvg1, media_2 = BatAvg2) |>
  mutate(
    bat_np = theta_no_pool,
    bat_p = theta_pool,
    bat_pp = theta_part,
    er_np = (media_2 - bat_np)^2,
    er_p = (media_2 - bat_p)^2,
    er_pp = (media_2 - bat_pp)^2
  )

data |>
  summarise(
    er_np = mean(er_np),
    er_p = mean(er_p),
    er_pp = mean(er_pp)
  )

data |>
  select(Player, media_1, media_2, bat_np, bat_p, bat_pp) |>
  pivot_longer(cols = starts_with("bat"), names_to = "modelo", values_to = "media") |>
  ggplot(aes(x = media_1, y = media_2)) +
  geom_point() +
  geom_abline(slope = 1, intercept = 0) +
  geom_point(aes(y = media), color = "red") +
  facet_wrap(~modelo) +
  theme_bw()

alpha = extract(aux, pars = c("alpha"))$alpha
melhor = rep(NA, 4000)
for(ii in 1:4000)
{
  melhor[ii] =which.max(alpha[ii, ])
}
post_melhor = table(melhor)/4000
names(post_melhor) = bball1970$Player
post_melhor

data |> 
 arrange(desc(media_2))

# Resolver a análise preditiva da temporada em aula
# Fazer a posteriori da temporada inteira