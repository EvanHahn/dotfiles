#!/usr/bin/env python3
import argparse
from urllib.parse import urlparse, parse_qsl

parser = argparse.ArgumentParser(description="Print out the parts of a URL")
parser.add_argument("url", type=str, help="The URL to parse")
args = parser.parse_args()

parsed = urlparse(args.url)

print("original:", args.url)

print("protocol:", parsed.scheme)

if parsed.username is not None:
    print("username:", parsed.username)

if parsed.password is not None:
    print("password:", parsed.password)

if parsed.hostname is not None:
    print("hostname:", parsed.hostname)

if parsed.port is not None:
    print("port:", parsed.port)

if len(parsed.path) != 0:
    print("path:", parsed.path)

if len(parsed.query) != 0:
    print("query:", parsed.query)
    for key, value in parse_qsl(parsed.query):
        print("-", key, value)

if len(parsed.fragment) != 0:
    print("hash:", parsed.fragment)
