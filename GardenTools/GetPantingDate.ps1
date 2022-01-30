 # This is a quick calculator i made to know when i needed to prepare seed starts indoors
 # It calculates the date you need to start the seeds according to the Frost Date

 ### Intro, Declares Surface Variables ###
Write-Host "Welcome to the planting Date Calculator"
$BeforeOrAfterFrost = "Q"
$FrostDate = Get-Date -Month 4 -Day 22

### Logic to determine if it is pre or post frost
while ($BeforeOrAfterFrost -ne "X") {
    Write-Host "To exit the calculator press X"
    $BeforeOrAfterFrost = Read-Host "is the planting day before the first frost? (Y/N)"

    ## If the Start Date is Pre First Frost
    if ($BeforeOrAfterFrost -eq "Y") {
        [int]$WeeksBefore = Read-Host "How many weeks before frost?"
        $WeeksBeforeToDay =  $WeeksBefore * 7
        $BeforeResult = $FrostDate.AddDays(-$WeeksBeforeToDay)

        Write-Host "The Date to Plant is " $BeforeResult
    }

    ## If the Start Date is Post Frost
    elseif ($BeforeOrAfterFrost -eq "N") {
        [int]$WeeksAfter = Read-Host "How many weeks after frost?"
        $WeeksAfterToDay =  $WeeksAfter * 7
        $AfterResult = $FrostDate.AddDays($WeeksAfterToDay)

        Write-Host "The Date to Plant is " $AfterResult
    }

    ## Simple Error Handling
    else {
        Write-Host "Please Enter a valid entry"
    }
}