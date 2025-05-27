# Задача для установки зависимостей
install:
    @echo "Установка зависимостей..."
    # Пример: установка модуля PowerShell
    powershell -Command "Install-Module -Name 7Zip4PowerShell -Force -Scope CurrentUser"

# Задача для запуска PowerShell скрипта
run-script:
    ./get_archive_and_hashes.ps1

.PHONY: run-script install
