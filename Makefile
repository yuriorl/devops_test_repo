build-and-run-job:
		docker build . -t scriptimage	
		docker run -it --rm scriptimage -s -v

.PHONY: build-image-job run-test-job
