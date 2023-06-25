#' Run
#' 
#' Run the application.
#' 
#' @param ... Passed to [shiny::shinyApp()].
#' 
#' @import shiny
#' 
#' @export 
run <- \(...) {
  shiny::shinyApp(ui, server, ...)
}
