# Kultra Mega Stores (KMS) Inventory Analysis

---
## Case Scenario 1

### 1.	Which product category had the highest sales?

```sql 
SELECT [Product_Category], CAST(SUM([Sales]) AS DECIMAL(18,2)) AS [Total_Sales]
FROM KMS_INVENTORY
GROUP BY [Product_Category]
ORDER BY [Total_Sales] DESC;
```

| Product_Category  | Total_Sales        |
|-------------------|--------------------|
| Technology        | ₦5,984,248.18      | 
| Furniture         | ₦5,178,590.55      |
| Office Supplies   | ₦3,752,762.11      |

**Insight:**
Technology products generated the most revenue.

---

### 2. What are the Top 3 and Bottom 3 regions in terms of sales?

### Top 3 Selling Regions

```sql 
SELECT TOP 3 [Region], CAST(SUM([Sales]) AS DECIMAL(18,2)) AS [Total_Sales]
FROM [KMS_INVENTORY]
GROUP BY Region
ORDER BY [Total_Sales] DESC;
```

| Region            | Total_Sales        |
|-------------------|--------------------|
| West              | ₦3,597,549.27      | 
| Ontario           | ₦3,063,212.48      |
| Prairie           | ₦2,837,304.61      |

### Bottom 3 Selling Regions

```sql
SELECT TOP 3 [Region], CAST(SUM([Sales]) AS DECIMAL(18,2)) AS [Total_Sales]
FROM KMS_INVENTORY
GROUP BY [REGION]
ORDER BY [Total_Sales] ASC;
```

| Region                   | Total_Sales        |
|--------------------------|--------------------|
| Nunavut                  | ₦116,376.48        | 
| Nortwest Territories     | ₦800,847.33        |
| Yukon                    | ₦975,867.38        |

**Insight:**
Sales promotion efforts should be intensified in the least selling regions to increase revenue.

---

### 3. Total sales of appliances in Ontario

```sql
SELECT Region, CAST(SUM(sales) AS DECIMAL(18,2)) AS [Total_Sales]
FROM KMS_INVENTORY
WHERE Region='Ontario' AND Product_Category= 'Appliances'
GROUP BY Region
```

| Region                   | Total_Sales        |
|--------------------------|--------------------|
| Ontario                  | null               | 

**Insight:**
There were no appliances sold in Ontario.

---

### 4. Revenue from Bottom 10 customers

```sql
SELECT TOP 10 [Customer_Name], CAST(SUM([Sales]) AS DECIMAL(18,2)) AS [Total_Sales]
FROM KMS_INVENTORY
GROUP BY Customer_Name
ORDER BY [Total_Sales] ASC;
```

| Customer_Name         | Total_Sales    |
|-----------------------|----------------|
| Jeremy Farry          | ₦85.72         | 
| Natalie DeCherney     | ₦125.90        |
| Nicole Fjeld          | ₦153.03        |
| Katrina Edelman       | ₦180.76        |
| Dorothy Dickinson     | ₦198.08        |
| Christine Kargatis    | ₦293.22        |
| Eric Murdock          | ₦343.33        |
| Chris McAfee          | ₦350.18        | 
| Rick Huthwaite        | ₦415.82        |
| Mark Hamilton         | ₦450.99        |

**Insight:**
These customers generated the least revenue for KMS, so I checked their buying habits to understand why.

```sql
----Checked Customer Buying Habits----
SELECT TOP 10 Customer_Name,
COUNT(DISTINCT Order_ID) AS Total_Orders,
SUM(Order_Quantity) AS Total_Qty_Bought,
AVG(Order_Quantity) AS Avg_Qty_per_Order,
CAST(SUM(Sales) AS DECIMAL(18,2)) AS Total_Sales,
MAX(Product_Name) AS Regular_Product
FROM KMS_INVENTORY
GROUP BY Customer_Name
ORDER BY Total_Sales ASC;
```

|Customer_Name     |Total_Orders|Total_Qty_Bought|Avg_Qty_per_Order|Total_Sales|                                 Regular_Product                                            |
|------------------|------------|----------------|-----------------|---------- |--------------------------------------------------------------------------------------------|
|Jeremy Farry	     | 2	        |28	             | 14	             |₦85.72 	   |OIC Thumb-Tacks                                                                             |
|Natalie DeCherney | 1	        | 21	           | 21	             |₦125.90	   |Adams Telephone Message Book W/Dividers/Space For Phone Numbers, 5 1/4"X8 1/2", 300/Messages|
|Nicole Fjeld	     | 2	        | 44	           | 22	             |₦153.03    |Xerox 1895                                                                                  |
|Katrina Edelman	 | 2	        | 37             | 18	             |₦180.76	   |Xerox 1993                                                                                  |
|Dorothy Dickinson | 1	        | 47             | 47	             |₦198.08	   |Newell 336                                                                                  |
|Christine Kargatis| 2	        | 30             | 15	             |₦293.22	   |Executive Impressions 12" Wall Clock                                                        |
|Eric Murdock	     | 4	        | 82	           | 20	             |₦343.33    |Xerox 200                                                                                   |
|Chris McAfee	     | 2	        | 29	           | 14	             |₦350.18	   |Nu-Dell Leatherette Frames                                                                  |
|Rick Huthwaite	   | 2          | 79             | 26	             |₦415.82	   |Wilson Jones Impact Binders                                                                 |
|Mark Hamilton	   | 1	        | 38	           | 19	             |₦450.99	   |Tenex Personal Self-Stacking Standard File Box, Black/Gray                                  |

#### Advice to KMS Management: Increasing Revenue from Bottom 10 Customers

**🔍 What We Found:**

From the sales data analysis, the bottom 10 customers by total sales contribute the least revenue to Kultra Mega Stores. These customers have low spending patterns, and without action, they represent untapped revenue potential.

**✅ Recommendation:**

To increase revenue from these bottom 10 customers, KMS should:

- Conduct Customer Surveys: Find out why they're not spending more — poor experience? high prices? Slow delivery?
- Offer Personalized Marketing to these customers to increase revenue
- Provide loyalty points to encourage repeat business.

---

### 5. KMS incurred the most shipping cost using which shipping method?

```sql
SELECT TOP 1 [Ship_Mode], CAST(SUM([Shipping_Cost]) AS DECIMAL(18,2)) AS [Total_Shipping_Cost]
FROM KMS_INVENTORY
GROUP BY Ship_Mode
ORDER BY [Total_Shipping_Cost] DESC;
```

| Ship_Mode       | Total_Shipping_Cost  |
|-----------------|----------------------|
| Delivery Truck  | ₦51,971.94           | 

**Insight:**
Delivery truck was the most expensive shipping method used.

## Case Scenario 2

### 6. Who are the most valuable customers, and what products or services did they typically purchase?

```sql
SELECT TOP 10 [Customer_Name],Product_Name, CAST(SUM(Sales) AS DECIMAL(18,2)) AS [Total_Sales]
FROM KMS_INVENTORY
GROUP BY Customer_Name,Product_Name
ORDER BY [Total_Sales] DESC;
```

|Customer_Name	    |                           Product_Name	                            |Total_Sales  |
|-------------------|---------------------------------------------------------------------|-------------|
|Emily Phan	        |Polycom ViewStation™ ISDN Videoconferencing Unit	                    |₦89,061.05   |
|Jasper Cacioppo	  |Polycom ViewStation™ ISDN Videoconferencing Unit	                    |₦45,923.76   |
|Craig Carreira	    |Polycom ViewStation™ ISDN Videoconferencing Unit	                    |₦41,343.21   | 
|Clytie Kelty	      |Canon PC940 Copier	                                                  |₦40,780.52   |
|Dennis Kane	      |Canon imageCLASS 2200 Advanced Copier	                              |₦33,367.85   |
|Karen Carlisle	    |Canon Image Class D660 Copier	                                      |₦29,884.60   |
|Steve Chapman	    |Riverside Palais Royal Lawyers Bookcase, Royale Cherry Finish	      |₦29,345.27   |
|Nick Crebassa	    |Hewlett-Packard Business Color Inkjet 3000 [N, DTN] Series Printers	|₦29,186.49   |
|Parhena Norris	    |Canon imageCLASS 2200 Advanced Copier	                              |₦28,761.52   |
|Deborah Brumfield	|Hewlett Packard LaserJet 3310 Copier	                                |₦28,664.52   |

**Insight:**
Emily Phan was KMS's most valuable customer.

### 7. Which small business customer has the highest sales?

```sql
SELECT TOP 1 Customer_Name,Customer_Segment, CAST(SUM([Sales]) AS DECIMAL(18,2)) AS [Total_Sales]
FROM KMS_INVENTORY
WHERE Customer_Segment ='Small Business'
GROUP BY Customer_Name,Customer_Segment
ORDER BY [Total_Sales] DESC;
```

|Customer_Name	| Customer_Segment	|Total_Sales  |
|---------------|-------------------|-------------|
|Dennis Kane	  |Small Business	    |₦75,967.59   |

**Insight:**
KMS sold the most to Dennis Kane's small business.

### 8. Which corporate customer placed the most number of orders in 2019 -2012?

```sql
SELECT TOP 1  Customer_Name,Customer_Segment, COUNT([Order_ID]) AS [Total_Order]
FROM KMS_INVENTORY
WHERE Customer_Segment ='Corporate' and Order_Date between '2009' and '2012'
GROUP BY Customer_Name,Customer_Segment
ORDER BY [Total_Order] DESC;
```

|Customer_Name	| Customer_Segment	|Total_Order |
|---------------|-------------------|------------|
|Adam Hart   	  |Corporate     	    | 19         |

### 9. Which consumer customer was the most profitable one?

```sql
SELECT TOP 1 Customer_Name,Customer_Segment, CAST(SUM([Profit]) AS DECIMAL(18,2)) AS [Total_Profit]
FROM KMS_INVENTORY
WHERE Customer_Segment ='Consumer'
GROUP BY Customer_Name,Customer_Segment
ORDER BY [Total_Profit] DESC;
```

|Customer_Name	| Customer_Segment	|Total_Profit |
|---------------|-------------------|-------------|
|Emily Phan 	  |Consumer     	    |₦34,005.44   |

### 10. Which customers returned items, and what segments do they belong to?

```sql
SELECT DISTINCT Customer_Name, Customer_Segment,[Status]
FROM KMS_INVENTORY
JOIN [Order_Status_Import1] ON KMS_INVENTORY . [Order_ID] = [Order_Status_Import1] . [Order_ID]
WHERE [Order_Status_Import1] . Status = 'Returned'
ORDER BY Customer_Name
```

| Customer_Name           | Customer_Segment | Status   |
|------------------------ |------------------|----------|
| Aaron Bergman           | Corporate        | Returned |
| Aaron Hawkins           | Home Office      | Returned |
| Adam Bellavance         | Small Business   | Returned |
| Adrian Barton           | Small Business   | Returned |
| Alan Hwang              | Corporate        | Returned |
| Alan Hwang              | Small Business   | Returned |
| Alejandro Grove         | Consumer         | Returned |
| Alejandro Grove         | Corporate        | Returned |
| Alejandro Savely        | Corporate        | Returned |
| Aleksandra Gannaway     | Corporate        | Returned |
| Alex Russell            | Home Office      | Returned |
| Alice McCarthy          | Corporate        | Returned |
| Alyssa Tate             | Small Business   | Returned |
| Amy Cox                 | Home Office      | Returned |
| Amy Cox                 | Small Business   | Returned |
| Amy Hunt                | Home Office      | Returned |
| Amy Hunt                | Small Business   | Returned |
| Anna Chung              | Home Office      | Returned |
| Anna Gayman             | Corporate        | Returned |
| Anna Haberlin           | Corporate        | Returned |
| Anne Pryor              | Consumer         | Returned |
| Annie Thurman           | Consumer         | Returned |
| Anthony Garverick       | Small Business   | Returned |
| Anthony O'Donnell       | Consumer         | Returned |
| Art Ferguson            | Corporate        | Returned |
| Art Foster              | Home Office      | Returned |
| Art Miller              | Corporate        | Returned |
| Arthur Prichep          | Home Office      | Returned |
| Arthur Wiediger         | Corporate        | Returned |
| Ashley Jarboe           | Small Business   | Returned |
| Astrea Jones            | Corporate        | Returned |
| Barbara Fisher          | Small Business   | Returned |
| Barry Blumstein         | Small Business   | Returned |
| Barry Gonzalez          | Small Business   | Returned |
| Becky Castell           | Consumer         | Returned |
| Becky Martin            | Home Office      | Returned |
| Becky Pak               | Corporate        | Returned |
| Ben Ferrer              | Corporate        | Returned |
| Ben Wallace             | Home Office      | Returned |
| Benjamin Patterson      | Corporate        | Returned |
| Benjamin Venier         | Small Business   | Returned |
| Berenike Kampe          | Corporate        | Returned |
| Beth Thompson           | Corporate        | Returned |
| Bill Donatelli          | Corporate        | Returned |
| Bill Donatelli          | Small Business   | Returned |
| Bill Eplett             | Corporate        | Returned |
| Bill Overfelt           | Corporate        | Returned |
| Bill Shonely            | Small Business   | Returned |
| Bobby Elias             | Small Business   | Returned |
| Bobby Odegard           | Corporate        | Returned |
| Bobby Trafton           | Corporate        | Returned |
| Brad Eason              | Small Business   | Returned |
| Brad Thomas             | Corporate        | Returned |
| Brad Thomas             | Home Office      | Returned |
| Brenda Bowman           | Small Business   | Returned |
| Brendan Dodson          | Corporate        | Returned |
| Brendan Sweed           | Consumer         | Returned |
| Brian Dahlen            | Small Business   | Returned |
| Brian DeCherney         | Corporate        | Returned |
| Brian Moss              | Corporate        | Returned |
| Brian Stugart           | Consumer         | Returned |
| Brian Stugart           | Corporate        | Returned |
| Brooke Gillingham       | Small Business   | Returned |
| Bruce Stewart           | Corporate        | Returned |
| Bryan Mills             | Small Business   | Returned |
| Bryan Spruell           | Home Office      | Returned |
| Candace McMahon         | Corporate        | Returned |
| Cari MacIntyre          | Corporate        | Returned |
| Cari Sayre              | Corporate        | Returned |
| Cari Sayre              | Home Office      | Returned |
| Carl Weiss              | Consumer         | Returned |
| Carlos Daly             | Corporate        | Returned |
| Carlos Daly             | Home Office      | Returned |
| Carlos Meador           | Corporate        | Returned |
| Carlos Soltero          | Consumer         | Returned |
| Carlos Soltero          | Small Business   | Returned |
| Carol Darley            | Home Office      | Returned |
| Carol Darley            | Small Business   | Returned |
| Carol Triggs            | Home Office      | Returned |
| Cassandra Brandow       | Home Office      | Returned |
| Cathy Prescott          | Corporate        | Returned |
| Chad Sievert            | Corporate        | Returned |
| Charles Crestani        | Consumer         | Returned |
| Charles McCrossin       | Corporate        | Returned |
| Charles Sheldon         | Corporate        | Returned |
| Charlotte Melton        | Home Office      | Returned |
| Christina DeMoss        | Home Office      | Returned |
| Christine Abelman       | Corporate        | Returned |
| Christine Kargatis      | Small Business   | Returned |
| Christy Brittain        | Consumer         | Returned |
| Cindy Chapman           | Consumer         | Returned |
| Cindy Chapman           | Corporate        | Returned |
| Cindy Stewart           | Consumer         | Returned |
| Clytie Kelty            | Small Business   | Returned |
| Corey Catlett           | Home Office      | Returned |
| Corinna Mitchell        | Corporate        | Returned |
| Craig Carroll           | Corporate        | Returned |
| Craig Leslie            | Consumer         | Returned |
| Craig Molinari          | Small Business   | Returned |
| Craig Yedwab            | Consumer         | Returned |
| Cynthia Arntzen         | Home Office      | Returned |
| Cynthia Arntzen         | Small Business   | Returned |
| Cyra Reiten             | Consumer         | Returned |
| Damala Kotsonis         | Corporate        | Returned |
| Dan Lawera              | Corporate        | Returned |
| Dan Reichenbach         | Corporate        | Returned |
| Daniel Lacy             | Small Business   | Returned |
| Daniel Raglin           | Corporate        | Returned |
| Darren Budd             | Consumer         | Returned |
| Darren Budd             | Corporate        | Returned |
| Darren Budd             | Home Office      | Returned |
| Darren Powers           | Corporate        | Returned |
| Darrin Sayre            | Consumer         | Returned |
| Dave Hallsten           | Corporate        | Returned |
| Dave Hallsten           | Home Office      | Returned |
| Dave Kipp               | Corporate        | Returned |
| Dave Poirier            | Small Business   | Returned |
| David Kendrick          | Home Office      | Returned |
| David Philippe          | Consumer         | Returned |
| Dean Braden             | Corporate        | Returned |
| Dean Percer             | Home Office      | Returned |
| Deanra Eno              | Corporate        | Returned |
| Delfina Latchford       | Small Business   | Returned |
| Denise Leinenbach       | Home Office      | Returned |
| Denise Monton           | Home Office      | Returned |
| Dennis Bolton           | Small Business   | Returned |
| Dennis Pardue           | Corporate        | Returned |
| Denny Ordway            | Small Business   | Returned |
| Dianna Arnett           | Home Office      | Returned |
| Dianna Vittorini        | Corporate        | Returned |
| Dionis Lloyd            | Small Business   | Returned |
| Don Weiss               | Corporate        | Returned |
| Dorothy Badders         | Home Office      | Returned |
| Dorris Love             | Home Office      | Returned |
| Doug Bickford           | Corporate        | Returned |
| Duane Benoit            | Home Office      | Returned |
| Duane Huffman           | Consumer         | Returned |
| Duane Huffman           | Small Business   | Returned |
| Duane Noonan            | Corporate        | Returned |
| Ed Braxton              | Home Office      | Returned |
| Edward Hooks            | Consumer         | Returned |
| Edward Nazzal           | Home Office      | Returned |
| Eleni McCrary           | Home Office      | Returned |
| Ellis Ballard           | Corporate        | Returned |
| Emily Grady             | Home Office      | Returned |
| Erica Hernandez         | Small Business   | Returned |
| Erica Smith             | Small Business   | Returned |
| Erin Creighton          | Corporate        | Returned |
| Erin Mull               | Corporate        | Returned |
| Eudokia Martin          | Home Office      | Returned |
| Eugene Moren            | Home Office      | Returned |
| Eva Jacobs              | Home Office      | Returned |
| Evan Henry              | Corporate        | Returned |
| Evan Minnotte           | Corporate        | Returned |
| Frank Atkinson          | Corporate        | Returned |
| Frank Gastineau         | Small Business   | Returned |
| Frank Hawley            | Home Office      | Returned |
| Frank Merwin            | Corporate        | Returned |
| Fred Chung              | Corporate        | Returned |
| Fred Harton             | Home Office      | Returned |
| Fred Hopkins            | Home Office      | Returned |
| Gary Hwang              | Home Office      | Returned |
| Gary McGarr             | Home Office      | Returned |
| George Bell             | Corporate        | Returned |
| George Zrebassa         | Small Business   | Returned |
| Giulietta Dortch        | Consumer         | Returned |
| Giulietta Dortch        | Corporate        | Returned |
| Grant Carroll           | Corporate        | Returned |
| Grant Carroll           | Small Business   | Returned |
| Grant Thornton          | Corporate        | Returned |
| Greg Guthrie            | Small Business   | Returned |
| Greg Tran               | Home Office      | Returned |
| Guy Armstrong           | Corporate        | Returned |
| Guy Thornton            | Corporate        | Returned |
| Hallie Redmond          | Small Business   | Returned |
| Harold Dahlen           | Corporate        | Returned |
| Harold Pawlan           | Small Business   | Returned |
| Helen Andreada          | Corporate        | Returned |
| Helen Wasserman         | Home Office      | Returned |
| Henry Goldwyn           | Small Business   | Returned |
| Herbert Flentye         | Small Business   | Returned |
| Hunter Glantz           | Corporate        | Returned |
| Ionia McGrath           | Small Business   | Returned |
| Ivan Gibson             | Corporate        | Returned |
| Jack Garza              | Corporate        | Returned |
| Jack O'Briant           | Small Business   | Returned |
| James Galang            | Consumer         | Returned |
| James Lanier            | Corporate        | Returned |
| Jane Waco               | Corporate        | Returned |
| Janet Lee               | Consumer         | Returned |
| Janet Martin            | Corporate        | Returned |
| Jas O'Carroll           | Corporate        | Returned |
| Jas O'Carroll           | Home Office      | Returned |
| Jason Klamczynski       | Small Business   | Returned |
| Jay Fine                | Consumer         | Returned |
| Jay Kimmel              | Small Business   | Returned |
| Jennifer Halladay       | Home Office      | Returned |
| Jeremy Pistek           | Corporate        | Returned |
| Jessica Myrick          | Small Business   | Returned |
| Jesus Ocampo            | Small Business   | Returned |
| Jill Matthias           | Consumer         | Returned |
| Jim Epp                 | Small Business   | Returned |
| Jim Kriz                | Consumer         | Returned |
| Jim Sink                | Corporate        | Returned |
| Joe Elijah              | Home Office      | Returned |
| Joel Eaton              | Home Office      | Returned |
| Joel Jenkins            | Corporate        | Returned |
| John Castell            | Small Business   | Returned |
| John Dryer              | Corporate        | Returned |
| John Grady              | Corporate        | Returned |
| John Lee                | Corporate        | Returned |
| John Lucas              | Corporate        | Returned |
| John Lucas              | Small Business   | Returned |
| John Murray             | Small Business   | Returned |
| John Stevenson          | Small Business   | Returned |
| Jonathan Doherty        | Corporate        | Returned |
| Joni Wasserman          | Consumer         | Returned |
| Joseph Airdo            | Consumer         | Returned |
| Joy Smith               | Corporate        | Returned |
| Julia Barnett           | Home Office      | Returned |
| Julia Dunbar            | Consumer         | Returned |
| Julia West              | Consumer         | Returned |
| Julia West              | Home Office      | Returned |
| Julie Prescott          | Home Office      | Returned |
| Justin Ellison          | Home Office      | Returned |
| Kalyca Meade            | Corporate        | Returned |
| Karen Bern              | Corporate        | Returned |
| Karen Seio              | Consumer         | Returned |
| Karl Brown              | Corporate        | Returned |
| Karl Brown              | Home Office      | Returned |
| Katharine Harms         | Consumer         | Returned |
| Katherine Hughes        | Consumer         | Returned |
| Katherine Nockton       | Corporate        | Returned |
| Katherine Nockton       | Home Office      | Returned |
| Kean Nguyen             | Corporate        | Returned |
| Kean Takahito           | Home Office      | Returned |
| Keith Dawkins           | Home Office      | Returned |
| Kelly Williams          | Corporate        | Returned |
| Ken Black               | Consumer         | Returned |
| Ken Dana                | Small Business   | Returned |
| Ken Lonsdale            | Consumer         | Returned |
| Khloe Miller            | Home Office      | Returned |
| Kimberly Carter         | Home Office      | Returned |
| Kimberly Carter         | Small Business   | Returned |
| Kristen Hastings        | Corporate        | Returned |
| Kristina Nunn           | Consumer         | Returned |
| Larry Hughes            | Home Office      | Returned |
| Larry Tron              | Corporate        | Returned |
| Larry Tron              | Home Office      | Returned |
| Laurel Beltran          | Consumer         | Returned |
| Laurel Elliston         | Corporate        | Returned |
| Laurel Elliston         | Home Office      | Returned |
| Lela Donovan            | Corporate        | Returned |
| Lena Radford            | Small Business   | Returned |
| Linda Cazamias          | Corporate        | Returned |
| Lisa DeCherney          | Consumer         | Returned |
| Liz Carlisle            | Corporate        | Returned |
| Liz MacKendrick         | Corporate        | Returned |
| Liz Pelletier           | Home Office      | Returned |
| Liz Price               | Corporate        | Returned |
| Liz Willingham          | Corporate        | Returned |
| Liz Willingham          | Home Office      | Returned |
| Luke Schmidt            | Home Office      | Returned |
| Luke Weiss              | Corporate        | Returned |
| Lycoris Saunders        | Corporate        | Returned |
| Magdelene Morse         | Home Office      | Returned |
| Marc Crier              | Consumer         | Returned |
| Marc Harrigan           | Home Office      | Returned |
| Maria Bertelson         | Corporate        | Returned |
| Maria Zettner           | Corporate        | Returned |
| Mark Cousins            | Corporate        | Returned |
| Mark Packer             | Small Business   | Returned |
| Mary Zewe               | Corporate        | Returned |
| Matt Collister          | Home Office      | Returned |
| Matt Connell            | Corporate        | Returned |
| Maureen Gastineau       | Consumer         | Returned |
| Max Jones               | Home Office      | Returned |
| Maxwell Schwartz        | Corporate        | Returned |
| Maya Herman             | Corporate        | Returned |
| Meg O'Connel            | Corporate        | Returned |
| Michael Dominguez       | Home Office      | Returned |
| Michael Granlund        | Corporate        | Returned |
| Michael Oakman          | Small Business   | Returned |
| Michelle Ellison        | Consumer         | Returned |
| Michelle Ellison        | Home Office      | Returned |
| Michelle Ellison        | Small Business   | Returned |
| Michelle Huthwaite      | Home Office      | Returned |
| Michelle Lonsdale       | Home Office      | Returned |
| Michelle Tran           | Corporate        | Returned |
| Mick Crebagga           | Corporate        | Returned |
| Mike Caudle             | Corporate        | Returned |
| Mike Gockenbach         | Consumer         | Returned |
| Mike Pelletier          | Corporate        | Returned |
| Mitch Gastineau         | Corporate        | Returned |
| Mitch Willingham        | Corporate        | Returned |
| Monica Federle          | Corporate        | Returned |
| Muhammed Lee            | Consumer         | Returned |
| Muhammed Yedwab         | Consumer         | Returned |
| Nancy Lomonaco          | Home Office      | Returned |
| Naresj Patel            | Corporate        | Returned |
| Naresj Patel            | Small Business   | Returned |
| Natalie Webber          | Corporate        | Returned |
| Nathan Gelder           | Home Office      | Returned |
| Nathan Mautz            | Corporate        | Returned |
| Nathan Mautz            | Home Office      | Returned |
| Neil French             | Corporate        | Returned |
| Neil Knudson            | Corporate        | Returned |
| Neoma Murray            | Small Business   | Returned |
| Nick Crebassa           | Corporate        | Returned |
| Noel Staavos            | Home Office      | Returned |
| Nora Paige              | Small Business   | Returned |
| Nora Pelletier          | Corporate        | Returned |
| Odella Nelson           | Small Business   | Returned |
| Olvera Toch             | Home Office      | Returned |
| Parhena Norris          | Home Office      | Returned |
| Patrick Bzostek         | Consumer         | Returned |
| Patrick Jones           | Home Office      | Returned |
| Patrick O'Donnell       | Home Office      | Returned |
| Patrick Ryan            | Corporate        | Returned |
| Paul MacIntyre          | Corporate        | Returned |
| Pauline Chand           | Corporate        | Returned |
| Pete Armstrong          | Consumer         | Returned |
| Pete Kriz               | Corporate        | Returned |
| Peter Fuller            | Consumer         | Returned |
| Peter Fuller            | Corporate        | Returned |
| Peter McVee             | Small Business   | Returned |
| Philip Fox              | Home Office      | Returned |
| Phillina Ober           | Small Business   | Returned |
| Phillip Breyer          | Corporate        | Returned |
| Quincy Jones            | Corporate        | Returned |
| Rachel Payne            | Consumer         | Returned |
| Ralph Kennedy           | Corporate        | Returned |
| Randy Bradley           | Small Business   | Returned |
| Randy Ferguson          | Corporate        | Returned |
| Raymond Book            | Consumer         | Returned |
| Resi Polking            | Small Business   | Returned |
| Ricardo Block           | Corporate        | Returned |
| Richard Eichhorn        | Consumer         | Returned |
| Rick Bensley            | Consumer         | Returned |
| Rick Reed               | Consumer         | Returned |
| Rick Wilson             | Consumer         | Returned |
| Ritsa Hightower         | Corporate        | Returned |
| Rob Lucas               | Small Business   | Returned |
| Rob Williams            | Home Office      | Returned |
| Robert Waldorf          | Home Office      | Returned |
| Roger Demir             | Consumer         | Returned |
| Roland Black            | Small Business   | Returned |
| Roland Fjeld            | Corporate        | Returned |
| Roy French              | Consumer         | Returned |
| Roy Phan                | Consumer         | Returned |
| Roy Phan                | Corporate        | Returned |
| Roy Skaria              | Corporate        | Returned |
| Ruben Dartt             | Corporate        | Returned |
| Ryan Crowe              | Small Business   | Returned |
| Sally Hughsby           | Consumer         | Returned |
| Sally Matthias          | Corporate        | Returned |
| Sam Zeldin              | Small Business   | Returned |
| Sandra Glassco          | Home Office      | Returned |
| Sanjit Chand            | Home Office      | Returned |
| Sanjit Jacobs           | Consumer         | Returned |
| Saphhira Shifley        | Corporate        | Returned |
| Sarah Brown             | Consumer         | Returned |
| Sarah Foster            | Corporate        | Returned |
| Sarah Jordon            | Consumer         | Returned |
| Scot Wooten             | Corporate        | Returned |
| Scott Cohen             | Consumer         | Returned |
| Sean Braxton            | Small Business   | Returned |
| Sean Miller             | Small Business   | Returned |
| Sean O'Donnell          | Corporate        | Returned |
| Sean Wendt              | Corporate        | Returned |
| Shahid Hopkins          | Small Business   | Returned |
| Shaun Chance            | Corporate        | Returned |
| Sheri Gordon            | Corporate        | Returned |
| Shirley Daniels         | Corporate        | Returned |
| Sibella Parks           | Small Business   | Returned |
| Sonia Cooley            | Corporate        | Returned |
| Sonia Sunley            | Small Business   | Returned |
| Speros Goranitis        | Corporate        | Returned |
| Stephanie Phelps        | Consumer         | Returned |
| Stephanie Ulpright      | Consumer         | Returned |
| Steve Chapman           | Corporate        | Returned |
| Steve Nguyen            | Consumer         | Returned |
| Steven Cartwright       | Home Office      | Returned |
| Steven Roelle           | Small Business   | Returned |
| Stuart Calhoun          | Consumer         | Returned |
| Sue Ann Reed            | Consumer         | Returned |
| Sung Pak                | Small Business   | Returned |
| Susan MacKendrick       | Corporate        | Returned |
| Susan Vittorini         | Home Office      | Returned |
| Tamara Dahlen           | Corporate        | Returned |
| Tamara Manning          | Corporate        | Returned |
| Tamara Willingham       | Corporate        | Returned |
| Ted Trevino             | Corporate        | Returned |
| Thais Sissman           | Small Business   | Returned |
| Thea Hudgings           | Consumer         | Returned |
| Theresa Swint           | Consumer         | Returned |
| Thomas Boland           | Corporate        | Returned |
| Tim Brockman            | Consumer         | Returned |
| Toby Knight             | Corporate        | Returned |
| Toby Swindell           | Small Business   | Returned |
| Todd Boyes              | Small Business   | Returned |
| Tom Prescott            | Small Business   | Returned |
| Tom Stivers             | Small Business   | Returned |
| Tom Zandusky            | Home Office      | Returned |
| Tonja Turnell           | Consumer         | Returned |
| Tony Chapman            | Consumer         | Returned |
| Tony Molinari           | Corporate        | Returned |
| Tony Sayre              | Home Office      | Returned |
| Tony Sayre              | Small Business   | Returned |
| Tracy Collins           | Consumer         | Returned |
| Troy Blackwell          | Home Office      | Returned |
| Trudy Bell              | Consumer         | Returned |
| Trudy Brown             | Small Business   | Returned |
| Valerie Dominguez       | Corporate        | Returned |
| Valerie Takahito        | Consumer         | Returned |
| Victor Price            | Consumer         | Returned |
| Victoria Pisteka        | Corporate        | Returned |
| Vivek Grady             | Corporate        | Returned |
| Xylona Price            | Corporate        | Returned |

### 11. Analyse shipping costs vs ship mode based on order priority. Do you think the company appropriately spent shipping costs based on the Order Priority? Explain your answer

```sql
SELECT Order_Priority, Ship_Mode,
COUNT(Order_ID) AS Order_Count,
CAST(SUM(Sales - Profit) AS DECIMAL(18,2)) AS Estimated_Shipping_Cost,
AVG(DATEDIFF(DAY, Order_Date, Ship_Date)) AS AVERAGE_SHIP_DATE
FROM KMS_INVENTORY
GROUP BY Order_Priority, Ship_Mode
ORDER BY Order_Priority, Ship_Mode DESC;
```

| Order_Priority  | Ship_Mode        | Order_Count | Estimated_Shipping_Cost | AVERAGE_SHIP_DATE |
|-----------------|------------------|-------------|-------------------------|-------------------|
| Critical        | Regular Air      | 1180        | ₦1,122,603.29           | 1                 |
| Critical        | Express Air      | 200         | ₦198,005.40             | 1                 |
| Critical        | Delivery Truck   | 228         | ₦1,221,313.12           | 1                 |
| High            | Regular Air      | 1308        | ₦1,315,653.55           | 1                 |
| High            | Express Air      | 212         | ₦206,125.18             | 1                 |
| High            | Delivery Truck   | 248         | ₦1,338,507.98           | 1                 |
| Low             | Regular Air      | 1280        | ₦1,372,177.20           | 4                 |
| Low             | Express Air      | 190         | ₦191,312.13             | 4                 |
| Low             | Delivery Truck   | 250         | ₦1,332,956.14           | 3                 |
| Medium          | Regular Air      | 1225        | ₦1,311,249.52           | 1                 |
| Medium          | Express Air      | 201         | ₦247,151.91             | 1                 |
| Medium          | Delivery Truck   | 205         | ₦976,998.95             | 1                 |
| Not Specified   | Regular Air      | 1277        | ₦1,279,926.85           | 1                 |
| Not Specified   | Express Air      | 180         | ₦194,393.97             | 1                 |
| Not Specified   | Delivery Truck   | 215         | ₦1,085,457.66           | 1                 |

### 🚚 Shipping Cost vs Order Priority: Was Spending Appropriate?

**🧠 Scenario:**

- **Delivery Truck** = Cheapest but slowest option

- **Express Air** = Fastest but most expensive option

**Expected use:**

- High-priority orders should use **Express Air**

- Low-priority orders should use **Delivery Truck**

#### 🔍 What We Found:

**❌ Insight:**

The shipping methods often did not align with the order priorities:

- **Delivery Truck** was used for high-priority orders.

- **Express Air** was used for low-priority orders.

This mismatch led to inefficient spending and wasted resources. Instead of optimizing for urgency and cost, shipping choices were frequently made inappropriately, resulting in a misalignment between speed, cost, and order priority.

**✅ Recommendation:**

- Use Delivery Truck only for low-priority or non-urgent bulk shipments.

- Reserve Express Air for critical or time-sensitive orders.
