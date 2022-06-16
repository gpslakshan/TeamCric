import numpy as np
import pandas as pd
from flask import Flask, request, jsonify, render_template
import pickle

# Create Flask app
app = Flask(__name__)

# Load the pickle model
model = pickle.load(open("bowling_model.pkl", "rb"))


@app.route("/predict", methods=["POST"])
def predict():
    json_ = request.get_json()
    query_df = pd.DataFrame(json_)
    prediction = model.predict(query_df)
    return jsonify({"Prediction": str(prediction[0])})


if __name__ == "__main__":
    app.run(debug=True)
