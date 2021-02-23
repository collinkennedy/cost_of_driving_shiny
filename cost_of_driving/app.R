#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


vectorOfGasPrices = c(seq(from = 2, to = 4, by =.01))


?sliderInput
?numericInput
# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Cost of Driving Calculator"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            numericInput(inputId = "gas_price",
                        label = "Price Per Gallon ($)",
                        min = 1,
                        max = 4,
                        value = "",
                        step = .01),
            numericInput(inputId = "mpg",
                        label = "Car's average MPG",
                        min = 1,
                        max = 50,
                        value = "",
                        step = 1),
            numericInput(inputId = "distance",
                         label = "Distance Driven",
                         value = "",
                         min = 1,
                         max = 100)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           textOutput("cost")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    driving_cost = reactive({
        gallons_used = input$distance/input$mpg
        cost = gallons_used*input$gas_price
        return(cost)

    })



    observeEvent(input$distance,{
        output$cost = renderText({
            if(is.na(driving_cost())){
                paste("")

            }else{
                paste("$",isolate(driving_cost()))
            }

        })
    })
    }

# Run the application
shinyApp(ui = ui, server = server)
