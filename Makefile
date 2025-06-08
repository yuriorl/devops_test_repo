build-image-and-run-container:
		docker build . -t scriptimage	
		docker run --rm scriptimage
install-modules:
		winget install 7zip
		Install-Module -Name 7Zip4PowerShell -Force -Scope CurrentUser
		Install-Module -Name Pester -Force -SkipPublisherCheck -Scope CurrentUser
run-pester-tests:
		Invoke-Pester ./tests/get_archive_and_checksum.Tests.ps1

#.PHONY: build-image-and-run-container,install-modules,run-pester-tests
