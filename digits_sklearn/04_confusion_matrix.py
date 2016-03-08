from __future__ import print_function
import numpy
from sklearn import metrics
import sys


test_targets = numpy.load('test_targets.npy')
predicted_targets = numpy.load('predicted_targets.npy')

confusion_matrix = metrics.confusion_matrix(test_targets, predicted_targets)
print("Confusion matrix:", file=sys.stderr)
print(confusion_matrix)
numpy.save('confusion_matrix.npy', confusion_matrix)
