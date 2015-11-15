"""
3Degrees Web Server

Brian Chen
Nicholas Walsh
Brian Yang

"""

from flask import Flask, request

app = Flask(__name__)


@app.route('/')
def hello_world():
    return 'Hello World!'


# Just testing web views for now
@app.route('/image', methods=['GET', 'POST'])
def image():
    if request.method == 'POST':
        return 'Good post request!'
    else:
        return 'Good get request!'

if __name__ == '__main__':
    app.run(port=5555)
