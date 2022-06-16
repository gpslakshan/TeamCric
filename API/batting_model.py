import numpy as np
import pandas as pd
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
import pickle

# Load the Dataset
df = pd.read_excel('cricket_data.xlsx', 'batting')
print(df.head())

# Handling the missing values
df = df.dropna()
df = df.drop(index=df[df['player_role'] == 'BOWL'].index)

# Adding the 'Runs Points' Column
r_conditions = [
    (df['R'] >= 30),
    (df['R'] >= 20) & (df['R'] < 30),
    (df['R'] >= 10) & (df['R'] < 20),
    (df['R'] > 0) & (df['R'] < 10),
    (df['R'] == 0)
]

r_values = [
    1,
    0.75,
    0.5,
    0.25,
    0
]

df['R_points'] = np.select(r_conditions, r_values)

# Adding the 'Fours Points' Column
fours_conditions = [
    (df['4S'] >= 10),
    (df['4S'] >= 5) & (df['4S'] < 10),
    (df['4S'] >= 2) & (df['4S'] < 5),
    (df['4S'] == 1),
    (df['4S'] == 0)
]

fours_values = [
    1,
    0.75,
    0.5,
    0.25,
    0
]

df['4S_points'] = np.select(fours_conditions, fours_values)

# Adding the 'Sixes Points' Column
sixes_conditions = [
    (df['6S'] >= 6),
    (df['6S'] >= 3) & (df['6S'] < 6),
    (df['6S'] == 2),
    (df['6S'] == 1),
    (df['6S'] == 0)
]

sixes_values = [
    1,
    0.75,
    0.5,
    0.25,
    0
]

df['6S_points'] = np.select(sixes_conditions, sixes_values)

# Adding the 'Strike Rate Points' Column
sr_conditions = [
    (df['SR'] >= 155),
    (df['SR'] >= 115) & (df['SR'] < 155),
    (df['SR'] >= 75) & (df['SR'] < 115),
    (df['SR'] >= 1) & (df['SR'] < 75),
    (df['SR'] == 0)
]

sr_values = [
    1,
    0.75,
    0.5,
    0.25,
    0
]

df['SR_points'] = np.select(sr_conditions, sr_values)

# Calculating the Performance Index of Each Player
df['performance_index'] = df['R_points'] + df['4S_points'] + df['6S_points'] + df['SR_points']

# Classifying the Performances into 'High', 'Medium' and 'Low' categories
performance_conditions = [
    (df['performance_index'] >= 2.50),
    (df['performance_index'] >= 1.00) & (df['performance_index'] < 2.50),
    (df['performance_index'] >= 0) & (df['performance_index'] < 1.00),
]

performance_values = [
    "High",
    "Medium",
    "Low"
]

df['performance'] = np.select(performance_conditions, performance_values)
df = df.filter(['player', 'player_role', 'team_name', 'opp_name', 'venue', 'performance'])

# Label Encoding the Data
le_player = LabelEncoder()
le_opp_name = LabelEncoder()
le_venue = LabelEncoder()
df['player_id'] = le_player.fit_transform(df['player'])
df['opp_id'] = le_opp_name.fit_transform(df['opp_name'])
df['venue_id'] = le_venue.fit_transform(df['venue'])

# Select Independent and Dependant Variables
inputs = df.filter(['player_id', 'opp_id', 'venue_id'])
target = df['performance']

# Split the dataset into train and test
X_train, X_test, y_train, y_test = train_test_split(inputs, target, test_size=0.2)

# Instantiate the model
model = RandomForestClassifier(n_estimators=200)

# Train the model
model.fit(X_train, y_train)

# Make pickle file of our model
pickle.dump(model, open("batting_model.pkl", "wb"))
