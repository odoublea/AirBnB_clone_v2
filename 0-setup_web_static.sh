#!/usr/bin/env bash
# Bash script that sets up your web servers for the deployment of web_static

# Install Nginx if not already installed
if [ $(dpkg-query -W -f='${Status}' nginx 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo apt-get update
  sudo apt-get install nginx -y
fi

# Create the necessary directories if they don't exist
sudo mkdir -p /data/ /data/web_static/ /data/web_static/releases/ /data/web_static/shared/ /data/web_static/releases/test/

# Create a HTML file for testing purposes
sudo echo '
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="keywords" content="ALX, Web Server, AirBnB Clone, HTML, CSS, JavaScript">
        <meta name="author" content="Abdulqudus Oladega">
        <title>Test Page</title>
    </head>

    <body>
        <header>
            <h1>First Deployment! 😁</h1>
        </header>

    </body>

</html>
' >> /data/web_static/releases/test/index.html

# Create a symbolic link to the current release. If the symbolic link already exists, it should be deleted and recreated every time the script is ran.
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# Set ownership of /data/ to the ubuntu user and group - recursive
sudo chown -R ubuntu:ubuntu /data/

# Update the Nginx configuration to serve content from the /data/web_static/current directory
sudo sed -i '41i\\tlocation /hbnb_static {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default

# Restart Nginx to apply the new configuration
sudo service nginx restart