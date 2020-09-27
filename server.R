library(shiny)
library(ggplot2)
library(dplyr)

# Load Data
DF <- read.csv("president-1976-2016.csv")
head(DF)
DEM <- DF[DF$party == "democrat",]
GOP <- DF[DF$party == "republican",]

DEM$rate = DEM$candidatevotes/DEM$totalvotes
GOP$rate = GOP$candidatevotes/GOP$totalvotes
head(DEM)
Election <- rbind(DEM, GOP)


# Define a server for the Shiny app 
function(input, output) { 
        
        # Fill in the spot we created for a plot 
        output$trending <- renderPlot({ 
                
                # Render a barplot 
                Electron_by_state <- Election[Election$state == input$State,]
                title_1 <- paste("Election Year Trendings in ", toString(input$State))
                p <- ggplot(data = Electron_by_state, aes(year, rate, col = party))
                p + geom_line() + geom_point() + 
                        ggtitle(title_1) +
                        xlab("Year") + ylab("Votes Rate")
        })
        
        output$result <- renderPlot({ 
                
                # Render a barplot 
                Electron_by_state <- Election[Election$state == input$State,]
                Electron_by_state_and_year <- Electron_by_state[Electron_by_state$year == input$Year,]
                title_2 <- paste("Election Result in ", toString(input$State), " in ", toString(input$Year))
                g <- ggplot(data = Electron_by_state_and_year, aes(candidate, candidatevotes, fill = party))
                g + geom_bar(stat="identity", width=0.5) + 
                        ggtitle(title_2) +
                        xlab("Party") + ylab("Candidate Votes")
        })
        
}