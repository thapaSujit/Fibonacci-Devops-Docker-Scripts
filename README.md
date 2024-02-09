# DockerHelper Module

The DockerHelper module provides cmdlets to simplify Docker-related tasks such as building Docker images, copying prerequisites to remote hosts, and running Docker containers.



## Cmdlets

### Build-DockerImage

Builds a Docker image from a Dockerfile.

```powershell
    # ComputerName is optional parameter. It Specifies the name of the remote computer where Docker is installed. If provided, the Docker image will be built on the specified remote host. If not provided, the Docker image will be built locally.
    Build-DockerImage -Dockerfile <path_to_Dockerfile> -Tag <image_tag> -Context <path_to_context_directory> -ComputerName <remote_computer_name>
```
### Copy-Prerequisites

Copies files and/or directories to a remote host.

```powershell
    Copy-Prerequisites -ComputerName <remote_computer_name> -Path <array_of_paths> -Destination <destination_path>
```

### Run-DockerContainer

Runs a Docker container.

```powershell
    # ComputerName and DockerParams are optional parameters. ComputerName specifies the name of the remote computer where Docker is installed. If provided, the Docker container will be run on the specified remote host. If not provided, the Docker container will be run locally.DockerParams Specifies additional parameters for the Docker container. This parameter accepts an array of strings. If provided, the Docker container will be run with the specified parameters. If not provided, the Docker container will be run with default parameters.
    Run-DockerContainer -ImageName <image_name> -ComputerName <remote_computer_name> -DockerParams <array_of_parameters>
```

## Fibonacci Script

The Fibonacci script (fibonacci.ps1) calculates the Fibonacci sequence.

### Usage
.\fibonacci.ps1 [<n>]

To run the Fibonacci script:

```powershell
    .\fibonacci.ps1 [<n>]
```

## Examples

### Building a Docker Image Locally

```powershell
    Build-DockerImage -Dockerfile .\Dockerfile -Tag fibonacci-image -Context .
```

### Copying Prerequisites

```powershell
    Copy-Prerequisites -ComputerName remote-host -Path .\prerequisites -Destination C:\temp
```

### Running a Docker Container locally

```powershell
    # If you skip the Docker parameter, it will output all Fibonacci numbers one by one every 0.5 second.
    Run-DockerContainer -ImageName fibonacci-image -ComputerName remote-host

    # If you include the Docker parameter, it will calculate the Fibonacci number for that parameter.
    Run-DockerContainer -ImageName fibonacci-image -ComputerName remote-host -DockerParams 5

```

To check if the Fibonacci sequence is working correctly, you can use the following command to view the Docker container logs:

```powershell
    # Replace <container_id> with the actual ID of the Docker container.
    docker logs <container_id>
```

Alternatively, you can use docker exec to run the Fibonacci script within the running container:


```powershell
    # Replace <container_id> with the actual ID of the Docker container.
    docker exec -it <container_id> pwsh /fibonacci.ps1
```







