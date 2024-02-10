# Use a base image that supports PowerShell from dockerhub
FROM mcr.microsoft.com/powershell:latest

# Copy the PowerShell script to the container
COPY fibonacci.ps1 /

# Set the entry point to PowerShell script
ENTRYPOINT ["pwsh", "-File", "/fibonacci.ps1"]