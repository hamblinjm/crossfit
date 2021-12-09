---
title: "Predicting Crossfit Rank from Athletes' Profiles"
layout: post
author: jessica-hamblin, skimbal_22, bradenwellman
post-image: /
description: Show how using athlete's profiles provides some information to predict how well they will do in competition.
tags:
- regression
- knn
- decision tree
- crossfit
- athlete
---

# Predicting Crossfit Competition Rank from Athletes' Profiles

Our group was interested in finding out how to design personalized workouts that would help an individual improve the most. To do this, we found a database of 
crossfit athletes that included each athlete's rank in the 2015 crossfit competition as well as information from each athlete's profile, including their eating habits, 
workout habits, and personal bests in several exercises. The idea is that if we can find certain exercises or habits that are strong indicators of ranking well in competition, 
we could build those exercises and habits into a workout and diet regimen to help an individual boost his/her performance.

## Data

### Predictors

Our data consisted of two excel files. In the first one (athletes) it had information in regards to each individual athlete. It had the athlete’s id, team, region, gender, age, height, weight, and their scores (times or reps) in many different exercises. Some of these exercises were specific to crossfit like “fran”, “helen”, “grace”, and the “filthy50”. There were also some columns that had the athlete’s responses in regards to their training experience, how long they have been training for, as well as their eating habits. 

The second excel file has the athlete’s id (which is what we used to join the two), score, and their rank. The rank is what we used as the value to be predicted (the response variable). 
At first glance this data seemed to be tidy already, but there happened to be many issues that we did not anticipate. These issues required quite a bit of cleaning time. 

### Cleaning

The columns that included the athlete’s responses in regards to their previous sports/exercise experience had some extra cleaning that needed to be done. We needed to separate the columns based on where there was a “|” because that is what separated different options that they could have chosen as their response. 

<img width="641" alt="train_column" src="https://user-images.githubusercontent.com/77635875/145333633-d88e5ca8-4365-46af-81d4-b0f2618c523f.png">


And they were allowed to choose multiple options. However, we found logic issues where one of these athletes would have selected the “I have no athletic background besides CrossFit” option, along with “I Played College Sports”. A combination of these types of responses may have contributed negatively in our models’ overall performance in predicting the outcomes.

We were able to separate the columns based on where there was a “|”, but we were not able to have the time to come up with a feasible way to remove logic errors from the thousands of athlete’s responses.

We then realized as we were checking each of the columns’ summaries that included the means as well as the standard deviations that some of the numbers made no sense whatsoever. For example, in the pullups column there were several responses that were recorded at 1000, and even one as high as 2,147,483,647. These values were obviously ridiculous in comparison to the histograms for each individual column. We had to remove the rows that had the absurd values by choosing a max and min (yes, there were even several negative pullups that were recorded). 

<img width="187" alt="absurd_pullups" src="https://user-images.githubusercontent.com/77635875/145333601-65909fa3-89a5-40c7-b9d8-6d577958a926.png">


## Models
### Tested models

### Best model


## Conclusion
Even with our best model, we couldn't make very accurate predictions on how well an athlete will rank in competition. This makes sense because...
