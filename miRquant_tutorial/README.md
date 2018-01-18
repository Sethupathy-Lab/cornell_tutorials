# Cornell specific miRquant instructions

Instructions on running miRhub using the python wrapper for Jeanette's perl code.

The location of the miRhub tutorial is here:
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

Change to your Cornell ID working directory and edit the file within the configuration directory (conf_miRquant.yml). The path must match where your fastqs are, which will require you putting in your Cornell ID. The path section of conf_miRquant.yml looks like this:
```
# Directory locations
paths:
    genome:
        /home/pr46_0001/projects/genome/
    mirquant:
        /home/pr46_0001/cornell_tutorials/cornell_miRquant_tutorial/
    output:
        /workdir/<put your Cornell ID here>/test_multi_samples/
    project:
        /workdir/<put your Cornell ID here>/test_multi_samples/
```

For more information and the full tutorial, see the [main miRquant repository](https://github.com/Sethupathy-Lab/miRquant). From here you can continue usint the main [miRquant tutorial](https://github.com/Sethupathy-Lab/miRquant/blob/master/tutorial/TUTORIAL.md) and follow along starting at the **Running miRQuant** section.
