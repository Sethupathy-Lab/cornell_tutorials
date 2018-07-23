# ChRO-seq

Instructions on running ChRO-seq in the Sethupathy Lab. For more in-depth information, read the [ChRO-seq paper](https://www.biorxiv.org/content/early/2017/09/07/185991).

The location of the ChRO-seq files is here:
```
/home/pr46_0001/cornell_tutorials/ChRO-seq
```

The directory contents are:
```
ChRO-seq/
├── dREG.HD
│   ├── dREG.HD
│   │   ├── DESCRIPTION
│   │   ├── inst
│   │   │   └── extdata
│   │   │       ├── chromInfo.hg19
│   │   │       ├── dREG_HD.model.rdata
│   │   │       ├── K562.chr21.minus.bw
│   │   │       ├── K562.chr21.plus.bw
│   │   │       └── k562.chr21.predictions.bed
│   │   ├── man
│   │   │   └── dREG_HD.Rd
│   │   ├── NAMESPACE
│   │   └── R
│   │       ├── dREG_HD_GPU_working.R
│   │       └── get_genomic_data.R
│   ├── manual.pdf
│   ├── run_dREG-HD.bsh
│   └── run_dREG-HD.R
├── dREG-Model
│   ├── asvm.dm3.RData
│   ├── asvm.mammal.RData
│   ├── dREG_HD.model.rdata
│   └── README.md
├── dREG_multiSubmit.sh
├── proseqMapper_36threads.bsh
├── qc_v2.bsh
└── README.md
```

We'll next reserve a machine, login to our machine, create a folder in the working directory, and move our test files there. For information on this, see [getting ready to run a job](https://github.com/Sethupathy-Lab/cornell_tutorials/blob/master/getting_ready_to_run_a_job.md).
**NOTE: Reserve a machine with at least 36 cores (medium-memory2 or higher) if you plan to use the maximum number of threads (which you probably want to do)**.

Copy ChRO-seq files to reserved machine:
```
$ cp /home/pr46_0001/cornell_tutorials/ChRO-seq/* /workdir/<your Cornell ID here>/
```

Copy your ChRO-seq sequencing files to this location, and then change to the same location.

### Example of a ChRO-seq run for Amy's HIO samples

These are the commands used to run ChRO-seq and info on these commands can be found in ChRO-seq pipeline

```
# proseqMapper using 36 cores
bash proseqMapper_36threads.bsh -i /home/pr46_0001/projects/genome/GRCh38.p7/GRCh38.primary_assembly.genome -c /home/pr46_0001/projects/genome/GRCh38.p7/GRCh38.chrom.sizes -b6 -q -O 2018_06_HIO &> HIO_mapping.log &

# We don't have multiple samples to merge, thus the mergeBigWigs step is skipped

# dREG_multiSubmit needs to be moved to the output directory prior to running, then this will submit dREG for all samples
./dREG_multiSubmit.sh *plus.bw &> dREG.log&

# bash loop to run writeBed for all samples
for x in *.bedgraph; do bash /workdir/mk2554/dREG/writeBedv2.bsh 0.8 $x; done

# Run dREG-HD for each HIO sample
bash /workdir/mk2554/dREG.HD/run_dREG-HD.bsh HIO7_1_ATCACG.bedgraph.bed HIO7_1_ATCACG_plus.bw HIO7_1_ATCACG_minus.bw /workdir/mk2554/dREG-Model/dREG_HD.model.rdata 36 &> dREG.HD.HIO1.log&

bash /workdir/mk2554/dREG.HD/run_dREG-HD.bsh HIO7_2_CGATGT.bedgraph.bed HIO7_2_CGATGT_plus.bw HIO7_2_CGATGT_minus.bw /workdir/mk2554/dREG-Model/dREG_HD.model.rdata 36 &> dREG.HD.HIO2.log&

bash /workdir/mk2554/dREG.HD/run_dREG-HD.bsh HIO7_3_TTAGGC.bedgraph.bed HIO7_3_TTAGGC_plus.bw HIO7_3_TTAGGC_minus.bw /workdir/mk2554/dREG-Model/dREG_HD.model.rdata 36 &> dREG.HD.HIO3.log&
```
