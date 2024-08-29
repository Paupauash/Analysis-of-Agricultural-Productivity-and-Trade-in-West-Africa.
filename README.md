# Analysis-of-Agricultural-Productivity-and-Trade-in-West-Africa.
This project evaluates West Africa's agricultural productivity and its impact on trade patterns from 2014 to 2022.

Ø  WHY THIS PROJECT?

Agriculture plays a crucial role in African economies. Between 2014 to 2022, Sierra Leone registered the agricultural sector's highest contribution to GDP in Africa, at over 60 percent. This highlights the significant potential of West African agriculture. Despite the sector's importance, the relationship between agricultural productivity and trade patterns in West Africa remains underexplored. This project aims to fill that gap by evaluating agricultural productivity in West Africa and its impact on trade from 2014 to 2022. The findings are expected to contribute to strategies for enhancing food security, optimizing trade relationships, and fostering sustainable economic development in the region.

Ø  OVERALL OBJECTIVE:  Analyze West Africa's agricultural productivity and its impact on trade patterns from 2014 to 2022.

Specific Objective SO1: Identify the product categories with the highest gross production in USD in West Africa.
Specific Objective SO2: Determine and compare trade balances (in tons) for key agricultural products.
Specific Objective SO3: Examine whether these products' negative trade balance is due to gross production

Ø  METHODS

Data collection

This project utilizes data from the Food and Agriculture Organization (FAO) of the United Nations' statistical database, FAOSTAT [2]. We extracted the following key variables for Western African countries: Gross Production Value (in current thousand US dollars), Import Quantity (in tons), and Export Quantity (in tons) for agricultural products.

Our analysis focuses on the period of 2014 to 2022, and the selected variables allow us to assess: Agricultural output through Gross Production Value, Trade flows via Import and Export Quantities, and Trade balances by comparing import and export data. Table 1 below summarizes the key variables used in this study.

The study focuses on three key quantitative continuous variables related to agricultural production and trade. Gross Production Value, measured in thousands of US dollars (USD), represents the total market value of agricultural products produced. This variable provides an overall measure of agricultural output in monetary terms. The Export Quantity, measured in tons (t), indicates the amount of agricultural products sold to foreign countries. Conversely, Import Quantity, also measured in tons (t), represents the amount of agricultural products purchased from foreign countries.

Analysis

Our analysis employed a comprehensive approach to examine West Africa's agricultural productivity and its impact on trade patterns. We began by utilizing R Studio to extract and wrangle the variables of interest from the FAO databases. To identify the most significant crops in the region, we plotted the average gross production in tons across West Africa during the years under investigation using Tableau.

To understand trade dynamics, we calculated trade balances for selected items by subtracting imported quantities from exported quantities. This calculation provided insights into whether specific crops were net exports or imports for the region. To visualize these trade patterns effectively, we created a diverging bar chart using Tableau, which allowed for a clear comparison of trade balances per item over the years.

To explore the relationship between production and trade outcomes, we introduced a qualitative variable called "trade sign," which represented whether the trade balance was positive or negative for each year. This allowed us to perform a more nuanced analysis of the connection between production levels and trade status. We then conducted a binomial logistic regression in Rstudio, using "trade sign" as the dependent variable and gross production as the quantitative independent variable.





