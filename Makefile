# Задача для установки зависимостей
install:
        # Устанавливаем 7z
        Install-Module -Name 7Zip4PowerShell -Force -Scope CurrentUser
        # Устанавливаем PowerShell Pester
        Install-Module -Name Pester -Force -SkipPublisherCheck

# Задача для запуска PowerShell Pester теста
run-test:
        Invoke-Pester -Path "./tests/get_archive_and_hashes.Tests.ps1" -Output Detailed

.PHONY: install run-test
