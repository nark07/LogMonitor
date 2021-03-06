Function MetricProcessor ([LogMonitor.FileChange] $change)
{
    If (!$change)
    {
        Throw "No change specified."
    }
        
    $metrics = @()
        
    if ($change.GetType().FullName -eq "LogMonitor.Processors.W3CChange")
    {
		$timeTakenIndex = [array]::indexof($change.FieldNames,[LogMonitor.Processors.W3CFields]::TimeTaken)
        
		foreach ($values in $change.Values)
		{
			if ($timeTakenIndex -ge 0 -And $values.length -gt $timeTakenIndex) 
			{
				$metrics += [LogMonitor.Metric]::Create('time_taken', [float]$values[$timeTakenIndex], [LogMonitor.MetricType]::Timing)
			}
		}
    }
        
    return $metrics
}