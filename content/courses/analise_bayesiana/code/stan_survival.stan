data {
  int<lower=0> N;
  vector[N] t;
  int<lower=0> N_cens;
  real<lower=0> t_cens;
}

parameters {
  real<lower=0> lambda;
}

model {
  t ~ exponential(lambda);
  target += N_cens * exponential_lccdf(t_cens | lambda);
  lambda ~ lognormal(0, 1);
}