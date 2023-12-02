#Pacotes
library(shiny)
library(shinythemes)
library(ggplot2)
require(lmtest)

# Server
shinyServer(function(input, output) {
  
  #Dados
  #Definir "dataset" reatividade
  datasetInput <- reactive({
    switch(input$dataset,
           'SalaryExperience' = {p <-  data.frame(Salartemp)
           colnames(p) <- c("y","x")
           p
           },
           'WeightPlant' = {C <-  data.frame(Pesoplat)
           colnames(C) <- c("y","x")
           C
           },
           'SuicideUnemployment' = {p2 <-  data.frame(Desep)
           colnames(p2) <- c("y","x")
           p2
           },
           'ConsumptionWeight' = {p3 <-  data.frame(c_combs)
           colnames(p3) <- c("y","x")
           p3},
           'AgeWeight' = {p4 <-  data.frame(Peso_emb)
           colnames(p4) <- c("y","x")
           p4
           })
           
  })
  
 
  
  output$printdata <- renderDataTable({
    datasetInput()
  })
  
  output$sum <- renderPrint({
    dset <- (datasetInput())
    summary(dset)
  })
  
  
  output$plot1 <- renderPlot({
    ggplot(datasetInput(), aes(x = x, y = y)) + geom_point() + geom_smooth(method=lm, se=FALSE)
  })
  
  output$modelor <- renderPrint({
    dset <- lm(datasetInput())
    dset
  })

  output$anov <- renderPrint({
    avn <- datasetInput()
    summary(lm(avn))
  })
  
  output$plote <- renderPlot({
    av <- lm(datasetInput())
    av
    par(mfrow=c(2,2))
    plot(av, which=c(1:4), pch=20)
  })
  
  output$normal <- renderPrint({
    tes <- lm(datasetInput())
    tes
    shapiro.test(tes$residuals)
    
  })
  
  output$homo <- renderPrint({
    bartlett.test(data=datasetInput(), y~x)
    
  })
  
  output$indep <- renderPrint({
    tes <- lm(datasetInput())
    tes
    dwtest(tes)
  })

  
})
