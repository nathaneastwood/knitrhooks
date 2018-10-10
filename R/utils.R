# a vectorized and better version than evaluate:::line_prompt
line_prompt <- function(x, prompt = getOption('prompt'),
                        continue = getOption('continue')) {
  # match a \n, then followed by any character (use zero width assertion)
  paste0(prompt, gsub('(?<=\n)(?=.|\n)', continue, x, perl = TRUE))
}

# Indents a Block
#  Input
#     "library(ggplot2)\nqplot(wt, mpg, data = mtcars)"
#  Output
#          library(ggplot2)
#          qplot(wt, mpg, data  = mtcars)
indent_block <- function(block, spaces = '    ') {
  if (is.null(block) || !any(nzchar(block))) return(rep(spaces, length(block)))
  if (spaces == '') return(block)
  line_prompt(block, spaces, spaces)
}
