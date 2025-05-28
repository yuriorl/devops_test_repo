build-and-run-job:
		docker build . -t scriptimage	
		docker run --rm scriptimage

.PHONY: build-and-run-job
