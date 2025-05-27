# Задача для установки зависимостей
install:
    @echo "Установка зависимостей..."
    # Устанавливаем 7z
    powershell -Command "Install-Module -Name 7Zip4PowerShell -Force -Scope CurrentUser"

# Задача для запуска PowerShell скрипта
run-script:
    ./get_archive_and_hashes.ps1
run-test:
    ./tests/get_archive_and_hashes.Tests.ps1

.PHONY: run-script install
