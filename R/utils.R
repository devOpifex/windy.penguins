#' Package File
#' 
#' Get path to a file.
#' 
#' @param ... Passed to [system.file()].
#' 
#' @keywords internal
pkg_file <- \(...){
  system.file(..., package = "windy.example")
}

#' Create Select Choices
#' 
#' Create choices for a select input.
#' 
#' @param choices Choices, named vector or list.
#' 
#' @importFrom htmltools tags
#' 
#' @keywords internal
select_choices <- \(
  choices
){
  if(missing(choices))
    stop("Missing `choices`", call. = FALSE)

  labels <- names(choices)
  if(is.null(labels))
    labels <- rep("", length(choices))

  values <- unname(choices)
  labels[labels == ""] <- values[labels == ""]

  1:length(values) |> 
    lapply(\(i) {
      tags$option(
        value = values[i],
        labels[i]
      )
    })
}

#' CSS Dependency
#' @keywords internal
dep <- function() {
  htmltools::htmlDependency(
    "tailwind",
    utils::packageVersion("windy.example"),
    package = "windy.example",
    src = "app/assets",
    script = c(src = "script.js"),
    stylesheet = c(src = "styles.css")
  )
}

#' Application Page
#' @param ... Application content
#' @keywords internal
page <- function(...) {
  tags$html(
    dep(),
    tags$body(
      class = "bg-slate-50 flex",
      ...
    )
  )
}

gauge_continuous <- function(g, ...) {
  gauge_color(c("#03045e", "#0077b6", "#00b4d8", "#90e0ef", "#caf0f8"))
}

gauge_discrete <- function(g, ...) {
  gauge_color(g, "#006ba6", "#ffbc42", "#8f2d56")
}
