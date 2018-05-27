#!/usr/bin/env python3

### Requirements ###
import sys
import signal
import gabrielize as gab

# start script 
print(gab.art('Gabrielize'));

# get params from shell
params = sys.argv[1:]

# run required command
command = params[0].lower()

if command == 'repo':
	gab.repo(params[1]);
else:
	print('command not found.');