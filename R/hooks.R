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
#' @importFrom knitr knit_hooks
#'
#' @export
output_max_height <- function() {
  knit_hooks$set(output = function(x, options) {
    if (!is.null(options$output_max_height)) {
      paste0(
        '<pre style = "max-height:',
        options$output_max_height,
        '; float: left; width: 910px; overflow-y: auto;">', x, "</pre>")
    } else {
      x
    }
  })
}

#' Print certain output lines
#'
#' Print only lines of the R output that the user specifies. This works
#' similarly to how \code{echo} works for printing R code.
#'
#' To run this hook, call the \code{output_lines()} function and then you can
#' either print a number of lines for all chunks
#'
#' \code{
#' knitr::opts_chunk$set(output_lines = 1:10)
#' }
#'
#' or you can specify it on a chunk by chunk basis
#'
#' \preformatted{
#' ```{r output_lines = 3:15}
#' print(mtcars)
#' ```
#' }
#'
#' Several options are available
#' \describe{
#'   \item{output_lines = n}{prints lines 1:n ...}
#'   \item{output_lines = 1:n}{prints lines 1:n ...}
#'   \item{output_lines = 3:15}{prints lines ... 3:15 ...}
#'   \item{output_lines = -(1:8)}{removes lines 1:8 and prints ... 9:n ...}
#' }
#' Note, there is no allowance for anything but a consecutive range of lines
#'
#' @examples
#' output_lines()
#'
#' @importFrom knitr knit_hooks
#' @importFrom utils head
#'
#' @export
output_lines <- function() {
  hook_output <- knit_hooks$get("output")
  knit_hooks$set(output = function(x, options) {
    lines <- options$output_lines
    if (is.null(lines)) {
      return(hook_output(x, options))
    }
    x <- unlist(strsplit(x, "\n"))
    more <- "..."
    if (length(lines) == 1) {
      if (length(x) > lines) {
        x <- c(head(x, lines), more)
      }
    } else {
      x <- c(
        if (abs(lines[1]) > 1) more else NULL,
        x[lines],
        if (length(x) > lines[abs(length(lines))]) more else NULL
      )
    }
    x <- paste(c(x, ""), collapse = "\n")
    hook_output(x, options)
  })
}

#' Print verbatim code chunks
#'
#' View the code chunk "asis" along with the chunk output.
#'
#' To run this hook, call the \code{source_verbatim()} function and then you can
#' either print all source code as verbatim chunks
#'
#' \code{
#' knitr::opts_chunk$set(source_verbatim = TRUE)
#' }
#'
#' or you can print it on a chunk by chunk basis
#'
#' \preformatted{
#' ```{r source_verbatim = TRUE}
#' print(mtcars)
#' ```
#' }
#'
#' @examples
#' source_verbatim()
#'
#' @importFrom knitr knit_hooks
#'
#' @export
source_verbatim <- function() {
  knit_hooks$set(source = function(x, options){
    if (!is.null(options$source_verbatim) && options$source_verbatim){
      opts <- gsub(
        "source_verbatim\\s*=\\s*TRUE",
        "",
        do.call("c", strsplit(options$params.src, ", "))
      )
      opts <- opts[!opts %in% c(" ", "")]
      opts <- gsub("^\\s", "", opts)
      bef <- if (length(opts) != 0 && nchar(opts) > 0) {
        sprintf("\n\n    ```{r, %s}\n", opts, "\n")
      } else {
        "\n\n    ```{r}\n"
      }
      paste0(
        bef,
        indent_block(paste(x, collapse = "\n"), "    "),
        "\n    ```\n"
      )
    } else {
      paste0(
        "\n\n```", tolower(options$engine), "\n", paste(x, collapse = "\n"),
        "\n```\n\n"
      )
    }
  })
}
