# Header
header <- dashboardHeader(
    title = "Supermarket Sales"
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
                    title = span("Overview", style = "font-size: 28px"),
                    span("The growth of supermarkets in most populated cities 
                      are increasing and market competitions are also high. 
                      The dataset is one of the historical sales of 
                      supermarket company which has recorded in 3 different 
                      branches for 3 months data.", style = "font-size: 20px")
                    ),
                box(
                  width = 6,
                  height = 532,
                  title = span("Information", style = "font-size: 28px"),
                  span("1) Date : Date of purchase", style = "font-size: 20px"),
                  br(),
                  span("2) Time : Purchase time",style = "font-size: 20px"),
                  br(),
                  span("3) City : Location of supercenters",style = "font-size: 20px"),
                  br(),
                  span("4) Gender : Gender type of customer",style = "font-size: 20px"),
                  br(),
                  span("5) Product line : General item categorization ( 
                      Electronic accessories, Fashion accessories, 
                      Food and beverages, Health and beauty, 
                      Home and lifestyle and Sports and travel)",style = "font-size: 20px"),
                  br(),
                  span("6) Quantity : Number of products purchased by customer",style = "font-size: 20px"),
                  br(),
                  span("7) Unit price : Price of each product in $",style = "font-size: 20px"),
                  br(),
                  span("8) Total : Total price product",style = "font-size: 20px"),
                  br(),
                  span("9) Payment : Payment used by customer for purchase 
                      (Cash, Credit card and Ewallet)",style = "font-size: 20px"),
                  br(),
                  span("10) Rating : Customer stratification rating on 
                      their overall shopping experience 
                      (scale of 1 to 10)",style = "font-size: 20px")
                  ),
                box(
                  width = 6,
                  title = span("Visualization", style = "font-size: 28px"),
                  span("Raw Data",style = "font-size: 20px"),
                  p("Raw Data Table"),
                  span("Sales",style = "font-size: 20px"),
                  p("Visualization 1: Detail value Average from each City"),
                  p("Visualization 2: Total Sales by Date from each City"),
                  span("Product Menu",style = "font-size: 20px"),
                  p("Visualization 1: Top Product Category by Total Sales"),
                  p("Visualization 2: Top Product Category Selling by Gender"),
                  p("Visualization 3: Top Product Category Selling by City"),
                  p("Visualization 4: Top Product Category Selling by Payment Type"),
                  span("Payment Menu",style = "font-size: 20px"),
                  p("Visualization 1: Top Payment Type by Quantity"),
                  p("Visualization 2: Quantity Payment Type based on Hour"),
                  p("Visualization 3: Quantity Payment Type based on Day"),
                  span("Contact Me",style = "font-size: 20px"),
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
                title = "Sales Average",
                width = 12,
                height = 305,
                radioButtons(inputId = "radio1",
                             label = "Choose City",
                             choices = unique(datasales$City), inline = TRUE),
                valueBoxOutput(outputId = "avg_totalsales", width = 3),
                valueBoxOutput(outputId = "avg_unit", width = 3),
                valueBoxOutput(outputId = "avg_quantity", width = 3),
                valueBoxOutput(outputId = "avg_rating", width = 3)
                )
            ),
            fluidRow(
                box(
                    title = "Sales Chart",
                    width = 12, 
                    dateRangeInput(inputId = "idsales1", 
                                   label = "Range Date",
                                   start = "2019-01-01",
                                   end = "2019-03-09",
                                   min = "2019-01-01",
                                   max = "2019-03-09"),
                    plotlyOutput("plotsales")
                    )
                )
        ),
        tabItem(
            tabName = "tab3",
            fluidRow(
                box(
                    title = "Top 6 Product Selling",
                    width = 12,
                    height = 360,
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
                    span("Contact", style = "font-size: 28px"),
                    br(),
                    span("Email : gashasarwono@gmail.com",style = "font-size: 20px"),
                    br(),
                    br(),
                    span("Portofolio",style = "font-size: 28px"),
                    br(),
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