# DockerHelper Module

The DockerHelper module provides cmdlets to simplify Docker-related tasks such as building Docker images, copying prerequisites to remote hosts, and running Docker containers.



## Cmdlets

### Build-DockerImage

Builds a Docker image from a Dockerfile.

```powershell
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
    Run-DockerContainer -ImageName <image_name> -ComputerName <remote_computer_name> -DockerParams <array_of_parameters>
```