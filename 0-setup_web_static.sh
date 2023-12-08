#!/usr/bin/env bash

# Install Nginx if it not already installed
if ! command -v nginx &>/dev/null; then
  sudo apt-get update
  sudo apt-get -y install nginx
fi

# Create the folder /data/ if it doesn’t already exist
# Create the folder /data/web_static/ if it doesn’t already exist
# Create the folder /data/web_static/releases/ if it doesn’t already exist
# Create the folder /data/web_static/shared/ if it doesn’t already exist
# Create the folder /data/web_static/releases/test/ if it doesn’t already exist
sudo mkdir -p /data/web_static/shared/
sudo mkdir -p /data/web_static/releases/test/

# Create a fake HTML file /data/web_static/releases/test/index.html (with simple content, to test your Nginx configuration)
echo '<html lang="en">
  <head>
	<meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="keywords" content="ALX, Web Server, AirBnB Clone, HTML, CSS, JavaScript">
        <meta name="author" content="Abdulqudus Oladega">
	<title>Hello World!</title>
  </head>
  <body>
    <h1>This is a test page! 😁</h1>
  </body>
</html>' | sudo tee /data/web_static/releases/test/index.html >/dev/null

# Create a symbolic link /data/web_static/current linked to the /data/web_static/releases/test/ folder. If the symbolic link already exists, it should be deleted and recreated every time the script is ran.
sudo ln -sf /data/web_static/releases/test /data/web_static/current

# Give ownership of the /data/ folder to the ubuntu user AND group (you can assume this user and group exist). This should be recursive; everything inside should be created/owned by this user/group.
sudo chown -R ubuntu:ubuntu /data/

# Update the Nginx configuration to serve the content of /data/web_static/current/ to hbnb_static (ex: https://mydomainname.tech/hbnb_static).
sudo sed -i '/listen 80 default_server;/a\\tlocation /hbnb_static {\n\t\talias /data/web_static/current/;\n\t}' /etc/nginx/sites-available/default
sudo service nginx restart
