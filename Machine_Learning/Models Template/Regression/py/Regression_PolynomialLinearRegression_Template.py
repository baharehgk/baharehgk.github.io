#!/usr/bin/env python
# coding: utf-8

# # Polynomial Regression

# ## Importing the Relevant Libraries

# In[ ]:


import numpy as np
import pandas as pd


# ## Importing the Dataset

# In[ ]:


df = pd.read_csv('ENTER_THE_NAME_OF_YOUR_DATASET_HERE.csv')

df.head()


# ## Declaring the Dependent & the Independent Variables

# In[ ]:


X = df.iloc[:, :-1].values

y = df.iloc[:, -1].values


# ## Splitting the Dataset into the Training Set and Test Set

# In[ ]:


from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 0)


# ## Training the Polynomial Regression Model 

# In[ ]:


from sklearn.preprocessing import PolynomialFeatures

poly_reg = PolynomialFeatures(degree = 4)

X_poly = poly_reg.fit_transform(X_train)


# In[ ]:


from sklearn.linear_model import LinearRegression

model = LinearRegression()

model.fit(X_poly, y_train)


# ## Predicting the Test set results

# In[ ]:


y_pred = model.predict(poly_reg.transform(X_test))


# ## Comparing Predicted Y with Real Y  (Test Set)

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


# In[ ]:




