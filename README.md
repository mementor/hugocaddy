```
hugocaddy:master ✓ ➭ docker build -t hugocaddy .

hugocaddy:master ✓ ➭ cp Caddyfile /tmp/Caddyfile && sudo mkdir -p /var/caddy/blog; sudo mkdir -p /var/caddy/sharer; docker run -d -p 80:80 -p 443:443 -v /tmp/Caddyfile:/etc/Caddyfile -v /var/caddy:/srv -v $HOME/.caddy:/root/.caddy hugocaddy
```
