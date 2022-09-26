library(dagitty)
library(tidyverse)

# Exemplo de DAGS e diagramas
corrente <- dagitty("dag {
    A -> B -> C
}")
plot(graphLayout(corrente))

coefeito <- dagitty("dag {
    A <- B -> C
}")
plot(graphLayout(coefeito))

collider <- dagitty("dag {
    A -> B <- C
}")
plot(graphLayout(collider))

g1 <- dagitty( "dag {
    W1 -> Z1 -> X -> Y
    Z1 <- V -> Z2
    W2 -> Z2 -> Y
}")
plot(graphLayout(g1))

g2 <- dagitty( "dag {
# COMPLETAR EM AULA
}")
plot(graphLayout(g1))

# Listar d-separações
print(impliedConditionalIndependencies(corrente))
print(impliedConditionalIndependencies(coefeito))
print(impliedConditionalIndependencies(collider))
print(impliedConditionalIndependencies(g1))
print(impliedConditionalIndependencies(g2))
