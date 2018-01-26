# Cornell specific miRquant instructions

Instructions on running miRquant on Cornell's cluster.  

1. Cornell-specific miRquant information and tutorial
2. Running a large amount of samples efficiently

### Cornell-specific miRquant information and tutorial

The location of the miRquant tutorial is here:
```
/home/pr46_0001/cornell_tutorials/miRquant_tutorial/
```

The directory contents are:
```
$ ls -1
bin
cornell_mirquantENV.sh
final_processing.py
miRquant.py
process_summary_to_tab.py
README.md
runC.py
test_multi_samples
test_sample
```

`test_sample` is a good place to start to practice running the first three major chunks of miRquant in a short amount of time, but ultimately we want to run `test_multi_samples`, which will teach you the full miRquant analysis on muliple samples of various conditions.

We'll next reserve a machine, login to our machine, create a folder in the working directory, and move our test files there. For information on this, see [getting ready to run a job](https://github.com/Sethupathy-Lab/cornell_tutorials/blob/master/getting_ready_to_run_a_job.md).

Copy our test files to Cornell ID work directory.
```
$ cp /home/pr46_0001/cornell_tutorials/miRquant_tutorial/test_multi_samples/* /workdir/<your Cornell ID here>/
$ cd /workdir/<your Cornell ID here>/
```

Change to your Cornell ID working directory and edit the file within the configuration directory (conf_miRquant.yml). The project path must match where your fastqs are and the output path must be identical until the naming of the directory to hold the output. This will require you to replace **``<put your Cornell ID here>``** with your Cornell ID. The path section of conf_miRquant.yml looks like this:
```
# Directory locations
paths:
    genome:
        /home/pr46_0001/projects/genome/
    mirquant:
        /home/pr46_0001/cornell_tutorials/cornell_miRquant_tutorial/
    output:
        /workdir/<put your Cornell ID here>/test_multi_samples/tutorial_output/
    project:
        /workdir/<put your Cornell ID here>/test_multi_samples/
```

For more information and the full tutorial, see the [main miRquant repository](https://github.com/Sethupathy-Lab/miRquant). From here you can continue using the main [miRquant tutorial](https://github.com/Sethupathy-Lab/miRquant/blob/master/tutorial/TUTORIAL.md) and follow along starting at the **Running miRQuant** section.

##### Collecting miRquant results
Once miRquant has completed running, we will want to keep the output files and the fastqs, but not all files that were generated. The miRquant_collect script can help with that.
```
$ miRquant_collect -h
usage: miRquant_collect [-h] [-l LOCATION] [-r RES] miRquant_out out

Collects the necessary files from the miRquant directory and
moves them to a directory in small RNAseq directory. This should
be run from the directory containing the sample fastqs and associated
miRquant files/directories, unless otherwise specified by the -r option.

positional arguments:
  miRquant_out          Name of directory containing miRquant sample files (logs, out, ect)
  out                   Name of output directory

optional arguments:
  -h, --help            show this help message and exit
  -l LOCATION, --location LOCATION
                        Location for output directory (Default = small RNA directory in miRquant_temporary)
  -r RES                Location of results directory (Default = current directory)
  ```


### Running a large amount of samples efficiently

miRquant takes a long time to run. If you have sequencing results from many samples, it is a good idea to subset the data and run in batchs. However, this will slightly change how we run miRquant, the details of which will be covered below. First, add the required path to our system path using this command:
```
PATH=$PATH:/home/pr46_0001/shared/bin
```

#### Subsetting fastqs

There is a script in place to break your data into sets, miRquant_subset.
```
$ miRquant_subset -h
usage: miRquant_subset [-h] [-n NUM] fastqs [fastqs ...]

Script will subset many fastqs into sets containing however many you chose
(default = 5).

The purpose of this script is two-fold; 1) Decrease the time required to
process many fastqs on CBSU by creating sets that can be run on multiple
machines 2) Decrease the amount of work to be repeated due to a
failure of a sample (eg: only have to re-run set instead of all samples).

If this script is used, sets must be assembled prior to running the
final_processing.py script. There are scripts to assist with this, see
miRquant tutorial under the Cornell tutorials section of the gitHub
(https://github.com/Sethupathy-Lab/cornell_tutorials).

positional arguments:
  fastqs             fastqs that you want to subset

optional arguments:
  -h, --help         show this help message and exit
  -n NUM, --num NUM  Number of files to put in each subset
```
For example, if we had 10 samples to break into two sets of 5, we would use the script as follows:
```
$ ls -1
SampleA.fastq
SampleB.fastq
SampleC.fastq
SampleD.fastq
SampleE.fastq
SampleF.fastq
SampleG.fastq
SampleH.fastq
SampleI.fastq
SampleJ.fastq

$ miRquant_subset -n 5 *.fastq
Each set will contain 5 fastqs

Creating set #1...
SampleA.fastq
SampleB.fastq
SampleC.fastq
SampleD.fastq
SampleE.fastq

Creating set #2...
SampleF.fastq
SampleG.fastq
SampleH.fastq
SampleI.fastq
SampleJ.fastq
Done!

$ ls -1
SampleA.fastq
SampleB.fastq
SampleC.fastq
SampleD.fastq
SampleE.fastq
SampleF.fastq
SampleG.fastq
SampleH.fastq
SampleI.fastq
SampleJ.fastq
set_1            <- set_1 containing SampleA.fastq to SampleE.fastq
set_2            <- set_2 containing SampleB.fastq to SampleJ.fastq
```
You'll still need to assemble a configuration folder for each of these sets prior to running miRquant on them.

#### Re-combining subsetted files

Once each set has been analysed through the process_summary_to_tab.py (but before running final_processing.py), bring the necessary files from the reserved computer to the lab space (see [miRquant collect script](#collecting-mirquant-results)
