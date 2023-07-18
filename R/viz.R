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
    varsInput(ns("y"), "Y axis", "body_mass_g"),
    div(
      class = "bg-white rounded shadow-sm p-4 m-2",
      uiOutput(ns("title")),
      varsInput(ns("x"), "X axis", default = "flipper_length_mm", class = "border border-gray-400"),
      g2Output(ns("scatter"))
    ),
    h2("Distribution", class = "text-2xl text-slate-700 pl-4"),
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

      output$title <- renderUI({
        title <- sprintf(
          "Species %s vs. %s",
          gsub("_", " ", input$x),
          gsub("_", " ", input$y)
        )
        h2(title, class = "text-2xl text-slate-700")
      })

      output$scatter <- renderG2({
        g2(penguins(), asp(!!(rlang::sym(input$x)), !!(rlang::sym(input$y)), color = "species")) %>%
          fig_point(asp(size = 3)) %>%
          planes(~.data$species, type = "tree") %>%
          gauge_discrete()
      })

      output$hist <- renderG2({
        g2(penguins(), asp(!!(rlang::sym(input$y)), color = "species")) %>%
          fig_histogram(adjust("stack"), bin_width = 100) %>%
          gauge_discrete()
      })

      output$box <- renderG2({
        g2(penguins(), asp("species", !!(rlang::sym(input$y)), color = "species")) %>%
          fig_boxplot() %>%
          fig_point(adjust("jitter"), asp("species", "body_mass_g", size = 1)) %>%
          gauge_discrete()
      })
  })
}

