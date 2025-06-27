# This is a quick calculator i made to know when i needed to prepare seed starts indoors
 # It calculates the date you need to start the seeds according to the Frost Date
 # The Date is specific to Magna UT, but could be modified to fit the date of last frost for your area
 # Average Last frost in Magna is 4/22 - you can find this online googling you city and "last frost"

 ### Intro, Declares Surface Variables ###
Write-Host "Welcome to the planting Date Calculator"

# Prompt for zip code and get last frost date
$ZipCode = Read-Host "Enter your 5-digit US zip code (or press Enter to use Magna, UT 84044)"
if ([string]::IsNullOrWhiteSpace($ZipCode)) {
    $ZipCode = "84044" # Magna, UT default
}

# Try to get last frost date from Old Farmer's Almanac (no API key required)
try {
    $FrostUrl = "https://www.almanac.com/gardening/frostdates/zipcode/$ZipCode"
    $FrostPage = Invoke-WebRequest -Uri $FrostUrl -UseBasicParsing -ErrorAction Stop
    # Find all matches for 'MMM dd' (e.g., 'Apr 16') and filter to valid months
    $validMonths = @('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')
    $dateMatches = [regex]::Matches($FrostPage.Content, "[A-Za-z]{3,} \d{1,2}")
    $FrostDateString = $null
    foreach ($match in $dateMatches) {
        $parts = $match.Value.Split(' ')
        if ($validMonths -contains $parts[0]) {
            $FrostDateString = $match.Value + ", " + (Get-Date).Year
            break
        }
    }
    if ($FrostDateString) {
        $FrostDate = Get-Date $FrostDateString
        Write-Host ("Using average last frost date for zip " + $ZipCode + ": " + $FrostDate.ToShortDateString())
    } else {
        throw "No valid frost date found in page content."
    }
} catch {
    Write-Host "[ERROR] Could not retrieve frost date for zip $ZipCode from Old Farmer's Almanac. Reason: $($_.Exception.Message)"
    Write-Host "Defaulting to Magna, UT (4/22) for last frost date."
    $ManualFrost = Read-Host "If you know your local last frost date, enter it as MM/DD (e.g., 05/10), or press Enter to use 4/22:"
    if (-not [string]::IsNullOrWhiteSpace($ManualFrost)) {
        try {
            $ManualFrostDate = Get-Date ($ManualFrost + "/" + (Get-Date).Year)
            $FrostDate = $ManualFrostDate
        } catch {
            Write-Host "Invalid date format. Using default (4/22)."
            $FrostDate = Get-Date -Month 4 -Day 22
        }
    } else {
        $FrostDate = Get-Date -Month 4 -Day 22
    }
}

$BeforeOrAfterFrost = "Q"
# ...existing code...
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