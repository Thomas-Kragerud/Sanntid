import socket
import threading

PORT = 6060
SERVER = socket.gethostbyname(socket.gethostname())

server = socket.socket(socket.AF_INET)
