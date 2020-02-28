tabPanel(title = "Single Gene Analysis",
        
    sidebarLayout(
        
        sidebarPanel(
            
            helpText("Analyis and visualization of RNA expression"),
            
            ## select gene to group by
            selectizeInput(inputId = "gene",
                           label = "Gene",
                           choices = gene,
                           options = list(
                               placeholder = 'Please select an option below',
                               onInitialize = I('function() { this.setValue(""); }')
                           )
            ),
            
            conditionalPanel(condition="input.tabselected==1",   # sidebar panel for when anova tab is selected
                             
                             ## select variable to group by
                             selectizeInput(inputId = "grouping",
                                            label = "Select variable to analyze",
                                            choices = NULL,
                                            selected = NULL,
                                            options = list(
                                                placeholder = 'Please select an option below',
                                                onInitialize = I('function() { this.setValue(""); }')
                                            )
                             ),
                             
                             ## select dataset to analyze
                             selectizeInput("dataset",
                                            label = "Select a dataset", 
                                            choices = NULL,
                                            selected = NULL,
                                            options = list(
                                                placeholder = 'Please select an option below',
                                                onInitialize = I('function() { this.setValue(""); }')
                                            )
                             )
            ),
            
            conditionalPanel(condition="input.tabselected==2",   # sidebar panel for when correlation tab is selected
                             
                             ## select a gene for pairwise correlation
                             selectizeInput(inputId = "gene2",
                                            label = "Gene",
                                            choices = gene,
                                            options = list(
                                                placeholder = 'Please select an option below',
                                                onInitialize = I('function() { this.setValue(""); }')
                                            )
                             ),
                             
                             ## select dataset to analyze
                             selectizeInput(inputId = "dataset_correlation",
                                            label = "Select a dataset", 
                                            choices = NULL,
                                            selected = NULL,
                                            options = list(
                                                placeholder = 'Please select an option below',
                                                onInitialize = I('function() { this.setValue(""); }')
                                            )
                             )
            )
        ),
        
        ## main panel for display
        mainPanel(
            
            ## tabs to display
            tabsetPanel(type = "tabs",
                        
                        tabPanel(title = "Anova",             ## create tab for Anova visuals
                                 value = 1,
                                 plotlyOutput("graph"), 
                                 
                                 ## horizonal line
                                 hr(),
                                 
                                 ## put the following on the same row
                                 fluidRow(
                                     
                                     ## create space for summary table
                                     column(4,
                                            "Summary of Expression",
                                            tableOutput("summary")
                                            
                                     ),
                                     
                                     ## create space for anova results
                                     column(4,
                                            "Anova",
                                            tableOutput("anova")
                                            
                                     ),
                                     
                                     # create space for tukey results
                                     column(4,
                                            "Tukey HSD",
                                            tableOutput("tukey")
                                            
                                     )
                                 )
                        ),
                        tabPanel("Correlation", 
                                 value = 2,
                                 plotlyOutput("correlation_plot")
                        ),
                        id = "tabselected"                   ## id for these tabpanel values
            )
        ),
        position = "left",
        fluid = TRUE
    )
) 