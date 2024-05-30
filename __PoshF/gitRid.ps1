

git branch --merged | Where-Object { $_ -notmatch "(^\*|main)" } | ForEach-Object { git branch -d $_.Trim() }
