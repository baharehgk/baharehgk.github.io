#!/usr/bin/env python
# coding: utf-8

# # Support Vector Regression (SVR)

# ## Importing the Relevant Libraries

# In[ ]:


import numpy as np
import pandas as pd


# ## Importing the Dataset

# In[ ]:


dataset = pd.read_csv('ENTER_THE_NAME_OF_YOUR_DATASET_HERE.csv')

dataset.head()


# ## Declaring the Dependent & the Independent Variables

# In[ ]:


X = dataset.iloc[:, :-1].values

y = dataset.iloc[:, -1].values


# In[ ]:


y = y.reshape(-1,1)


# ## Splitting the Dataset into the Training Set and Test Set

# In[ ]:


from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 0)


# ## Feature Scaling

# In[ ]:


from sklearn.preprocessing import StandardScaler


sc_X = StandardScaler()

X_train = sc_X.fit_transform(X_train)


sc_y = StandardScaler()

y_train = sc_y.fit_transform(y_train)


# ## Training the SVR Model 

# In[ ]:


from sklearn.svm import SVR

model = SVR(kernel = 'rbf')

model.fit(X_train, y_train)


# ## Predicting the Test Set Results

# In[ ]:


y_pred = sc_y.inverse_transform(model.predict(sc_X.transform(X_test)))


# ## Comparing Predicted Y with Real Y (Test Set)

# In[ ]:


data = pd.DataFrame()

pd.set_option('precision', 2)

data['Predicted_Y'] = y_pred

data['Real_Y'] = y_test

data


# ## Evaluating the Model Performance

# In[ ]:


from sklearn.metrics import r2_score

r2_score(y_test, y_pred)

