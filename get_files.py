#
# Final Project 
# Alyssa Cantu
#

import csv
import os
import StringIO
import tarfile
import urllib2
from shutil import copyfile
directory = 'C:\Users\MyName\Desktop\hmp_data'
manifest = 'manifest_files'
os.chdir(os.path.join(directory, manifest))

def untar(response, savedir=None):
    #filtering FASTQ files for a size of 50 mb (5e7 bytes) or less
    #selection of file size can be customized
    if int(response.headers["Content-Length"]) > 5e7:
        return
    tar = StringIO.StringIO()
    tar.write(response.read())
    tar.seek(0)
    tar = tarfile.open(fileobj=tar)
    tar.extractall(savedir)
    tar.close()

f = []
for (dirpath, dirnames, filenames) in os.walk('.'):
    f.extend(filenames)
    break
for filename in f:
    dirname = os.path.join(directory, os.path.splitext(filename)[0] + '_files')
    if not os.path.exists(dirname):
        os.makedirs(dirname)
    i = 0
    with open(filename,'rb') as tsvin:
        tsvin = csv.reader(tsvin, delimiter='\t')
        next(tsvin)
        for row in tsvin:
            savedir = os.path.join(dirname, str(i))
            i += 1
            if os.path.exists(savedir):
                continue
            url = row[3].split(',')[0]
            response = None
            try:
                response = urllib2.urlopen(url)
            except:
                continue
            untar(response, savedir)

            action_item = async.get(url, hooks = {'response' : do_something(savedir=savedir)})
            async_list.append(action_item)
        async.map(async_list)
    dirname2 = dirname + '_all'
    if not os.path.exists(dirname2):
        os.makedirs(dirname2)
    for curdir, _, filenames in os.walk(dirname):
        for file in filenames:
            copyfile(os.path.join(curdir,file), os.path.join(dirname2, file))
