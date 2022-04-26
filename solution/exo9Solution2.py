import numpy as np
from generateData import generate_random_dataset_high_dimension
from sklearn.model_selection import StratifiedKFold
from sklearn.metrics import make_scorer,balanced_accuracy_score
from sklearn.ensemble import RandomForestClassifier
from sklearn.feature_selection import SelectFromModel
from sklearn.pipeline import Pipeline
from sklearn.model_selection import GridSearchCV
# Generate dataset
size = 100
dataset = generate_random_dataset_high_dimension(size)

columns = []
for i in range(10000):
  columns.append('x'+str(i))   

features = dataset[columns]
label = dataset['target']
x = features.values
y = label.values


p_grid = {"model1__estimator__min_samples_split"     : [20,30],
          "model2__min_samples_split"     : [20,30]}
          
forest2 = RandomForestClassifier(n_estimators=1000,class_weight='balanced_subsample',criterion='entropy',min_samples_split=20,max_features='sqrt',max_samples=0.4)
new_model = Pipeline([('model1',SelectFromModel(RandomForestClassifier(n_estimators=1000,class_weight='balanced_subsample',criterion='entropy',min_samples_split=20,max_features='sqrt',max_samples=0.4), prefit=False)), ('model2', forest2)])


res=[]
skf = StratifiedKFold(n_splits=2,shuffle=True,random_state=3)
for train_index, test_index in skf.split(x, y):
   X_train, X_test = x[train_index], x[test_index]
   y_train, y_test = y[train_index], y[test_index] 
   grid = GridSearchCV(estimator=new_model, param_grid=p_grid,scoring=make_scorer(balanced_accuracy_score,needs_proba=False), cv=3)
   grid.fit(X_train, y_train) 
   y_pred = grid.predict(X_test);
   res.append(balanced_accuracy_score(y_test,y_pred))

print(np.mean(res))
print(np.std(res))
          



