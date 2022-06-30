#
# This is the server logic of a Shiny web application that generate the AMU report. You can run the
# application by clicking 'Run App' above.
#


library(shiny)
library(htmltools)
library(dplyr)
library(plotly)

#organize dataset

max <- read.csv("data/max.csv")
min <- read.csv("data/min.csv")
alim <-read.csv("data/Alim.csv")


min$Year <- factor(min$Year)
min$Année <- factor(min$Year)

max$Year <- factor(max$Year)
max$Route <- factor(max$Route)
#Rename Route
max$Route <- ifelse(max$Route=="IM_L", "IMM-Lactation",
                    ifelse(max$Route=="IM_T", "IMM-Tarissement",
                           ifelse(max$Route=="INJ", "Injectable", 
                                  ifelse(max$Route=="IU", "IU", 
                                         ifelse(max$Route=="ORAL", "PO", "Topique")))))



# Define server logic required to draw figures
shinyServer(function(input, output) {

  #Add the table with antb in feed
  colnames(alim)= c("Antibiotique", "2017", "2018", "2019", "2020")
  output$table_alim <- renderTable(alim, 
                                   digits=1
                                   )
  
  
  ###########
  # PANEL 3 #
  ###########
 
  # 1 reactive to identify the variable (DDD or DCD) to plot 
  variable <- reactive({
    if ( 1 %in% input$Indice_tot) return(min$total_DCD)
    if ( 2 %in% input$Indice_tot) return(min$total_DDD)
  })
  
  # 1 reactive to change the label of title and yaxis
  ylabel <- reactive({
    if ( 1 %in% input$Indice_tot) return("traitement complet")
    if ( 2 %in% input$Indice_tot) return("dose-jour")
  })
  
  output$TotalPlot <- renderPlotly({
    min%>%
      plot_ly(
        y = ~variable(),
        split = ~Year,
        type = 'violin',
        box = list(
          visible = T
        ),
        meanline = list(
          visible = T
        ),
        spanmode="hard"
      )%>%
      layout(title = paste0("Utilisation totale en ", ylabel()), 
             yaxis = list(title = paste0(ylabel(), "/100 animaux-année"),
                          hoverformat = '.0f',  
                          #range = list(0, 900),
                          zeroline = TRUE), 
             showlegend = FALSE
       )
    
  })

  ###################
  # PANEL 4        #
  ################### 
  variable2 <- reactive({
    if ( 1 %in% input$Indice_route) return(max$total_DCD)
    if ( 2 %in% input$Indice_route) return(max$total_DDD)
  })
  
  ylabel2 <- reactive({
    if ( 1 %in% input$Indice_route) return("traitement complet")
    if ( 2 %in% input$Indice_route) return("dose-jour")
  }) 

  #1 additional reactive to adjust limits of the y axis  
  yrange2 <- reactive({
    if ( 1 %in% input$Indice_route) return(550)
    if ( 2 %in% input$Indice_route) return(1600)
  })
  
  output$RoutePlot <- renderPlotly({
    plot_ly(max, 
            x = ~Route, 
            y = ~variable2(), 
            color = ~Year, 
            type = "box",
            marker=list(color="white"))%>% 
      layout(boxmode="group",
             title = paste0("Utilisation par voie d'administration en ", ylabel2()), 
             yaxis = list(title = paste0(ylabel2(), "/100 animaux-année"),
                          hoverformat = '.1f',  
                          range = list(0, paste0(yrange2()))), 
             xaxis = list(title = "Voie d'administration"),
             legend= list(x = 0.2, 
                          y = 0.95, 
                          orientation="h"))
    
  })
  
  
  
  ###################
  # PANEL 5        #
  ################### 
 
  # 1 reactive for all three plots to fix the title and y axis labels
     ylabel3 <- reactive({
    if ( 1 %in% input$Indice_cat) return("traitement complet")
    if ( 2 %in% input$Indice_cat) return("dose-jour")
  })  
  
  #1 reactive for all three plots to adjust limits of the y axis (so we have the same y range for all plots)  
  yrange3 <- reactive({
    if ( 1 %in% input$Indice_cat) return(1500)
    if ( 2 %in% input$Indice_cat) return(8000)
  })
 
   ####  Cat 1   ####
  # 1 reactive per plot to fix the variable (DCD or DDD) to be plotted
   variable3 <- reactive({
    if ( 1 %in% input$Indice_cat) return(min$cat1_DCD)
    if ( 2 %in% input$Indice_cat) return(min$cat1_DDD)
  })
  
  output$Cat1Plot <- renderPlotly({
      plot_ly(min,
        y = ~variable3(),
        split = ~Year,
        type = 'violin',
        box = list(
          visible = T
        ),
        meanline = list(
          visible = T
        ),
        spanmode="hard"
      )%>%
      layout(title = paste0("Utilisation des catégories I en ", ylabel3()), 
             yaxis = list(title = paste0(ylabel3(), "/100 animaux-année"),
                          hoverformat = '.0f',  
                          range = list(0, paste0(yrange3()))),
                          zeroline = TRUE, 
             showlegend = FALSE
        
      )
    
  })
  
  ####  Cat 2   ####
  variable4 <- reactive({
    if ( 1 %in% input$Indice_cat) return(min$cat2_DCD)
    if ( 2 %in% input$Indice_cat) return(min$cat2_DDD)
  })
  

  output$Cat2Plot <- renderPlotly({
    plot_ly(min,
            y = ~variable4(),
            split = ~Year,
            type = 'violin',
            box = list(
              visible = T
            ),
            meanline = list(
              visible = T
            ),
            spanmode="hard"
    )%>%
      layout(title = paste0("Utilisation des catégories II en ", ylabel3()), 
             yaxis = list(title = paste0(ylabel3(), "/100 animaux-année"),
                          hoverformat = '.0f',  
                          range = list(0, paste0(yrange3()))),
                          zeroline = TRUE, 
             showlegend = FALSE
             
      )
    
  })  
  
  ####  Cat 3   ####
  variable5 <- reactive({
    if ( 1 %in% input$Indice_cat) return(min$cat3_DCD)
    if ( 2 %in% input$Indice_cat) return(min$cat3_DDD)
  })
  
  output$Cat3Plot <- renderPlotly({
    plot_ly(min,
            y = ~variable5(),
            split = ~Year,
            type = 'violin',
            box = list(
              visible = T
            ),
            meanline = list(
              visible = T
            ),
            spanmode="hard"
    )%>%
      layout(title = paste0("Utilisation des catégories III en ", ylabel3()), 
             yaxis = list(title = paste0(ylabel3(), "/100 animaux-année"),
                          hoverformat = '.0f',  
                          range = list(0, paste0(yrange3()))),
                          zeroline = TRUE, 
             showlegend = FALSE
             
      )
    
  })  

  ###################
  # PANEL 6        #
  ################### 
  
  # 1 additional reactive to adjust limits of the y axis (same for all plots)  
  yrange6 <- reactive({
    if ( 1 %in% input$Indice_fam) return(450)
    if ( 2 %in% input$Indice_fam) return(1500)
  })
  
  # 1 reactive for plot's labels (same for all plots)
  ylabel6 <- reactive({
    if ( 1 %in% input$Indice_fam) return("traitement complet")
    if ( 2 %in% input$Indice_fam) return("dose-jour")
  }) 

  ###############
  ###  CAT 1  ###
  ###############
  # We will need 1 reactive per antimicrobial family 
  variable_TG <- reactive({
    if ( 1 %in% input$Indice_fam) return(min$TGCeph_DCD)
    if ( 2 %in% input$Indice_fam) return(min$TGCeph_DDD)
  })
  variable_FL <- reactive({
    if ( 1 %in% input$Indice_fam) return(min$Fluoro_DCD)
    if ( 2 %in% input$Indice_fam) return(min$Fluoro_DDD)
  })
  variable_PO <- reactive({
    if ( 1 %in% input$Indice_fam) return(min$Poly_DCD)
    if ( 2 %in% input$Indice_fam) return(min$Poly_DDD)
  })
  
  output$Fam1Plot <- renderPlotly({
    plot_ly(min,
            x = ~Année,
            y = ~variable_TG() , 
            type = 'box', 
            name="Céphalosporines de 3ème gén.",
            marker=list(color="white")
            )%>% add_trace(min,
                             x = ~Année,
                             y = ~variable_FL() ,
                             type = 'box', 
                             name="Fluoroquinolones",
                             marker=list(color="white"))%>% 
                              add_trace(min,
                              x = ~Année,
                              y = ~variable_PO(),
                              type = 'box', 
                               name="Polymyxines",
                              marker=list(color="white")
                               )%>%
      layout(boxmode="group",
             title = paste0("Utilisation des catégories I en ", ylabel6()), 
             yaxis = list(title = paste0(ylabel6(), "/100 animaux-année"),
                          hoverformat = '.1f',  
                          range = list(0, paste0(yrange6()))),
             legend= list(x = 0.1, 
                          y = 0.95, 
                          orientation="h")
             )
  })
      
    ###############
    ###  CAT 2  ###
    ###############
    # We will need 1 reactive per antimicrobial family 
    variable_SP <- reactive({
      if ( 1 %in% input$Indice_fam) return(min$BLSensPen_DCD)
      if ( 2 %in% input$Indice_fam) return(min$BLSensPen_DDD)
    })
    variable_AM <- reactive({
      if ( 1 %in% input$Indice_fam) return(min$Amin_DCD)
      if ( 2 %in% input$Indice_fam) return(min$Amin_DDD)
    })
    variable_FG <- reactive({
      if ( 1 %in% input$Indice_fam) return(min$FGCeph_DCD)
      if ( 2 %in% input$Indice_fam) return(min$FGCeph_DDD)
    })
    variable_LI <- reactive({
      if ( 1 %in% input$Indice_fam) return(min$Linco_DCD)
      if ( 2 %in% input$Indice_fam) return(min$Linco_DDD)
    })
    variable_RP <- reactive({
      if ( 1 %in% input$Indice_fam) return(min$BLResPen_DCD)
      if ( 2 %in% input$Indice_fam) return(min$BLResPen_DDD)
    })
    variable_TM <- reactive({
      if ( 1 %in% input$Indice_fam) return(min$TMS_DCD)
      if ( 2 %in% input$Indice_fam) return(min$TMS_DDD)
    })
    variable_MA <- reactive({
      if ( 1 %in% input$Indice_fam) return(min$Macr_DCD)
      if ( 2 %in% input$Indice_fam) return(min$Macr_DDD)
    })
    variable_ES <- reactive({
      if ( 1 %in% input$Indice_fam) return(min$PenES_DCD)
      if ( 2 %in% input$Indice_fam) return(min$PenES_DDD)
    })
    
    output$Fam2Plot <- renderPlotly({
      plot_ly(min,
              x = ~Année,
              y = ~variable_SP() , 
              type = 'box', 
              name="Pen. sens. aux beta-lact.",
              marker=list(color="white")
      )%>%
        add_trace(min,
                  x = ~Année,
                  y = ~variable_RP(),
                  type = 'box', 
                  name="Pen. résist. aux beta-lact.",
                  marker=list(color="white")
        )%>%
        add_trace(min,
                  x = ~Année,
                  y = ~variable_ES(),
                  type = 'box', 
                  name="Pen. à spectre étendu",
                  marker=list(color="white")
        )%>% add_trace(min,
                     x = ~Année,
                     y = ~variable_AM() ,
                     type = 'box', 
                     name="Aminoglycosides",
                     marker=list(color="white"))%>% 
        add_trace(min,
                  x = ~Année,
                  y = ~variable_FG(),
                  type = 'box', 
                  name="Céphalosporines de 1ère gén.",
                  marker=list(color="white")
        )%>%
        add_trace(min,
                      x = ~Année,
                      y = ~variable_LI(),
                      type = 'box', 
                      name="Lincosamides",
                      marker=list(color="white")
        )%>%
        add_trace(min,
                  x = ~Année,
                  y = ~variable_TM(),
                  type = 'box', 
                  name="Trimethoprim-sulfonamides",
                  marker=list(color="white")
        )%>%
        add_trace(min,
                  x = ~Année,
                  y = ~variable_MA(),
                  type = 'box', 
                  name="Macrolides",
                  marker=list(color="white")
        )%>%
        
        layout(boxmode="group",
               title = paste0("Utilisation des catégories II en ", ylabel6()), 
               yaxis = list(title = paste0(ylabel6(), "/100 animaux-année"),
                            hoverformat = '.1f',  
                            range = list(0, paste0(yrange6()))),
               legend= list(x = 0.1, 
                            y = 0.95, 
                            orientation="h")
               )
    
  })  
    
    ###############
    ###  CAT 3  ###
    ###############
    # We will need 1 reactive per antimicrobial family 
    variable_TE <- reactive({
      if ( 1 %in% input$Indice_fam) return(min$Tetr_DCD)
      if ( 2 %in% input$Indice_fam) return(min$Tetr_DDD)
    })
    variable_SU <- reactive({
      if ( 1 %in% input$Indice_fam) return(min$Sulf_DCD)
      if ( 2 %in% input$Indice_fam) return(min$Sulf_DDD)
    })
    variable_AMP <- reactive({
      if ( 1 %in% input$Indice_fam) return(min$Amph_DCD)
      if ( 2 %in% input$Indice_fam) return(min$Amph_DDD)
    })
    
    output$Fam3Plot <- renderPlotly({
      plot_ly(min,
              x = ~Année,
              y = ~variable_TE() , 
              type = 'box', 
              name="Tétracyclines",
              marker=list(color="white")
      )%>% add_trace(min,
                     x = ~Année,
                     y = ~variable_SU() ,
                     type = 'box', 
                     name="Sulfonamides",
                     marker=list(color="white"))%>% 
        add_trace(min,
                  x = ~Année,
                  y = ~variable_AMP(),
                  type = 'box', 
                  name="Amphénicols",
                  marker=list(color="white")
        )%>%
        layout(boxmode="group",
               title = paste0("Utilisation des catégories III en ", ylabel6()), 
               yaxis = list(title = paste0(ylabel6(), "/100 animaux-année"),
                            hoverformat = '.1f',  
                            range = list(0, paste0(yrange6()))),
               legend= list(x = 0.1, 
                            y = 0.95, 
                            orientation="h")
        )
    })
 
})
