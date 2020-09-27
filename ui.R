library(shiny)


# Load Data

DF <- read.csv("president-1976-2016.csv")
head(DF)
DEM <- DF[DF$party == "democrat",]
GOP <- DF[DF$party == "republican",]

DEM$rate = DEM$candidatevotes/DEM$totalvotes
GOP$rate = GOP$candidatevotes/GOP$totalvotes
head(DEM)
Election <- rbind(DEM, GOP)
State_list <- unique(Election$state)
Year_list <- unique(Election$year)

# Use a fluid Bootstrap layout 
fluidPage(     
        
        # Give the page a title 
        titlePanel("Election Year Trendings"), 
        
        # Generate a row with a sidebar 
        sidebarLayout(       
                
                
                # Define the sidebar with one input 
                sidebarPanel(p(strong("Documentation:",style="color:red"), a("User Help Page",href="https://rpubs.com/dora_dongying/667016")), 
                             selectInput("State", "State:",  
                                         choices = State_list), 
                             hr(), 
                             selectInput("Year", "Year:",  
                                         choices = Year_list), 
                             helpText("Select a state to see the election year trending there.\n
                                      Select a year to see the results in that year.") 
                ), 
                
                # Create a spot for the barplot 
                mainPanel( 
                        plotOutput("trending"),
                        plotOutput("result") 
                ) 
                
        ) 
) 