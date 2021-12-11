#!/usr/bin/env python3

import base64
from getpass import getpass

def encode_auth(username: str, password: str):
    auth_string = f"{username}:{password}"
    auth_bytes = auth_string.encode('ascii')
    b64_bytes = base64.b64encode(auth_bytes)
    b64_string = b64_bytes.decode('ascii')   

    return b64_string 

def encode_auth_with_input():
    username = input("Username: ")
    password = getpass("Password: ")

    return encode_auth(username=username, password=password)

if __name__ == '__main__':
    print(encode_auth_with_input())
