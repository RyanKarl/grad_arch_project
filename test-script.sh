#!/bin/bash

#move all the output files to a better spot
DIR_NAME=`$RANDOM`
mkdir $DIR_NAME

lscpu > $DIR_NAME/cpu_info.txt

#primesieve
echo "Running primesieve, ~20 minutes"
echo -e "y\nprimesieve_res\nprimesieve_res\n\nn\nn" | phoronix-test-suite benchmark primesieve > $DIR_NAME/primesieve_out.txt

#aobench
echo "Running aobench, ~5 minutes"
echo -e "y\naobench_res\naobench_res\n\nn\nn\n" | phoronix-test-suite benchmark aobench > $DIR_NAME/aobench_out.txt

#ramspeed
echo "Running ramspeed, ~3 minutes"
echo -e "5\n2\ny\nramspeed_res\nramspeed_res\n\nn\nn\n" | phoronix-test-suite benchmark ramspeed > $DIR_NAME/ramspeed_out.txt

#cyclictest
echo "Running cyclictest, ~7 minutes"
echo -e "2\ny\ncyclictest_res\ncyclictest_res\n\nn\nn\n" | phoronix-test-suite benchmark cyclictest > $DIR_NAME/cyclictest_out.txt

#bork
echo "Running bork, ~6 minutes"
echo -e "y\nbork_res\nbork_res\n\nn\nn\nn\nn\n" | phoronix-test-suite benchmark bork > $DIR_NAME/bork_out.txt

#pybench
echo "Running pybench, ~4 minutes"
echo -e "y\pybench_res\npybench_res\n\nn\nn\n" | phoronix-test-suite benchmark pybench > $DIR_NAME/pybench_out.txt

mv ~/.phoronix-test-suite/test-results $DIR_NAME/results


