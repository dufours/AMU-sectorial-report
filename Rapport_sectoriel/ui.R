#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.

library(shiny)

# Define UI for application that draws the AMU sectorial report
shinyUI(fluidPage(
  
  # Application title
  titlePanel(  h2("Protoype de rapport sectoriel bovin laitier sur l'utilisation des antibiotiques")), 
                   
  
  
  # Sidebar with a radio button for chosen indicator (DDD vs DCD)
  sidebarLayout(
    sidebarPanel(radioButtons("Indice", label = h3("Choisir l'unité de mesure:"),
                              choices = list("Traitement antibiotique complet/100 animaux-année" = 1, "Dose journalière d'antibiotique/100 animaux-année" = 2), 
                              selected = 1), width=2
                 
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs",
                  
                  tabPanel("À propos",
                            fluidRow(
                             column(width=12,
                                    p("Cette application permet de visualiser la consommation 
                          d'antibiotiques sur les fermes québécoises.
                          Vous pouvez y visualiser les informations pour votre ferme et 
                          vous comparer aux autres fermes du Québec.", style="font-size:25px"), 
                                    br(),
                                    p("Dans l'application l'utilisation des antibiotiques est rapportée en 
                         nombre de traitements complets 'standards'.
                     Un traitement complet 'standard' représente la quantité d'antibiotique
                         nécessaire pour administrer un traitement complet pour un animal donné. 
                         Par exemple, pour un traitement intra-mammaire, si l'étiquette indique:", style="font-size:25px"),
                                    br(),
                                    p("Administrer un tube de 10ml. Répéter une seule fois 24h plus tard.", style="font-size:25px"),
                                    p("Un traitement 'standard' pour ce produit sera alors de 2 tubes de 10ml (ou 20 ml).", style="font-size:25px"),
                                    br(),
                                    p("Ces traitements 'standards'ont été établis en utilisant
                        l'étiquette des produits vétérinaires et en supposant des poids
                        types pour les bovins de différents ages.
                        Ce nombre de traitements complets est ensuite reporté en un taux d'utilisation 
                        pour un troupeau
                        de 100 vaches adultes pour une année, ce qui vous permet de vous comparer aux autres fermes 
                      québécoises. Ils ne représentent cependant pas nécessairement le nombre exact 
                      d'animaux traités sur votre ferme. Pour plus de détails sur ce sujet, voir l'article suivant de 
                         Lardé et collaborateur (2019).", style="font-size:25px"),
                                    a(href="https://www.frontiersin.org/articles/10.3389/fvets.2020.00010/full", 
                                      "Assignment of Canadian Defined Daily Doses and Canadian Defined Course Doses 
                       for Quantification of Antimicrobial Usage in Cattle. Lardé et al. (2019)", style="font-size:25px")
                             )
                           ),
                           
                           
                           fluidRow(
                             column(4, tags$img(src = "UdeM_monde.png", width="500")), column(2, tags$img(src = "cercl.png", height="250")),
                             column(3, tags$img(src = "vetexpert.png", width="400")), column(3, tags$img(src = "quebec.jpg", width="400"))
                             )  
                           
                           ),
                  tabPanel("Données utilisées"),
                  
                  tabPanel("Utilisation globale", htmlOutput("TotalPlot")),
                  tabPanel("Par voie d'administration"),
                  tabPanel("Par catégorie d'antibiotique"),
                  tabPanel("Par famille d'antibiotique"))
                  
      )
    )
  )
)