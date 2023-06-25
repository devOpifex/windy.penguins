#' Server
#' 
#' Server logic.
#' 
#' @param input,output Environments.
#' @param session Shiny session.
#' 
#' @import shiny
#' @keywords internal
server <- \(input, output, session){
  # update initial inputs
  observe({
    session$sendCustomMessage(
      "init", 
      list(
        species = unique(palmerpenguins::penguins$species),
        islands = unique(palmerpenguins::penguins$island)
      )
    )
  })

  penguins <- reactive({
    req(input$species)
    req(input$islands)

    dat <- palmerpenguins::penguins

    if(input$species != "all")
      dat <- dat |>
        dplyr::filter(.data$species == input$species)

    if(input$islands != "all")
      dat <- dat |>
        dplyr::filter(.data$island == input$islands)

    return(dat)
  })

  viz_server("viz", penguins)
}
