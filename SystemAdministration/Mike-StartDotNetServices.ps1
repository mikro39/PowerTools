# I need to clean this script up, but it is to take a list

If($chooseFileType -eq 'txt'){
    $ComputerListLocation = Read-Host "Where is the .txt list that you would like to use?"
    }
    elseif($chooseFileType -eq 'csv'){
    $ComputerListLocation = Read-Host "Where is the .csv list that you would like to use?"
    }
    else {
    Write-host "Please Enter a Valid file type"
    }
    
    $computerlist = Get-Content $ComputerListLocation
    
    Write-Host "Getting Credentials, please enter the credentials to the remote machines in the prompt"
    pause
    $credentials = Get-Credential
    
    do
    {
    Write-Host "### - What Would you like to do with the computers in the list? - ###"
    Write-Host "This will affect IIS, and MailerCompnent and ScheduleComponent Services"
    Write-Host "1 - Start Services"
    Write-Host "2 - Stop Services"
    Write-Host "3 - Output Selected Computers"
    Write-Host "q - exit"
    $selection = Read-Host "Please make a selection"
    switch ($selection)
        {
        '1'{
        Write-Host "Starting .Net Application"
        ForEach($computer in $computerlist){
        Invoke-Command -ComputerName $computer -Credential $credentials -ScriptBlock {Startup-OnPrem}
        }
        Write-Host "Run Complete"
        }
        '2' {
        Write-Host "Stopping .Net Application"
        ForEach($computer in $computerlist){
        Invoke-Command -ComputerName $computer -Credential $credentials -ScriptBlock {ShutDown-OnPrem}
        }
        Write-Host "Run Complete"
        }
        '3'{
        Write-Host $computerlist
        }
        }
        pause
    }
    until ($selection -eq 'q')