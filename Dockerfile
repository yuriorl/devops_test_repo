FROM mcr.microsoft.com/powershell:latest
COPY ./dev_build ./dev_build
COPY ./tests ./tests
COPY ./get_archive_and_checksum.ps1 ./get_archive_and_checksum.ps1
RUN mkdir -p ./dev_artifacts
RUN apt-get update && apt-get install --no-install-recommends -y p7zip-full && \
apt-get clean && \
pwsh -Command " \
    Install-Module -Name 7Zip4PowerShell -Force -Scope CurrentUser; \
    Install-Module -Name Pester -Force -SkipPublisherCheck -Scope CurrentUser \
"

ENTRYPOINT ["pwsh", "-Command", "Invoke-Pester ./tests/get_archive_and_checksum.Tests.ps1"]
