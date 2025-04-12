#!/usr/bin/env python3
import base64
from sys import argv
from replit.object_storage import Client

if __name__ == '__main__':
    if len(argv) < 2:
        print("Usage: read.py [list]")
        exit(1)

    list_name = argv[0]

    client = Client()
    content = client.download_as_text("list_" + list_name + ".json")

    print(content)
