import numpy
import pickle
from sklearn import svm


training_data = numpy.load('train_data.npy')
training_targets = numpy.load('train_targets.npy')

# Create a classifier: a support vector classifier
classifier = svm.SVC(gamma=0.001)

# We learn the digits on the first half of the digits
classifier.fit(training_data, training_targets)

with open('classifier.pkl', 'wb') as fp:
    pickle.dump(classifier, fp, 2)
