# Module script file containing the cmdlets

# Cmdlet: Build-DockerImage
function Build-DockerImage {
    [CmdletBinding()]
    param(
        # Parameter: Dockerfile
        [Parameter(Mandatory=$true)]
        [ValidateScript({Test-Path $_ -PathType Leaf})]  # Validate that provided path exists and points to a file
        [string]$Dockerfile,                            # Path to the Dockerfile used for building the Docker image
        
        # Parameter: Tag
        [Parameter(Mandatory=$true)]
        [string]$Tag,                                   # Docker image name/tag
        
        # Parameter: Context
        [Parameter(Mandatory=$true)]
        [ValidateScript({Test-Path $_ -PathType Container})]  # Validate that the provided path exists and points to a directory
        [string]$Context,                                # Path to the Docker context directory
        
        # Parameter: ComputerName
        [string]$ComputerName                            # Optional parameter: name of the remote computer where Docker commands will be executed
    )

    try {
        # Build Docker image
        if ($ComputerName) {
            # Invoke Docker build command on the remote computer
            Invoke-Command -ComputerName $ComputerName -ScriptBlock {
                docker build -t $using:Tag -f $using:Dockerfile $using:Context
            }
        } else {
            # Build Docker image locally
            docker build -t $Tag -f $Dockerfile $Context
        }
    } catch {
        # Handle errors during Docker image building
        Write-Error "Failed to build Docker image: $_"
    }
}

# Cmdlet: Copy-Prerequisites
function Copy-Prerequisites {
    [CmdletBinding()]
    param(
        # Parameter: ComputerName
        [Parameter(Mandatory=$true)]
        [string]$ComputerName,                      # Name of the remote computer
        
        # Parameter: Path
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]                  # Validate that the parameter value is not null or empty
        [string[]]$Path,                            # Array of local file or directory paths to copy
        
        # Parameter: Destination
        [Parameter(Mandatory=$true)]
        [string]$Destination                        # Destination directory on the remote computer
    )

    try {
        # Copy prerequisites to remote host
        foreach ($p in $Path) {
            if (!(Test-Path $p)) {
                # Check if the file or directory exists
                Write-Error "File or directory '$p' does not exist."
                return
            }
            # Copy the file or directory to the remote host using administrative shares
            Copy-Item -Path $p -Destination "\\$ComputerName\$Destination" -Recurse
        }
    } catch {
        # Handle errors during file copying
        Write-Error "Failed to copy prerequisites: $_"
    }
}

# Cmdlet: Run-DockerContainer
function Run-DockerContainer {
    [CmdletBinding()]
    param(
        # Parameter: ImageName
        [Parameter(Mandatory=$true)]
        [string]$ImageName,                         # Docker image name to run
        
        # Parameter: ComputerName
        [string]$ComputerName,                      # Optional parameter: name of the remote computer where Docker commands will be executed
        
        # Parameter: DockerParams
        [string[]]$DockerParams                     # Optional parameters to pass to the Docker container
    )

    try {
        # Run Docker container
        if ($ComputerName) {
            # Run Docker container on the remote computer
            $containerName = Invoke-Command -ComputerName $ComputerName -ScriptBlock {
                docker run -d $using:ImageName $using:DockerParams
            }
            return $containerName
        } else {
            # Run Docker container locally
            $containerName = docker run -d $ImageName $DockerParams
            return $containerName
        }
    } catch {
        # Handle errors during Docker container execution
        Write-Error "Failed to run Docker container: $_"
    }
}

# Export module functions
Export-ModuleMember -Function *-*