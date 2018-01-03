import os
import pandas as pd
import numpy as np

from sklearn.preprocessing import LabelEncoder, OneHotEncoder
from sklearn.model_selection import train_test_split
from sklearn.metrics import roc_auc_score
import scipy.sparse as sp
from fastFM import als

"""

RUN R SCRIPT --------------- subset_for_FM.R

"""

#original df
train_test_df_path = os.path.join('..','data','df_FM.csv')
train_target_path = os.path.join('..','data','train_target.csv')

#songs infos dataset
#TODO implements this dataset in the FM -content filtering- method
songs_info = os.path.join('..','data','songs.csv')

def convert_to_FM_DF(train_test_df_path, train_target_path):
    le = LabelEncoder()
    oe = OneHotEncoder()
    df = pd.read_csv(train_test_df_path, encoding = 'UTF-8')
    target = pd.read_csv(train_target_path)
    
    target.loc[np.where(target == 0)[0]+1,] = -1
    
    msno = le.fit_transform(df.msno)
    msno = pd.DataFrame(msno)
    msno = oe.fit_transform(msno)
    
    song_id = le.fit_transform(df.song_id)
    song_id = pd.DataFrame(song_id)
    song_id = oe.fit_transform(song_id)
    
    sparse_df = sp.hstack((msno, song_id), format='csr')
    
    train_sparse = sparse_df[:7377418,]
    test_sparse = sparse_df[7377418:,]
    
    target = target.x

    
    return test_sparse, train_sparse, target
    
def train_model(train_sparse, target):
    
    X = train_sparse
    y = target
    
    X_train, X_test, y_train, y_test = train_test_split(X, y)
    
    fm = als.FMClassification(n_iter = 100, rank = 8)
    fm.fit(X_train, y_train)
    
    y_pred = fm.predict(X_test)
    
    score = roc_auc_score(y_test, y_pred)
    
    print("score = "+str(score))
    
    return fm
    
    
test_sparse, train_sparse, target = convert_to_FM_DF(train_test_df_path, train_target_path)
fm = train_model(train_sparse, target)
y_hat = fm.predict(test_sparse)

save_predictions_path = os.path.join('..','data','FM_answers.csv')

np.savetxt(save_predictions_path, y_hat, delimiter = ',')
"""

RUN R SCRIPT --------------- reassemble_test_df.R

"""
