#!/bin/bash
#submit multiple samples to dREG to call TREs
#usage: dREG_multiSubmit.sh <samplename_plus.bw for each sample>
#output: bedgraph of scores for each sample


########################################
###### Input dREG parameters here ######
########################################

outdir='dREG_single_sample_output'
asvm='/home/pr46_0001/ChRO-seq/dREG-Model/asvm.mammal.RData'
cores=36

########################################


#for each sample
for ARG in "$@"
  do
    
    #file name
    plus=$ARG

    #check that plus file is read in
    if [[ $plus =~ .*plus.bw ]]; then
	:
    else
	echo 'File '$plus 'is not the plus strand. Skipping sample.'
	echo
	continue
    fi

    #check that minus file is not read in
    if [[ $plus =~ .*minus.bw ]]; then
	echo 'File '${plus} 'is the minus strand. Skipping sample.'
	echo
	continue
    fi

    minus=${plus/_plus.bw/_minus.bw}
    #get sample name from file name
    sample=`echo ${plus} | rev | cut -d "/" -f1 | rev | sed 's/_plus.bw$//'`
    echo ${sample}

    echo 'Plus strand bigwig:: '${plus}
    echo 'Minus strand bigwig: '${minus}

    #make output directory
    mkdir -p ${outdir}
   

    #run dREG
    echo $(date +'%b %d %T') "Running dREG" 
    bash /workdir/mk2554/dREG/run_dREG.bsh \
	$plus \
	$minus \
	$outdir/$sample \
	$asvm \
	$cores \
	|& tee $outdir/dREG_${sample}.log.out   	
    
    echo $(date +'%b %d %T') "$sample is finished"
    echo

done
