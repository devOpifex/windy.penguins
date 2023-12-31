tabs <- function(...){
  div(
    class = "tabs p-2 md:col-span-10 md:max-h-screen overflow-y-auto",
    ...
  )
}

tab <- function(..., class = "", .value) {
  class <- sprintf("tab %s", class)

  div(
    `data-value` = .value,
    class = class,
    ...
  )
}

nav <- function() {
  div(
    class = "bg-cyan-600 text-white md:h-full px-4 py-2 rounded-r-lg shadow w-100 md:col-span-2 md:min-h-screen",
    div(
      class = "mb-6",
      h2("{windy}", class = "text-2xl px-2 px-2"),
    ),
    nav_entry("Home", class = "bg-white text-cyan-600 rounded"),
    nav_entry("Visualisation"),
    div(
      id = "inputs",
      class = "hidden mt-4",
      div(
        class = "mb-2",
        tags$label("Species", class = "text-sm text-white"),
        tags$select(
          id = "species",
          class = "bg-white text-slate-700 px-2 py-1 rounded w-full"
        )
      ),
      div(
        class = "mb-2",
        tags$label("Islands", class = "text-sm text-white"),
        tags$select(
          id = "islands",
          class = "bg-white text-slate-700 px-2 py-1 rounded w-full"
        )
      )
    ),
    tags$a(
      href = "https://opifex.org",
      target = "_blank",
      tags$img(
        class = "max-w-fit w-20 md:w-100",
        src = "https://opifex.org/assets/img/opifex-logo.png"
      )
    )
  )
}

nav_entry <- function(label, target = tolower(label), class = "") {
  cls <- sprintf("w-full hover:font-bold navigation px-4 py-2 %s", class)

  div(
    class = "mb-2",
    tags$p(
      span(label, class = "cursor-pointer"),
      class = cls, 
      `data-target` = target
    )
  )
}
