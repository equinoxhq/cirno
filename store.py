#!/usr/bin/env python3
import base64
from sys import argv
from replit.object_storage import Client

if __name__ == '__main__':
    if len(argv) < 2:
        print("Usage: store.py [list] [base64 encoded content]")
        exit(1)

    list_name = argv[0]
    content = base64.decode(argv[1])

    client = Client()
    client.upload_from_text("list_" + list_name + ".json", content)
