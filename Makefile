# Задача для установки зависимостей
install:
    @echo "Установка зависимостей..."
    # Устанавливаем 7z
    powershell -Command "Install-Module -Name 7Zip4PowerShell -Force -Scope CurrentUser"
    # Устанавливаем PowerShell Pester
    powershell -Command "Install-Module -Name Pester -Force -SkipPublisherCheck"

# Задача для запуска PowerShell Pester теста
run-test:
    ./tests/get_archive_and_hashes.Tests.ps1

.PHONY: run-script install
