build-image-job:
	docker build -t scriptimage -f ./Dockerfile	

run-test-job:
	docker run -it --rm scriptimage -s -v

.PHONY: install run-test
