
library(mxnet)
a <- mx.nd.ones(c(2,3), ctx = mx.cpu())
b <- a * 2 + 1
b
