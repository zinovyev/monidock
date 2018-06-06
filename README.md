# monidock

Lightweight docker monitoring tool build on Rack

![Monidock monitor screen](doc/monitor.png)

## Run on your host

```bash

git clone git@github.com:zinovyev/monidock.git monidock

cd monidock

bundle install

bundle exec rake start # `stop` and `status` commands are also available

```

Remember to change username and password for basic auth. The values can be set by exporting the environment vairables:

* `MON_NAME` for username (the default value is `monit`);

* `MON_PASSWORD` for password (the default value is `secret`);


## Run in container


```bash

git clone git@github.com:zinovyev/monidock.git monidock

cd monidock

docker build -t monidock .

docker run -v /var/run/docker.sock:/var/run/docker.sock --privileged --rm -d \
  -p 9292:9292 \
  -e MON_NAME="monit" \
  -e MON_PASSWORD="12345678" \
  --name monitor docker-monit

```
