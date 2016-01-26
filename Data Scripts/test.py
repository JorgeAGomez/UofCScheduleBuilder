import json

from pprint import pprint

with open('output.json') as data_file:    
    data = json.load(data_file)

for d in data:
	print d["title"]