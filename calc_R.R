# Instale o pacote shiny, caso ainda não esteja instalado
if (!require(shiny)) install.packages("shiny")

library(shiny)

# Define a interface do usuário (UI)
ui <- fluidPage(
  titlePanel("Calculadora Básica"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("num1", "Número 1:", value = 0),
      numericInput("num2", "Número 2:", value = 0),
      selectInput(
        "operation",
        "Operação:",
        choices = c(
          "Adição" = "add",
          "Subtração" = "sub",
          "Multiplicação" = "mul",
          "Divisão" = "div",
          "Potenciação" = "pow"
        )
      ),
      actionButton("calc", "Calcular"),
      br(),
      br(),
      textOutput("result")
    ),
    mainPanel(
      h3("Resultado:"),
      verbatimTextOutput("result_display")
    )
  )
)

# Define a lógica do servidor
server <- function(input, output) {
  result <- reactive({
    input$calc # Ação ao clicar no botão
    
    isolate({
      num1 <- input$num1
      num2 <- input$num2
      operation <- input$operation
      
      if (operation == "add") {
        return(num1 + num2)
      } else if (operation == "sub") {
        return(num1 - num2)
      } else if (operation == "mul") {
        return(num1 * num2)
      } else if (operation == "div") {
        if (num2 == 0) {
          return("Erro: Divisão por zero!")
        }
        return(num1 / num2)
      } else if (operation == "pow") {
        return(num1 ^ num2)
      }
    })
  })
  
  output$result_display <- renderPrint({
    result()
  })
}

# Rodar a aplicação Shiny
shinyApp(ui = ui, server = server)
