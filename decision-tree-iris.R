# Install and load the necessary package
if (!require(rpart)) install.packages("rpart")
library(rpart)

# Load the iris dataset
data("iris")

# View the first few rows of the dataset
head(iris)

# Split the data into training and testing sets
set.seed(123)  # For reproducibility
train_indices <- sample(1:nrow(iris), size = 0.7 * nrow(iris))
train_data <- iris[train_indices, ]
test_data <- iris[-train_indices, ]

# Train a decision tree model to predict Species
model <- rpart(Species ~ ., data = train_data, method = "class")

# Summarize the model
summary(model)

# Visualize the decision tree
plot(model)
text(model, use.n = TRUE)

# Make predictions on the test set
predictions <- predict(model, test_data, type = "class")

# Print the predictions
print(predictions)

# Evaluate the model by comparing predictions to actual values
confusion_matrix <- table(predictions, test_data$Species)
print(confusion_matrix)

# Calculate accuracy
accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
print(paste("Accuracy:", accuracy))

