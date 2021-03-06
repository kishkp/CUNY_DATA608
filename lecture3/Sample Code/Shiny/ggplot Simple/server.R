library(ggplot2)
library(dplyr)

df <- read.csv('https://raw.githubusercontent.com/charleyferrari/CUNY_DATA608/master/lecture3/Sample%20Code/hpi.csv')
df$DATE <- as.POSIXct(strptime(df$DATE, format = '%m/%d/%y'))

function(input, output, session) {
  
  output$plot1 <- renderPlot({
    
    dfSlice <- df %>%
      filter(Seasonality == input$seas, Metro == input$metro)
    
    ggplot(dfSlice, aes(x = DATE, y = HPI, color = Tier)) +
      geom_line()
  })
  
  output$stats <- renderPrint({
    dfSlice <- df %>%
      filter(Seasonality == input$seas, Metro == input$metro, Tier == input$tier)
    
    summary(dfSlice$HPI)
  })
  
}