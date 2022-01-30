 

Write-Host "Welcome to the planting Date Calculator"
$BeforeOrAfterFrost = "Q"
$FrostDate = Get-Date -Month 4 -Day 22


while ($BeforeOrAfterFrost -ne "X") {
    Write-Host "To exit the calculator press X"
    $BeforeOrAfterFrost = Read-Host "is the planting day before the first frost? (Y/N)"

    if ($BeforeOrAfterFrost -eq "Y") {
        [int]$WeeksBefore = Read-Host "How many weeks before frost?"
        $WeeksBeforeToDays =  $WeeksBefore * 7
        $BeforeResult = $FrostDate.AddDays(-$WeeksBeforeToDays)

        Write-Host "The Date to Plant is "$BeforeResult
    }
    elseif ($BeforeOrAfterFrost -eq "N") {
        int $WeeksAfter = Read-Host "How many weeks after?"
    }
    else {
        Write-Host "Please Enter a valid entry"
    }
}