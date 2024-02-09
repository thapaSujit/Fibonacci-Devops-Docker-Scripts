# Function to calculate Fibonacci sequence
function Get-Fibonacci {
    param (
        [Parameter(Mandatory=$true)]
        [ValidateRange(0,[int]::MaxValue)]  # Validate that parameter is a non-negative integer
        [int]$n
    )

    try {
        # Initialize Fibonacci sequence
        $fibonacci = @(0, 1)

        # Base cases
        if ($n -eq 0) {
            Write-Output "0"
        }
        elseif ($n -eq 1) {
            Write-Output "1"
        }
        else {
            # Calculate Fibonacci numbers
            for ($i = 2; $i -le $n; $i++) {
                $fibonacci += $fibonacci[-1] + $fibonacci[-2]
            }
            Write-Output $fibonacci[-1]
        }
    }
    catch {
        Write-Error "Failed to calculate Fibonacci sequence: $_"
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
