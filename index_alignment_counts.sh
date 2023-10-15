#!/bin/bash


SECONDS=0


# Step 3. Generate Index and mapping  


conda activate mapping

# STAR Generating Indice

echo "STAR Generating Indice"


STAR \
--runMode genomeGenerate \
--genomeDir star_index \
--genomeFastaFiles genome_data/reference_genome.fa \
--sjdbGTFfile genome_data/annotation.gtf \
--runThreadN 4 

echo "Indice Generated!"

# Mapping step

echo "STAR Performing Mapping"

STAR \
--genomeDir star_index \
--readFilesIn /raw_data/filename_read1.fastq /raw_data/filename_read2.fastq \
--runThreadN 4 \
--outSAMtype BAM SortedByCoordinate \
--quantMode GeneCounts

echo "Mapping Task Finished"

echo "FeatureCounts Performing Gene Counts"

featureCounts -p -a /genome_data/annotation.gtf -o counts1.txt --largestOverlap -t exon -g gene_id  /pathtofolder/prefix1Aligned.sortedByCoord.out.bam 

echo "Gene Counts Task Finished"


duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."







