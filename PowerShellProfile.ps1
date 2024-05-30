


oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\paradox.omp.json" | Invoke-Expression
Del alias:h

Set-Alias -Name pyt -Value PythonMath
Set-Alias -Name eprof -Value EditProfile 


function d {cd C:\devil}

Set-Alias -Name cd -Option AllScope -Value Push-Location
Set-Alias -Name n -Value Pop-Backstack
set-Alias -Name t -Value Push-Backstack
Set-Alias -Name cob -Value SelectGitBranch
function hh
{
    abra recall
}
function blog
{
    Start-Process https://dev.azure.com/EquinorASA/DCM/_workitems/recentlyupdated/
}
[System.Collections.Stack]$GLOBAL:backStack = @()
[System.Collections.Stack]$GLOBAL:childStack = @()

function SelectGitBranch
{
    python C:\\devil\__Tools\selectbranch.py
}

function Pop-Backstack
{
    if ($GLOBAL:backStack.Count -lt 1)
    {
        return
    
    }
    Push-Location ($GLOBAL:backStack.Pop())
}

function Push-Backstack
{
    $tmp = (Get-Location).Path
    Pop-Location

    if ((Get-Location).Path -eq $tmp)
    {
        return
    }
    $GLOBAL:backStack.Push($tmp)
}

Set-Alias -Name h -Value Go-Parent
function Go-Parent
{
    $tmp = (Get-Location).Path
    Set-Location ..
    $GLOBAL:childStack.Push($tmp)

}
Set-Alias -Name s -value Go-Child
function Go-Child
{
    if ($GLOBAL:childStack.Count -lt 1)
    {
        return
    }
    Set-Location($GLOBAL:childStack.Pop())
}


function popper {Pop-Location -Scope AllScope}


function Editprofile {
    ise C:\Windows\System32\WindowsPowerShell\v1.0\Profile.ps1
}


function PythonMath {
    python -i -c "from math import *"
}
