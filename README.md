```
sudo mkdir /var/caddy/blog; sudo mkdir /var/caddy/sharer; docker run -d -p 80:80 -p 443:443 -v /tmp/Caddyfile:/etc/Caddyfile -v /var/caddy:/srv -v $HOME/.caddy:/root/.caddy hugocaddy

docker build -t hugocaddy .
```
