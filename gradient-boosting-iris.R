# Install and load the necessary package
if (!require(gbm)) install.packages("gbm")
library(gbm)

# Load the iris dataset
data("iris")

# View the first few rows of the dataset
head(iris)

# Encode the response variable as a factor
iris$Species <- as.numeric(as.factor(iris$Species)) - 1

# Split the data into training and testing sets
set.seed(123)  # For reproducibility
train_indices <- sample(1:nrow(iris), size = 0.7 * nrow(iris))
train_data <- iris[train_indices, ]
test_data <- iris[-train_indices, ]

# Train a Gradient Boosting model to predict Species
gbm_model <- gbm(Species ~ ., 
                 data = train_data, 
                 distribution = "multinomial", 
                 n.trees = 100, 
                 interaction.depth = 3, 
                 shrinkage = 0.1, 
                 n.minobsinnode = 10,
                 cv.folds = 5,
                 n.cores = NULL, 
                 verbose = FALSE)

# Print the model summary
summary(gbm_model)

# Make predictions on the test set
predictions_prob <- predict(gbm_model, test_data, n.trees = gbm_model$n.trees, type = "response")
predictions <- apply(predictions_prob, 1, which.max) - 1

# Convert predictions back to factor levels
predictions <- factor(predictions, levels = 0:2, labels = levels(iris$Species))

# Print the predictions
print(predictions)

# Evaluate the model by comparing predictions to actual values
confusion_matrix <- table(predictions, factor(test_data$Species, levels = 0:2, labels = levels(iris$Species)))
print(confusion_matrix)

# Calculate accuracy
accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
print(paste("Accuracy:", accuracy))

