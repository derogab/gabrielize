# Requirements
from __future__ import print_function
from pyfiglet import figlet_format
import os
import sys
import git
import getpass
import six
import requests

# Functions
def art(text):
    return '\033[96m'+figlet_format(text, font='slant')+'\x1b[0m'
    pass

def repo(path=''):
    # Initialize a gab's drive
    if path=='':
        path = six.moves.input('Insert the path to save repo: ')
        pass

    print(art('Gabrielize'))
    print('Gabrielizing..')
    print('Save repositories @ '+path)

    if not path.endswith('/'):
        path = path+'/'
        pass

    if os.path.isdir(path):
        with open("lists/repositories") as file:
            for line in file:
                repository = line.strip() # preprocess line
                url = "https://github.com/" + repository
                if url!='':
                    repo = url.split('/')[4]
                    if repo.endswith('.git'):
                        repo = repo[:-4]
                        pass
                    print('Downloading '+repo+'...', end='\r')
                    if not os.path.isdir(path+repo):
                        r = requests.get(url)
                        if str(r.status_code) == str(404):
                            print('Downloading '+repo+'...\033[91m not found.\x1b[0m')
                            pass
                        else:
                            try:
                                git.Git().clone(url, path+repo)
                                print('Downloading '+repo+'...\033[92m done.\x1b[0m')
                                pass
                            except:
                                print('Downloading '+repo+'...\033[91m failed.\x1b[0m')
                                pass
                            pass
                        pass
                    else:
                        # previously downloaded
                        g = git.cmd.Git(path+repo)
                        if g.pull() == 'Already up-to-date.':
                            print('Downloading '+repo+'...\033[95m no changes.\x1b[0m')
                            pass # else
                        else:
                            print('Downloading '+repo+'...\033[33m updated.\x1b[0m')
                            pass # else
                        pass # else
                    pass # if
                pass # for
            pass # with
        pass # if
    else:
        print('\033[91mFailed\x1b[0m: '+path[:-1]+' doesn\'t exist. Or it isn\'t a folder.')
        pass # path exists?

    print('Gabrielized.')
    print('Bye '+getpass.getuser()+'!')
    pass #def
