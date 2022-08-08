The purpose of this project is to compare the healthcare systems of 4 countries. In order to do that, we defined 4 keys which we based our comparison on: Number of physicians, number of nurses
, number of beds and mortality rate of patients with diabetes and cancer. Based on these criteria, we calculated the composite indicator which is the addition of the normalized criteria. 
We were able to obtain our data bases from the World bank database sets. 
Once we obtained the data sets, we cleaned them via excel and imported them to SQL. 
Via SQL we did the follwing:
1) normalize the value of each indicator for each country individually and store the query as a new table; hecne, we have 4 new tables.
2) We joined the tabls together on a common key, which in this case is the economy.
3)We added the normalized indicators to form the composite indicator
4)We ranked the countries based on the CI usnig the rank function