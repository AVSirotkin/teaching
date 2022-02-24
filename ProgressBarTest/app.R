#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyWidgets)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Old Faithful Geyser Data"),
    
    # Sidebar with a slider input for number of bins 
    dropdownButton(
        sliderInput("bins",
                    "Number of bins:",
                    min = 1,
                    max = 50,
                    value = 30),
        actionBttn(
            inputId = "Id110",
            label = "Пересчитать", 
            style = "bordered",
            color = "success"),
        
        circle = TRUE, status = "danger",
        icon = icon("gear"), width = "300px",
        
        tooltip = tooltipOptions(title = "Click to see inputs !")
    ),
    
    progressBar(id = "pb", value = 5000, total = 5000, status = "info", display_pct = TRUE, striped = TRUE, title = "All options"),
    # Show a plot of the generated distribution
    plotOutput("distPlot")
    
)


# Define server logic required to draw a histogram
server <- function(input, output, session) {
    
    output$distPlot <- renderPlot({
        
        if (input$Id110 == 0)
            return()
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- isolate(seq(min(x), max(x), length.out = input$bins + 1))
        
        # draw the histogram with the specified number of bins
        
        for (i in 1:5){
            Sys.sleep(1)
            updateProgressBar(session = session, id = "pb", value = i*1000, total = 5000)
        }
        
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
