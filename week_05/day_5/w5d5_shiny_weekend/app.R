# libraries and data included in helpers.R file, also includes the assigned values. 

source('helpers.R')



# I explored the data and decided to analyse the top selling games in specified genres.
# I also thought it would be interesting to see the relationship between user and critic scores. 
# Therefore decided on 2 graphs; 
#   i) bar chart showing sales of top games 
#   ii) scatterplot with user and critic scores.
# Include an interactive table for additional detail about the games


ui <- fluidPage(
  
  titlePanel("Computer Game Comparison App"),
  br(), 
  br(),
  
  fluidRow(
    column(
      width = 4,
      offset = 1,
      pickerInput(inputId = "genre_input",
                  label = "Genre: select one or multiple",
                  choices = genre_list,
                  multiple = TRUE,
                  options = list(
                    `actions-box` = TRUE,
                    `deselect_all`= TRUE,
                    `select_all` = TRUE,
                    `none-selected` = "zero"
                  )
      )
    ),
    
    column(
      width = 4,
      selectInput(inputId = "publisher_input",
                  label = "Publisher",
                  choices = unique(game_sales$publisher),
      )
    ),
    
  
    actionButton(inputId = 'update',
                 label = "update dashboard"),
    
    
    br(),
    br(),
    br(),
    br(),
    
    fluidRow(
      column(6, 
             plotOutput('top10_barplot')),
      column(5,
             offset = 1,
             plotlyOutput('score_barplot')), 
    ),
    br(),
    br(),
    br(),
    br(),
    
    
    DT::dataTableOutput('table_output')
  )
)

server <- function(input, output, session) {
  
  filtered_data <- eventReactive(eventExpr = input$update,
                                 valueExpr = {
                                   game_sales %>% 
                                     filter(genre %in% input$genre_input, 
                                            publisher == input$publisher_input
                                            )
                                 })    
  # table: wanted to display an interactive table to show details of these selections. 
  output$table_output <- DT::renderDataTable({
    filtered_data()
  })
  
  
  # Graph 1: Top selling games by genre. 
  # Wanted to include a select all/ deselect picker to combine multiple genres
  # decided a flipped bar chart would be the best visualisation, since it will show the sales
  # and also the name of the game. 
  # only wanted to show the top 10 games, although with some combinations of genre and publisher give < 10 
  # made the text, axis etc large so easy to see!
  output$top10_barplot <- renderPlot({
    
   filtered_data() %>% 
      arrange(desc(sales)) %>% 
      head(10) %>% 
      ggplot()+
      aes(x = reorder(name, sales), y = sales, fill = rating)+
      geom_col()+
      coord_flip()+
      theme_classic()+
      labs(
        x = "Game",
        y = "Sales",
        title = "Top selling games"
      )+
      theme(text = element_text(size = 16))
  })
  
  # Graph 2: Score of user/ critic score best represented by scatterplot. 
  # wanted to include plotly to provide text of game when hover over points
  # interesting to see which game was most highly scored
  # and see where users and critics gave similar or different scores
 
  output$score_barplot <- renderPlotly({
    
    filtered_data() %>% 
      arrange(desc(sales)) %>% 
      ggplot(tooltip = text)+
      aes(x = user_score, y = critic_score, 
          fill = rating, 
          text = paste0("Game: ", name))+
      geom_point(size = 3)+
      labs(
        x = "User score",
        y = "Critic score",
        title = "Games scores"
      )+
      theme_classic()+
      theme(text = element_text(size = 12))
    
  })
  
  
  
}

shinyApp(ui, server)