#!/bin/bash


SECONDS=0

# Download Data 

# Raw Data Download: this tutorial is performed on paired end RNAseq data 
# Reference Genome
# GTF File
# Once above mentioned data is available, next step will be QC.

# Qaulity Control STEP of Raw Data
# New directories created and moved files into corrosponding directories to keep analysis overview in useful structure
mkdir raw_data genome_data
mv *.fastq.gz raw_data/
mv annotation.gtf reference_genome.fa adapter_file.fa genome_data/ 
# Creating a new folder to store your QC reports.
mkdir fastqc_report
# Running fastqc on sequencing data. The wilrdcard * is used to run fastqc on all files at once.
conda activate bio
fastqc raw_data/*.fastq.gz fastqc_report/  
# it will generate html files & Discussion on FastQC reports is available in tutorial file

# Trimming Adapters
# flexbar is only available on Ubuntu 
flexbar --version # to check the version of flexbar
flexbar -r 
flexbar -r fastq.fq -a fasta.fa -ao 3 -ae 0.1
flexbar -r raw_data/filename_read1.fastq.gz -p raw_data/filename_read2.fastq.gz -a genomce_data/adapter_file.fa -x 13 \
--zip-output GZ --adapter-min-overlap 7 --min-read-length 25 --threads 1 -t output_file 
echo "Flexbar Trimming Finished!"

# adaptor trimmining with cutadapt (Flexbar is only available on ubuntu) 

# Here, the input reads are in filename_reads1.fastq and filename.reads2.fastq, and the result will be written to out.filename_read1.fastq & out.filename.read2.fastq.
# In paired-end mode, the options -a, -b, -g and -u that also exist in single-end mode are applied to the forward reads only. To modify the reverse read, 
# these options have uppercase # versions -A, -B, -G and -U that work just like their counterparts. In the example above, ADAPTER_FWD will therefore be 
# trimmed from the forward reads and ADAPTER_REV from the reverse reads.

# create directory to save trimmed data
mkdir trimmed_data
cutadapt -a AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT -A GATCGGAAGAGCACACGTCTGAACTCCAGTCACATCTCGTATGCCGTCTTCTGCTTG -o \
/trimmed_data/out.filename_read1.fastq -p trimmed_data/out.filename_read2.fastq raw_data/filename_read1.fastq.gz aw_data/filename_read2.fastq.gz
echo "Trimming Finished!"

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."





