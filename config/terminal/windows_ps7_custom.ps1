Invoke-Expression (&starship init powershell)

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

function Get-DefaultWslDistro {
    $distros = wsl -l -v | Select-String -Pattern '\*'
    if ($distros -ne $null) {
        return ($distros.Line -split ' ')[1].Trim()
    }
    return $null
}

function wsl-docker {
	param(
		[Parameter(ValueFromRemainingArguments=$true)]
		$params
	)

      # TODO: Find why $distro cant be used in "wsl -d $distro" statements
	# $distro = Get-DefaultWslDistro
	# if ($distro -eq $null) {
	# 	echo "No default WSL distro found"
	# 	return
	# }

	if ((wsl -d Ubuntu -- sudo service docker status) -like "*is not running*") {
		wsl -d Ubuntu -- sudo service docker start
	}
	wsl -d Ubuntu -- docker $params
}

if (-not (Get-Command -Name docker -ErrorAction SilentlyContinue)) {
	New-Alias -Name docker -Value wsl-docker
}
