build-image-and-run-container:
		docker build . -t scriptimage	
		docker run --rm scriptimage
install-modules:
		powershell -command "\
		Install-PackageProvider -Name NuGet -MinimumVersion "2.8.5.201" -Force;
		Install-Module -Name 7Zip4PowerShell -Force -Scope CurrentUser;\
		Install-Module -Name Pester -Force -SkipPublisherCheck -Scope CurrentUser;"
run-pester-tests:
		powershell -command "\
		Invoke-Pester ./tests/get_archive_and_checksum.Tests.ps1"

#.PHONY: build-image-and-run-container,install-modules,run-pester-tests
