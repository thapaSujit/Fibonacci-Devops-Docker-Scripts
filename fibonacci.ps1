# Function to calculate Fibonacci sequence
function Get-Fibonacci {
    param (
        [int]$n
    )

    $fibonacci = @(0, 1)

    if ($n -eq 0) {
        Write-Host "0"
    }
    elseif ($n -eq 1) {
        Write-Host "1"
    }
    else {
        for ($i = 2; $i -le $n; $i++) {
            $fibonacci += $fibonacci[-1] + $fibonacci[-2]
        }
        Write-Host $fibonacci[-1]
    }
}

# Check if any parameters are passed
if ($args.Count -eq 0) {
    # Output all Fibonacci numbers one by one every 0.5 second
    $i = 0
    while ($true) {
        Get-Fibonacci -n $i
        $i++
        Start-Sleep -Milliseconds 500
    }
}
else {
    # Output corresponding Fibonacci number for the passed parameter
    $n = $args[0]
    Get-Fibonacci -n $n
}
