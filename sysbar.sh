#!/bin/bash

#Johnson, Thomas#
#PA-3 (Shell Programming)#
#sysbar.sh#
#Feng,Chen#
#cs4103-sp17#
#cs410350#

cpuPlot(){

cat > cpu_usage.plot << EOF
=stacked;  usr; sys; idle
max=100
legendx=right
legendy=center
=noupperright
=nogridy
title=CPU Utilization
colors=magenta,yellow,dark_blue
xlabel=Time
xlabelshift=0,1
rotateby=-45
ylabel=Percentage (%)
ylabelshift=2,0
=table
yformat=%g%%		

EOF
}

ioPlot(){

cat > disk_usage.plot << EOF
=stacked; kB_read; kB_write
legendx=right
legendy=center
=noupperright
=nogridy
title=Disk Utilization
colors=yellow,dark_blue
xlabel=Time
xlabelshift=0,1
rotateby=-45
ylabel=Bandwidth (kB/sec)
ylabelshift=2,0
=table
yformat=%g

EOF
}

writeCpu(){
paste <(date +%H:%M:%S) <(mpstat | awk 'NR==4{print $4 "\t" $6 "\t" $13}') >> cpu_usage.plot ;
}

writeIo(){
paste <(date +%H:%M:%S) <(iostat | awk 'NR==7{print $3 "\t" $4}') >> disk_usage.plot ;
}


if [ $# -gt 2 ]; then
	echo -e "Incorrect usage. For correct usage information use the command:\n ./sysbar help "
elif [ $# -le 0 ]; then
	echo -e "Incorrect usage. First argument invalid. For correct usage information use the command:\n ./sysbar help "
else

	case $1 in
		#Case 1.1
		help)
			echo -e "To run this script use the command:\n ./sysbar.sh <interval> <iterations> \n Where the first argument is the time in seconds (1-60) to wait between tests,\n and the second argument is the amount of tests (1-10) to do."
		;;#End of Case 1.1 
	
		#Case 1.2
		[1-9]|[1-5][0-9]|[6][0]) 
		
			case $2 in
				#Case 1.21 "Main Execution"
				[1-9]|[1][0]) 
				
					cpuPlot
					ioPlot
				
					for (( i=0; i<$2; i++ )); do
						writeCpu
						writeIo
						sleep $1
					done

					perl bargraph.pl cpu_usage.plot > cpu_usage.eps
					perl bargraph.pl disk_usage.plot > disk_usage.eps
					rm cpu_usage.plot
					rm disk_usage.plot					
					;;#End of Case 1.21

				#Case 1.22
				*)
					echo -e "Incorrect usage. Second argument invalid For correct usage information use the command:\n ./sysbar help"
					;;#End of Case 1.2
			esac
			;;#End of Case 1.2
		#Case 1.3
		*) 
			echo -e "Incorrect usage. First argument invalid. For correct usage information use the command:\n ./sysbar help "
			;;#End of Case 1.3
	esac
fi
