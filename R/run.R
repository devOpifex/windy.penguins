#' Run
#' 
#' Run the application.
#' 
#' @param ... Passed to [shiny::shinyApp()].
#' 
#' @import shiny
#' 
#' @export 
run <- function(...) {
  shiny::shinyApp(ui, server, ...)
}
