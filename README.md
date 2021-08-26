# Persuation-Modeling
Using Persuasion Modeling for Marketing Education in Tertiary Institutions

Author and Contribution
-----------------------
Afolabi Ibukun

Emeruwa Akachukwu 

Project Description
-------------------
This project aims at using persuasion modelling also known as uplift modelling to improve on education marketing using a tertiary institution as case study. 
We used both KNN and Random Forest algorithm for the uplift modelling using data retrieved from questionnaires.

Motivation
----------
The motivation and goal is to discover the uplift model that performs better out of Random Forest and KNN and also provide recommendations on how to reducing the Economic Investment in marketing educational workshops. 


Data Description
----------------
Data was collected within the period of June and July 2020. 
The questionnaire was administered to the students of various levels i.e. from 200 level  to  500 level. Lastly, a total of one thousand two hundred and fifty
(1250) questionnaires were administered and two hundred and twenty four (224) responded.
[Data 1 for developing models](https://github.com/ibkAfolabi/Persuation-Modeling/blob/main/TrainingDS3.csv)
[Data 2 for developing models](https://github.com/ibkAfolabi/Persuation-Modeling/blob/main/TrainingDS3knn.csv)
[Data for fresh prediction](https://github.com/ibkAfolabi/Persuation-Modeling/blob/main/TrainingDS3NewData.csv)

Technical Aspects
-----------------
The following are the steps to modelling Individual Uplift or persuasion which was carried out in this research.
1. Send a question (survey) asking if respondents are interested in a particular subject of interest.
2. Split the total data sample into two equal halves randomly and offer a promotion on the subject matter to one half and nothing to the other half
3. Send another post promotion survey to the total data sample to know if their opinion on the same subject matter.
4. When you retrieve the result from (3), create a binary variable called Moved_AD to indicate whether opinion has moved in favour of the subject matter or not.
5. Calculate the percentage of movement in the favour of the subject matter of those who did not get the message
6. Calculate the percentage of movement in the favour of the subject matter for those that got the message
7. Calculate the overall lift (i.e. the effect of sending the message) by subtracting (5) from (6). At this stage, we can report which respondent opinion will move in favour of the subject matter and how the message performed overall (overall lift).
8. Develop a predictive model with Moved_AD as the outcome variable and various predictor variable including the treatment message. The predictive model will predict how much positive impact the message will have on the respondents and with this, we can direct our message to those with the highest persuasion potential (propensity). 
In this research, we investigated two classification algorithms ( KNN and Random Forest)  and picked the best out of the two.


Credits
-------
DATA MINING FOR BUSINESS ANALYTICS Concepts, Techniques, and Applications in R Book of 2018 book
