param($step=1)

$i=1

while ( $i -lt 200000 )
{
	echo $i
	$i=$i+$step
}