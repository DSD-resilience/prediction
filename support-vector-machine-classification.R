# Install and load the necessary package
if (!require(e1071)) install.packages("e1071")
if (!require(caret)) install.packages("caret")

library(e1071)
library(caret)

# Load the iris dataset
data("iris")

# View the first few rows of the dataset
head(iris)

# Split the data into training and testing sets
set.seed(123)  # For reproducibility
train_index <- createDataPartition(iris$Species, p = 0.7, list = FALSE)
train_data <- iris[train_index, ]
test_data <- iris[-train_index, ]

# Train a Support Vector Machine model to predict Species
svm_model <- svm(Species ~ ., data = train_data, kernel = "linear")

# Summarize the model
summary(svm_model)

# Make predictions on the test set
predictions <- predict(svm_model, newdata = test_data)

# Evaluate the model by comparing predictions to actual values
confusion_matrix <- confusionMatrix(predictions, test_data$Species)
print(confusion_matrix)
