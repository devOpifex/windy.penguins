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
ui <- function(req) {
  page(
    nav(),
    tabs(
      tab(
        .value = "home",
        div(
          class = "bg-white shadow text-center m-2 rounded p-4",
          h1("Hello, Tailwind!", class = "text-cyan-600 text-6xl mt-8 mb-4"),
          p(
            class = "text-slate-800",
            "Using tailwind with shiny with the {windy} package, an example."
          ),
          div(
            class = "flex w-full justify-center items-center",
            tags$img(
              class = "max-h-96",
              src = "https://allisonhorst.github.io/palmerpenguins/reference/figures/lter_penguins.png"
            )
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
