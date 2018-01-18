# miRhub

Instructions on running miRhub using the python wrapper for Jeanette's perl code.

The location of the miRhub tutorial is here:
```
/home/pr46_0001/cornell_tutorials/miRhub_tutorial
```

The directory contents are:
```
.
├── README.md
└── test
    ├── DEG_down.txt
    └── DEG_up.txt
```

To run miRhub, we have to add the location of the executable scripts the system path. This can be done by running the following command:
```
PATH=$PATH:/home/pr46_0001/shared/bin
```

miRhub should now be available to us. To test this, we will run `miRhub --help` to see if we can access the program information.
```
$ miRhub --help
usage: miRhub [-h] [-c CONS] [-p PROJECT] [-n [NETWORK]] [-i ITER] [-s]
              [-sp SPECIES]
              gene_lists [gene_lists ...]

Wrapper for Jeanette's miRhub perl code.

positional arguments:
  gene_lists            Lists of differentially expressed genes from DESeq

optional arguments:
  -h, --help            show this help message and exit
  -c CONS, --cons CONS  Required miR conservation across included species (default = 012)
  -p PROJECT, --project PROJECT
                        Name for the project to be affixed to output files (default = miRhubProject)
  -n [NETWORK], --network [NETWORK]
                        Run miRhub in protein network mode, we usually use the list mode (default = list)
  -i ITER, --iter ITER  Number of iterations to run (default = 1000)
  -s, --six             Include if you want sixmer matches to be taken into account, we usually do not want this (default = no sixmers)
  -sp SPECIES, --species SPECIES
                        Indicate which species miRhub is being run for; should be mouse or human (default = mouse)
```

We'll next reserve a machine, login to our machine, create a folder in the working directory, and move our test files there. For information on this, see [getting ready to run a job](https://github.com/Sethupathy-Lab/cornell_tutorials/blob/master/getting_ready_to_run_a_job.md).

Copy our test files to Cornell ID work directory.
```
$ cp /home/pr46_0001/cornell_tutorials/miRhub_tutorial/test/* /workdir/<your Cornell ID here>/
$ cd /workdir/<your Cornell ID here>/
```

The test files are DEG_down and DEG_up for either down or up differentially expressed genes, respectfully. These lists were generated from human samples, and we will be running these under the standard parameters (cons of 012, list mode, 1000 iterations, no sixmers). We will want to change the project name to something more specific (-p flag) and indicate this is for human (-sp flag):
```
miRhub -p tutorial -sp human DEG_down.txt DEG_up.txt
```
The final output will be an excell sheet containing the miRhub results. The first sheet will be a list of the gene lists used and which conditions they were run under. The following sheets will be the miRhub results for each list and cons setting.

                        
