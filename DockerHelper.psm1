# Module script file containing the cmdlets

# Cmdlet: Build-DockerImage
function Build-DockerImage {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Dockerfile,
        
        [Parameter(Mandatory=$true)]
        [string]$Tag,
        
        [Parameter(Mandatory=$true)]
        [string]$Context,
        
        [string]$ComputerName
    )

    # Build Docker image
    if ($ComputerName) {
        Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            docker build -t $using:Tag -f $using:Dockerfile $using:Context
        }
    } else {
        docker build -t $Tag -f $Dockerfile $Context
    }
}

# Cmdlet: Copy-Prerequisites
function Copy-Prerequisites {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$ComputerName,
        
        [Parameter(Mandatory=$true)]
        [string[]]$Path,
        
        [Parameter(Mandatory=$true)]
        [string]$Destination
    )

    # Copy prerequisites to remote host
    foreach ($p in $Path) {
        Copy-Item -Path $p -Destination "\\$ComputerName\$Destination" -Recurse
    }
}

# Cmdlet: Run-DockerContainer
function Run-DockerContainer {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$ImageName,
        
        [string]$ComputerName,
        
        [string[]]$DockerParams
    )

    # Run Docker container
    if ($ComputerName) {
        $containerName = Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            docker run -d $using:ImageName $using:DockerParams
        }
        return $containerName
    } else {
        $containerName = docker run -d $ImageName $DockerParams
        return $containerName
    }
}

# Export module functions
Export-ModuleMember -Function *-*
