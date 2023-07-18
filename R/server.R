#' Server
#' 
#' Server logic.
#' 
#' @param input,output Environments.
#' @param session Shiny session.
#' 
#' @importFrom rlang .data
#' 
#' @import shiny
#' @keywords internal
server <- function(input, output, session){
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
      dat <- dplyr::filter(dat, .data$species == input$species)

    if(input$islands != "all")
      dat <- dplyr::filter(dat, .data$island == input$islands)

    return(dat)
  })

  viz_server("viz", penguins)
}
