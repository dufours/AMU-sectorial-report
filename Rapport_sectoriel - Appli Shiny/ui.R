#
# This is the user-interface definition of a Shiny web application that generates the AMU report. You can
# run the application by clicking 'Run App' above.
#

library(shiny)
library(plotly)

# Define UI for application that draws the AMU report
shinyUI(fluidPage(# Application title
  titlePanel(h2(tags$b("Prototype de rapport sectoriel bovin laitier sur l'utilisation des antimicrobiens"),
                br(),
                br(),
                a(href = "https://simon-dufour.shinyapps.io/Rapport_AMU_laitier_EN/", "English"),
                br(),
                br()
                )),
  
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
                rapport tel qu'il pourrait être produit à l'aide de ce genre de données.", style= "color:red"),
              
              "Pour des enquêtes utilisant des données réelles, les lecteurs sont plutôt invités à consulter les articles de " ,
              a(href = "https://www.sciencedirect.com/science/article/pii/S0022030220309930?via%3Dihub", "(Lardé et al., 2021c)"),
              "et de ",
              a(href = "https://onlinelibrary.wiley.com/doi/10.1111/zph.12929", "(Millar et al., 2022)."),
              
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
                tags$li("Ahmad Albaaj", style = "font-size:20px"),
                tags$li("Miguel Sautié Castellanos", style = "font-size:20px")
              )
            )
          )
        ),
        
        fluidRow(
          column(width = 2),
          column(width = 4, tags$img(src = "UdeM_monde.png", width = "600")),
          column(width = 1),
          column(width = 4, tags$img(src = "cercl.png", height = "250")),
          column(width = 1)
        ),
        fluidRow(
          column(width = 2),
          column(width = 4, tags$img(src = "vetexpert.png", width = "400")),
          column(width = 1),
          column(width = 4, tags$img(src = "quebec.jpg", width = "400")),
          column(width = 2)
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
                   p("On note une certaine réduction de même qu'une homogénisation des taux d'utilisation 
                     des antibiotiques pour les années 2019 et 2020. En effet, en 2016, 2017 et 2018, 
                     les taux d'utilisation des antibiotiques semblaient légèrement plus élevés (médiane variant de 222 
                     à 280 pour 2016 à 2018 vs. 206 à 199 traitements complets/100 animaux-année pour 2019 et 2020). 
                     L'étendue interquartile en 2016, 2017 et 2018 était de 250, 272 et 265 traitements complets/
                     100 animaux-année, respectivement. En comparaison, l'étendue interquartile était de 107 et 120 
                     traitements complets/100 animaux-année pour les années 2019 et 2020, respectivement. Les taux
                     d'utilisation des antibiotiques semblaient donc beaucoup plus variables, d'un troupeau à 
                     l'autre en 2016, 2017 et 2018 et ces taux d'utilisation seraient ensuite devenus plus 
                     homogènes en 2019 et 2020.",
                     style = "font-size:20px"
                   ),
                   p("Ces changements dans les taux d'utilisation des antibiotiques semblent moins apparents lorsque 
                     les taux sont raportés en dose-jour/100 animaux-année. Cependant, il s'agit principalement 
                     d'un artefact causé par l'échelle de la figure. En inspectant les médianes et en réduisant
                      l'axe des Y de la figure, on note les mêmes tendances.",
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
          
          column(width = 9,
                 h2(tags$b("Antibiotiques administrés par voies intra-mammaire, injectable, intra-utérine, orale ou topique")),
                 br(),
                 plotlyOutput("RoutePlot"),
                 br(),
                 p(
                   "La voie d'administration la plus utilisée étaient la voie intra-mammaire.
                   Lorsque mesuré en traitements complets, les traitements intra-mammaires durant 
                   la lactation (traitements pour la mammite clinique) étaient les plus fréquents. 
                   Cependant, étant donné leur plus longue durée d'action, les traitements 
                   intra-mammaires au tarissement représentaient la part la plus grande des traitements
                   antibiotiques lorsque ceux-ci étaient rapportés en doses journalières.",
                   style = "font-size:20px"
                 ),
                 p(
                   "On note une réduction importante du nombre de traitements complets des antibiotiques
                   intra-mammaires durant la lactation en 2019 et 2020, comparativement aux 
                   années 2016 à 2018. En effet, les taux d'utilisation médians de ces antibiotiques 
                   variaient de 72 à 115 traitements complets/100 animaux-année entre 2016 et 2018, 
                   alors que ces taux médians étaient de 65, puis 45 traitements complets/100 animaux-année
                   en 2019 et 2020, respectivement. On note également que les taux d'utilisation 
                   de ces antibiotiques étaient plus homogènes d'un troupeau à l'autre pour les 
                   années 2019 et 2020. En effet, des étendues interquartiles supérieures à 
                   200 traitements complets/100 animaux-année étaient observées pour les années 2016 à 
                   2018, alors que celles-ci étaient de 85 et 52 traitements complets/100 animaux-année
                   pour les années 2019 et 2020, respectivement. ",
                   style = "font-size:20px"
                   ),
                 p(
                   "On observe peu de variation d'une année à l'autre dans les taux d'utilisation
                   des antibiotiques administrés par voie intra-mammaire au tarissement, ou par voies
                   injectable, intra-utérine, orale ou topique.",
                   style = "font-size:20px"
                 )
                 ),
          column=(width=1)
           ),
        fluidRow(
          column(width=2),
          column(width=9,
                 h2(tags$b("Antibiotiques dans l'alimentation")),
                 p("L'ajout d'antibiotiques d'importance pour la santé humaine dans les aliments des bovins laitiers est une pratique très marginale au Québec",
                   a(href = "https://www.mdpi.com/2076-2607/9/9/1834/htm", "(Lardé et al., 2021b)."),
                   " Par souçis de simplicité,  nous avons donc simplement rapporté la proportion des élevages de bovins laitiers pour lesquels il y avait une prescription  
                   d'antibiotiques dans l'alimentation pour une année donnée et ce, par agent antimicrobien. Pour ces calculs, les données pour l'année 2016 n'étaient
                   malheureusement pas disponibles.", style = "font-size:20px"),
                 h3(tags$b("Tableau 1."), "Proportion (%) des élevages avec une prescription active."),
                 tableOutput('table_alim'),
                 p("On note que seuls 3 antibiotiques étaient parfois utilisés dans l'alimentation des bovins laitiers. Il s'agissait du monensin, qui était administré dans 21 à 
                 39% des troupeaux. Le lasalocide sodique était également utilisé, mais dans 13 à 17% des troupeaux seulement. Le monensin et le lasalocide sodique sont considérés 
                   par Santé Canada comme étant des antibiotiques de faible importance (catégorie IV) pour la santé humaine ",
                   a(href = "https://www.canada.ca/fr/sante-canada/services/medicaments-produits-sante/medicaments-veterinaires/resistance-antimicrobiens/categorisation-medicaments-antimicrobiens-basee-leur-importance-medecine-humaine.html", "(Santé Canada)."),
                   "Finalement, 1% des troupeaux utilisaient l'oxytétracycline dans l'alimentation de certains groupes d'animaux. 
                   L'oxytétracycline est considérée par Santé Canada comme étant un antibiotique de moyenne importance (catégorie III) pour la santé humaine ",
                   a(href = "https://www.canada.ca/fr/sante-canada/services/medicaments-produits-sante/medicaments-veterinaires/resistance-antimicrobiens/categorisation-medicaments-antimicrobiens-basee-leur-importance-medecine-humaine.html", "(Santé Canada)."),
                   "Ces différentes utilisations variaient peu entre 2016 et 2020.", tags$b("Notez que les données pour l'année 2020 étaient incomplètes. La réduction observée en 2020 est donc possiblement causée par cet artefact.")
                 ),
                 
                 style = "font-size:20px" 
          ),
          column(width=1)
          
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
                   p("Les antibiotiques les plus utlisés étaient ceux de catégorie II-Haute importance. 
                     La majorité des produits vétérinaires antibiotiques homologués pour les bovins font 
                     partie de cette catégorie. En général, on observe peu de variation d'une année à l'autre 
                     dans les taux d'utilisation des antibiotiques de catégorie II-Haute importance et de 
                     catégorie III-Importance moyenne. On note, cependant, des changements importants dans les taux d'utilisation 
                     des antibiotiques de catégorie I-Très haute importance."
                   ),
                   h3(tags$b("Antibiotiques de catégorie I-Très haute importance")),
                   p(
                     "On note une réduction très importante ainsi qu'une homogénisation 
                     des taux d'utilisation des antibiotiques de catégorie I-Très haute importance 
                     en 2019 et 2020, comparativement à la période 2016 à 2018. En effet, les taux médians 
                     d'utilisation de ces antibiotiques étaient de 39, 34 et 47 traitements complets/100 
                     animaux-année en 2016, 2017 et 2018, respectivement, vs. 11 puis 3 traitements 
                     complets/100 animaux-année en 2019 et 2020, respectivement. Cette réduction semble faire suite à la nouvelle réglementation québécoise sur l'utilisation des 
                     antibiotiques de catégorie I-Très haute importance. Cette réduction des 
                     taux d'utilisation a d'ailleurs été étudiée sur un échantillon plus important de troupeaux 
                     laitiers québécois (n=3569) par ",
                     a(href = "https://onlinelibrary.wiley.com/doi/10.1111/zph.12929", "Millar et al. (2022)."),
                   ),
                     
                     
                     h3(tags$b("*Catégorisation des médicaments antimicrobiens basée sur leur importance en médecine humaine" )),
                     p("Les antibiotiques sont catégorisés en 4 catégories (I–Très haute importance, II–Haute importance, III–Importance moyenne et IV–Faible importance) 
                   par Santé Canada en fonction de leur importance pour la santé humaine",
                       a(href = "https://www.canada.ca/fr/sante-canada/services/medicaments-produits-sante/medicaments-veterinaires/resistance-antimicrobiens/categorisation-medicaments-antimicrobiens-basee-leur-importance-medecine-humaine.html", "(Santé Canada)"),
                       ". Les principaux critères de la catégorisation sont l'indication (i.e., la maladie ciblée) et la disponibilité des médicaments antimicrobiens 
                   de remplacement pour le traitement d'infections chez les humains. L'utilisation des antimicrobiens en médecine vétérinaire 
                   n'est pas prise en considération dans cette catégorisation."
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
          ),
          column(width=8, 
                 h2(tags$b("Utilisation par famille d'antibiotique")),
                 br(),
                 h3(tags$b("Antibiotiques de catégorie I-Très haute importance")),
                br(),
                br(),
                plotlyOutput("Fam1Plot"),
                br(),
                p(
            "Les principales familles d'antibiotiques de catégorie I-Très haute importance
            utilisées étaient les Céphalosporines de 3e génération et les Polymyxines. L'utilisation 
            de cette dernière famille d'antibiotiques à cessée en 2019, suite au retrait, par le manufacturier, du seul 
            produit vétérinaire contenant cette famille d'antibiotique. Dans l'échantillon de troupeaux utilisé pour ce rapport, 
            les fluoroquinolones n'ont pas été utilisées durant la période d'observation. En 2020, ",
            
            a(href = "https://pubmed.ncbi.nlm.nih.gov/33272584/", "Lardé et al. "),
            "rapportaient, dans un échantillon de 101 troupeau laitiers québécois suivis 
            en 2017 et 2018, une utilisation très marginale (<1% d'utilisateurs) de cette famille 
            d'antibiotiques.",
            style = "font-size:20px"
          )
        )
        ),
        
        fluidRow(
          column(width=2),
          column(width=8,
          h3(tags$b("Antibiotiques de catégorie II-Haute importance")),
          br(),
          br(),
          plotlyOutput("Fam2Plot"),
          br(),
          
          p("Comme mentionné précédemment, c'est dans cette catégorie d'antibiotiques 
            que nous retrouvons le plus de produits vétérinaires homologués pour les bovins 
            au Canada. Les familles d'antibiotiques les plus utilisées étaient les 
            Penicillines sensibles aux beta-lactames (Benzathine benzylpenicilline, Benzylpenicilline et Procaine benzylpenicilline), 
            les Céphalosporines de 1e génération (Céfapirine), 
            les Penicillines résistantes aux beta-lactames (Ampicilline), 
            ainsi que les Aminoglycosides (Dihydrostreptomycine, Gentamicine, Neomycine et Streptomycine).
             On note une réduction importante des taux d'utilisation de cette dernière famille 
            d'antibiotique en 2019 et 2020. Celle-ci est possiblement expliquée par 
            le retrait, par le manufacturier, d'un produit vétérinaire contenant une 
            Dihydrostreptomycine. On note également, pour plusieurs familles d'antibiotiques,
            des variations temporelles des taux d'utilisation.",
            style = "font-size:20px")
        )
        ),
        
        fluidRow(
          column(width=2),
          column(width=8,
          h3(tags$b("Antibiotiques de catégorie III-Importance moyenne")),
          br(),
          br(),
          plotlyOutput("Fam3Plot"),
          br(),
          
          p("Relativement peu d'antibiotiques de catégorie III-Importance moyenne étaient utilisés. 
            La principale famille d'antibiotique utilisées dans cette catégorie sont 
            les Tétracyclines. On note un réduction de leur utilisation en 2019 et 2020. 
            Cette diminution est probablement due à la discontinuation des produits injectables contenant cet agent antimicrobien durant cette période.",
            style = "font-size:20px")
        )
        ),
        
        fluidRow(
          column(width=2),
          column(width=8,
          h3(tags$b("Tableau 2."), "Classification des agents antimicrobiens utilisés dans les produits à usage vétérinaire au Canada chez les bovins et en fonction de leur importance pour la santé humaine ",
             a(href = "https://www.canada.ca/fr/sante-canada/services/medicaments-produits-sante/medicaments-veterinaires/resistance-antimicrobiens/categorisation-medicaments-antimicrobiens-basee-leur-importance-medecine-humaine.html", "(Santé Canada).")
          ),
          tableOutput('table_famille'),
          style = "font-size:20px"))
        
        
      )
    )
    
  )))