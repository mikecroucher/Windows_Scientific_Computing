#parallel_counters.ps1
#Runs 5 instances of counter.ps1 in parallel

$scriptname 	= "counter.ps1"
$outputfileBase = "outfile"
$outputfileExt  = ".txt"

$scriptPath = "$pwd\$scriptname"

for ($i=1; $i -le 5; $i++)
{
  $outputfilePath = "$pwd\$outputfileBase" + $i + $outputfileExt
  $command = "$scriptPath -step $i `> $outputfilePath"
  $myScriptBlock = [scriptblock]::Create($command)
  start-job -scriptblock $myScriptBlock

}
	 