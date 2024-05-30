param (
    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [string[]]$Content,

    [Parameter(Mandatory=$true, Position=0)]
    [string]$where,

    [Parameter(Mandatory=$true, Position=1)]
    [string]$to
)

process {
    $modifiedContent = $Content | ForEach-Object {
        if ($_ -eq $where) {
            $to
        } else {
            $_
        }
    }
    return $modifiedContent
}


