function WaitForCompletion {
    param (
        [int32] $TaskId,
        [string] $EngineHost,
        [string] $EnginePort
    )
    
    Write-Verbose "Waiting for completion"

    while ($true) {
        $result = Invoke-CheckLongRunningCommand -TaskId $TaskId -EngineHost $EngineHost -EnginePort $EnginePort
        Write-Verbose $result
        if ($result.IsCompleted) {
            $result
            break
        }
        Start-Sleep -Seconds 2
    }
}