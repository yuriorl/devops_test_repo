Describe "Checking if the result archive exists and is not null" {
	BeforeAll {
		Write-Host "Running the script
---------------------------------------------------------------------------------"
		.\get_archive_and_hashes.ps1
		Write-Host "Script has run
---------------------------------------------------------------------------------"
	}

	It "Checking if the folder is empty" {
		Test-Path -Path ".\dev_artifacts\*"
	}
	It "Checking if the archives are empty" {
		Get-ChildItem -Path ".\dev_artifacts" | ForEach-Object {
			Write-Host "Checking for .\dev_artifacts\$_"
			(Get-Item ".\dev_artifacts\$_").Length | Should BeGreaterThan 0
		} 
	}
	It "Checking if the temp service folders are removed" {
		Get-ChildItem -Path ".\dev_build" | ForEach-Object {
			Write-Host "Checking $_
---------------------------------------------------------------------------------"
			Test-Path "..\dev_$_`_hashes" | Should not exist
			Write-Host "$_ hashes are removed"
			Test-Path "..\dev_$_`_totalhashes" | Should not exist
			Write-Host "$_ totalhashes are removed"
			Test-Path "..\dev_artifacts\$_`_artifacts_extracted.7z" | Should not exist
			Write-Host "$_ exctracted archive is removed"
		}
	}
	
}