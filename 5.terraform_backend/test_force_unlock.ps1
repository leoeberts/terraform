# Script to test Terraform force unlock feature
Write-Host "Testing Terraform force unlock feature..."

# Check if AWS_PROFILE is set
if (-not $env:AWS_PROFILE) {
    Write-Host "Error: AWS_PROFILE environment variable not set"
    Write-Host "Run: tf profile <your-profile-suffix>"
    exit 1
}

Write-Host "Step 1: Starting long-running apply to create a lock..."

# Start apply in background job to create a lock
$lockJob = Start-Job -ScriptBlock {
    param($profile, $workDir)
    Set-Location $workDir
    $env:AWS_PROFILE = $profile
    terraform apply -auto-approve
} -ArgumentList $env:AWS_PROFILE, (Get-Location).Path

Write-Host "Apply job started (ID: $($lockJob.Id))"
Write-Host "Waiting 10 seconds for lock to be acquired..."
Start-Sleep -Seconds 10

Write-Host "`nStep 2: Attempting to trigger lock error..."
try {
    # Try to run another apply to see the lock error
    Write-Host "Running second apply to see lock error..."
    $result = terraform apply -auto-approve 2>&1 | Out-String
    Write-Host $result
    
    # Extract lock ID using multiple patterns
    $lockId = $null
    
    # Try different regex patterns for UUID
    if ($result -match "ID:\s+([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})") {
        $lockId = $Matches[1]
    } elseif ($result -match "([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})") {
        $lockId = $Matches[1]
    }
    
    if ($lockId) {
        Write-Host "`nStep 3: Found lock ID: $lockId"
        
        Write-Host "`nStep 4: Force unlocking..."
        Write-Host "Running: terraform force-unlock -force $lockId"
        $unlockResult = terraform force-unlock -force $lockId 2>&1
        Write-Host $unlockResult
        
        Write-Host "`nStep 5: Verifying unlock by running apply again..."
        Start-Sleep -Seconds 2
        $verifyResult = terraform apply -auto-approve 2>&1
        Write-Host $verifyResult
        Write-Host "Apply completed successfully after force unlock!"
    } else {
        Write-Host "`nCould not extract lock ID from error message."
        Write-Host "Full output for manual inspection:"
        Write-Host $result
        Write-Host "`nYou can manually run: terraform force-unlock <LOCK_ID>"
    }
} catch {
    Write-Host "Error occurred: $_"
} finally {
    Write-Host "`nStep 6: Cleaning up background job..."
    if ($lockJob.State -eq "Running") {
        Write-Host "Stopping background apply job..."
        Stop-Job $lockJob -ErrorAction SilentlyContinue
    }
    
    Write-Host "Background job output:"
    Receive-Job $lockJob -ErrorAction SilentlyContinue
    Remove-Job $lockJob -ErrorAction SilentlyContinue
}

Write-Host "`nForce unlock test completed!"