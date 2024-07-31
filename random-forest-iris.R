# Install and load the necessary package
if (!require(randomForest)) install.packages("randomForest")
library(randomForest)

# Load the iris dataset
data("iris")

# View the first few rows of the dataset
head(iris)

# Split the data into training and testing sets
set.seed(123)  # For reproducibility
train_indices <- sample(1:nrow(iris), size = 0.7 * nrow(iris))
train_data <- iris[train_indices, ]
test_data <- iris[-train_indices, ]

# Train a Random Forest model to predict Species
rf_model <- randomForest(Species ~ ., data = train_data, ntree = 100)

# Print the model summary
print(rf_model)

# Make predictions on the test set
predictions <- predict(rf_model, test_data)

# Print the predictions
print(predictions)

# Evaluate the model by comparing predictions to actual values
confusion_matrix <- table(predictions, test_data$Species)
print(confusion_matrix)

# Calculate accuracy
accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
print(paste("Accuracy:", accuracy))

