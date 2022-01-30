 

Write-Host "Welcome to the planting Date Calculator"
$BeforeOrAfterFrost = "Q"
$DateOfLastFrost = 


while ($BeforeOrAfterFrost -ne "X") {
    Write-Host "To exit the calculator press X"
    $BeforeOrAfterFrost = Read-Host "is the planting day before or after the first frost? (Y/N)"

    if ($BeforeOrAfterFrost -eq "Y") {
        [int]$WeeksBefore = Read-Host "How many weeks before frost?"
        $WeeksBeforeToDays =  $WeeksBefore * 7

        Write-Host $WeeksBeforeToDays
    }
    elseif ($BeforeOrAfterFrost -eq "N") {
        int $WeeksAfter = Read-Host "How many weeks after?"
    }
    else {
        Write-Host "Please Enter a valid entry"
    }
}