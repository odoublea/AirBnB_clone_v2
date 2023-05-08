#!/usr/bin/python3
"""Fabric script (based on the file 1-pack_web_static.py) that distributes
an archive to your web servers, using the function do_deploy.
"""
from fabric.api import env, put, run

env.hosts = ['<IP web-01>', 'IP web-02']


def do_deploy(archive_path):
    """Distributes an archive to your web servers, using the function
    do_deploy."""
    from os.path import isfile
    if not isfile(archive_path):
        return False
    try:
        file_name = archive_path.split('/')[-1]
        name = file_name.split('.')[0]
        put(archive_path, '/tmp/')
        run('mkdir -p /data/web_static/releases/{}/'.format(name))
        run('tar -xzf /tmp/{} -C /data/web_static/releases/{}/'.format(
            file_name, name))
        run('rm /tmp/{}'.format(file_name))
        run('rm -rf /data/web_static/current')
        run('ln -s /data/web_static/releases/{}/ /data/web_static/current'
            .format(name))
        return True
    except Exception:
        return False
