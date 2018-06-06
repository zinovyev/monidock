# monidock
Lightweight docker monitoring tool

# Run on your host

```bash

git clone git@github.com:zinovyev/monidock.git monidock

cd monidock

bundle install

bundle exec rake start # `stop` and `status` commands are also available

```

# Run in container


```bash

git clone git@github.com:zinovyev/monidock.git monidock

cd monidock

docker build -t monidock .

docker run -v /var/run/docker.sock:/var/run/docker.sock --privileged -p 9292:9292 --rm --name monitor monidock

```
