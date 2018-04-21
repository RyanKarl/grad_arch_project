#!/bin/bash

out="results.csv"

echo "machine, kernel, aobench, cyclictest, primesieve, pybench ramspeed," > $out

for dir in `ls | grep "test-[0-9]"`; do
	line="`grep "Model name:" $dir/cpuinfo* | sed 's/  */ /g' | cut -d ' ' -f 3-`"
	line="$line, `cat $dir/aobench*/system-logs/aobench*/uname | cut -d ' ' -f 3`"
	for bench in `ls $dir | grep "test-[0-9]\+$"`; do
		value="`cat $dir/$bench/composite.xml | grep "<Value>" | cut -d '>' -f 2 | cut -d '<' -f 1`"
		line="$line, $value"
	done
	echo "$line" >> $out
done
