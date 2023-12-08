#!/usr/bin/python3
'''Fabric script that generates a .tgz archive from the contents of the
web_static folder of your AirBnB Clone repo, using the function do_pack.'''
from fabric.api import local
from datetime import datetime


def do_pack():
    '''Generates a .tgz archive from the contents of the web_static folder
    of your AirBnB Clone repo'''
    try:
        local("mkdir -p versions")
        now = datetime.now()
        archive_filename = 'web_static_{}.tgz'.format(now.strftime('%Y%m%d%H%M%S'))

        # All files in the folder web_static must be added to the final archive
        local('tar -cvzf versions/{} web_static'.format(archive_filename))
        return 'versions/{}'.format(archive_filename)
    except:
        return None
