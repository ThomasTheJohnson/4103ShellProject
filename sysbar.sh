#!/bin/bash

case $1 in
	help) echo "This is the help case";;

	[0-999]) echo "The interval is between 0 and 999";;

	*) echo "This is an invalid command.";;
esac
