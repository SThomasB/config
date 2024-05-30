param (
    [Parameter(Position=0)][string]$yourBranch
)


$currentBranch = Invoke-Expression "git rev-parse --abbrev-ref HEAD"

Write-Host "Switching to main branch" -ForegroundColor Green
git checkout main

Write-Host "Fetching all remote branches" -ForegroundColor Green
git fetch --all

Write-Host "Pulling latest changes from remote main branch" -ForegroundColor Green
git pull origin main

Write-Host "Switching to your branch: $currentBranch" -ForegroundColor Green
git checkout $currentBranch

Write-Host "Merging main branch into your branch: $currentBranch" -ForegroundColor Green
git merge main

Write-Host "Pushing your branch: $currentBranch" -ForegroundColor Green
git push origin $currentBranch

Write-Host "Done!" -ForegroundColor Green
