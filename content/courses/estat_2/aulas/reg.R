library(glmnet)

# Simulação
n = 1000
d = 900
beta = rep(0, d)
beta[1] = 6
beta[2] = 3

X <- rnorm(n*d)
dim(X) = c(n, d)
Y = X %*% beta + rnorm(n)
meus_dados = data.frame(Y = Y, X)

# Ajuste da regressão por minimos quadrados
aux = lm(Y ~ ., data = meus_dados)
summary(aux)

# Ajuste da regressão por lasso
aux = cv.glmnet(X, Y)
aux$lambda.min
aux_2 = glmnet(X, Y, lambda = aux$lambda.min)
aux_2$beta

## Regressão polinomial
d = 16
n = 30
x <- rnorm(n)
y = 2*x^2 + x + 3 + rnorm(n)
x_star = NULL
for(j in 1:d) x_star = cbind(x_star, x^j)

meus_dados = data.frame(y = y, x_star)
aux = lm(y~., data = meus_dados)
beta = aux$coefficients

g = function(x) 2*x^2 + x + 3
g_fit = function(x)
{
  resp = rep(NA, length(x))
  for(ii in 1:length(x))
  {
    resp[ii] = sum(beta*(x[ii]^(0:20)))
  }
  resp
}


curve(g, from = -5, to = 5)
curve(g_fit, from = -5, to = 5, add = TRUE)



