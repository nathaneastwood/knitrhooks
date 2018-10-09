#' Add a scrollbar to R output
#'
#' Determine a maximum height that R console output should be and if output is
#' larger than that value, make it scrollable.
#'
#' To run this hook, call the \code{output_max_height()} function and then you
#' can either set a global maximum height
#'
#' \code{
#' knitr::opts_chunk$set(output_max_height = "300px")
#' }
#'
#' or you can specify it on a chunk by chunk basis
#'
#' \preformatted{
#' ```{r output_max_height = "300px"}
#' print(mtcars)
#' ```
#' }
#'
#' @examples
#' output_max_height()
#'
#' @export
output_max_height <- function() {
  knitr::knit_hooks$set(output = function(x, options) {
    if (!is.null(options$max_height)) {
      paste0(
        '<pre style = "max-height:',
        options$max_height,
        '; float: left; width: 910px; overflow-y: auto;">', x, "</pre>")
    } else {
      x
    }
  })
}
