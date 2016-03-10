import numpy
from sklearn import datasets


# The digits dataset
digits = datasets.load_digits()

# To apply a classifier on this data, we need to flatten the image, to
# turn the data in a (samples, feature) matrix:
n_samples = len(digits.images)
data = digits.images.reshape((n_samples, -1))

# We select the first half of the dataset for training
training_data = data[:n_samples / 2]
training_targets = digits.target[:n_samples / 2]
# and the rest for evaluation
test_data = data[n_samples / 2:]
test_targets = digits.target[n_samples / 2:]

numpy.save('train_data.npy', training_data)
numpy.save('train_targets.npy', training_targets)
numpy.save('test_data.npy', test_data)
numpy.save('test_targets.npy', test_targets)
