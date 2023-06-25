#' User Interface
#' 
#' The user interface.
#' 
#' @param req Request, see `httpuv`.
#' 
#' @import shiny
#' @importFrom htmltools htmlTemplate
#' 
#' @keywords internal
ui <- \(req) {
  page(
    nav(),
    tabs(
      tab(
        .value = "home",
        div(
          class = "bg-white shadow h-56 text-center m-2 rounded p-4",
          h1("Hello, Tailwind!", class = "text-cyan-600 text-6xl mt-8 mb-4"),
          p(
            class = "text-slate-800",
            "Using tailwind with shiny using the {windy} package, an example."
          )
        )
      ),
      tab(
        .value = "visualisation",
        class = "hidden",
        vizUI("viz")
      )
    )
  )
}
