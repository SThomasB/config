param(
    [string]$action
)


if ($action -eq "open") {
    Invoke-Expression 'python C:\devil\__Tools\blink.py new'

} elseif ($action -eq "ls") {
    Invoke-Expression 'python C:\devil\__Tools\blink.py portals'

} elseif ($action -eq "lsf") {
    Invoke-Expression 'python C:\devil\__Tools\blink.py portals full'

} elseif ($action -eq "clear") {
    Invoke-Expression 'python C:\devil\__Tools\blink.py clear'

} elseif ($action -eq "close") {

    Invoke-Expression 'python C:\devil\__Tools\blink.py blink'
    $target = Get-Content C:\devil\__Tools\.blink\to
    Invoke-Expression 'python C:\devil\__Tools\blink.py clear $target'

} elseif ($action -eq "recall") {
    $target = Get-Content C:\devil\__Tools\.blink\to
    cd $target
} else {

    Invoke-Expression 'python C:\devil\__Tools\blink.py blink'
    $blink_to = Get-Content C:\devil\__Tools\.blink\to
    cd $blink_to
}
