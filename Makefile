build-and-run-job:
		docker build . -t scriptimage	
		docker run --rm scriptimage

.PHONY: build-image-job run-test-job
