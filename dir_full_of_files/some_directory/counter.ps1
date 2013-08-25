param($step=1)
#A simple, long running job to demonstrate background jobs

$i=1

while ( $i -lt 200000 )
{
	echo $i
	$i=$i+$step
}