n <- 100
m <- 10

dados <- rep(NA, 1000)
for(j in 1:1000)
{
  X <- rnorm(n, 0, 1)
  Y <- rnorm(m, 0, 1)
  dados[j] = var(X)/var(Y)
}
plot(density(dados))

dens = function(x) df(x, n, m)
curve(dens, from = 0, to = 5)


s1 = var(X)
s2 = var(Y)


s1/s2 < qf(0.5*alpha, n-1, m-1)
s1/s2 > qf(1-(0.5*alpha), n-1, m-1)
