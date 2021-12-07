# Crossfit data

# Read in athlete and leader
athlete <- read.csv('athlete.csv')
leader <- read.csv('leader.csv')

names(leader)

# Head
head(leader)
head(athlete)

# Names let's check them out
names(athlete)
names(leader)

# Different values for training
table(athlete$train)
unique(athlete$train) # 85

# Eating
head(athlete$eat, n = 20)
table(athlete$eat)
unique(athlete$eat) # 49

# What are these things? Grace?
head(athlete$grace, n = 100)

# Need the tidyverse
library(tidyverse)

# Create our plot function
scatter <- function(data) {
  
  # Pipe the data
  data %>%
    
    # Create our ggplot object
    ggplot(mapping = aes(x = rank, y = score)) +
    
    # Make it a scatterplot
    geom_point()
  
}

# Creating different subsets of the data to look at Rank V Score
sample <- sample(1:1000, 500)
subset <- leader[sample, ]

# Next sample of bigger n
sample2 <- sample(1:10000, 5000)
subset2 <- leader[sample2, ]

# Even bigger
sample3 <- sample(1:100000, 50000)
subset3 <- leader[sample3, ]

# Biggest
sample4 <- sample(1:nrow(leader), 10000)
subset4 <- leader[sample4, ]

# Plotting them all
par(mfrow = c(2, 2)) # Why isn't this working?
scatter(subset)
scatter(subset2)
scatter(subset3) # What is going on?
scatter(subset4) # WHAT ????????????
par(mfrow=c(1,1))

# How many rows are in leader?
nrow(leader) # 1572222

# NOTE: The data *seems* to be ordered? In sample 1 (where the obversation 
# vals only went up to 1000) only that first graph is showing up. We're 
# definitely need to figure out which factors are causing the different lines


# Looking at the data, it might be ordered by division?
table(subset2$division)
table(subset4$division)

# ADDENDUM: This hypothesis seems correct. All of our data points in the first 2 subsets
# are in division 1. However, subset 4 begings the new division. The data is ordered, but 
# the random sampling wasn't effective because I didn't sample over the million rows.


# Just found out about pirate plots so i want to try them
pirateplot(score ~ division, 
           data = subset4, 
           pal = "info", theme = 3)

install.packages('pirateplot')
library(pirateplot)

# Aww, this package isn't available in this version of R :(

athlete %>%
  select(pullups) %>%
  arrange(desc(pullups)) %>%
  head(n = 100)

max(athlete$backsq, na.rm = TRUE)
max(athlete$helen, na.rm = TRUE)



# Histogram
athlete %>%
  filter(backsq < 1000) %>%
  ggplot(mapping = aes(x = backsq)) +
  geom_histogram()

# Pullups
athlete %>%
  filter(pullups < 74 & pullups > 30) %>%
  arrange(desc(pullups)) %>%
  nrow()

names(athlete)

# Just for testing
athlete %>%
  drop_na(train) %>%
  head(n = 100) %>%
  select(athlete_id, team, train) -> train
  
# String detection
str_detect(train$train, "I workout mostly") -> vals
train$present <- vals

# Merging everything
df = merge(x=athlete,y=leader,by="athlete_id")
df2 = merge(x=athlete,y=leader,by="athlete_id", all = TRUE)

# Number of missing values
df %>%
  summarise_all(funs(sum(is.na(.))))

df2 %>%
  summarise_all(funs(sum(is.na(.))))


hist(df2$pullups)

histies <- function(variable, limit) {
  
  athlete %>%
    filter(variable < limit) %>%
    ggplot(mapping = aes(x = variable)) +
    geom_histogram()
  
}

nrow(df)
nrow(df2)

df %>%
  drop_na() -> this

head(this)
nrow(this)

names(this)

this %>%
  filter(pullups < 74) %>%
  ggplot(mapping = aes(x = pullups)) +
  geom_histogram()


