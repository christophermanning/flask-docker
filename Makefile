DEFAULT: setup

# track the build timestamp in Dockerfile.build so the Dockerfile is rebuilt when dependencies change
Dockerfile.build: Dockerfile
	docker build -t flask-docker .
	touch $@

clean:
	rm Dockerfile.build

RUN_ARGS=--rm -it --volume ./:/src flask-docker

setup: Dockerfile.build requirements.txt
	@docker run $(RUN_ARGS) /bin/sh -c " \
		python3 -m venv .venv; \
		pip install -r requirements.txt; \
	"

lint: Dockerfile.build
	@docker run $(RUN_ARGS) black .

shell: Dockerfile.build
	@docker run $(RUN_ARGS) /bin/sh

# setting --debug enables live reloading
serve: Dockerfile.build
	@docker run --publish 5000:5000 $(RUN_ARGS) flask run --host=0.0.0.0 --debug
