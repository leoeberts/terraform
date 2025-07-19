# Script to test Terraform state locking by running two applies simultaneously
Write-Host "Testing Terraform state locking..."
Write-Host "Starting two tf apply processes simultaneously"

# Check if AWS_PROFILE is set
if (-not $env:AWS_PROFILE) {
    Write-Host "Error: AWS_PROFILE environment variable not set"
    Write-Host "Run: tf profile <your-profile-suffix>"
    exit 1
}

# Start first apply in background
$job1 = Start-Job -ScriptBlock {
    param($profile)
    Set-Location "C:\Users\leona\Desktop\Study\Terraform\my_terraform\5.terraform_backend"
    aws sso login --profile $profile
    terraform apply -auto-approve
} -ArgumentList $env:AWS_PROFILE

# Start second apply in background
$job2 = Start-Job -ScriptBlock {
    param($profile)
    Set-Location "C:\Users\leona\Desktop\Study\Terraform\my_terraform\5.terraform_backend"
    aws sso login --profile $profile
    terraform apply -auto-approve
} -ArgumentList $env:AWS_PROFILE

Write-Host "Both jobs started. Waiting for completion..."
Write-Host "Job 1 ID: $($job1.Id)"
Write-Host "Job 2 ID: $($job2.Id)"

# Wait for both jobs to complete
Wait-Job $job1, $job2

Write-Host "`nJob 1 Output:"
Receive-Job $job1

Write-Host "`nJob 2 Output:"
Receive-Job $job2

# Clean up jobs
Remove-Job $job1, $job2

Write-Host "`nState lock test completed!"