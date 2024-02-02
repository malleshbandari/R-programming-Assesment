#Task----------------1
# Exploratory data analysis:
#Load the dataset and the relevant libraries
# Install and load the readxl package
install.packages("readxl")
library(readxl)
Data=read_excel(file.choose())
head(Data)

#Perform data type conversion of the attributes
str(Data)
Data$dteday <- as.Date(Data$dteday)
str(Data)

#Carry out the missing value analysis
missing_values <- colSums(is.na(Data))
print(missing_values)## As per the missing_values summary there is no missing values in dataset

#TASK-----------2
#Attributes distribution and trends
library(ggplot2)
#Plot monthly distribution of the total number of bikes rented
# Plot monthly distribution
ggplot(Data, aes(x = mnth, y = cnt, fill = factor(mnth))) +
  geom_bar(stat = "identity") +
  labs(title = "Monthly Distribution of Bikes Rented",
       x = "Month",
       y = "Total Number of Bikes Rented") +
  theme_minimal()
#Plot yearly distribution of the total number of bikes rented
ggplot(Data, aes(x = yr, y = cnt, fill = factor(yr))) +
  geom_bar(stat = "identity") +
  labs(title = "Yearly Distribution of Bikes Rented",
       x = "Year",
       y = "Total Number of Bikes Rented") +
  theme_minimal()
#Plot boxplot for outliers' analysis
ggplot(Data, aes(x = factor(yr), y = cnt)) +
  geom_boxplot(fill = "lightblue") +
  labs(title = "Boxplot for Outliers' Analysis",
       x = "Year",
       y = "Total Number of Bikes Rented") +
  theme_minimal()

#TASK------------3
# Split the dataset into train and test dataset
# Independent variables
X <- Data[, !(names(Data) %in% c("cnt", "instant"))]
# Traget variable
y <- Data$cnt
head(X)
head(y)
install.packages("caret")
library(caret)
set.seed(123)
# Create an index for splitting data
index <- createDataPartition(y, p = 0.8, list = FALSE)

# Split features and target into training and testing sets
X_train <- X[index, ]
X_test <- X[-index, ]
y_train <- y[index]
y_test <- y[-index]

#TASK-----------------4
#Create a model using the random forest algorithm
install.packages("randomForest")
library(randomForest)

# Create a random forest model
rf_model <- randomForest(y_train ~ ., data = X_train, ntree = 100)

# Print the model summary
print(rf_model)

#Task---------5
# Make predictions on the test set
predictions <- predict(rf_model, newdata = X_test)

# Print or inspect the predictions
print(predictions)

# Calculate Mean Absolute Error (MAE)
mae <- mean(abs(y_test - predictions))
cat("Mean Absolute Error (MAE):", mae, "\n")

# Calculate Root Mean Squared Error (RMSE)
rmse <- sqrt(mean((y_test - predictions)^2))
cat("Root Mean Squared Error (RMSE):", rmse, "\n")

# Calculate R-squared
rsquared <- 1 - (sum((y_test - predictions)^2) / sum((y_test - mean(y_test))^2))

cat("R-squared:", rsquared, "\n")


### testing whether model overfitting or not


model <- randomForest(y_train ~ ., data = X_train, ntree = 100)
# Predictions on the training set
predictions_train <- predict(model, newdata = X_train)

# Predictions on the test set
predictions_test <- predict(model, newdata = X_test)

# Evaluate performance on the training set
mae_train <- mean(abs(y_train - predictions_train))
rmse_train <- sqrt(mean((y_train - predictions_train)^2))
cat("Training Set - MAE:", mae_train, " | RMSE:", rmse_train, "\n")

# Evaluate performance on the test set
mae_test <- mean(abs(y_test - predictions_test))
rmse_test <- sqrt(mean((y_test - predictions_test)^2))
cat("Test Set - MAE:", mae_test, " | RMSE:", rmse_test, "\n")




# Train the model with regularization
model <- randomForest(y_train ~ ., data = X_train, mtry = sqrt(ncol(X_train)))

# Predict on the test set
predictions <- predict(model, newdata = X_test)

# Evaluate performance
mae <- mean(abs(y_test - predictions))
rmse <- sqrt(mean((y_test - predictions)^2))
cat("Test Set - MAE:", mae, " | RMSE:", rmse, "\n")



##HYPER PARAMETER TUNNING
#Combine features and target into a data frame
train_data <- cbind(X_train, y_train)

# Set up the train control for cross-validation
ctrl <- trainControl(method = "cv", number = 10)

# Tune hyperparameters using random search
set.seed(123)
tuned_model <- train(
  y_train ~ ., 
  data = train_data,  # Use the combined data
  method = "rf", 
  trControl = ctrl, 
  tuneLength = 15
)
# Get the best model
best_model <- tuned_model$finalModel

# Assess performance on the test set
predictions_test <- predict(best_model, newdata = X_test)
mae_test <- mean(abs(y_test - predictions_test))
rmse_test <- sqrt(mean((y_test - predictions_test)^2))

cat("Tuned Model - Test Set MAE:", mae_test, " | RMSE:", rmse_test, "\n")

# Calculate R-squared
rsquared <- 1 - (sum((y_test - predictions_test)^2) / sum((y_test - mean(y_test))^2))

cat("R-squared:", rsquared, "\n")

