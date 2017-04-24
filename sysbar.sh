#!/bin/bash

case $1 in
	#Case 1.1
	help)
		echo "To run this script use the command: \n ./sysbar.sh <interval> <iterations> \n Where the first argument is the time in seconds (1-60) to wait between tests,\n and the second argument is the amount of tests (1-10) to do."
		;;#End of Case 1.1 
	
	#Case 1.2
	[1-9]|[1-5][1-9]|[6][0]) 
		
		case $2 in
			#Case 1.21
			[1-9]|[1][0]) 
				echo "$1 and $2 were the inputs"
				;;#End of Case 1.21
			#Case 1.22
			*)
				echo "Incorrect usage. Second argument invalid For correct usage information use the command:\n ./sysbar help"
				;;#End of Case 1.2
		esac
	
		;;#End of Case 1.2
	#Case 1.3
	*) 
		echo "Incorrect usage. First argument invalid. For correct usage information use the command:\n ./sysbar help "
		;;#End of Case 1.3
esac
