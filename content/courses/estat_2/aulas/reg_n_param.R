library(rpart)
library(tidyverse)

x1 <- rbinom(100, 1, 0.5)
x2 <- rbinom(100, 1, 0.5)
y = ifelse(runif(100) < 0.1, 1-x1*x2, x1*x2)

data <- tibble(x1=x1, x2=x2, y=y)
aux = rpart(y~x1+x2, data = data)
plot(aux)
text(aux)

library(randomForest)
n = 1000
x <- rnorm(n)
y = 4*sin(4*x) + 2*x^2 + rnorm(n, 0.1)
plot(x, y)

data = tibble(x=x, y=y)
aux = randomForest(y~x, data=data)
summary(aux)

y_pred = predict(aux, data)

data_real = tibble(x = x, y = y, tipo = "dados")
data_prev = tibble(x = x, y = y_pred, tipo = "prev")
data = rbind(data_real, data_prev)

ggplot(data, aes(x=x, y=y, color=tipo)) +
  geom_point()

summary((y - y_pred)^2)

