from generateData import generate_random_dataset_linear_separable
from sklearn import svm
from fig import plot_points_with_label, plot_decision_regions
import numpy as np


# Generate dataset
size = 2000
dataset = generate_random_dataset_linear_separable(size)
features = dataset[['x', 'y']]
label = dataset['target']

x = features.values
y = label.values


plot_points_with_label(x, y)


#process data
model = svm.SVC(kernel='linear',class_weight='balanced')
model.fit(x,y)
plot_decision_regions(x, y, classifier=model)

#process new data
#On peut utiliser deux manieres 
#x_test = np.empty((3,2)) #maniere 1
#x_test[0][0]=15
#x_test[0][1]=16
#x_test[1][0]=-15
#x_test[1][1]=-14
#x_test[2][0]=3
#x_test[2][1]=5
x_test = np.array([[15, 16],[-15 ,-14],[3, 5]]) #maniere 2
y_test = model.predict(x_test)
print(y_test)




