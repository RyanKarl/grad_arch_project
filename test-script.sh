#!/bin/bash

if [ "`whoami`" != "root" ]; then
	echo "Error, must run as root!"
	exit 1
fi

#move all the output files to a better spot
name="test-$RANDOM"
while [ -f $name ]; do
	name="test-$RANDOM"
done
mkdir $name
cd $name

lscpu > cpuinfo-"$name".txt

#aobench
echo "Running aobench, ~5 minutes"
echo -e "y\naobench-$name\naobench-$name\n\nn\nn\n" | phoronix-test-suite benchmark aobench > aobench-"$name"-out.txt

#primesieve
echo "Running primesieve, ~20 minutes"
echo -e "y\nprimesieve-$name\nprimesieve-$name\n\nn\nn" | phoronix-test-suite benchmark primesieve > primesieve-"$name"-out.txt

#ramspeed
echo "Running ramspeed, ~3 minutes"
echo -e "5\n2\ny\nramspeed-$name\nramspeed-$name\n\nn\nn\n" | phoronix-test-suite benchmark ramspeed > ramspeed-"$name"-out.txt

#cyclictest
echo "Running cyclictest, ~7 minutes"
echo -e "2\ny\ncyclictest-$name\ncyclictest-$name\n\nn\nn\n" | phoronix-test-suite benchmark cyclictest > cyclictest-"$name"-out.txt

#pybench
echo "Running pybench, ~4 minutes"
echo -e "y\npybench-$name\npybench-$name\n\nn\nn\nn\nn\n" | phoronix-test-suite benchmark pybench > pybench-"$name"-out.txt

#bork
#echo "Running bork, ~6 minutes"
#echo -e "y\nbork-$name\nbork-$name\n\nn\nn\nn\nn\n" | phoronix-test-suite benchmark bork > bork-"$name"-out.txt

echo "Tests complete, moving results files"
mv /var/lib/phoronix-test-suite/test-results/*"$name" .

sync

echo "Finished"
