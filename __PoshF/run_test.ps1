
param([string]$container, [string]$path)
docker exec -i "$container" pytest $path
