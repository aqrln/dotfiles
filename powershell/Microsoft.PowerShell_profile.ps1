function GitStatus {
    git status -sb
}

Set-Alias -Name gs -Value GitStatus

function GitDiff {
    git diff
}

Set-Alias -Name gd -Value GitDiff

Invoke-Expression (&starship init powershell)