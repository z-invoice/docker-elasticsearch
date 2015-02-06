# Elasticsearch Docker Container

This packages are build upon BusyBox and provide a minimal footprint and are configurable. 

Take also a look at ELK stack friends.
[zinvoice/logstash]()
[sirile/kibanabox]()
[progrium/logspout]()
[tonistiigi/dnsdock]()


Quick Start
=========
If you have [docker-compose]() installed (aka. fig) you can download our [docker-compose.yml]() file and run it with `docker-compose up -d` to start the complete ELK Stack.

Manual Quick Start
========
```
docker run -d --name elasticsearch -h elasticsearch \
	-v /etc/localtime:/etc/localtime:ro \
	-v /etc/timezone:/etc/timezone:ro \
	-p 9200:9200 \
	zinvoice/elasticsearch
```

If you would like to start the rest of ELK Stack here are the other compatible container.
```
docker run -d --name logstash -h logstash \
	-v /etc/localtime:/etc/localtime:ro \
	-v /etc/timezone:/etc/timezone:ro \
	-p 9200:9200 \
	zinvoice/logstash

docker run -d --name kibana -h kibana \
	-v /etc/localtime:/etc/localtime:ro \
	-v /etc/timezone:/etc/timezone:ro \
	-p 8000:80 \ 
	sirile/kibanabox

docker run -d --name logspout -h logspout \
	-v /etc/localtime:/etc/localtime:ro \
	-v /etc/timezone:/etc/timezone:ro \
	-v /var/run/docker.sock:/tmp/docker.sock \
	-p 8100:8000 \ 
	progrium/logspout \
	syslog://<<IP-OR-HOSTNAME-OF-LOGSTASH>:5000
``` 

When running with dnsdock you can simple put in the dns entry of logstash which is `logstash` 

How is it working
========
We use `progrium/logspout` which is a "docker daemon aware" container that forwards `STDOUT` and `STDERR` streams of ALL running containers to logstash.
We also use dnsdock to avoid the need to link the container together. 


Configuration
========
You can configure elasticsearch in two ways 

1. Mount your custom created `elasticsearch.yml` file from you Host mashine into `zinvoice/elasticsearch` 
with `-v /host/dir/elasticsearch.yml:/opt/elasticsearch/config/elasticsearch.yml`. Full example: `docker run -d --name elasticsearch -h elasticsearch -v /etc/localtime:/etc/localtime:ro -v /etc/timezone:/etc/timezone:ro -v /host/dir/elasticsearch.yml:/opt/elasticsearch/config/elasticsearch.yml -p 9200:9200 zinvoice/elasticsearch`

2. Create a brand new config container and define a volume inside the Dockerfile `VOLUME /opt/elasticsearch/config/`  COPY  your file `elasticsearch.yml` into that folder and create that container (no need to run/start it). After the container is created your can start elasticsearch and mount the volumes from the config container in this way: `docker run -d --name elasticsearch -h elasticsearch -v /etc/localtime:/etc/localtime:ro -v /etc/timezone:/etc/timezone:ro -volumes-from you/nameOfConfigContainer -p 9200:9200 zinvoice/elasticsearch`


