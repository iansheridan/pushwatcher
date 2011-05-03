# Push Watcher

A simple sinatra application that waits for a push notice from githup logs the action and will run commands as needed.

## Install

    gem install bundler
    bundle install

## Server Setup

I usually run it as a Unicorn socket and use Nginx to proxy to it. Here is my Nginx config:

    upstream unicorn_updates_server {
            # This is the socket we configured in unicorn.rb
            server unix:/path/to/sockets/unicorn.sock fail_timeout=0;
    }

    server {
            listen       80;
            server_name  updates.example.com;

            root   /path/to/static/assets;
            index  index.html index.htm index.php;

            location / {
                    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                    proxy_set_header Host $http_host;
                    proxy_redirect off;

                    # If you don't find the filename in the static files
                    # Then request it from the unicorn server
                    if (!-f $request_filename) {
                            proxy_pass http://unicorn_updates_server;
                            break;
                    }
            }

            # redirect server error pages to the static page /50x.html
            error_page   500 502 503 504  /50x.html;
            location = /50x.html {
                root   html;
            }


            location ~ /\.ht {
                deny  all;
            }
    }

Make sure that you edit that config to your needs.
