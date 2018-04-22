
# coding: utf-8

# In[369]:


import pandas as pd
import numpy as np
import xml.etree.cElementTree as ET
import glob
import re


# In[371]:


def pull_test(testID="10015"):
    Test = ["aobench", "cyclictest", "primesieve", "pybench", "ramspeed"]
    wanted = ['Model name:\s+(.+)', 'L1d cache:\s+(.+)K', 'L1i cache:\s+(.+)K', 'L2 cache:\s+(.+)K']

    CPU_Dat = []

    directory = '../test-' + testID + '/'
    # Get wanted list 
    filename = directory + "cpuinfo-test-" + testID + ".txt"
    cpu_data_file = open(filename).read()
    for item in wanted:
            CPU_Dat.append(re.split(item, cpu_data_file)[1])

    # Get Kernel Version Information
    filename = directory+"aobench-test-"+testID+"/system-logs/aobench-test-"+testID+"/version"
    cpu_data_file = open(filename).read()
    CPU_Dat.append(re.split('Linux version\s+(.+)\s\(debian',cpu_data_file)[1])

    # Get CPU Information
    filename = directory+"aobench-test-"+testID+"/system-logs/aobench-test-"+testID+"/cpuinfo"
    cpu_data_file = open(filename).read()

    #Get Test Specific Data
    CPU_Dat.append(re.split('bugs\s*:\s*(.*)',cpu_data_file)[1])
    
    for subTest in Test:
        filename = directory+subTest+"-test-"+testID+"/composite.xml"
        cpu_data_file = open(filename).read()

        print(filename)
        tree = ET.ElementTree(file=filename)

        for elem in tree.iter(tag='Value'):
            CPU_Dat.append(float(elem.text))

        for elem in tree.iter(tag='RawString'):
            if elem.text:
                elems = elem.text.split(":")
                for subelem in elems:
                    CPU_Dat.append(float(subelem))
            else:
                CPU_Dat.append("0")
                CPU_Dat.append("0")
                CPU_Dat.append("0")
    #     for item in subTest:
    #         CPU_Dat.append(do_thing(testID, item))
    print(CPU_Dat)
    return CPU_Dat

