#' viz UI
#' 
#' @param id Unique id for module instance.
#' 
#' @import g2r
#' 
#' @keywords internal
vizUI <- \(id){
	ns <- NS(id)

  div(
    class = "p-4",
    h1("Visualisation", class = "text-cyan-600 text-4xl pl-4"),
    div(
      class = "bg-white rounded shadow-sm p-4 m-2",
      h2("Species body mass", class = "text-2xl text-slate-700"),
      g2Output(ns("scatter"))
    ),
    h2("Body mass distribution", class = "text-2xl text-slate-700 pl-4"),
    div(
      class = "grid grid-cols-2",
      div(
        class = "bg-white rounded shadow-sm p-4 m-2",
        g2Output(ns("hist"), height = 300)
      ),
      div(
        class = "bg-white rounded shadow-sm p-4 m-2",
        g2Output(ns("box"), height = 300)
      )
    )
  )
}

#' viz Server
#' 
#' @param id Unique id for module instance.
#' 
#' @keywords internal
viz_server <- \(id, penguins){
	moduleServer(
		id,
		\(
			input, 
			output, 
			session
			){
				ns <- session$ns

        output$scatter <- renderG2({
          g2(penguins(), asp(flipper_length_mm, body_mass_g, color = species)) |>
            fig_point(asp(size = 3)) |>
            planes(~species, type = "tree") |>
            gauge_discrete()
        })

        output$hist <- renderG2({
          g2(penguins(), asp(body_mass_g, color = species)) |>
            fig_histogram(adjust("stack"), bin_width = 100) |>
            gauge_discrete()
        })

        output$box <- renderG2({
          g2(penguins(), asp(species, body_mass_g, color = species)) |>
            fig_boxplot() |>
            fig_point(adjust("jitter"), asp(species, body_mass_g, size = 1)) |>
            gauge_discrete()
        })
		}
	)
}

