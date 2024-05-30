param([String] $EnvironmentName
      ,[String] $Lib)
Write-Host "EnvironmentName: " $EnvironmentName

$PAEnvironment = Get-PowerAppEnvironment "*${EnvironmentName}*"
Get-AdminPowerApp "*${Lib}*" | Where {$_.EnvironmentName -like $PAEnvironment.EnvironmentName}
