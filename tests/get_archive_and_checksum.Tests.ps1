Describe "Checking if the result archive exists and is not null" {
	BeforeAll {
		Write-Host "Running the script
---------------------------------------------------------------------------------"
		pwsh -Command ".\get_archive_and_checksum.ps1"
		$currentPath = (pwd).Path
		Write-Host "Script has run
---------------------------------------------------------------------------------"
	}

	It "Checking if the folder is empty" {
		        $items = Get-ChildItem -Path "\dev_artifacts" -ErrorAction SilentlyContinue
			Write-Host "Checking if artifacts foldes is empty"
        		$items.Count | Should -Not -Be 0 -Because "dev_artifacts folder should not be empty"
	}
	It "Checking if the archives are empty" {
		$archives = Get-ChildItem -Path "\dev_artifacts" -File
        		foreach ($archive in $archives) {
            		Write-Host "Checking if size of $($archive.FullName) is 0"
            		$archive.Length | Should -BeGreaterThan 0 -Because "$($archive.Name) should not be empty"
		} 
	}
	It "Checking if the temp service folders are removed" {
		Get-ChildItem -Path "$currentPath\dev_build" | ForEach-Object {
			Write-Host "Checking garbage of $_
---------------------------------------------------------------------------------"
			Test-Path "..\$currentPath\dev_$_`_hashes" | Should -Not -Exist
			Write-Host "$_ hashes are removed"
			Test-Path "..\$currentPath\dev_$_`_totalhashes" | Should -Not -Exist
			Write-Host "$_ totalhashes are removed"
			Test-Path "..\$currentPath\dev_artifacts\$_`_artifacts_extracted.7z" | Should -Not -Exist
			Write-Host "$_ exctracted archive is removed"
		}
	}
	
}