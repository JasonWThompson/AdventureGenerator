param (
    [Parameter()]
    [string]
    $Path
)

$headerRegex = "\*\*(.*?)\*\*"
$valueRegex = "^\s*\d+\s*\|\s*(.*)"

$questParts = @()
$questContent = @{}
$part = ""

# Read the content
Get-Content $Path | ForEach-Object {
    [string]$line = $_
    if ($line -match $headerRegex) {
        $part = $Matches[1]
        $questParts += $part
        $questContent[$part] = @()
    }
    if ($line -match $valueRegex) {
        $questContent[$part] += $Matches[1]
    }
}

# Generate a random quest.
$questParts | ForEach-Object {
    $part = $_
    $possibleChoices = $questContent[$part]
    $diceRoll = Get-Random -Minimum 0 -Maximum $possibleChoices.Count
    Write-Host "$($part): $($possibleChoices[$diceRoll])"
}

