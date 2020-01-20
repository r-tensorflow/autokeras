library("shiny")

shinyUI(
  fluidPage(
    br(),
    wellPanel(
      fluidRow(
        column(6, align = "right", actionButton("submit", label = "Submit")),
        column(6, align = "left", actionButton("next_btn", label = "Next"))
      ),
      br(),
      fluidRow(
        column(6, align="center", fluidRow(
          plotOutput("img_1", height = 108, width = 108),
          selectInput("sel_img_1", label = "", choices = categories)
        )),
        column(6, fluidRow(
          plotOutput("img_1_res", height = 160)
        ))
      ),
      fluidRow(
        column(6, align="center", fluidRow(
          plotOutput("img_2", height = 108, width = 108),
          selectInput("sel_img_2", label = "", choices = categories)
        )),
        column(6, fluidRow(
          plotOutput("img_2_res", height = 160)
        ))
      ),
      fluidRow(
        column(6, align="center", fluidRow(
          plotOutput("img_3", height = 108, width = 108),
          selectInput("sel_img_3", label = "", choices = categories)
        )),
        column(6, fluidRow(
          plotOutput("img_3_res", height = 160)
        ))
      ),
      fluidRow(
        column(6, align="center", fluidRow(
          plotOutput("img_4", height = 108, width = 108),
          selectInput("sel_img_4", label = "", choices = categories)
        )),
        column(6, fluidRow(
          plotOutput("img_4_res", height = 160)
        ))
      )
    )
  )
)
