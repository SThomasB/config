param(
    [Parameter(Position=0)]
    [string]$program
)



$command = 'CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0"]'
$new_command = 'CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--reload"]'
$content = Get-Content Dockerfile | ForEach-Object {
if ($_ -eq $command) {
    $new_command
} else {
    $_
}
}


$dockerignore = Get-Content .dockerignore
$newdockerignore = $dockerignore | ForEach-Object {
if ($_ -eq ".env") {
    run.ps1
} else {
    $_
}
}

Set-Content .dockerignore $newdockerignore
Set-Content .myDockerfile $content

$app_path = "$($PWD)\app"
$test_path = "$($PWD)\test"
$container_app_path = "/home/non-root-user/app"
$container_test_path = "/home/non-root-user/test"


try {
Write-Host "Tearing down any old ecmApi container" -ForegroundColor Yellow
docker kill ecmApi >> .null
} catch {

}
try {
docker rm -f ecmApi  >> .null
} catch {
}
try {
    Write-Host "Removing any old ecmApi image" -ForegroundColor Yellow
    docker rmi -f appimage >> .null
} catch {

}
Start-Sleep -Seconds 1

Write-Host "Building development image ecmApi" -ForegroundColor Green
docker build -f .myDockerfile -t appimage .



Write-Host "Running container daemon" -ForegroundColor Green
Write-Host "mounting $($app_path) in container" -ForegroundColor Green
Write-Host "mounting $($test_path) in container" -ForegroundColor Green
docker run -dp 8003:8000 -v ${app_path}:${container_app_path} -v ${test_path}:${container_test_path} --name ecmApi appimage

$total = 4
for ($i = 1; $i -le $total; $i++) {
    Write-Progress -Activity "Starting development server" -PercentComplete ($i / $total * 100)
    Start-Sleep -Seconds 1
}

Remove-Item .myDockerfile

Start-Process http://localhost:8003/swagger/index.html

Set-Content .dockerignore $dockerignore
Remove-Item .null
