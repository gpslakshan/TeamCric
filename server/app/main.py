from flask import Flask, request, jsonify, redirect, url_for
import pandas as pd
import pickle

model = None
app = Flask(__name__)
app.debug = True


def extractModel():
    global model 
    model = pickle.load(open('model.pkl','rb'))

# @app.route("/")
# def home():
#     return redirect(url_for("bowlingPredictions")) 

@app.route('/make-predictions-bowling',methods=['POST'])
def bowlingPredictions():
    global model
    
    print('[SERVER] : Recived A Request...')
    requestData = request.data

    print(requestData)
    # df = pd.DataFrame(requestData)
    # predictions = model.predict(df)

    # return jsonify(
    #     {
    #         "results" :list(predictions)
    #     }
    # )


if __name__ == "__main__":
    extractModel()
    app.run()