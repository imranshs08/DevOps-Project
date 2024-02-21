from flask import Flask
import socket
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def index():
    # Get current date and time
    current_datetime = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    
    # Get IP address of the Linux machine
    ip_address = socket.gethostbyname(socket.gethostname())
    
    # Create the response message
    message = f"Current Date and Time: {current_datetime}\nIP Address: {ip_address}"
    
    return message

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
