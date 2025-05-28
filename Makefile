build-image-job:
		docker build . -t scriptimage	

run-test-job:
		docker run -it --rm scriptimage -s -v

.PHONY: build-image-job run-test-job
