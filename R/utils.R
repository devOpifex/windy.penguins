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

  lapply(1:length(values), \(i) {
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
      class = "bg-slate-50 min-h-full",
      div(
        class = "md:grid md:grid-cols-12",
        ...
      )
    )
  )
}

gauge_continuous <- function(g, ...) {
  gauge_color(c("#03045e", "#0077b6", "#00b4d8", "#90e0ef", "#caf0f8"))
}

gauge_discrete <- function(g, ...) {
  gauge_color(g, "#006ba6", "#ffbc42", "#8f2d56")
}

varsInput <- function(id, label, default = "", class = "") {
  opts <- lapply(names(palmerpenguins::penguins)[grepl("_", names(palmerpenguins::penguins))], \(n) {
    name <- gsub("_", " ", n)
    name <- tools::toTitleCase(name)

    opt <- tags$option(value = n, name)

    if(n == default)
      opt <- htmltools::tagAppendAttributes(opt, selected = NA)

    return(opt)
  })

  tagList(
    tags$label(label, class = "text-sm text-white"),
    tags$select(
      id = id,
      class = sprintf("bg-white text-slate-700 px-2 py-1 rounded w-full %s", class),
      opts
    )
  )
}
