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
We tried three different models:
* KNN
* Decision Tree
* Bagged Decision Tree

### KNN

For the knn regression model we tried several different approaches to finding good predictors for the model to get the lowest root mean squared error value. 

This first image shows an example of where we would only use one predictor in order to predict for the rank variable. This specific picture is when we used the "candj" column which seemed to be a better predictor than most. Some of the worst predictors were age and weight where it didn't seem to have any trend in regards to someone having a better rank based on if they were a younger athlete.

(The next few picture examples are subsetted for the female athletes because we were trying to see if we could predict rank better if we had the male and female athletes in separate prediction models)

<img width="416" alt="candj_subset_female" src="https://user-images.githubusercontent.com/77635875/145334164-b3a8e249-6aeb-4de2-9198-d232a07eb293.png">

You can see that the scale goes up to values as high as 80000. A lower rank means that you are performing better, so in this case rank is similar to a golf score in the sense that lower is better. Hopefully someone doesn't get a golf score of 80000.

In this next picture it shows our next approach of using all of the predictors in the knn regression model. We got a rmse value as low as 9126 when the nearest neighbor parameter was 3. Which is fairly high, however, it is on a scale of 80000. 

<img width="339" alt="rmse_female_full" src="https://user-images.githubusercontent.com/77635875/145334358-502ca264-0e33-454c-bed5-4bd78043f9ed.png">

While doing the individual approach we were able to see a few predictors that tended to have more of a trend than some of the other predictors. We were then able to do another knn model where it was trained but based on a subset of those predictors that seemed to trend better with the rank response variable. These better predictors were 'helen', 'grace', 'fran', 'pullups', and 'backsq' (back squat). From this picture you can see that with a nearest neighbor parameter of 3 the rmse was able to drop as low as 8540. This value is still quite high on the scale of 80000, but was fairly lower than the 9126 that we got from using all of the predictors. 

<img width="336" alt="subset_rmse_female" src="https://user-images.githubusercontent.com/77635875/145334480-0f26f3dd-0cae-4154-b517-b366a26c65bd.png">


### Decision Tree
We also tried a decision tree model. The parameters we used for this model included age, height, weight, gender, personal bests for several exercises, workout habits, sports experience, and diet. We did not rerun this model with different subsets of predictors.
To build the decision tree model, we used a `StandardScaler` to get all the data on the same scale, and then we used a `GridSearchCV` to test the values 1-50 for the `max_depth` hyperparameter. With `random_state = 0`, we found that the best value of `max_depth` was 16. Using that value produced a model with RMSE = 8970 and R^2 = 0.8429.

### Bagging 
We thought that bagging would improve the performance of our decision tree, so we tried that as well. The bagging regressor with `base_estimator` equal to our decision tree increased R^2 to be 0.8968 (compared to 0.8429 from the decision tree alone) and decreased RMSE to be about 7269 (compared to 8970). This is a great improvement.


## Conclusion
The model with the best RMSE and R^2 was the bagging model built off of our decision tree. With this model we can make decent predictions, even if they are still a little off from how well an athlete really ranks in competition. This makes sense because looking at the individual trends from each exercise plotted against the rank, in most cases, there is not a strong correlation. Knowing that the correlation is fairly weak and that the rank ranges from about 1-80,000, our best model's RMSE of 7269 is fairly good.

![image](https://user-images.githubusercontent.com/65671142/145696774-9fa04a0b-493d-4a20-9891-81feae1ab81e.png)

