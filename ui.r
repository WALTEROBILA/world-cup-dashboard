library(shiny)
library(shinyWidgets)
library(ggplot2)
library(plotly)
library(DT)
library(shinythemes)

library(readr)
data<- read_csv("team_data.csv")
plagen<-read_csv("player_stats.csv")

data$games<-format(data$games,big.mark = ",", digits = 1 ,scientific = FALSE,trim = TRUE)

shinyUI(fluidPage(theme=shinytheme("cerulean"),
                  tags$style(HTML("
    th {
      color: white;
      background-color: #333;
    }
  ")),
                  setBackgroundImage(src = "https://media.gettyimages.com/id/1388594162/photo/fifa-in-doha-march-30-2022.jpg?s=612x612&w=gi&k=20&c=KtvBiFWGlVk7Hkt5Ox5iaRXj66CXR7lbNHMwYfb1ThY="),
                  
  titlePanel(h2(strong("2022 FIFA WORLD CUP DASHBOARD"),style="text-align:center;font-size:26pt;")),
  
  
    mainPanel(
      tabsetPanel(
        type = "tabs",
       
        
          tabPanel(h2(strong("OVERALL SUMMARY"),style="font-size:12pt;"),
                 sidebarPanel(
                   pickerInput("scountry","Select Country", choices = c("Argentina"=1,"Australia"=2,"Belgium"=3,"Brazil"=4,"Cameroon"=5,"Canada"=6,"Costa Rica"=7,"Croatia"=8,
                                                                       "Denmark"=9,"Ecuador"=10,"England"=11,"France"=12,"Germany"=13,"Ghana"=14,"Iran"=15,"Japan"=16,"Korea Republic"=17,
                                                                       "Mexico"=18,"Morocco"=19,"Netherlands"=20,"Poland"=21,"Portugal"=22,"Qatar"=23,"Saudi Arabia"=24,"Senegal"=25,
                                                                       "Serbia"=26,"Spain"=27,"Switzerland"=28,"Tunisia"=29,"United States"=30,"Uruguay"=31,"Wales"=32),multiple = T,
                               options = list("actions-box"=TRUE),selected = c(1:32))
                 ),DTOutput("summarytable")),
           tabPanel(h2(strong("PASSING"),style="font-size:12pt;"), sidebarPanel(pickerInput("pass","Select Passing Statistics To View", choices = names(passing),multiple = T,options = list("actions-box"=TRUE))),
                                            br(),
                                            br(),
                                            br(),
                                          br(),
                                            br(),
                                            br(),
                                            
                    DTOutput("passtable"),br(),br(),br(),br(),br(),br(), column(8,plotlyOutput("scatterplot"))),
        
           tabPanel(h2(strong("SHOOTING"),style="font-size:12pt;"), sidebarPanel(pickerInput("shot","Select Country",choices = c("Argentina"=1,"Australia"=2,"Belgium"=3,"Brazil"=4,"Cameroon"=5,"Canada"=6,"Costa Rica"=7,"Croatia"=8,
                                                                                             "Denmark"=9,"Ecuador"=10,"England"=11,"France"=12,"Germany"=13,"Ghana"=14,"Iran"=15,"Japan"=16,"Korea Republic"=17,
                                                                                             "Mexico"=18,"Morocco"=19,"Netherlands"=20,"Poland"=21,"Portugal"=22,"Qatar"=23,"Saudi Arabia"=24,"Senegal"=25,
                                                                                             "Serbia"=26,"Spain"=27,"Switzerland"=28,"Tunisia"=29,"United States"=30,"Uruguay"=31,"Wales"=32),multiple = T,
                                                         options = list("actions-box"=TRUE),selected = c(1:32))),DTOutput("shotable")),
        
        tabPanel(h2(strong("POSSESSION"),style="font-size:12pt;"),sidebarPanel(
          pickerInput("country","Select Country", choices = c("Argentina"=1,"Australia"=2,"Belgium"=3,"Brazil"=4,"Cameroon"=5,"Canada"=6,"Costa Rica"=7,"Croatia"=8,
                                                              "Denmark"=9,"Ecuador"=10,"England"=11,"France"=12,"Germany"=13,"Ghana"=14,"Iran"=15,"Japan"=16,"Korea Republic"=17,
                                                              "Mexico"=18,"Morocco"=19,"Netherlands"=20,"Poland"=21,"Portugal"=22,"Qatar"=23,"Saudi Arabia"=24,"Senegal"=25,
                                                              "Serbia"=26,"Spain"=27,"Switzerland"=28,"Tunisia"=29,"United States"=30,"Uruguay"=31,"Wales"=32),multiple = T,
                      options = list("actions-box"=TRUE))),DTOutput("posstable"),plotlyOutput("splot", height = 500,width = 800)),
        
        tabPanel(h2(strong("INDIVIDUAL STATISTICS"),style="font-size:12pt;"),sidebarPanel(
          pickerInput("pcountry","Select Country", choices = unique(plagen$team),multiple = TRUE,
                                                          options = list("actions-box"=TRUE)),selected=NULL) ,DTOutput("pstats")),
        
        
       
        


      
        )
    )
  )
)




































