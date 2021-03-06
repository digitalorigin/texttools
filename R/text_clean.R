# roxygen2::roxygenise()

#' @title text.trim.leading
#' @usage text.trim.leading(x)
#' @export text.trim.leading
text.trim.leading <- function (x) {
  return(sub("^\\s+", "", x))
}

#' @title text.trim.trailing
#' @usage text.trim.trailing(x)
#' @export text.trim.trailing
text.trim.trailing <- function (x) {
  return(sub("\\s+$", "", x))
}

#' @title text.trim
#' @usage text.trim(x)
#' @export text.trim
text.trim <- function (x) {
  return(gsub("^\\s+|\\s+$", "", x))
}

#' @title text.remove_extra_spaces
#' @usage text.remove_extra_spaces(x)
#' @export text.remove_extra_spaces
text.remove_extra_spaces <- function(x) {
  return(gsub("(?<=[\\s])\\s*|^\\s+|\\s+$", "", x, perl=TRUE))
}

#' @title text.remove_extra_characters
#' @usage text.remove_extra_characters(x, characters_to_simplify="[[:alpha:]]")
#' @export text.remove_extra_characters
text.remove_extra_characters <- function(x, characters_to_simplify="[[:alpha:]]") {
  # characters_to_simplify = "."
  return(gsub(paste0("(",characters_to_simplify,")\\1+"), "\\1", x))
}

#' @title text.remove_extra_characters_readable
#' @usage text.remove_extra_characters_readable(x)
#' @export text.remove_extra_characters_readable
text.remove_extra_characters_readable <- function(x) {
  output = x
  output = gsub("([^0123456789])\\1{2,}", "\\1\\1", output)
  output = gsub("([^rslRSL0123456789])\\1+", "\\1", output)
  return(output)
}

#' @title text.remove_links
#' @usage text.remove_links(x, replacement="")
#' @export text.remove_links
text.remove_links <- function(x, replacement="") {
  return(gsub("http\\w+", replacement, x))
}

#' @title text.remove_punctuation
#' @usage text.remove_punctuation(x, replacement="")
#' @export text.remove_punctuation
text.remove_punctuation <- function(x, replacement="") {
  return(gsub("[[:punct:]]", replacement, x))
}

#' @title text.remove_numbers
#' @usage text.remove_numbers(x, replacement="")
#' @export text.remove_numbers
text.remove_numbers <- function(x, replacement="") {
  return(gsub("[[:digit:]]", replacement, x))
}

#' @title text.remove_tabs
#' @usage text.remove_tabs(x, replacement=" ")
#' @export text.remove_tabs
text.remove_tabs <- function(x, replacement=" ") {
  return(gsub("[\t]", replacement, x))
}

#' @title text.remove_newlines
#' @usage text.remove_newlines(x, replacement=" ")
#' @export text.remove_newlines
text.remove_newlines <- function(x, replacement=" ") {
  output = x
  output = gsub("[\n]", replacement, output)
  output = gsub("[\r]", "", output)
  return(output)
}

#' @title text.clean
#' @usage text.clean(
#'   x,
#'   trim = TRUE,
#'   remove_links = TRUE,
#'   remove_punctuation = TRUE,
#'   remove_numbers = TRUE,
#'   remove_tabs = TRUE,
#'   remove_newlines = TRUE,
#'   remove_extra_spaces = TRUE)
#' @export text.clean
text.clean = function(
  x,
  trim = TRUE,
  remove_links = TRUE,
  remove_punctuation = TRUE,
  remove_numbers = TRUE,
  remove_tabs = TRUE,
  remove_newlines = TRUE,
  remove_extra_spaces = TRUE
) {
  if (trim) x = text.trim(x)

  if (remove_links) x = gsub("http\\w+", "", x)
  if (remove_punctuation) x = gsub("[[:punct:]]", "", x)
  if (remove_numbers) x = gsub("[[:digit:]]", "", x)

  if (remove_tabs) x = gsub("[\t]", " ", x)
  if (remove_newlines) {
    x = gsub("[\n]", " ", x)
    x = gsub("[\r]", "", x)
  }

  if (remove_extra_spaces) x = text.remove_extra_spaces(x)
  return(x)
}

#' @title text.toASCII
#' @usage text.toASCII(
#'   x,
#'   useUnwantedArray = TRUE,
#'   useIConv = TRUE,
#'   listNonASCII = listNonASCII,
#'   listASCII = listASCII)
#' @export text.toASCII
text.toASCII = function(
  x,
  useUnwantedArray = TRUE,
  useIConv = TRUE,
  listNonASCII = listNonASCII,
  listASCII = listASCII
) {
  if (useUnwantedArray) {
    x = chartr(
      paste0(listNonASCII, collapse=""),
      paste0(listASCII, collapse=""),
      x)
  }
  if (useIConv) {
    x = iconv(x, to='ASCII//TRANSLIT')
  }

  return(x)
}

#' @title text.simpleCap
#' @usage text.simpleCap(x)
#' @export text.simpleCap
text.simpleCap <- function(x) {
  output = lapply(strsplit(x, " "),
    function(s) {
      paste(toupper(substring(s, 1,1)), substring(s, 2), sep="", collapse=" ")
    }
  )
  output = unlist(output)
}
