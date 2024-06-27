library(shiny)
library(tm)
library(wordcloud)
library(wordcloud2)
library(memoise)

textProcess <- memoise(function(text) {

  myCorpus <- Corpus(VectorSource(text))
  myCorpus <- tm_map(myCorpus, content_transformer(tolower))
  myCorpus <- tm_map(myCorpus, removePunctuation)
  myCorpus <- tm_map(myCorpus, removeNumbers)
  myCorpus <- tm_map(myCorpus, removeWords, c("this", "that", "it", "the", "and", "but"))
  
  myDTM = TermDocumentMatrix(myCorpus, control = list(minWordLength = 1))
  
  m = as.matrix(myDTM)
  
  sort(rowSums(m), decreasing = TRUE)
})


fontFamily <<-  list("Arial", "Combria")
color <<- list("暗色系" = "random-dark", 
               "亮色系" = "random-light")
backgroundColor <<- list("灰色" = "gray", 
                         "黑色" = "black")
minRotation <<- list("-PI" = -pi, "-3PI/4" = -3*pi/4, 
                     "-PI/2" = pi/2, "-PI/4" = -pi/4)
maxRotation <<- list("PI" = pi, "3PI/4" = 3*pi/4, 
                     "PI/2" =  pi/2, "PI/4" = pi/4)
shape <<- list("圆形" = "circle", "心形" = "cardioid", "星形" = "star", 
               "钻石形" = "diamond", "三角形" = "triangle", "五边形" = "pentagon")


ui <- fluidPage(
  
  titlePanel("Word Cloud"),
  tabsetPanel(
    tabPanel("Wordcloud 1",
             fixedRow(
               column(4, "    ", fileInput("upload", "上传文件", accept = c(".txt")))
             ),
             sidebarLayout(
               sidebarPanel(
                 actionButton("update", "Begin!"),
                 hr(),# 创建一个代表html标签的R对象
                 sliderInput("freq", "词语最小频率:", min = 1,  max = 50, value = 15),
                 sliderInput("max", "词语最大重复次数:", min = 1,  max = 300,  value = 100)
               ),
               
               # Show Word Cloud
               mainPanel(
                 plotOutput("plot1")
               )
             ),
             downloadButton("download1", "下载图片")
             ),
    
    tabPanel("Wordcloud 2",
             sidebarLayout(
               sidebarPanel(
                 selectInput("fontFamily", "选择字体:", choices = fontFamily),
                 selectInput("color", "选择字体颜色:", choices = color),
                 selectInput("backgroundColor", "选择背景颜色:", choices = backgroundColor),
                 selectInput("minRotation", "选择字体旋转角度范围的最小值:", choices = minRotation),
                 selectInput("maxRotation", "选择字体旋转角度范围的最大值:", choices = maxRotation),
                 selectInput("shape", "选择图像形状:", choices = shape),
                 sliderInput("size", "字体大小:", min = 1,  max = 10, value = 1),
                 sliderInput("fontWeight", "字体粗细:", min = 1,  max = 800,  value = 600),
                 sliderInput("rotationRatio", "字体旋转比例:", min = 0,  max = 1,  value = 0.4)
               ),
               
               mainPanel(
                 plotOutput("plot2", width='100%', height='400px')
               )
             )),
  )
  
  
)

server <- function(input, output, session) {
  book <- reactive({
    req(input$upload)  
    ext <- tools::file_ext(input$upload$name)
    switch(ext,
           txt = readLines(input$upload$datapath, encoding = "UTF-8"),
           validate("输入无效！请上传.txt 文件。")
    )
  })
  terms <- reactive({
    input$update
    isolate({ #响应阻断器
      withProgress({
        setProgress(message = "正在加载...")
        textProcess(book())
      })
    })
  })
  
  wordcloud_rep <- repeatable(wordcloud)
  
  output$plot1 <- renderPlot({
    wordcloud_rep(names(terms()), terms(), scale = c(4,0.5),
                  min.freq = input$freq, max.words = input$max,
                  colors = brewer.pal(8, "Dark2"))
  })
  output$download1 <- downloadHandler(
    filename = "wordcloud.png",
    content = function(file) {
      png(file)
      wordcloud_rep(names(terms()), terms(), scale = c(4,0.5),
                min.freq = input$freq, max.words = input$max,
                colors = brewer.pal(8, "Dark2"))
      dev.off()
    }
  )
  output$plot2 <- renderPlot({
    wordcloud2(demoFreq, size = input$size, minSize = 0, gridSize = 0,
               fontFamily = input$fontFamily, fontWeight = input$fontWeight,
               color = input$color, backgroundColor = input$backgroundColor,
               minRotation = input$minRotation, maxRotation = input$maxRotation,
               rotateRatio = input$rotateRatio,
               shape = input$shape, ellipticity = 0.65, widgetsize = NULL)
    
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
