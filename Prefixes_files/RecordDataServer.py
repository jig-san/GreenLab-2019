'''
Python Script to start a local server which will be used to obtain the load time of the webpage
and write it to a CSV file.
'''
from os import curdir
from base64 import b64decode
from os.path import join as pjoin

from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer

class StoreHandler(BaseHTTPRequestHandler):
    store_path = pjoin(curdir, 'Timing.csv')

    def _send_cors_headers(self):
      """ Sets headers required for CORS """
      self.send_header("Access-Control-Allow-Origin", "*")
      self.send_header("Access-Control-Allow-Methods", "GET,POST,OPTIONS")

    def do_OPTIONS(self):
      self.send_response(200)
      self._send_cors_headers()
      self.end_headers()

    def do_HEAD(self):
      self.send_response(200)
      self._send_cors_headers()
      self.end_headers()
      
    def do_GET(self):
        print (self.path)
	name = self.path
        data = self.path.split("?")[1]
	print('data',data)
        print(b64decode(data).decode('utf-8'))
	data_decoded = b64decode(data).decode('utf-8')+'\t'+name+'\n'
        if self.path.find('Timing'):
            with open(self.store_path, 'a') as fh:
                fh.write(data_decoded)	

        self.send_response(200)
        self._send_cors_headers()
        self.end_headers()

server = HTTPServer(('', 8080), StoreHandler)
server.serve_forever()
