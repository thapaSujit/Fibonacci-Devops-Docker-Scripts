# DockerHelper Module

The DockerHelper module provides cmdlets to simplify Docker-related tasks such as building Docker images, copying prerequisites to remote hosts, and running Docker containers.



## Cmdlets

### Build-DockerImage

Builds a Docker image from a Dockerfile.

```powershell
    Build-DockerImage -Dockerfile <path_to_Dockerfile> -Tag <image_tag> -Context <path_to_context_directory> -ComputerName <remote_computer_name>
```
