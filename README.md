# R-programming-Assesment.
# Bike Rental Prediction Model

## Introduction

This project focuses on predicting bike rentals using a random forest algorithm in R. The dataset contains information about daily bike rentals, including various attributes such as weather conditions, temperature, and the total number of bikes rented.

## Tasks

### Task 1: Exploratory Data Analysis

- Load the dataset using the `readxl` package.
- Perform data type conversion for attributes, specifically converting the "dteday" attribute to a Date type.
- Conduct missing value analysis; no missing values were found in the dataset.

### Task 2: Attributes Distribution and Trends

- Visualize the monthly and yearly distribution of bikes rented using `ggplot2`.
- Create boxplots for outliers' analysis.

### Task 3: Data Splitting

- Split the dataset into training and testing sets using the `caret` package.

### Task 4: Random Forest Model Creation

- Create a random forest model using the `randomForest` package.
- Print the model summary.

### Task 5: Model Evaluation

- Make predictions on the test set and calculate Mean Absolute Error (MAE), Root Mean Squared Error (RMSE), and R-squared for model evaluation.
- Test whether the model is overfitting by comparing performance on the training and test sets.

### Task 6: Model with Regularization

- Train the model with regularization to improve generalization.
- Evaluate the performance of the regularized model.

### Task 7: Hyperparameter Tuning

- Combine features and target into a data frame for hyperparameter tuning.
- Set up cross-validation and tune hyperparameters using random search.
- Assess the performance of the tuned model on the test set.

## Files

- `your_script.R`: R script containing the code for data analysis and model building.
- `your_dataset.xlsx`: Dataset used for analysis.

## Usage

1. Install the required packages by running the package installation commands.
2. Load the dataset using `file.choose()` and follow the provided tasks in the script.
