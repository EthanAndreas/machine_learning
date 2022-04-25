from sklearn import svm
from generateData import generate_random_dataset_xor
from fig import plot_points_with_label, plot_decision_regions
from sklearn.metrics import confusion_matrix

def process(model,x,y):
    model.fit(x,y)    
    plot_decision_regions(x, y, classifier=model)    
    y_predict = model.predict(x)
    CM = confusion_matrix(y,y_predict,normalize='true')
    print("avec les donnees d entraitement : pourcentage moyen : {}".format(0.5*(CM[1][1]+CM[0][0])))
    
# Generate dataset
size = 200
dataset = generate_random_dataset_xor(size)
features = dataset[['x', 'y']]
label = dataset['target']
x = features.values
y = label.values
plot_points_with_label(x, y)

# SVM RBF
for g in [0.001,0.01,0.1,1,10,100]:
    print("--- Traitement avec gamma = {} -----".format(g))
    model = svm.SVC(kernel='rbf',class_weight='balanced',gamma=g)
    process(model,x,y)
    
    
        


