library(shiny)
library(shinyWidgets)
library(ggplot2)
library(plotly)
library(dplyr)
library(DT)

shinyServer(function(input,output)({
  
  country<-reactive({as.numeric(input$country)})
  scountry<-reactive({as.numeric(input$scountry)})
  pass<-reactive({input$pass})
  shot<-reactive({input$shot})
  pcountry<-reactive({input$pcountry})
  
  
  
  
  output$posstable<-renderDT({data[country(),c(1,4)]})
  
  #output$possplot<-renderPlot({ggplot(data, aes(x=team,y=possession,fill=team))+geom_bar(stat="identity")+coord_flip()+xlab("Team")+ylab("Average Possession")})
  
  output$splot<-renderPlotly({plot_ly(data=data,x=~team,y=~possession,type='bar',text=~team)})
  
  output$summarytable<-renderDT({data[scountry(),c(1,3,4,5,7,9,10,14,15)]})
  
  passing<-data%>%select(team,passes,passes_pct,passes_short,passes_long,passes_pct_long,passes_into_final_third,passes_into_penalty_area,progressive_passes)
  passing<-rename(passing,"Country"=team, "Passes Attempted"=passes, "Pass Completion"=passes_pct, "Short Passes Attempted"=passes_short, "Long Passes Attempted"=passes_long, "Long Pass Completion"=passes_pct_long,"Passes into Final Third"=passes_into_final_third,"Passes into Penalty Area"=passes_into_penalty_area,"Progressive Passes"=progressive_passes)
  passing$"Passes per game"<-passing$`Passes Attempted`/as.numeric(data$games)
  passing$"Progressive Passes per game"<-passing$`Progressive Passes`/as.numeric(data$games)
  
  output$passtable<-DT::renderDataTable({passing[,input$pass]})
  observeEvent(input$pass,{output$passtable<-DT::renderDataTable({passing[,input$pass]})})
  
  output$scatterplot<-renderPlotly({plot_ly(passing, x=~passing$`Passes Attempted`,y=~passing$`Progressive Passes`,type = "scatter",text=~Country)%>%layout(xaxis=list(title="Passes Attempted"))})
  
  output$shotable<-renderDT({datatable(data[shot(),c(1,71,72,73,74,75,76,77)])})
  
  plagen<-rename(plagen, Player=player,Position=position,Country=team,Age=age,Club=club, "Games Played"=games,"Minutes Played"=minutes, Goals=goals,Assists=assists,"Yellow Cards"=cards_yellow,"Red Cards"=cards_red)
 output$pstats<- DT::renderDataTable({plagen[plagen$Country==input$pcountry,c(1,2,3,4,5,7,9,11,12,16,17)]})
 observeEvent(input$pcountry,{output$pstats<-DT::renderDataTable({plagen[plagen$Country==input$pcountry,c(1,2,3,4,5,7,9,11,12,16,17)]}) })
  

  
  
}
  
)
  
)




























