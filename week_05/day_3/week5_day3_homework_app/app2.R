
library(tidyverse)
library(shiny)

students_big <- CodeClanData::students_big

all_regions <- students_big %>% 
  distinct(region) %>% 
  pull()

ui <- fluidPage(
  fluidRow(
    column(
      width = 3,
      radioButtons('handed_input',
                   'Handedness',
                   choices = unique(students_big$handed), 
                   inline = TRUE
      )
    ),
    
    column(
      width = 3,
      radioButtons('colour_input',
                   'Colour?',
                   choices = c("blue", "red")), 
      inline = TRUE
    ),
    
    
    
    column(
      width = 3,
      selectizeInput('region_input',
                     'Region',
                     choices = unique(students_big$region)
      )
    ),
    column(
      width = 3,
      selectInput('gender_input',
                  'Gender',
                  choices = unique(students_big$gender)
      )
    ),
    
    actionButton(inputId = 'update',
                 label = "update dashboard"),
    
    
    fluidRow(
      column(6, 
             plotOutput('travel_barplot')),
      column(6, 
             plotOutput('spoken_barplot'))
    ),
    
    DT::dataTableOutput('table_output')
    
  )
)
  
  
        
  
   DT::dataTableOutput('table_output')
  



   server <- function(input, output) {
     
     filtered_data <- eventReactive(eventExpr = input$update,
                                     valueExpr = {
                                       students_big %>% 
                                         filter(handed == input$handed_input, 
                                                region == input$region_input,
                                                gender == input$gender_input)
                                     })    
  
  output$table_output <- DT::renderDataTable({
    filtered_data()
  })
  
  
  output$travel_barplot <- renderPlot({
    
    filtered_data() %>% 
      ggplot() +
      geom_bar(aes(travel_to_school),
                   fill = input$colour_input)
  })
  
  output$spoken_barplot <- renderPlot({
    
    filtered_data() %>% 
      ggplot() +
      geom_bar(aes(languages_spoken),
               fill = input$colour_input)
  
})
  
}
shinyApp(ui = ui, server = server)
