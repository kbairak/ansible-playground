## Playground for Ansible

The goal here is to easily set up an environment to test out ansible commands,
playbooks or roles. The various hosts are setup as Docker containers running
Debian Jessie, SSH and Python.


### Prerequisites

You need to have Docker, Docker-compose and Python installed. You may choose to
have Ansible installed globally, or you can use a virtual environment. You also
need to have the port 2222 and a few more after that open for local
connections.


### Get started

```bash
git clone https://github.com/kbairak/ansible-playground
cd ansible-playground
make
```

`make` makes sure that the containers will use your public key to authenticate
SSH connections and also builds the image for the containers (based on
[krlmlr/debian-ssh](https://hub.docker.com/r/krlmlr/debian-ssh/)).

If you want to install Ansible in a virtual environment:

```bash
mkvirtualenv ansible
pip install ansible
```


### Add a host

```bash
./bin/add_host webserver
```

This command edits your `docker-compose.yml`, `ssh.config` and `inventory`
files so that you can target a host named 'webserver' in your ansible commands
and playbooks. Feel free to add as many hosts as you like. Also feel free to
check the modified files in order to understand what went on there.


### Test

```bash
make up  # Runs `docker-compose up -d`
ansible webserver -m ping
```

If everything went smoothly, you should see this:

```
webserver | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```


### Housekeeping your docker containers

* As long as you don't remove anything from your `docker-compose.yml` file,
  you should be able to remove all your containers with:

  ```bash
  make down  # Runs `docker-compose down`
  ```

* If you want to stop the containers so that you don't lose any changes you
  might have made to them, run

  ```bash
  make stop  # Runs `docker-compose stop`
  ```
 
  instead. You can restart them later with:

  ```bash
  make restart  # Runs `docker-compose restart`
  ```

* If you remove some services from `docker-compose.yml` while their respective
  containers are running, then `docker-compose` won't be able to find them. In
  this case, look them up with:

  ```bash
  docker ps -a
  
  CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                      PORTS                              NAMES
  c9fcc0e9a172        debian-ssh-python   "/run.sh"                4 minutes ago       Up 4 minutes                0.0.0.0:2222->22/tcp               ansibleplayground_webserver_1
  ```
 
  The names added by `docker-compose` should make it easy to identify and
  stop/remove them.

  ```bash
  docker stop ansibleplayground_webserver_1
  docker rm -f ansibleplayground_webserver_1
  ```
