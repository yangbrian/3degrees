"""
3Degrees Web Server

Brian Chen
Nicholas Walsh
Brian Yang

"""
import json
from urllib.parse import urlencode
from urllib.request import urlopen

from flask import Flask, request, Response
from pip._vendor import requests

app = Flask(__name__)


@app.route('/')
def hello_world():
    return 'Hello World!'


# Just testing web views for now
@app.route('/image', methods=['GET', 'POST'])
def image():
    if request.method == 'POST':
        post_data = call(request.form['image'])

        return Response(response=json.dumps(post_data) + '\n',
                        status=200,
                        mimetype="application/json")
    else:
        return 'Good get request!'

def wolfram_cloud_call(**args):
    arguments = dict([(key, arg) for key, arg in args.items()])
    result = urlopen("https://www.wolframcloud.com/objects/user-d9df7bde-57d3-4d40-a250-48b46698adbd/mapOutput", urlencode(arguments).encode('UTF-8'))
    result = requests.post('https://www.wolframcloud.com/objects/user-d9df7bde-57d3-4d40-a250-48b46698adbd/mapOutput', files={'im': open('report.xls', 'rb')})
    return result.read()

def call(img):
    textresult = wolfram_cloud_call(im=img)
    return textresult

if __name__ == '__main__':
    app.run(port=5555,debug=True)
