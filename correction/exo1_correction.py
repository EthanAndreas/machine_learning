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
print(x.shape)
print(y.shape)
plot_points_with_label(x, y)


#process data
model = svm.SVC(kernel='linear',class_weight='balanced')
model.fit(x,y)
plot_decision_regions(x, y, classifier=model)

#Value of points to test
pt1=np.array([[15,16]])
pt2=np.array([[-15,14]])
pt3=np.array([[3,5]])

#Value of predicton
s1=model.predict(pt1)
s2=model.predict(pt2)
s3=model.predict(pt3)

#affichage
print(s1)
print(s2)
print(s3)