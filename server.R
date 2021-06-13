function(input, output){

#===SALES===
#Line Plot      
    output$plotsales <- renderPlotly({
        datasales <- datasales %>%
            filter(Date >= input$idsales1[1],
                   Date <= input$idsales1[2])
        plotsales <- ggplot(datasales, aes(x = Date, y = Total, color = City)) +
            geom_line() + geom_point() +
            scale_x_date(date_breaks = "4 day", date_labels = "%b-%d") +
            scale_y_continuous(breaks = seq(0, 4000, 500)) +
            theme(legend.position = "bottom") +
            theme_minimal()
        ggplotly(plotsales)})
    
#Value Box (Average Total Sales) 
    output$avg_totalsales <- renderValueBox({
        value_average_total_sales  <- datasales %>%
             select(Total,City) %>% 
             filter(City == input$radio1) %>% 
             pull(Total) %>% 
             mean() %>% 
             round(2) %>% 
             dollar()
        valueBox(
            value = value_average_total_sales, 
            subtitle = "Average Total Sales",
            icon = icon("dollar-sign"),
            color = "orange", width = 3)})
    
#Value Box (Average Unit) 
    output$avg_unit <- renderValueBox({
        value_average_unit  <- datasales %>%
            select(Unit_Price,City) %>% 
            filter(City == input$radio1) %>% 
            pull(Unit_Price) %>% 
            mean() %>% 
            round(2) %>% 
            dollar
        valueBox(
            value = value_average_unit, 
            subtitle = "Average Unit Price",
            icon = icon("tags"),
            color = "orange", width = 3)})
    
#Value Box (Average Quantity)    
    output$avg_quantity <- renderValueBox({
        value_average_quantity  <- datasales %>%
            select(Quantity,City) %>% 
            filter(City == input$radio1) %>% 
            pull(Quantity) %>% 
            mean() %>% 
            round(0)
        valueBox(
            value = value_average_quantity, 
            subtitle = "Average Quantity Product",
            icon = icon("boxes"),
            color = "orange", width = 3)})
    
#Value Box (Average Rating)  
        output$avg_rating <- renderValueBox({
        value_average_rating  <- datasales %>% 
            select(Rating,City) %>% 
            filter(City == input$radio1) %>% 
            pull(Rating) %>% 
            mean() %>% 
            round(2)
        valueBox(
            value = value_average_rating, 
            subtitle = "Average Rating",
            icon = icon("star"),
            color = "orange", width = 3)})

#===PRODUCT===
#Bar Plot Top    
        output$plotproduct1 <- renderPlotly({
            dataproduct1 <- ggplot(dataproduct1,aes(x=Total,y=reorder(Product_line,Total),text=label)) +
                geom_col(aes(fill = Product_line)) +
                theme_minimal() +
                theme(legend.position = "none") +
                labs(x="Total Sales", y="Product Category") +
                scale_x_continuous(breaks = seq(0,60000,10000))
                ggplotly(dataproduct1,tooltip = "text") %>% 
                  layout(height=300) %>% 
                  config(displayModeBar=F)})
 

        
#Bar Plot Left       
        output$plotproduct2 <- renderPlotly({
            dataproduct2 <- dataproduct2 %>%
                     filter(Gender == input$idplotproduct2)
            dataproduct2 <- ggplot(dataproduct2,aes(x=Quantity, y=reorder(Product,Quantity),text=label)) +
                         geom_col(aes(fill=Product),position="dodge") +
                         theme_minimal() +
                         theme(legend.position = "none")+
                labs(x = "Quantity", y = "Product Category")
            ggplotly(dataproduct2,tooltip = "text")})
        
#Bar Plot Middle       
        output$plotproduct3 <- renderPlotly({
            dataproduct3 <- dataproduct3 %>%
                filter(City == input$idplotproduct3)
            dataproduct3 <- ggplot(dataproduct3,aes(x=Quantity, y=reorder(Product,Quantity),text=label)) +
                geom_col(aes(fill=Product),position="dodge") +
                theme_minimal() +
                theme(legend.position = "none") +
                labs(x = "Quantity", y = "Product Category")
            ggplotly(dataproduct3,tooltip = "text")})
        
#Bar Plot Right       
        output$plotproduct4 <- renderPlotly({
            dataproduct4 <- dataproduct4 %>%
                filter(Payment == input$idplotproduct4)
            dataproduct4 <- ggplot(dataproduct4,aes(x=Quantity, y=reorder(Product,Quantity),text=label)) +
                geom_col(aes(fill=Product),position="dodge") +
                theme_minimal() +
                theme(legend.position = "none")+
                labs(x = "Quantity", y = "Product Category")
            ggplotly(dataproduct4,tooltip = "text")})
        
    
#===PAYMENT===
#Bar Plot Top   
        output$plotpayment1 <- renderPlotly({
            datapayment1 <- datapayment1 %>%
                filter(Month == input$idplotpayment1) %>%
                group_by(Payment) %>%
                summarize(Quantity = sum(Quantity)) %>%
                mutate(label=glue("Quantity: {Quantity}
                                    Payment: {Payment}")) %>%
                ggplot(aes(x=Quantity,y=reorder(Payment,Quantity),text = label)) +
                geom_col(aes(fill=Payment)) +
                theme_minimal() +
                theme(legend.position = "none") +
                labs(x = "Quantity", y = "Payment")
            ggplotly(datapayment1,tooltip= "text")})

# Area Plot Left
         output$plotpayment2 <- renderPlotly({
             datapayment2 <- datapayment2 %>% 
                 filter(Payment == input$idplotpayment2) 
             datapayment2 <- ggplot(datapayment2, aes(x = Hour, y = Quantity,group=Payment,text=label)) +
                     geom_point(aes(color=Payment)) + geom_line(aes(color=Payment)) +
                     geom_area(aes(fill=Payment),position = position_dodge(0),alpha = 0.4) +
                     theme_minimal() +
                     theme(legend.position = "none")
             ggplotly(datapayment2,tooltip= "text")})

# Area Plot Right
         output$plotpayment3 <- renderPlotly({
             datapayment3 <- datapayment3 %>% 
                 filter(Payment == input$idplotpayment2) 
             datapayment3 <- ggplot(datapayment3, aes(x = Day, y = Quantity,group=Payment,text=label)) +
                     geom_point(aes(color=Payment)) + geom_line(aes(color=Payment)) +
                     geom_area(aes(fill=Payment),position = position_dodge(0),alpha = 0.4) +
                     theme_minimal() +
                     theme(legend.position = "none")
             ggplotly(datapayment3,tooltip = "text")})
    
              
#===RAW DATA===
         output$tablerawdata <- renderDataTable({
             datatable(data = dataraw,rownames = F,
                       options = list(scrollX = T,"pageLength" = 20,
                                      lengthChange = F))})
}
