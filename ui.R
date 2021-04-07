# Header
header <- dashboardHeader(
    title = "Shiny Gasha"
)

# Side_Bar
sidebar <- dashboardSidebar(
    sidebarMenu(
        menuItem(
            text = "Overview",
            tabName = "tab0",
            icon = icon("eye")
        ),
        menuItem(
            text = "Raw Data",
            tabName = "tab1",
            icon = icon("database")
        ),
        menuItem(
            text = "Sales",
            tabName = "tab2",
            icon = icon("dollar-sign")
        ),
        menuItem(
            text = "Product",
            tabName = "tab3",
            icon = icon("shopping-cart")
        ),
        menuItem(
            text = "Payment",
            tabName = "tab4",
            icon = icon("money-bill-wave")
        ),
        menuItem(
            text = "Contact Me",
            tabName = "tab5",
            icon = icon("user")
        )
    )
)

# Body
body <- dashboardBody(
    tabItems(
        tabItem(
            tabName = "tab0",
            fluidRow(
                box(
                    width = 12, 
                    titlePanel("Overview"),
                    p("The growth of supermarkets in most populated cities 
                      are increasing and market competitions are also high. 
                      The dataset is one of the historical sales of 
                      supermarket company which has recorded in 3 different 
                      branches for 3 months data."),
                    titlePanel("Attribute Information"),
                    p("---Information Columns---"),
                    p("City : Location of supercenters"),
                    p("Customer type : Type of customers, recorded by Members 
                      for customers using member card and Normal for without 
                      member card."),
                    p("Gender : Gender type of customer"),
                    p("Product line : General item categorization groups - 
                      Electronic accessories, Fashion accessories, 
                      Food and beverages, Health and beauty, 
                      Home and lifestyle, Sports and travel"),
                    p("Unit price : Price of each product in $"),
                    p("Quantity : Number of products purchased by customer"),
                    p("Total : Total price including tax"),
                    p("Date : Date of purchase (Record available from 
                      January 2019 to March 2019)"),
                    p("Time : Purchase time (10am to 9pm)"),
                    p("Payment : Payment used by customer for purchase 
                      (3 methods are available – 
                      Cash, Credit card and Ewallet)"),
                    p("Rating : Customer stratification rating on 
                      their overall shopping experience 
                      (On a scale of 1 to 10)"),
                    titlePanel("Visualization"),
                    p("---Raw Data Menu---"),
                    p("See raw data table"),
                    p("---Sales Menu---"),
                    p("Visualization 1: Total Sales by Date from each City"),
                    p("Visualization 2: Detail value Average from each City"),
                    p("---Product Menu---"),
                    p("Visualization 1: Top Product Category by Total Sales"),
                    p("Visualization 2: Top Product Category Selling by Gender"),
                    p("Visualization 3: Top Product Category Selling by City"),
                    p("Visualization 4: Top Product Category Selling by Payment Type"),
                    p("---Payment Menu---"),
                    p("Visualization 1: Top Payment Type by Quantity"),
                    p("Visualization 2: Quantity Payment Type based on Hour"),
                    p("Visualization 3: Quantity Payment Type based on Day"),
                    p("---Contact Me---"),
                    p("Contact and Portofolio")
                )
            )
        ),
        tabItem(
            tabName = "tab1",
            fluidRow(
                box(
                    title = "Raw Data",
                    width = 12,
                    dataTableOutput(outputId = "tablerawdata")
                )
            )
        ),
        tabItem(
            tabName = "tab2",
            fluidRow(
                box(
                    title = "Filter Sales Chart",
                    width = 3, 
                    dateRangeInput(inputId = "idsales1", 
                                   label = "Range Date",
                                   start = "2019-01-01",
                                   end = "2019-03-09",
                                   min = "2019-01-01",
                                   max = "2019-03-09")
                ),
                box(
                    title = "Sales Chart",
                    width = 9,
                    plotlyOutput("plotsales")
                )
            ),
            fluidRow(
                box(
                    title = "Detail Sales Average",
                    width = 12,
                    height = 305,
                    radioButtons(inputId = "radio1",
                                 label = "Choose City",
                                 choices = unique(datasales$City), inline = TRUE),
                    valueBoxOutput(outputId = "avg_totalsales", width = 3),
                    valueBoxOutput(outputId = "avg_unit", width = 3),
                    valueBoxOutput(outputId = "avg_quantity", width = 3),
                    valueBoxOutput(outputId = "avg_rating", width = 3)
                ),
            )
        ),
        tabItem(
            tabName = "tab3",
            fluidRow(
                box(
                    title = "Top 6 Product Selling",
                    width = 12,
                    plotlyOutput("plotproduct1")
                )
            ),
            fluidRow(
                box(
                    title = "Product Selling by Gender",
                    width = 4,
                    radioButtons(inputId = "idplotproduct2", 
                                 label = "Gender",
                                 choices = c("Male","Female"),
                                 inline = T),
                    plotlyOutput("plotproduct2")
                ),
                box(
                    title = "Product Selling by City",
                    width = 4,
                    radioButtons(inputId = "idplotproduct3", 
                                 label = "City",
                                 choices = c("Mandalay","Naypyitaw","Yangon"),
                                 inline = T),
                    plotlyOutput("plotproduct3")
                ),
                box(
                    title = "Product Selling by Payment Type",
                    width = 4,
                    radioButtons(inputId = "idplotproduct4", 
                                 label = "Type Payment",
                                 choices = c("Ewallet","Cash","Credit card"),
                                 inline = T),
                    plotlyOutput("plotproduct4")
                )
            )
        ),
        tabItem(
            tabName = "tab4",
            fluidRow(
                box(
                    title = "Quantity Payment Based On Month",
                    width = 12,
                    radioButtons(inputId = "idplotpayment1",
                                 label = "Month",
                                 choices = unique(datapayment1$Month),
                                 inline = TRUE),
                    plotlyOutput("plotpayment1")
                ),
            fluidRow(
                box(
                    title = "Quantity Payment Based On Hour and Day",
                    width = 12,
                    radioButtons(inputId = "idplotpayment2",
                                 label = "Payment",
                                 choices = c("Ewallet","Cash","Credit card"),
                                 inline = TRUE),
                    plotlyOutput("plotpayment2"),
                    plotlyOutput("plotpayment3"))
                )
            )
        ),
        tabItem(
            tabName = "tab5",
            fluidRow(
                box(width = 12,
                    titlePanel("Contact"),
                    p("Email : gashasarwono@gmail.com"),
                    titlePanel("Portofolio"),
                    actionButton(inputId='linkedin', label="LinkedIn", 
                                 icon = icon("linkedin"), 
                                 onclick ="window.open('https://www.linkedin.com/in/gasha-sarwono-putra-ba556a147/', '_blank')"),
                    actionButton(inputId='github', label="GitHub", 
                                 icon = icon("github"), 
                                 onclick ="window.open('https://github.com/gashasp', '_blank')"),
                    actionButton(inputId='rpubs', label="RPubs", 
                                 icon = icon("r-project"), 
                                 onclick ="window.open('https://rpubs.com/gashasp', '_blank')")
                    )
                )
            )
        )
    ) 

# Full_Page
dashboardPage(
    skin = "green",
    header = header,
    body = body,
    sidebar = sidebar
)