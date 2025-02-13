from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_service1():
    return 'Hello from Service 1! Srinand M V'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8081)
