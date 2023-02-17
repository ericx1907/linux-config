---
title: "Basic R Markdown"
author: "Eric Xu"
date: "2023-02-14"
output:
  html_document:
    keep_md: true
---

This is first Paragraph
This is still the first praagraph.


Below is a code chunk:


```r
fit = lm(dist ~ speed, data = cars)
b   = coef(fit)
plot(cars)
abline(fit)
```

![](basic_files/figure-html/unnamed-chunk-1-1.png)<!-- -->

The slope of the regression is -17.5790949.
