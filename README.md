<!-- README.md is generated from README.Rmd. Please edit that file -->
knitrhooks
==========

**knitrhooks** provides useful knitr hooks to extend the functionality of **knitr**, **Rmarkdown** and **bookdown**.

Example
-------

The current functionality provided by this package is to set a maximum height for R output and add a scroll bar to any output larger than a given height.

<pre>
<code>```{r max_height_example}
library(knitrhooks)
output_max_height()
```</code>

# Example document

<code>```{r output_max_height = "300px"}
print(mtcars)
```</code>
</pre>
The above code will produce the following HTML document.

![scrollable\_r\_output](tools/images/README-example.PNG)
