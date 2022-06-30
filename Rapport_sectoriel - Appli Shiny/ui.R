#
# This is the user-interface definition of a Shiny web application that generates the AMU report. You can
# run the application by clicking 'Run App' above.
#

library(shiny)
library(plotly)

# Define UI for application that draws the AMU report
shinyUI(fluidPage(# Application title
  titlePanel(h2(tags$b("Prototype de rapport sectoriel bovin laitier sur l'utilisation des antimicrobiens"))),
  
  # Organize main panel in multiple tabsetpanels
  mainPanel(width = 12, tabsetPanel(type = "tabs",tabPanel(
        
        ###########
        # PANEL 1 #
        ###########
        titlePanel(h3("À propos")),
        
        fluidRow(
          column(width = 1),
          
          column(width = 10,
            h2(tags$b("Contexte")),
            p(
              "Ce prototype de rapport vise à présenter la distribution du taux d'utilisation des antimicrobiens sur les fermes laitières du Québec et son évolution dans le temps. Des études récentes ont
                démontré l'excellente adéquation entre l'utlisation des antimicrobiens sur les fermes laitières québécoises et les données de ventes vétérinaires ",
              a(href = "https://www.mdpi.com/2076-2607/9/5/1106/htm", "(Lardé et al., 2021a)"),
              "et de prescriptions alimentaires",
              a(href = "https://www.mdpi.com/2076-2607/9/9/1834/htm", "(Lardé et al., 2021b)."),
              "Pour ce prototype de rapport, nous avons donc utilisé les données de ventes vétérinaires et de prescriptions
                alimentaires d'un petit nombre de troupeaux laitiers ayant accepté une telle utilisation de leur données. Ces données ont été extraites du logiciel ",
              a(href = "http://www.vet-expert.com/", "VetExpert"),
              " afin d'estimer l'utilisation des antimicrobiens. ",
              tags$b("Notez que les données disponibles ne couvraient pas complètement la période visée (2016 à 2020) pour ce prototype de rapport et une petite partie
                de ces données ont donc dûes été extrapolées. Il ne s'agit donc pas d'un rapport réel sur l'utilisation des antimicrobiens, mais plutôt d'un exemple de 
                rapport tel qu'il pourrait être produit à l'aide de ce genre de données."),
              style = "font-size:20px"),
            p("Dans le futur, ce prototype de rapport pourrait être appliqué à un plus grand nombre, voir même l'ensemble des troupeaux laitiers du Québec, ou à d'autres types de productions 
              animales et pourrait être mis à jour annuellement.",
              style = "font-size:20px"),
            h2(tags$b("Remerciements")),
            p("Ce prototype de rapport a été préparé par",
              a(href = "https://www.simondufour.ca/", "Simon Dufour"),
              ", professeur à la Faculté de médecine vétérinaire de l'Université de Montréal grâce à un financement du Gouvernement du Québec accordé au ",
              a(href = "https://fmv.umontreal.ca/services/centre-dexpertise-et-de-recherche-clinique-en-sante-et-bien-etre-animal/",
                "Centre d'expertise et de recherche clinique en santé et bien-être animal (CERCL)"),
              "et avec l'appui des collaborateurs suivants:", style = "font-size:20px"),
            
            tags$div(
              class = "header",
              checked = NA,
              list(
                tags$li("Jean-Philippe Roy", style = "font-size:20px"),
                tags$li("David Francoz", style = "font-size:20px"),
                tags$li("Cécile Ferrouillet", style = "font-size:20px"),
                tags$li("Julie Arsenault", style = "font-size:20px"),
                tags$li("Cécile Aenishaenslin", style = "font-size:20px"),
                tags$li("Hélène Lardé", style = "font-size:20px"),
                tags$li("Maud de Lagarde", style = "font-size:20px"),
                tags$li("Nikky Millar", style = "font-size:20px"),
                tags$li("Sébastien Buczinski", style = "font-size:20px"),
                tags$li("Ahmad Albaaj", style = "font-size:20px")
              )
            )
          )
        ),
        
        fluidRow(
          column(width = 1),
          column(width = 3, tags$img(src = "UdeM_monde.png", width = "600")),
          column(width = 2, tags$img(src = "cercl.png", height = "250")),
          column(width = 3, tags$img(src = "vetexpert.png", width = "400")),
          column(width = 2, tags$img(src = "quebec.jpg", width = "400")),
          column(width = 1)
        )
      ),
      
      ###########
      # PANEL 2 #
      ###########
      tabPanel(titlePanel(h3("Données, unités de mesure et figures")),
      fluidRow(
        column(width = 1),
        
        column(width = 10,
          h2(tags$b("Les données")),
          p("Aperçu des données utilisées:", style = "font-size:20px"),
          ###############################################################################################
          # The next lines could be updated in the future to "automate" the writing of the numbers used #
          ###############################################################################################
          tags$div(
            class = "header",
            checked = NA,
            list(
              tags$li("84 troupeaux laitiers", style = "font-size:20px"),
              tags$li("4 années (2016 à 2020)", style = "font-size:20px"),
              tags$li("79 992 lignes de ventes vétérinaires", style = "font-size:20px"),
              tags$li("11 639 (14.6%) lignes de ventes vétérinaires correspondaient à des ventes d'antibiotiques", style ="font-size:20px"),
              tags$li("180 prescriptions alimentaires", style = "font-size:20px")
            )
          ),
          
          h2(tags$b("Les unités de mesure")),
          p("Dans ce rapport l'utilisation des antimicrobiens peut être rapportée en nombre de traitements antibiotiques complets ou en nombre de doses journalières 
          d'antibiotique par 100 animaux-année. Un traitement antibiotique complet représente la quantité d'antibiotique nécessaire pour administrer un traitement 
          complet pour un animal type. Une dose journalière représente la quantité d'antibiotique nécessaire pour traiter un animal type pour une journée."
            , style = "font-size:20px"),
          
          p("Par exemple, pour un traitement intra-mammaire, si l'étiquette indique: administrer un tube de 10ml, répéter une seule fois 24h plus tard.",
             style = "font-size:20px"),
          
          tags$div(
            class = "header",
            checked = NA,
            list(
              tags$li("Le traitement antibiotique complet sera 2 tubes de 10ml (ou 20ml).", style = "font-size:20px"),
              tags$li("La dose journalière d'antibiotique sera alors 1 tube de 10ml", style = "font-size:20px")
            )
          ),
          br(),
          p("Ces indices standardisés ont été établis en utilisant l'étiquette des produits vétérinaires et en supposant des poids types pour les bovins de 
          différents ages. Ce nombre de traitements complets est ensuite reporté en un taux d'utilisation pour un troupeau type de 100 animaux adultes 
          (vaches en lactation et taries) pour une année. Pour plus de détails sur ce sujet, voir l'article de " ,
          a(href = "https://www.frontiersin.org/articles/10.3389/fvets.2020.00010/full", "Lardé et al. (2019)."), style = "font-size:20px"),
          
          h2(tags$b("Les figures")),
          p("Les figures présentées dans les prochaines sections du rapport sont interactives:", style = "font-size:20px"),
          
          tags$div(
            class = "header",
            checked = NA,
            list(
              tags$li("Vous pouvez", tags$b("modifier l'unité de mesure"), " (traitement antibiotique complet vs. dose journalière d'antibiotique) utilisée 
                      pour rapporter les taux d'utilisation des antibiotiques.", style = "font-size:20px"),
              tags$li("En ", tags$b("survolant la figure avec votre souris,"), " différentes statistiques s'afficheront (ex. médiane, moyenne, quartile 1, 
                      quartile 3, minimum, maximum).", style = "font-size:20px"),
              tags$li("Vous pouvez ", tags$b("agrandir une section de la figure en la sélectionnant"), " avec le bouton gauche de votre souris. Un double-clic 
              vous permettra de revenir à la figure originale.", style = "font-size:20px"),
              tags$li("Dans les figures où une légende est présentée, vous pouvez ", tags$b("sélectionner/désélectionner certains des groupes"), " présentés en 
              cliquant sur le symbole correspondant à ce groupe dans la légende.", style = "font-size:20px"),
              tags$li("Vous pouvez ", tags$b("exporter la figure initiale ou la figure que vous avez modifiée"), " en format png en cliquant sur l'onglet 
              photo dans la partie supérieure droite de la figure. Il s'agira alors d'une image statique.", style = "font-size:20px")
            )
          ),
          br(),
          br()
          
        )
      )
      ),
      
      ###########
      # PANEL 3 #
      ###########
      tabPanel(
        titlePanel(h3("Utilisation globale")),
        fluidRow(
          column(width = 2,
          radioButtons(
            "Indice_tot",
            label = h3("Choisir l'unité de mesure:"),
            choices = list(
              "Traitement antibiotique complet" = 1,
              "Dose journalière d'antibiotique" = 2
            ),
            selected = 1
          ),style = "font-size:20px"
        ),
        
        column(width = 9,
               h2(tags$b("Utilisation totale")),
               br(),
               plotlyOutput("TotalPlot"))
        ),
        
        fluidRow(column(width = 2),
                 column(
                   br(),
                   br(),
                   p(
                     "ICI ONT POURRAIT AJOUTER UN COURS TEXTE EXPLIQUANT LES GRANDES LIGNES DE LA FIGURE EN DCD ET DE CELLE EN DDD. LE TEXTE POURRAIT ÊTRE RÉACTIF
                          ET S'AJUSTER À L'UNITÉ DE MESURE CHOISIE.
                            Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum ullam,
                            ratione modi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum
                            ullam, ratione modi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum ullam,
                            ratione modi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum
                            ullam, ratione modi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum ullam,
                            ratione modi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum
                            ullam, ratione modi.",
                     style = "font-size:20px"
                   ),
                   width = 9
                 ))
      ),
      
      
      ###########
      # PANEL 4 #
      ###########
      tabPanel(
        titlePanel(h3("Par voie d'administration")),
        fluidRow(
          column(width = 2,
                 radioButtons(
                   "Indice_route",
                   label = h3("Choisir l'unité de mesure:"),
                   choices = list(
                     "Traitement antibiotique complet" = 1,
                     "Dose journalière d'antibiotique" = 2
                   ),
                   selected = 1
                 ),style = "font-size:20px"
          ),
          
          column(width = 6,
                 h2(tags$b("Antibiotiques courants")),
                 br(),
                 plotlyOutput("RoutePlot"),
                 br(),
                 p(
                   "ICI ONT POURRAIT AJOUTER UN COURS TEXTE EXPLIQUANT LES GRANDES LIGNES DE LA FIGURE EN DCD ET DE CELLE EN DDD. LE TEXTE POURRAIT ÊTRE RÉACTIF
                          ET S'AJUSTER À L'UNITÉ DE MESURE CHOISIE.
                            Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum ullam,
                            ratione modi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum
                            ullam, ratione modi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum ullam,
                            ratione modi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum
                            ullam, ratione modi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum ullam,
                            ratione modi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum
                            ullam, ratione modi.",
                   style = "font-size:20px"
                 )
                 ),
          column(width=1),
          column(width=3,
                 h2(tags$b("Antibiotiques dans l'alimentation")),
                 p("L'ajout d'antibiotiques d'importance pour la santé humaine dans les aliments des bovins laitiers est une pratique très marginale au Québec",
                   a(href = "https://www.mdpi.com/2076-2607/9/9/1834/htm", "(Lardé et al., 2021b)."),
                   " Par souçis de simplicité,  nous avons donc simplement rapporté la proportion des élevages de bovins laitiers pour lesquels il y avait une prescription  
                   d'antibiotiques dans l'alimentation pour une année donnée et ce, par agent antimicrobien. Pour ces calculs, les données pour l'année 2016 n'étaient
                   malheureusement pas disponibles.", style = "font-size:20px"),
                 h3(tags$b("Tableau 1."), "Proportion (%) des élevages avec une prescription active."),
                 tableOutput('table_alim'),
                 p("On note que seul 3 antibiotiques étaient parfois utilisés dans l'alimentation des bovins laitiers. Il s'agissait du monensin, qui était administré dans 21 à 
                 39% des troupeaux. Le lasalocide sodique était également utilisé, mais dans 13 à 17% des troupeaux seulement. Le monensin et le lasalocide sodique sont considérés 
                   par Santé Canada comme étant des antibiotiques de faible importance (catégorie IV) pour la santé humaine ",
                   a(href = "https://www.canada.ca/fr/sante-canada/services/medicaments-produits-sante/medicaments-veterinaires/resistance-antimicrobiens/categorisation-medicaments-antimicrobiens-basee-leur-importance-medecine-humaine.html", "(Santé Canada)."),
                   "Finalement, 1% des troupeaux utilisaient l'oxytétracycline dans l'alimentation de certains groupes d'animaux. 
                   L'oxytétracycline est considérée par Santé Canada comme étant un antibiotique de moyenne importance (catégorie III) pour la santé humaine ",
                   a(href = "https://www.canada.ca/fr/sante-canada/services/medicaments-produits-sante/medicaments-veterinaires/resistance-antimicrobiens/categorisation-medicaments-antimicrobiens-basee-leur-importance-medecine-humaine.html", "(Santé Canada)."),
                   "Ces différentes utilisations variaient peu entre 2017 et 2020."
                    ),
                 
                 style = "font-size:20px" 
                 )
          )
      ),
        
      ###########
      # PANEL 5 #
      ###########
      tabPanel(
        titlePanel(h3("Par catégorie d'antibiotique")),
        fluidRow(
          column(width = 2,
                 radioButtons(
                   "Indice_cat",
                   label = h3("Choisir l'unité de mesure:"),
                   choices = list(
                     "Traitement antibiotique complet" = 1,
                     "Dose journalière d'antibiotique" = 2
                   ),
                   selected = 1
                   )
                 )
          , style = "font-size:20px"
          ),
        fluidRow(h2(tags$b("Utilisation en fonction de l'importance pour la santé humaine*")),
                 br(),
                 column(width = 4,
                        plotlyOutput("Cat1Plot")),
                 column(width = 4,
                        plotlyOutput("Cat2Plot")),
                 column(width = 4,
                        plotlyOutput("Cat3Plot"))
                ),
        fluidRow(column(
                   br(),
                   br(),
                   p(
                     "ICI ONT POURRAIT AJOUTER UN COURS TEXTE EXPLIQUANT LES GRANDES LIGNES DE LA FIGURE EN DCD ET DE CELLE EN DDD. LE TEXTE POURRAIT ÊTRE RÉACTIF
                          ET S'AJUSTER À L'UNITÉ DE MESURE CHOISIE.
                            Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum ullam,
                            ratione modi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum
                            ullam, ratione modi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum ullam,
                            ratione modi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum
                            ullam, ratione modi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum ullam,
                            ratione modi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum
                            ullam, ratione modi.",
                     br(),
                     br(),
                     h3(tags$b("*Catégorisation des médicaments antimicrobiens basée sur leur importance en médecine humaine" )),
                     p("Les antibiotiques sont catégorisés en 4 catégories (I–Très haute importance, II–Haute importance, III–Importance moyenne et IV–Faible importance) 
                   par Santé Canada en fonction de leur importance pour la santé humaine",
                       a(href = "https://www.canada.ca/fr/sante-canada/services/medicaments-produits-sante/medicaments-veterinaires/resistance-antimicrobiens/categorisation-medicaments-antimicrobiens-basee-leur-importance-medecine-humaine.html", "(Santé Canada)"),
                       ". Les principaux critères de la catégorisation sont l'indication (i.e., la maladie ciblée) et la disponibilité des médicaments antimicrobiens 
                   de remplacement pour le traitement d'infections chez les humains. L'utilisation des antimicrobiens en médecine vétérinaire 
                   n'est pas prise en considération dans cette catégorisation."),
                     br()
                   ),
                   style = "font-size:20px",
                   width = 12
                 ))
      ),
      
      
      ###########
      # PANEL 6 #
      ###########
      tabPanel(
        titlePanel(h3("Par famille d'antibiotique")),
        fluidRow(
          column(width = 2,
                 radioButtons(
                   "Indice_fam",
                   label = h3("Choisir l'unité de mesure:"),
                   choices = list(
                     "Traitement antibiotique complet" = 1,
                     "Dose journalière d'antibiotique" = 2
                   ),
                   selected = 1
                 ),style = "font-size:20px"
          )
          
        ),
        fluidRow(h2(tags$b("Utilisation par famille d'antibiotique")),
                 br(),
          column(width = 4,
                 plotlyOutput("Fam1Plot")),
          column(width = 4,
                 plotlyOutput("Fam2Plot")),
          column(width = 4,
                 plotlyOutput("Fam3Plot"))
        ),
        fluidRow(column(
          br(),
          br(),
          p(
            "ICI ONT POURRAIT AJOUTER UN COURS TEXTE EXPLIQUANT LES GRANDES LIGNES DE LA FIGURE EN DCD ET DE CELLE EN DDD. LE TEXTE POURRAIT ÊTRE RÉACTIF
                          ET S'AJUSTER À L'UNITÉ DE MESURE CHOISIE.
                            Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum ullam,
                            ratione modi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum
                            ullam, ratione modi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum ullam,
                            ratione modi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum
                            ullam, ratione modi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum ullam,
                            ratione modi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quidem, optio? Dolore quia velit totam dolorum
                            ullam, ratione modi.",
            style = "font-size:20px"
          ),
          width = 12
        ))
      )
    )
    
  )))