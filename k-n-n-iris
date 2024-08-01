# Install and load the necessary package
if (!require(class)) install.packages("class")
library(class)

# Load the iris dataset
data("iris")

# View the first few rows of the dataset
head(iris)

# Split the data into training and testing sets
set.seed(123)  # For reproducibility
train_indices <- sample(1:nrow(iris), size = 0.7 * nrow(iris))
train_data <- iris[train_indices, ]
test_data <- iris[-train_indices, ]

# Separate features and labels
train_features <- train_data[, -5]
train_labels <- train_data[, 5]
test_features <- test_data[, -5]
test_labels <- test_data[, 5]

# Scale the features (important for KNN)
train_features <- scale(train_features)
test_features <- scale(test_features)

# Train a KNN model to predict Species
k <- 3  # Number of neighbors
predictions <- knn(train = train_features, test = test_features, cl = train_labels, k = k)

# Print the predictions
print(predictions)

# Evaluate the model by comparing predictions to actual values
confusion_matrix <- table(predictions, test_labels)
print(confusion_matrix)

# Calculate accuracy
accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
print(paste("Accuracy:", accuracy))
