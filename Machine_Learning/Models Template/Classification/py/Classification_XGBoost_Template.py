#!/usr/bin/env python
# coding: utf-8

# # XGBoost Classification

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


# ## Splitting the Dataset into the Training Set and Test Set

# In[ ]:


from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.25, random_state = 0)


# ## Training the XGBoost Classification Model

# In[ ]:


from xgboost import XGBClassifier

model = XGBClassifier()

model.fit(X_train, y_train)


# ## Predicting the Test Set Results

# In[ ]:


y_pred = model.predict(X_test)


# ## Confusion Matrix

# In[ ]:


from sklearn.metrics import confusion_matrix, accuracy_score

cm = confusion_matrix(y_test, y_pred)

accuracy = accuracy_score(y_test, y_pred)

print("Accuracy is: ", accuracy, "\n\n Confusion Matrix:\n\n ", cm)

