n1 = 9
n2 = 6
mu1 = 167
mu2 = 172
sigma1 = 1
sigma2 = 4
x1 = rnorm(n1, mu1, sigma1)
x2 = rnorm(n2, mu2, sigma2)
alpha = 0.05

# H0: mu1 - mu2 = -5
a = -5
SS <- sqrt(var(x1)/n1 + var(x2)/n2)
abs(mean(x1)-mean(x2)-a) > qt(1-0.5*alpha, n1+n2-2)*SS

# H0: mu1 - mu2 <= -5
a = -5
SS <- sqrt(var(x1)/n1 + var(x2)/n2)
mean(x1)-mean(x2)-a > qt(1-alpha, n1+n2-2)*SS

#
n = 9
mu = 75
sigma = 10
x1 = rnorm(n, mu, sigma)
mu_reg = 5
sigma_reg = 1
x2 = x1 - rnorm(n, mu_reg, sigma_reg)

# d ~ N(mu_reg, ---)
d = x1-x2

# H0: mu_reg <= 0 
mean(d) > (qt(1-alpha, n-1)*sd(d))/sqrt(n)

sigma_reg
sd(d)
