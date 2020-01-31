# ChRO-seq

Instructions on running ChRO-seq in the Sethupathy Lab. For more in-depth information, read the [ChRO-seq paper](https://www.biorxiv.org/content/early/2017/09/07/185991).

The location of the ChRO-seq files is here:
```
/home/pr46_0001/cornell_tutorials/ChRO-seq
```

We'll next reserve a machine, login to our machine, create a folder in the working directory, and move our test files there. For information on this, see [getting ready to run a job](https://github.com/Sethupathy-Lab/cornell_tutorials/blob/master/getting_ready_to_run_a_job.md).
**NOTE: Reserve a machine with at least 36 cores (medium-memory2 or higher) if you plan to use the maximum number of threads (which you probably want to do)**.

Copy ChRO-seq files to reserved machine:
```
$ cp /home/pr46_0001/cornell_tutorials/ChRO-seq/* /workdir/<your Cornell ID here>/
```

Copy your ChRO-seq sequencing files to this location, and then change to the same location.

### Example of a ChRO-seq run for Tim's FLC normal liver samples

#### Overview

1. Eliminate PCR duplicates, trim reads, QC, map to genome
2. Merge bigwig files from mapping to call TREs
3. Call a universal set of TREs with dREG
4. Identify differentially transcribed TREs between cell types/conditions
5. Perform transcription factor motif enrichment analysis


These are the commands used to run ChRO-seq and info on these commands can be found in ChRO-seq pipeline

```
source /home/pr46_0001/ChROseq/ChROseq_pipeline/ProseqMapper/setChROenv.bsh

bash /home/pr46_0001/ChROseq/ChROseq_pipeline/ProseqMapper/proseq2.0.bsh \
  -SE \
  -G \
  -i /home/pr46_0001/projects/genome/GRCh38.p7_rRNA/GRCh38.primary_assembly.genome_rRNA \
  -c /home/pr46_0001/projects/genome/GRCh38.p7_rRNA/GRCh38.rRNA.chrom.sizes \
  -O ProseqMapper2.0_output \
  --UMI1=6 \
  --thread=40 \
  -4DREG &> Proseq_output.log&

*** Work in progress ***

# We don't have multiple samples to merge, thus the mergeBigWigs step is skipped

# dREG_multiSubmit needs to be moved to the output directory prior to running, then this will submit dREG for all samples
./dREG_multiSubmit.sh *plus.bw &> dREG.log&

# Change into the dREG_single_sample_output directory and bash loop to run writeBed for all samples
for x in *.bedgraph; do bash /workdir/mk2554/dREG/writeBedv2.bsh 0.8 $x; done

# Once writeBedv2 finishes, move all files in the dREG_single_sample_output directory to the directory immediately above it.

# Move to the directory containing all of the outputs (in the original output directory) and run dREG-HD for each HIO sample
bash /workdir/mk2554/dREG.HD/run_dREG-HD.bsh HIO7_1_ATCACG.bedgraph.bed HIO7_1_ATCACG_plus.bw HIO7_1_ATCACG_minus.bw /workdir/mk2554/dREG-Model/dREG_HD.model.rdata 36 &> dREG.HD.HIO1.log&

bash /workdir/mk2554/dREG.HD/run_dREG-HD.bsh HIO7_2_CGATGT.bedgraph.bed HIO7_2_CGATGT_plus.bw HIO7_2_CGATGT_minus.bw /workdir/mk2554/dREG-Model/dREG_HD.model.rdata 36 &> dREG.HD.HIO2.log&

bash /workdir/mk2554/dREG.HD/run_dREG-HD.bsh HIO7_3_TTAGGC.bedgraph.bed HIO7_3_TTAGGC_plus.bw HIO7_3_TTAGGC_minus.bw /workdir/mk2554/dREG-Model/dREG_HD.model.rdata 36 &> dREG.HD.HIO3.log&
```
