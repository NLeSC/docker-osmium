.PHONY: latest develop local

default: latest develop

latest: latest/Dockerfile 
	docker build -t nlesc/osmium:latest latest

develop: develop/Dockerfile
	docker build -t nlesc/osmium:develop develop

local: develop local/Dockerfile local/joblauncher.yml local/ssh_config local/ssh_key local/ssh_key.pub local/ssh_known_hosts
	docker build -t nlesc/osmium-local local
