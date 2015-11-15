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

app = Flask(__name__)


@app.route('/')
def hello_world():
    return 'Hello World!'


# Just testing web views for now
@app.route('/image', methods=['GET', 'POST'])
def image():
    if request.method == 'POST':

        print(request.form['image'])
        post_data = call(request.form['image'])

        # return post_data
        return Response(response=post_data,
                        status=200,
                        mimetype="image/jpeg")
    else:
        return 'Good get request!'

def wolfram_cloud_call(**args):
    arguments = dict([(key, arg) for key, arg in args.items()])
    result = urlopen("https://www.wolframcloud.com/objects/user-d9df7bde-57d3-4d40-a250-48b46698adbd/mapOutput", urlencode(arguments).encode('UTF-8'))
    return result.read()

def call(img):
    textresult = wolfram_cloud_call(im=img)
    return textresult

if __name__ == '__main__':
    app.run(port=5555,debug=True)
