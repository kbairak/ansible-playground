all: ssh build

ssh:
	echo "SSH_KEY=$(shell cat ~/.ssh/id_rsa.pub)" > docker-compose.env

build:
	docker build -t debian-ssh-python .

up:
	docker-compose up -d

down:
	docker-compose down

stop:
	docker-compose stop

restart:
	docker-compose restart
