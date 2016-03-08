import numpy
import pickle


with open('classifier.pkl', 'rb') as fp:
    classifier = pickle.load(fp)

test_data = numpy.load('test_data.npy')

# Now predict the value of the digit on the second half:
predicted = classifier.predict(test_data)
numpy.save('predicted_targets.npy', predicted)
