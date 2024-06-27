library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("中心极限定理数值模拟"),
  sidebarLayout(
    sidebarPanel(
      selectInput("distribution", "选择分布:",
                  choices = c("二项分布" = "binom",
                              "卡方分布" = "chisq",
                              "泊松分布" = "pois",
                              "正态分布" = "norm",
                              "均匀分布" = "unif",
                              "指数分布" = "exp")),
      sliderInput("sampleSize", "样本数:",
                  min = 1, max = 200, value = 10),
      sliderInput("numExp", "实验次数:",
                  min = 1, max = 10000, value = 1000),
      numericInput("seed", "种子:", value = 123),
      sliderInput("bins", "直方图的窗格个数:",
                  min = 10, max = 50, value = 30),
      radioButtons("axisType", "直方图的纵轴:",
                   choices = c("频率" = "freq", "频数" = "count"))
    ),
    mainPanel(
      plotOutput("histPlot"),
      plotOutput("qqPlot")
    )
  )
)

server <- function(input, output) {
  output$histPlot <- renderPlot({
    set.seed(input$seed)
    n <- input$sampleSize
    numExp <- input$numExp
    dist <- switch(input$distribution,
                   binom = function() rbinom(n, size = 8, prob = 0.5),
                   chisq = function() rchisq(n, df = 8),
                   pois = function() rpois(n, lambda = 1/3),
                   norm = function() rnorm(n),
                   unif = function() runif(n),
                   exp = function() rexp(n))
    
    means <- replicate(numExp, mean(dist()))
    
    binWidth <- (max(means) - min(means)) / input$bins
    breaks <- seq(min(means), max(means), by = binWidth)
    
    hist(means, breaks = breaks, probability = input$axisType == "freq",
         main = paste("均值的直方图（基于", numExp, "次实验）"), xlab = "样本均值")
    if (input$axisType == "freq") {
      lines(density(means), col = "red")
    }
  })
  
  output$qqPlot <- renderPlot({
    set.seed(input$seed)
    n <- input$sampleSize
    numExp <- input$numExp
    dist <- switch(input$distribution,
                   binom = function() rbinom(n, size = 8, prob = 0.5),
                   chisq = function() rchisq(n, df = 8),
                   pois = function() rpois(n, lambda = 1/3),
                   norm = function() rnorm(n),
                   unif = function() runif(n),
                   exp = function() rexp(n))
    
    means <- replicate(numExp, mean(dist()))
    
    qqnorm(means)
    qqline(means, col = "red")
  })
}

shinyApp(ui = ui, server = server)
