#!/usr/bin/env python
# -*- coding: utf8 -*-
# -*- tab-width:2; indent-tabs-mode:t -*- vim: set noet ts=2:

# Copyright (C) 2009  David Hilley <davidhi@cc.gatech.edu>
# Copyright (C) 2010  Matt DeVuyst <mdevuyst@gmail.com>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software Foundation,
# Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
import cgi, urlparse
import subprocess
import tempfile, time
import os, sys, re, string
import stat
import optparse
import traceback
import urllib
from SocketServer import ThreadingMixIn
from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer

def translit(s):
		table = {'а':'a', 'б':'b', 'в':'v', 'г':'g', 'д':'d', 'е':'e', 'ё':'e', 'з':'z', 'и':'i', 'й':'y', 'к':'k', 'л':'l', 'м':'m', 'н':'n', 'о':'o', 'п':'p', 'р':'r', 'с':'s', 'т':'t', 'у':'u', 'ф':'f', 'х':'h', 'ъ':'\'', 'ы':'y', 'ь':'\'', 'э':'e', 'А':'A', 'Б':'B', 'В':'V', 'Г':'G', 'Д':'D', 'Е':'E', 'Ё':'E', 'З':'Z', 'И':'I', 'Й':'Y', 'К':'K', 'Л':'L', 'М':'M', 'Н':'N', 'О':'O', 'П':'P', 'Р':'R', 'С':'S', 'Т':'T', 'У':'U', 'Ф':'F', 'Х':'H', 'Ъ':'\'', 'Ы':'Y', 'Ь':'\'', 'Э':'E', 'ж':'zh','ц':'ts','ч':'ch','ш':'sh','щ':'sch','ю':'ju','я':'ja','Ж':'Zh','Ц':'Ts','Ч':'Ch','Ш':'Sh','Щ':'Sch','Ю':'Ju','Я':'Ja'}

		for k in table.keys():
			 s = s.replace(k,table[k])

		return s

class MultiThreadedHTTPServer(ThreadingMixIn, HTTPServer):
		    pass

_default_port = 8888
_default_editor = "rvim --servername dev --remote"
_default_wait = 60 * 60
_default_debug_mode = 0

temp_has_delete=True
processes = {}

class Handler(BaseHTTPRequestHandler):
	global temp_has_delete

	def do_GET(self):
		if self.path == '/status':
		  self.send_response(200)
		  self.send_header('Content-Type', 'text/plain; charset=utf-8')
		  self.end_headers()
		  self.wfile.write('edit-server is running.\n')
		  return
	  self.send_error(404, "GET Not Found: %s" % self.path)

	def do_POST(self):
		global processes
		try:
			(content, params) = cgi.parse_header(self.headers.
												 getheader('content-type'))

			clength = 0
			cl = self.headers.getheader('content-length')

			if self.debug >= 1:
					print "Recv headers: {0}".format(self.headers)

			if cl != None:
				clength = int(cl)
			else:
				self.send_response(411)
				self.end_headers()
				return

			body = self.rfile.read(clength)
			if self.debug > 1:
					print body

			l = [s for s in self.path.split('/') if s]
			print l

			existing_file = self.headers.getheader('x-file')

			# write text into file
			if not existing_file or existing_file == "undefined":
				existing = False
				url = translit(urllib.unquote(self.headers.getheader('x-url')))
				print "url:", url
				prefix = "chrome_"
				if url:
					prefix += re.sub("[^.\w]", "_", re.sub("^.*?//","",url))
				prefix += "_"
				if temp_has_delete==True:
					f = tempfile.NamedTemporaryFile(
							delete=False, prefix=prefix, suffix='.txt')
					fname = f.name
				else:
					tf = tempfile.mkstemp(prefix=prefix, suffix='.txt')
					f = os.fdopen(tf[0],"w")
					fname = tf[1]
				print "Opening new file ", fname
			else:
				existing = True
				p = processes[existing_file]
				print "Opening existing file ", existing_file
				f = open(existing_file, "w")
				fname = existing_file

			f.write(body)
			f.close()
			last_mod_time = os.stat(fname)[stat.ST_MTIME]

			if not existing:
				# spawn editor...
				cmd = self.editor.split(" ")
				cmd.append(fname)
				print "Spawning editor:{0}".format(cmd)
				p = subprocess.Popen(cmd, close_fds=True)
				processes[fname] = p

			saved = False
			rc = None
			count = 0
			while (True):
				time.sleep(1)

				if rc == None:
						rc = p.poll()
						if rc != 0:
								break

				count += 1
				if count > _default_wait:
						print "too long delay for %s, exiting" % fname
						break

				mod_time = os.stat(fname)[stat.ST_MTIME]
				if mod_time != last_mod_time:
					print "new mod time:", mod_time, " last:", last_mod_time
					last_mod_time = mod_time
					count = 0
					saved = True

				if saved: break

			if saved:
					self.send_response(200)

					f = file(fname, 'r')
					s = f.read()
					f.close()
			else:
					if rc > 0:
							msg = 'text editor returned %d' % rc
					elif rc < 0:
							msg = 'text editor died on signal %d' % -rc
					self.send_error(404, msg)

			if saved:
				self.send_header('x-open', "true")
			else:
				try:
					os.unlink(fname)
				except :
					print "Unable to unlink:", fname
					pass

			self.send_header('x-file', fname)
			self.end_headers()
			self.wfile.write(s)
		except :
		  print traceback.format_exc()
			print "Error: ", sys.exc_info()[0]
			self.send_error(404, "Not Found: %s" % self.path)

def parse_options():
	parser = optparse.OptionParser()
	parser.add_option("-p", "--port", type="int", dest="port", default = _default_port,
		help="port number to listen on (default: " + str(_default_port) + ")")
	parser.add_option( "-d", "--debug", type="int", dest="debug", default = _default_debug_mode,
		help="debug mode (default: " + str(_default_debug_mode) + ")")
	parser.add_option("-e", "--editor", dest="editor", default = _default_editor,
		help='text editor to spawn (default: "' + _default_editor + '")')
	return parser.parse_args()[0]

def main():
	global temp_has_delete
	import platform
	t = platform.python_version_tuple()
	if int(t[0]) == 2 and int(t[1]) < 6:
		temp_has_delete = False;
		print "Handling lack of delete for NamedTemporaryFile:", temp_has_delete
	options = parse_options()
	Handler.editor = options.editor
	Handler.debug = options.debug
	try:
		httpserv = MultiThreadedHTTPServer(('localhost', options.port), Handler)
		httpserv.table = {}
		httpserv.serve_forever()
	except KeyboardInterrupt:
		httpserv.socket.close()

if __name__ == '__main__':
	main()

