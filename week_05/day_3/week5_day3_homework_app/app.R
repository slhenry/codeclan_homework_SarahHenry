library(shiny)
library(tidyverse)
library(bslib)

backpack_data <- CodeClanData::backpack

all_year <- backpack_data %>% 
  distinct(year) %>% 
  pull()

ui <- fluidPage(
  theme = bs_theme(bootswatch = "cosmo"),
  titlePanel("Backpack Weight, Major and Year Comparison"),
  br(),
  br(),
  sidebarLayout(
    sidebarPanel(
      radioButtons(inputId = "gender_input",
                   label = tags$h3(tags$i("Which gender?")),
                   choices = c("Male", "Female"),
      ),
      selectInput(inputId = "year_input",
                  label = tags$h3(tags$i("Which Year?")),
                  choices = all_year
                  
      )
      
    ),
    mainPanel(
      plotOutput("backpack_plot")
    )
  )
)
      
    

server <- function(input, output, session) {
  
  output$backpack_plot <- renderPlot({
    backpack_data %>% 
      filter(sex == input$gender_input,
             year == input$year_input) %>% 
      ggplot()+
      aes(x = major, y = backpack_weight, fill = sex)+
      geom_col(show.legend = FALSE)+
      coord_flip()+
      theme_light()+
      labs(
        x = "Major",
        y = "Total backpack weight")+
      scale_fill_manual(values = c("Male" = "blue",
                                   "Female" =  "red")
      )
  })
  
}

shinyApp(ui, server)