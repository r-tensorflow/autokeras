library("shiny")

shinyServer(function(input, output, session) {
  img_file <- reactive({
    in_file <- input$img_file
    if (is.null(in_file)) {
      return("")
    }
    in_file$datapath
  })

  # original image
  output$img <- renderImage(
    list(src = img_file(), height = 250),
    deleteFile = FALSE
  )
  
  # resulting classification category
  output$img_res <- renderImage(emojify(img_file()), deleteFile = FALSE)
})
