PORT?=5500
IMGNAME?=geoip
CONTNAME?=geoip

build: Dockerfile
	@echo "$$(date): Building docker container."
	@docker build -t $(IMGNAME) .

stop:
	@echo "$$(date): Terminating deployment."
	@docker kill $(CONTNAME) 2> /dev/null || true

clean: stop
	@echo "$$(date): Removing image."
	@docker rm -f $(CONTNAME) 2> /dev/null || true

deploy: clean
	@echo "$$(date): Deploying application."
	@docker run --restart unless-stopped -d \
                --name $(CONTNAME) -p $(PORT):80 $(IMGNAME)
