library("shiny")

shinyServer(function(input, output, session) {
  current_images <- reactiveVal(sample_imgs(imgs))
  
  output$img_1 <- renderImage(
    list(src = current_images()[[1]]), deleteFile = FALSE)
  output$img_2 <- renderImage(
    list(src = current_images()[[2]]), deleteFile = FALSE)
  output$img_3 <- renderImage(
    list(src = current_images()[[3]]), deleteFile = FALSE)
  output$img_4 <- renderImage(
    list(src = current_images()[[4]]), deleteFile = FALSE)
  
  observeEvent(input$submit, {
    pred_categs <- emojify(current_images())
    user_resp <- c(
      input$sel_img_1, input$sel_img_2, input$sel_img_3, input$sel_img_4)
    res <- sapply(seq_len(nrow(pred_categs)), function(i) {
      act_row <- pred_categs[i, ]
      names(act_row)[which.max(act_row)] == user_resp[[i]]
    })
    
    output$img_1_res <- renderPlot(categ_plot(pred_categs[1,]))
    output$img_2_res <- renderPlot(categ_plot(pred_categs[2,]))
    output$img_3_res <- renderPlot(categ_plot(pred_categs[3,]))
    output$img_4_res <- renderPlot(categ_plot(pred_categs[4,]))
    
    showNotification(paste0("Correct: ", sum(res)))
    if (all(res)) {
      showModal(modalDialog(
        title = "hooray!",
        paste0(
          "You've got them all, enjoy the emojizer by typing:\n",
          'remotes::install_github("jcrodriguez1989/rco", ref = "emojizer")'),
        easyClose = TRUE
      ))
    }
  })
  
  observeEvent(input$next_btn, {
    output$img_1_res <- renderPlot(NULL)
    output$img_2_res <- renderPlot(NULL)
    output$img_3_res <- renderPlot(NULL)
    output$img_4_res <- renderPlot(NULL)
    current_images(sample_imgs(imgs))
  })
})
