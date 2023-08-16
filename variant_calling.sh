#How many unfiltered variants

bcftools view -H cichlid_full.vcf.gz | wc -l

###Variant Calling Script

#!/bin/bash -l
#SBATCH -p batch
#SBATCH -J variant_calling
#SBATCH -n 8

#Load gatk
module load gatk/4.4.0.0

# Set paths to files
AF_ONLY_GNOMAD="/var/scratch/global/emurungi/mitch/mutect/resources/af-only-gnomad.hg38.vcf.gz"
REFERENCE_FASTA="/var/scratch/global/emurungi/mitch/mutect/whole_genome/hg38.fa"
NORMAL_BAM="/var/scratch/global/emurungi/mitch/mutect/normal.updated.bam"
TUMOR_BAM="/var/scratch/global/emurungi/mitch/mutect/tumor.updated.bam"

# Run Mutect2
gatk Mutect2 \
-R $REFERENCE_FASTA \
-I $TUMOR_BAM \
-I $NORMAL_BAM \
--germline-resource $AF_ONLY_GNOMAD \
-O output.vcf.gz

###Extracting Variants

#!/bin/bash -l
#SBATCH -p batch
#SBATCH -J extract_variants
#SBATCH -n 8

# Load GATK
module load gatk/4.4.0.0

# Set paths to files
REFERENCE_FASTA="/var/scratch/global/emurungi/mitch/mutect/whole_genome/hg38.fa"
INPUT_VCF="output.vcf.gz"
OUTPUT_VCF="variants_in_genes.vcf.gz"

# Define intervals for the genes ZNF217, ZNF750, and ZNF703
INTERVALS="chr20:53567071-53593839 chr17:82829434-82840022 chr8:37695782-37700019"

# Use SelectVariants to extract variants in specified intervals
gatk SelectVariants \
-R $REFERENCE_FASTA \
-V $INPUT_VCF \
-L $INTERVALS \
-O $OUTPUT_VCF
















