#' @export
max_height <- function() {
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
