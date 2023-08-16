####Script_for_trimming_raw_data

# Set the path to Trimmomatic
trimmomatic_path="/usr/share/java/trimmomatic.jar"

# Set the input directory containing the raw FASTQ files
input_dir="/home/john/Desktop/data/Mitch"

# Set the output directory to store the trimmed FASTQ files
output_dir="/home/john/Desktop/data/Mitch/trimmomatic"

# Set the adapter sequences
adapter_file="TruSeq3-PE.fa"

# Loop through each pair of FASTQ files in the input directory
for fastq_pair in "$input_dir"/*_R1.fastq.gz; do
    # Extract the base name of the file without the _R1.fastq.gz extension
    base_name=$(basename "$fastq_pair" _R1.fastq.gz)
    
    # Specify the input and output files for forward and reverse reads
    forward_input="$input_dir/$base_name""_R1.fastq.gz"
    forward_output="$output_dir/$base_name""_R1.trimmed.fastq.gz"
    reverse_input="$input_dir/$base_name""_R2.fastq.gz"
    reverse_output="$output_dir/$base_name""_R2.trimmed.fastq.gz"
    
    # Run Trimmomatic to perform the trimming
    java -jar "$trimmomatic_path" PE -threads 4 -phred33 \
        "$forward_input" "$reverse_input" \
        "$forward_output" "$output_dir/$base_name""_R1.unpaired.fastq.gz" \
        "$reverse_output" "$output_dir/$base_name""_R2.unpaired.fastq.gz" \
        ILLUMINACLIP:"$adapter_file":2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
done


