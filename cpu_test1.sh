

#! /bin/bash

: 'max_min(){
max=${$1[0]}
min=${$1[0]}

for i in "${$1[@]}" 
do
     if [ $i -gt $max ]
     then
        max="$i"
     fi

     if [ $i -lt $min ]
     then
        min="$i"
     fi
done


echo "maxi : $max"
echo "min : $min"

}
'
AvgMemory(){

avg=`echo "scale = 2; $1/$2" | bc`

echo "Avg memory : $avg"
}

AvgCpu(){

avg1=`echo "scale = 2; $1/$2" | bc`
echo "Avg cpu : $avg1"
}

AvgDisk(){
avg2=`echo "scale = 2; $1/$2" | bc`
echo "Avg disk : $avg2"
}

let count=max=max1=max2=mem=DiskUsage=CpuUsage=0

array=()
arr2=()
arr3=()

if [[ $# -lt 1 ]];
then       
	echo "usage:$0 <missing argument>"
	echo "input time period in secs"
	exit 102
fi

if [[ $# -eq 2 ]];
then

	if [ $2 = "cpu" ];
	then
	CPU=$(top -bn1 | grep load | awk '{printf "%.2f\t\t\n", $(NF-2)}')
	else
	echo "Usage $2 cpu or CPU"
	

	if [ $2 = "disk" ];
	then
	DISK=$(df -h | awk '$NF=="/"{printf "%.2f\t\t", $5}')
	else
	echo "usage $2 disk or DISK"
	

	if [ $2 = "mem" ];
	then
	MEMORY=$(free -m | awk 'NR==2{printf "%.2f\t\t",$3*100/$2 }')
	else
	echo "USage $2 mem or MEM"
	

else


	printf "Memory\t\tDisk\t\tCPU\n"
	end=$((SECONDS+$1))
	while [ $SECONDS -le $end ]; do
		MEMORY=$(free -m | awk 'NR==2{printf "%.2f\t\t",$3*100/$2 }')
		DISK=$(df -h | awk '$NF=="/"{printf "%.2f\t\t", $5}')
		CPU=$(top -bn1 | grep load | awk '{printf "%.2f\t\t\n", $(NF-2)}')
		echo "$MEMORY$DISK$CPU"
	fi
fi
fi
fi
	
	mem=`echo  $mem + $MEMORY | bc`
	DiskUsage=`echo $DiskUsage + $DISK | bc`
	CpuUsage=`echo $CpuUsage + $CPU | bc`
	count=`echo $count + 1 | bc`


array+=($MEMORY)
arr2+=($CPU)
arr3+=($DISK)

sleep 5

done
:'
 if [[ "$MEMORY" > "$max" ]]; then
     max="$MEMORY"
  fi
 if [[ "$CPU" > "$max1" ]]; then
     max1="$CPU"
  fi
 if [[ "$DISK" > "$max2" ]]; then
     max2="$DISK"
  fi
'
AvgMemory $mem $count

AvgDisk $DiskUsage $count

AvgCpu $CpuUsage $count



echo "Maximum memory :$max "
echo "Maximum CPU :$max1 "
echo "Maximum DISK :$max2 "



#grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}'

