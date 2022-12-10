# Teste para variancia populacional em uma populacao
n = 15
mu = 1.67
sigma = 0.1
alpha = 0.05

X = rnorm(n, mu, sigma)

# H0 : sigma = 0.4
Stat = (n-1)*var(X)/(0.4)^2

rj_1 = Stat < qchisq(0.5*alpha, n-1) 
rj_2 = Stat > qchisq(1-0.5*alpha, n-1)
rejeicao = rj_1 || rj_2
rejeicao

densidade <- function(x) dchisq(x, n-1)
curve(densidade, from = 0, to = 2*(n-1))

# Teste chi2 
hist(amostra)
n = 100
amostra = sample((1:6), n, 
                 replace = TRUE,
                 prob = c(1/2, 1/10, 1/10,
                          1/10, 1/10, 1/10))
obs = table(amostra)
esp = rep(n/6, 6)
Stat = sum((obs-esp)^2/esp)
Stat > qchisq(1-alpha, 5)

#
n = 100
x <- sample((1:4), n, 
            replace = TRUE,
            prob = c(1/4, 1/4, 1/4, 1/4))
obs = matrix(table(x), nrow = 2, ncol = 2)

p = r/n
q = c/n

c = colSums(obs)
r = rowSums(obs)

soma = 0
for(i in 1:2) 
{
  for(j in 1:2)
  {
    obs_ij = obs[i,j]
    esp_ij = n*p[i]*q[j]
    soma = soma + (obs_ij-esp_ij)^2/esp_ij
  }
}
qchisq(1-alpha, 1)



x <- rbinom(100, 1, 0.5)
y <- x*rbinom(100, 1, 0.75) + (1-x)*rbinom(100, 1, 0.25)
data = data.frame(x=x, y=y)
summary(xtabs(data = data))
