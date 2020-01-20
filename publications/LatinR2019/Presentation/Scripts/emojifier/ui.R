library("shiny")

shinyUI(
  fluidPage(
    titlePanel("the Emojifier!"),
    br(),
    wellPanel(
      fluidRow(fileInput("img_file", label = "Drop an image!")),
      fluidRow(align = "center", plotOutput("img", height = 250)),
      fluidRow(align = "center", plotOutput("img_res", height = 140))
    )
  )
)
