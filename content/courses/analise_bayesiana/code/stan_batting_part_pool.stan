data {
  int<lower=0> N;           // items
  int<lower=0> K[N];        // initial trials
  int<lower=0> y[N];        // initial successes
  int<lower=0> K_new[N];    // new trials
  int<lower=0> y_new[N];    // new successes
}

parameters {
  real mu;                       // population mean of success log-odds
  real<lower=0> sigma;           // population sd of success log-odds
  vector[N] alpha_std;           // success log-odds (padronizado)
}

transformed parameters {
  // Parametrizacao nao-centrada: alpha = mu + sigma * alpha_std.
  // Equivale a alpha ~ normal(mu, sigma), mas evita o funil de Neal,
  // que trava o amostrador quando sigma e pequeno e derruba o ESS.
  vector[N] alpha = mu + sigma * alpha_std;   // success log-odds
}

model {
  mu ~ normal(-1, 1);               // hyperprior
  sigma ~ normal(0, 1);             // hyperprior
  alpha_std ~ std_normal();         // prior (hierarchical, nao-centrado)
  y ~ binomial_logit(K, alpha);     // likelihood
}
