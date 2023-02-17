
<!-- basic.md is generated from basic.Rmd. Please edit that file -->

# This is a title

This is first Paragraph This is still the first praagraph.

Below is a code chunk:

``` r
fit = lm(dist ~ speed, data = cars)
b   = coef(fit)
plot(cars)
abline(fit)
```

![](basic_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

The slope of the regression is -17.5790949.

## Some math

$$\begin{equation} \label{eq1}
\begin{split}
A & = \frac{\pi r^2}{2} \\
  & = \frac{1}{2} \pi r^2
\end{split}
\end{equation}$$
