library(shiny)
library(shinythemes)
library(ggplot2)
require(lmtest)
require(datasets)


shinyUI(fluidPage(
  navbarPage(title= "Análise de Regressão Linear Interativa", theme = shinytheme("spacelab"),
             sidebarLayout(
               sidebarPanel(
                 h3("Análise de regressão linear interativa usando Shiny"),
                 p("Esta aplicação em Shiny explora algumas análises de regressão linear, ao selecionar o banco
                   de dados desejado é possível obter as informações sobre o mesmo, e navegando pela abas
                   ao lado obtêm-se as análises, desde de o ajuste do modelo até os testes de hipóteses."),
                 p("Aplicativo desenvolvido por" , a("Maria Fagna", href="https://github.com/Fagna", target="_blank"), ". Acesse
                   ", a(" o github", href="https://github.com/Fagna/App_Regression_Interactive.git", target="_blank"), " para visualizar o código."),
               
                            selectInput("dataset", "Escolha um banco de dados:",
                                          c('SalaryExperience',
                                            'WeightPlant',
                                            'SuicideUnemployment',
                                            'ConsumptionWeight',
                                            'AgeWeight')),
                              conditionalPanel(
                                "input.dataset == 'SalaryExperience'",
                                h5(strong("Relação entre salário e tempo de experiência")),
                                h6("Os dados relativos aos salários estão expressos em unidades
                                   de mil reais e o tempo de experiência no cargo em anos completos"),
                                h6(strong("Variáveis:")),
                                h6(em("Variável independente (X):"), "Experiência"),
                                h6(em("Variável dependente (Y):"), "Salário"),
                                h5(strong("Atenção:")),
                                h6("Teste para homogeneidade (Bartlett) não válido para os dados,
                                 pois  variável independente (X) não possui mais de uma observação igual")
                              ),
                              
                              conditionalPanel(
                                "input.dataset == 'WeightPlant'",
                                h5(strong("Relação entre matéria verde e doses do produto químico")),
                                h6("Os dados referente o peso das plantas foram obtidos em matéria verde 
                                e as doses foram aplicadas em determinadas datas, depois houve a pesagem"),
                                h6(strong("Variáveis:")),
                                h6(em("Variável independente (X):"), "Dose"),
                                h6(em("Variável dependente (Y):"), "Peso verde")
                              ),
                              
                              conditionalPanel(
                                "input.dataset == 'SuicideUnemployment'",
                                h5(strong("Relação entre desemprego e suicídios")),
                                h6("Os dados são de um levantamento das taxas de desemprego e o índice de 
                                   suicídios nos EUA em 14 diferentes anos, no período de 1950 a 1977. O índice 
                                   foi calculado para cada 1000 habitantes"),
                                h6(strong("Variáveis:")),
                                h6(em("Variável independente (X):"), "Desemprego"),
                                h6(em("Variável dependente (Y):"), "Suicídios"),
                                h5(strong("Atenção:")),
                                h6("Teste para homogeneidade (Bartlett) não válido para os dados,
                                 pois  variável independente (X) não possui mais de uma observação igual")
                              ),
                 
                             conditionalPanel(
                               "input.dataset == 'ConsumptionWeight'",
                               h5(strong("Relação entre peso e consumo dos automóveis")),
                               h6("Os dados são de um levantamento realizado com automóveis de passeio do 
                               mesmo ano de fabricação que foram selecionados aleatoriamente, os pesos foram 
                              obtido em kg e o consumos em litros, durante um trecho  de uma determinada estrada"),
                               h6(strong("Variáveis:")),
                               h6(em("Variável independente (X):"), "Peso"),
                               h6(em("Variável dependente (Y):"), "Consumo")
                             ),
                 
                            conditionalPanel(
                              "input.dataset == 'AgeWeight'",
                              h5(strong("Relação entre peso e idade de embriões")),
                              h6("Os dados são relativos ao peso (em gramas) de embriões de galinhas e 
                                 idade (em dias) desses embriões"),
                              h6(strong("Variáveis:")),
                              h6(em("Variável independente (X):"), "Idade"),
                              h6(em("Variável dependente (Y):"), "Peso"),
                              h5(strong("Atenção:")),
                              h6("Teste para homogeneidade (Bartlett) não válido para os dados,
                                 pois  variável independente (X) não possui mais de uma observação igual")
                            
                            )
                 
                 
                     ),
              
               mainPanel(
                 tabsetPanel(
                   tabPanel("Dados", icon = icon("server"),
                            dataTableOutput("printdata"),
                            h5(strong("Summary")),
                            h6("Algumas estatísticas descritivas como os valores mínimos e 
                               máximos, 1º e 3º quartis, média e mediana podem ser observados abaixo"),
                            verbatimTextOutput("sum")),
                   
                   tabPanel("Regressão", icon = icon("chart-line"),
                            h5(strong("Reta Ajustada")),
                            plotOutput("plot1",height = 400, width=600),
                            h5(strong("Ajuste do modelo")),
                            verbatimTextOutput("modelor"),
                            h5(strong("Análise de variância (ANOVA)")),
                            h6("O modelo é significativo quando apresenta um p < 0.05"),
                            verbatimTextOutput("anov")),
                   
                   tabPanel("Diagnóstico", icon = icon("laptop-medical"),
                            plotOutput("plote")),
                   
                   tabPanel("Testes", icon = icon("lightbulb"),
                            h5(strong("Teste para normalidade (Shapiro-Wilk)")),
                            h6("O dados atendem ao pressuposto de normalidade quando p > 0.05"),
                            verbatimTextOutput("normal"),
                            h5(strong("Teste para independência (Durbin-Watson)")),
                            h6("O dados atendem ao pressuposto de independência quando p > 0.05"),
                            verbatimTextOutput("indep"),
                            h5(strong("Teste para homogeneidade (Bartlett)")),
                            h6("O dados atendem ao pressuposto de homogeneidade quando p > 0.05"),
                            verbatimTextOutput("homo")
                   
                 )
                 
               )
                            

             )
             
 )
)
))
   
