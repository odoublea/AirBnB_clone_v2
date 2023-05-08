#!/usr/bin/env python3
"""
Fabric script that distributes an archive to your web servers,
using the function do_deploy
"""

import os
from fabric.api import env, put, run

env.hosts = ['54.165.180.170', '54.210.123.212']
# env.user = os.environ.get('USER')


def do_deploy(archive_path):
    """
    Distributes an archive to your web servers using the function do_deploy

    Args:
        archive_path (str): path to the archive to distribute

    Returns:
        bool: True if all operations have been done correctly, otherwise False
    """
    if not os.path.exists(archive_path):
        return False

    # Upload archive to /tmp/ directory of web server
    archive_filename = os.path.basename(archive_path)
    remote_path = "/tmp/{}".format(archive_filename)
    put(archive_path, remote_path)

    # Uncompress archive to /data/web_static/releases/<archive filename
    # without extension> on web server
    folder_name = archive_filename.split(".")[0]
    release_path = "/data/web_static/releases/{}".format(folder_name)
    run("mkdir -p {}".format(release_path))
    run("tar -xzf {} -C {} --strip-components=1".format(remote_path,
                                                        release_path))

    # Delete archive from web server
    run("rm {}".format(remote_path))

    # Delete symbolic link /data/web_static/current from web server
    current_path = "/data/web_static/current"
    run("rm -f {}".format(current_path))

    # Create new symbolic link /data/web_static/current on web server
    run("ln -s {} {}".format(release_path, current_path))

    return True
