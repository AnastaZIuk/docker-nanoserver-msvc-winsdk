function Wait-For {
    param (
        [string]$Command,          
        [int]$TickWait = 1,    
        [int]$TotalTicks = 5 
    )

    Write-Host "⏳ Waiting for command.. (Max retries: $TotalTicks, Interval: ${TickWait}s)"
    
    for ($i=1; $i -le $TotalTicks; $i++) {
        Write-Host "⏳ [$i/$TotalTicks]: $Command"
        if (Invoke-Expression $Command) {
            Write-Host "✅ Success!"
            return $true
        }
        Start-Sleep -Seconds $TickWait
    }

    Write-Error "❌ Timeout: $Command did not succeed!"
    exit 1
}

function Check-ExitCode {
    param (
      [string]$message
    )
    if ($LASTEXITCODE -ne 0) {
      Write-Host "❌ ERROR: $message (Exit Code: $LASTEXITCODE)"
      exit $LASTEXITCODE
    }
    Write-Host "✅ Success!"
}
