#Gerando a amostra
n1 = 9
n2 = 4
m1 = 172
m2 = 163
sigma = 0.25

B = 10^4
acertos = rep(NA, B)
for(ii in 1:B)
{
  x1 = rnorm(n1, m1, sigma)
  x2 = rnorm(n2, m2, sigma)
  
  # Testando m1 = mu2
  alpha = 0.05
  mu0 = 9
  S = sqrt(sum(c((x1-mean(x1))^2, (x2-mean(x2))^2))/(n1+n2-2))
  k = -qt(alpha/2,n1+n2-2)*S*sqrt((n1+n2)/(n1*n2))
  
  # Resultado do teste
  acertos[ii] = abs(mean(x1)-mean(x2)-mu0) <= k
}
mean(acertos)


# P-valor
TT = -(sqrt((n1+n2)/(n1*n2))*abs(mean(x1)-mean(x2)-mu0))/S

2*pt(TT , n1+n2-2)
