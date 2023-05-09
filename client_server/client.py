import socket as st

#HOST = '10.22.73.80' Equivalent on eduarm
HOST = st.gethostbyname(st.gethostname())
PORT = 5050

print(HOST)
# Create a socket object
client_socket = st.socket(st.AF_INET, st.SOCK_STREAM)

# Connect to the server
client_socket.connect((HOST, PORT))

# Send a message to the server
message = '5500 * 32'
client_socket.sendall(message.encode())

# Receive the response from the server
respons = client_socket.recv(1024).decode()
print('Recived respons: ' + respons)

#close the socket
client_socket.close()