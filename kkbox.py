########################################
# import packages
########################################
import os

# Essential packages
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# From customized toolbox
from tools.wrangling import *
from tools.helperOutput import *

# For modeling selection
from sklearn.model_selection import train_test_split
from sklearn.model_selection import StratifiedKFold
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import GridSearchCV
from sklearn.metrics import confusion_matrix
from sklearn.metrics import accuracy_score as as_

# Some candidates of algo
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.ensemble import BaggingClassifier
from sklearn.ensemble import VotingClassifier

# XGboost
import xgboost as xgb

'''Tensorflow
import tensorflow as tf'''

########################################
## Load data
########################################

# Setting Parameters
seed = 99	# random_state
folds = 5 	# k-folds
train_csv_path = os.path.join('..', 'data', 'kkbox.csv')
test_csv_path = os.path.join('..', 'data', 'kkbox_test.csv')

# Preprocessing
# train_sparse, target, test_sparse, ids= loadAndPreprocess(train_csv_path, test_csv_path, to_sparse_mode=True, from_pickle=False)
train_sparse, target, test_sparse, ids= loadAndPreprocess(to_sparse_mode=True, from_pickle=True)
X_train, X_test, y_train, y_test = train_test_split(train_sparse, target, train_size=0.8, random_state=seed)

# Random Forest
print(' Random Forest '.center(60,'-'))
forest = RandomForestClassifier(
	criterion='entropy', n_estimators=10, random_state=seed, max_depth=5, n_jobs=-1)
forest.fit(X_train, y_train)
y_train_pred = forest.predict(X_train)
y_test_pred = forest.predict(X_test)
print("Train score: {0:.4f} / Test score: {1:.4f}\n".format(as_(y_train, y_train_pred), as_(y_test, y_test_pred)))

# XGBoost
print(' XGboostClassifier '.center(60,'-'))

params = {
	'objective': 'binary:logistic',
	'eta': 0.6,
	'max_depth': 10,
	'silent': 1,
	'eval_metric': 'auc',
	'subsample': 0.5,
	'colsample_bytree ': 0.7,
	'min_child_weight': 2
}

d_train = xgb.DMatrix(X_train, label=y_train)
d_test = xgb.DMatrix(X_test, label=y_test) 

eval_set = [(X_train, y_train), (X_test, y_test)]
watchlist = [(d_train, 'train'), (d_test, 'test')]
xgbt = xgb.train(params, d_train, 105, watchlist, early_stopping_rounds=20, maximize=True, verbose_eval=10)
saveModelHelper(xgbt)
xgbOutputHelper(xgbt)

# kfold = StratifiedKFold(n_splits=folds, random_state=seed)
# kfold = kfold.split(X_train, y_train)
# results = cross_val_score(xgb, X_train, y_train, cv=kfold)
# print("Accuracy: %.2f%% (%.2f%%)" % (results.mean()*100, results.std()*100))
# y_train_pred = forest.predict(X_train)
# y_test_pred = forest.predict(X_test)
# print("Train score: {0:.4f} / Test score: {1:.4f}\n".format(as_(y_train, y_train_pred), as_(y_test, y_test_pred)))

'''# Adaboost
from sklearn.ensemble import AdaBoostClassifier
print(' Adaboost '.center(60,'-'))
tree = DecisionTreeClassifier(criterion='entropy', max_depth=3, random_state=seed)
ada = AdaBoostClassifier(base_estimator=tree, n_estimators=500, learning_rate=0.1, random_state=seed)
ada = ada.fit(X_train, y_train)
y_train_pred = ada.predict(X_train)
y_test_pred = ada.predict(X_test)
print("Train score: {0:.4f} / Test score: {1:.4f}\n".format(as_(y_train, y_train_pred), as_(y_test, y_test_pred)))

# BaggingClassifier
print(' BaggingClassifier '.center(60,'-'))
tree = DecisionTreeClassifier(criterion='entropy', max_depth=3, random_state=seed)
bag = BaggingClassifier(
					base_estimator=tree, 
					n_estimators=50, 
					max_samples=1.0, 
					max_features=1.0, 
					bootstrap=True,
					bootstrap_features=False,
					n_jobs=-1,
					random_state=seed)
tree = tree.fit(X_train, y_train)
y_train_pred = tree.predict(X_train)
y_test_pred = tree.predict(X_test)
print("Result from DecisionTreeClassifier:")
print("Train score: {0:.4f} / Test score: {1:.4f}".format(as_(y_train, y_train_pred), as_(y_test, y_test_pred)))
print("Here we use DTC as a base estomator of BaggingClassifier.")

bag = bag.fit(X_train, y_train)
y_train_pred = bag.predict(X_train)
y_test_pred = bag.predict(X_test)
print("Result from BaggingClassifier:")
print("Train score: {0:.4f} / Test score: {1:.4f}\n".format(as_(y_train, y_train_pred), as_(y_test, y_test_pred)))
'''
