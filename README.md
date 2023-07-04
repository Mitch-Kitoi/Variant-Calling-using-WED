# Variant-Calling-using-WED
Variant calling of breast cancer mutations using whole exome data (WED)
The aim is to call zinc finger protein (ZNF) mutations in patients with breast cancer. Specific zinc fingers are ZNF 750, ZNG 201 and ZNF 217.
Raw whole exome data of patients is already available (both tumor and normal cells).
#### To meet the objective I followed the procedure below;
- Fastqc of raw WED and analysis of the reports
- Trimming of data based on the report, using Trimmomatic
- Conducting the second fastqc and generating a multiqc report
- Alignment of trimmed data to whole human genome GRCh38.fna using hisat2
- Sorting of BAM files using Samtools
- Doing variant calling using gatk tool
  


