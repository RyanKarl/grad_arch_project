#!/bin/bash

#move all the output files to a better spot
cd $(mktemp -d)

lscpu > cpu_info.txt

#primesieve
echo "Running primesieve, ~20 minutes"
echo -e "y\nprimesieve_res\nprimesieve_res\n\nn\nn" | phoronix-test-suite benchmark primesieve > primesieve_out.txt

#aobench
echo "Running aobench, ~5 minutes"
echo -e "y\naobench_res\naobench_res\n\nn\nn\n" | phoronix-test-suite benchmark aobench > aobench_out.txt

#ramspeed
echo "Running ramspeed, ~3 minutes"
echo -e "5\n2\ny\nramspeed_res\nramspeed_res\n\nn\nn\n" | phoronix-test-suite benchmark ramspeed > ramspeed_out.txt

#cyclictest
echo "Running cyclictest, ~7 minutes"
echo -e "2\ny\ncyclictest_res\ncyclictest_res\n\nn\nn\n" | phoronix-test-suite benchmark cyclictest > cyclictest_out.txt

#bork
echo "Running bork, ~6 minutes"
echo -e "y\nbork_res\nbork_res\n\nn\nn\nn\nn\n" | phoronix-test-suite benchmark bork > bork_out.txt

#pybench
echo "Running pybench, ~4 minutes"
echo -e "y\pybench_res\npybench_res\n\nn\nn\n" | phoronix-test-suite benchmark pybench > pybench_out.txt

mv ~/.phoronix-test-suite/test-results results


