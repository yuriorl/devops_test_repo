Get-childitem -Path "C:\Users\orlow\dev_build" -directory | Foreach-object {
	$projectPath = "C:\Users\orlow\dev_build\$_"
	Write-Host "Project path is $projectPath"
	$artifactsPath = "C:\Users\orlow\dev_artifacts"

	New-Item -Path "C:\Users\orlow\dev_$_`_hashes" -ItemType Directory -Force
	$hashDir = "C:\Users\orlow\dev_$_`_hashes"
	Write-Host "Hash dir is $hashDir"

	Write-Host "Calculating hashes"
# Ищем общий хэш sha256 всех файлов проекта и сохраняем в файл
	$sha256hashFile = "$hashDir\sha256sums.txt"
	$sha1hashFile = "$hashDir\sha1sums.txt"
	$md5hashFile = "$hashDir\md5sums.txt"

	$combinedsha256HashString = Get-ChildItem -Path "$projectPath" -Recurse -File | 
    	ForEach-Object { (Get-FileHash $_.FullName -Algorithm SHA256).Hash } | Sort-Object | Out-String

	$sha256 = [System.Security.Cryptography.SHA256]::Create()
	$finalsha256HashBytes = $sha256.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($combinedsha256HashString))
	$finalsha256Hash = [System.BitConverter]::ToString($finalsha256HashBytes).Replace("-", "").ToLower()

	"$finalsha256Hash" | Out-File "$sha256hashFile"

# Ищем общий хэш sha1 всех файлов проекта и сохраняем в файл
	$combinedsha1HashString = Get-ChildItem -Path "$projectPath" -Recurse -File | 
    	ForEach-Object { (Get-FileHash $_.FullName -Algorithm SHA1).Hash } | Sort-Object | Out-String

	$sha1 = [System.Security.Cryptography.SHA1]::Create()
	$finalsha1HashBytes = $sha1.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($combinedsha1HashString))
	$finalsha1Hash = [System.BitConverter]::ToString($finalsha1HashBytes).Replace("-", "").ToLower()

	"$finalsha1Hash" | Out-File $sha1hashFile
	
# Ищем общий хэш md5 всех файлов проекта и сохраняем в файл
	$combinedmd5HashString = Get-ChildItem -Path "$projectPath" -Recurse -File | 
    	ForEach-Object { (Get-FileHash $_.FullName -Algorithm MD5).Hash } | Sort-Object | Out-String

	$md5 = [System.Security.Cryptography.MD5]::Create()
	$finalmd5HashBytes = $md5.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($combinedmd5HashString))
	$finalmd5Hash = [System.BitConverter]::ToString($finalmd5HashBytes).Replace("-", "").ToLower()

	"$finalmd5Hash" | Out-File $md5hashFile
	Write-Host "Hash is save to $md5hashFile"

	Write-Host "Zipping and adding hashes"
	7z a -t7z "$artifactsPath\$_`_artifacts.7z" -spf -snl "$projectPath" "$hashDir"

# Ищем общие хэши полученного архива
	$archivePath = "$artifactsPath\$_`_artifacts.7z"
	$extractPath = "$artifactsPath\$_`_artifacts_extracted.7z"

	Write-Host "Unzipping"	
	#Expand-Archive -Path $archivePath -DestinationPath $extractPath -Force
	7z x -r "$archivePath" -o"$extractPath"

	New-Item -Path "C:\Users\orlow\dev_$_`_totalhashes" -ItemType Directory -Force
	$totalhashDir = "C:\Users\orlow\dev_$_`_totalhashes"

	$totalsha256hashFile = "$totalhashDir\$_`_artifacts.7z.sha256"
	$totalsha1hashFile = "$totalhashDir\$_`_artifacts.7z.sha1"
	$totalmd5hashFile = "$totalhashDir\$_`_artifacts.7z.md5"

	Write-Host "Calculating total hashes"
#total sha256

	(Get-FileHash "$artifactsPath\$_`_artifacts.7z" -Algorithm SHA256).Hash | Out-File $totalsha256hashFile

#total sha1

	(Get-FileHash "$artifactsPath\$_`_artifacts.7z" -Algorithm SHA1).Hash | Out-File $totalsha1hashFile

#total md5

	(Get-FileHash "$artifactsPath\$_`_artifacts.7z" -Algorithm MD5).Hash | Out-File $totalmd5hashFile

# Архивируем содержимое проекта и добавляем туда контрольные суммы
	7z a -t7z "$artifactsPath\$_`_artifacts.7z" -spf -snl "$totalhashDir"
	Write-Host "Zipping and adding hashes DONE"

# Чистим за собой служебные папки и файлы

	Remove-Item -Path "$extractPath" -Recurse -Force
	Remove-Item -Path "$hashDir" -Recurse -Force
	Remove-Item -Path "$totalhashDir" -Recurse -Force

}

