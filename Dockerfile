FROM krlmlr/debian-ssh:jessie

RUN apt-get update && apt-get install -y python
