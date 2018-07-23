# miRhub

Instructions on running ChRO-seq in the Sethupathy Lab. For more in-depth information, read the [ChRO-seq paper](https://www.biorxiv.org/content/early/2017/09/07/185991).

The location of the miRhub tutorial is here:
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

Reserve a machine with at least 36 cores (medium-memory2 or higher) and copy contens of ChRO-seq folder to your location on the reserved machine.

```
$ cp /home/pr46_0001/cornell_tutorials/ChRO-seq/* /workdir/<your Cornell ID here>/
```

Copy your ChRO-seq sequencing files to this location, and then change to the same location.

### Example of a ChRO-seq run for Amy's HIO samples

bash proseqMapper_36threads.bsh -i /home/pr46_0001/projects/genome/GRCh38.p7/GRCh38.primary_assembly.genome -c /home/pr46_0001/projects/genome/GRCh38.p7/GRCh38.chrom.sizes -b6 -q -O 2018_06_HIO &> HIO_mapping.log &

./dREG_multiSubmit.sh *plus.bw &> dREG.log&

for x in *.bedgraph; do bash /workdir/mk2554/dREG/writeBedv2.bsh 0.8 $x; done

bash /workdir/mk2554/dREG.HD/run_dREG-HD.bsh HIO7_1_ATCACG.bedgraph.bed HIO7_1_ATCACG_plus.bw HIO7_1_ATCACG_minus.bw /workdir/mk2554/dREG-Model/dREG_HD.model.rdata 36 &> dREG.HD.HIO1.log&

bash /workdir/mk2554/dREG.HD/run_dREG-HD.bsh HIO7_2_CGATGT.bedgraph.bed HIO7_2_CGATGT_plus.bw HIO7_2_CGATGT_minus.bw /workdir/mk2554/dREG-Model/dREG_HD.model.rdata 36 &> dREG.HD.HIO2.log&

bash /workdir/mk2554/dREG.HD/run_dREG-HD.bsh HIO7_3_TTAGGC.bedgraph.bed HIO7_3_TTAGGC_plus.bw HIO7_3_TTAGGC_minus.bw /workdir/mk2554/dREG-Model/dREG_HD.model.rdata 36 &> dREG.HD.HIO3.log&
