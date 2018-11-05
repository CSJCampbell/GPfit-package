# GPfit-package

A computationally stable approach of fitting a Gaussian Process (GP) model to a deterministic simulator. 

Branch of CRAN package with recommended updates. Changes improve performance by ~2 times.

```{r}
set.seed(45341)
# response
y1 <- mtcars$mpg[-id]
# row dimension
nn <- nrow(mtcars)
id <- (nn - 1):nn
x1 <- scale_norm(seq_len(nn - 2), range = c(1, nn))
# disp dimension
d1 <- scale_norm(mtcars$disp)[-id]
# matrix of inputs
m1 <- cbind(
    ro = x1,
    am = mtcars$am[-id], 
    ds = d1)
# fit model
gpf1 <- GP_fit(
    X = m1,
    Y = y1)
# predict for new records
gpp1 <- predict(gpf1, 
    xnew = cbind(
        ro = scale_norm(id, range = c(1, nn)), 
        am = mtcars$am[id], 
        ds = scale_norm(mtcars$disp[id], range = mtcars$disp)))
# response forecast
cbind(actual = mtcars$mpg[id], predicted = gpp1$Y_hat)
```
