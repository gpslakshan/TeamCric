import numpy as np
import pandas as pd
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
import pickle

# Load the Dataset
df = pd.read_excel('cricket_data.xlsx', 'bowling')
print(df.head())

# Removing Batsmen from the bowling dataframe
df = df.dropna()
df = df.drop(index=df[df['player_role'] == 'BAT'].index)

o_conditions = [
    (df['O'] > 3),
    (df['O'] > 2) & (df['O'] <= 3),
    (df['O'] > 1) & (df['O'] <= 2),
    (df['O'] > 0) & (df['O'] <= 1),
    (df['O'] == 0)
]

o_values = [
    1,
    0.75,
    0.5,
    0.25,
    0
]

df['O_points'] = np.select(o_conditions, o_values)

m_conditions = [
    (df['M'] > 0),
    (df['M'] <= 0)
]

m_values = [
    1,
    0
]

df['M_points'] = np.select(m_conditions, m_values)

w_conditions = [
    (df['W'] > 3),
    (df['W'] > 2) & (df['W'] <= 3),
    (df['W'] > 1) & (df['W'] <= 2),
    (df['W'] > 0) & (df['W'] <= 1),
    (df['W'] <= 0)
]

w_values = [
    1,
    0.75,
    0.5,
    0.25,
    0
]

df['W_points'] = np.select(w_conditions, w_values)

er_conditions = [
    (df['ER'] <= 1),
    (df['ER'] > 1) & (df['ER'] <= 3),
    (df['ER'] > 3) & (df['ER'] <= 7),
    (df['ER'] > 7) & (df['ER'] <= 10),
    (df['ER'] > 10)
]

er_values = [
    1,
    0.75,
    0.5,
    0.25,
    0
]

df['ER_points'] = np.select(er_conditions, er_values)

# Calculating the Performance Index of Each Player
df['performance_index'] = df['O_points'] + df['M_points'] + df['W_points'] + df['ER_points']


performance_conditions = [
    (df['performance_index'] > 1.50),
    (df['performance_index'] >= 1.00) & (df['performance_index'] <= 1.50),
    (df['performance_index'] < 1),
]

performance_values = [
    "High",
    "Medium",
    "Low"
]

df['performance'] = np.select(performance_conditions, performance_values)
df = df.filter(['player', 'player_role', 'team_name', 'opp_name', 'venue', 'performance'])

#Label Encoding the Data
le_player = LabelEncoder()
le_opp_name = LabelEncoder()
le_venue = LabelEncoder()
df['player_id'] = le_player.fit_transform(df['player'])
df['opp_id'] = le_opp_name.fit_transform(df['opp_name'])
df['venue_id'] = le_venue.fit_transform(df['venue'])

# Select Independant and Dependant Variables
inputs = df.filter(['player_id', 'opp_id', 'venue_id'])
target = df['performance']

# Split the dataset into train and test
X_train, X_test, y_train, y_test = train_test_split(inputs, target, test_size=0.2)

# Instantiate the model
model = RandomForestClassifier(n_estimators=200)

# Train the model
model.fit(X_train, y_train)

# Make pickle file of our model
pickle.dump(model, open('bowling_model.pkl', 'wb'))
