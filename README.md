# master_thesis_RBM20_DCM
This repository contains all code that was written and used for the master thesis 'On- and Off-Target Activity of Therapeutic CRISPR Base Editing for Familial Dilated Cardiomyopythy' by Leonie Küchenhoff. The thesis was done at the EMBL in the lab of Prof. Dr. Steinmetz under the supervision of Dr. Shengdi Li.

## DNA

### 1. ./DNA/variant_calling
Pre-processing of the raw fastq files into called variants (.vcf).  
#### Steps:
##### 1. Install and activate conda environment
mamba env create -p ./envs/smake -f ./envs/environment.yaml  
conda activate ./envs/smake  
##### 2. Prepare input and configuration files
./variant_calling/RunThisFirst.sh
##### 3. Run snakemake
snakemake --profile ./profile
Credit: Shengdi Li

### 2. ./DNA/variantfile_preparation
Steps following variant calling. Includes snakemake workflow to normalize, filter, and merge vcf files from differnt tissues and variant callers into one txt file. Can be run from the same environment as the variant calling part. Therefore, call:   
conda activate ./envs/smake

#### a) snakefile  
Contains snakemake workflow. Call with:  
snakemake --profile profile
#### b) /scripts  
Helper scripts that are called in the snakemake workflow:  
 - vcf_to_AFtable.pl  
Transforms vcf files to txt table for easier data handling.    
 - db_entry_overlap.py  
Script to extract overlapping sites with sites annotated in databases. Also corrects genotype of duplicated alleles.  
Returns trimmed database entry files with only entries overlapping with sample variants.  
 - create_filter_tables.py  
Script to perform quality filtering and save filtered variants  
 - table_annovar.pl  
Script to add genome annotation to variants.  

### 3. ./DNA/variant_analysis
Analysis of serveral aspects of output files from step two.
config.py - directory settings for import statements. Most import files are created in step 2.  
 - variant_caller_venn.ipynb   
    Plot venn diagrams of variants called by different variant callers.  
 - tissue_spec_list.ipynb  
    Write one list per tissue of tissue specific variants. Output needed for AF.ipynb & variant_surrounding.ipynb  
 - AF.ipynb  
    Plot total number of tissue specific and common variants  
    Plot allele frequency of A to G mutations  
    Plot allele frequency of on-target edits   
 - annotation.ipynb    
    Plot how variants are annotated (intron vs. exon etc.), calculate fraction per category, sample and tissue.  
 - SNP_type.ipynb  
    Calculate fraction of SNP per sample and tissue and categorize into type of SNP, plot results.  
 - variant_surrounding.ipynb    
    For each tissue specific variant, the following things will be checked:  
    Is it an A>G mutation?  
    Are there any gRNA Sequence similarities around the variant?  
 - semi_global_alignment.pl  
    Helper scrip that is called in variant_surrounding.ipynb. Searches for Seqeuence similarities of two sequences and  
    returns number of mismatches of best match.

## RNA
### 1. ./RNA/calling_prep
Pre-processing of the raw fastq files into variant files (.vcf). Also includes some steps following variant calling, such as filtering, normalization and merging them into a common txt file.
Can be run from the same environment as the DNA variant calling part. However, certain rules of the snakemake pipeline require python 2.7, which is run from a separate environment. 
##### 1. Install python 2.7 conda environment. 
mamba env create -p ./env/smakep27 -f ./env/env_p27.yml  
The pipeline is run from the same evironment as the DNA pipeline. The p27 environment will be called withing the snakemake pipeline. Therefore, run:  
conda activate ../../DNA/variant_calling/env/smake
##### 2. Run the snakemake pipeline
If all samples with the P635L mutation should be run, call:  
snakemake -s snakefile --profile profile --use-conda --config mutation=p635l  
If all samples with the R636Q mutation should be run, call:  
snakemake -s snakefile --profile profile --use-conda --config mutation=r636q  

### 2. ./RNA/analysis
This folder cotains all costum made scripts to analyze variants.
It has the following files:

#### Python scripts and jupyter notebooks

- config.py   
Paths that are used several times in scripts. They are imported at start of most scripts
- config.sh   
Paths that are used several times in bash scripts.  

- tissue_spec_list.ipynb  
Write one list per tissue of tissue specific variants (with annotation in which other samples these variant occur)

- filter_mgp_variants.ipynb  
Filter mgp db entries based on their annotations. Variants of interest are only protein coding variants.
- overlap_callers.ipynb  
Compare outputs of 6 different variant callers. Determine count of called variants, overlap with protein coding known variants (extracted with script above)
and overlap with each other

- variant_caller_venn_HC_PL_ST.ipynb  
Script to plot venn diagrams for variants called by HC, PL and ST
-on_target_AF.pynb  
Plot allele frequency of on-target edits
- AF.ipynb  
Plot counts of tissue specific and common variants & check relationship to read coverage
- SNP_type_pm_strand.ipynb  
Calculate fraction of SNP per sample and categorize into type of SNP

- annotation.ipynb  
 Annotate txt files and add info if variant is on pos. or negative strand. Save annotated df in annotation_dir

 - bystander_edits.ipynb  
 Search for bystander edits (edits in gRNA binding region)

 - bystander_edits_DNA.ipynb   
 Search for bystander edits (edits in gRNA binding region) but with DNA data  

- variant_sourrounding.ipynb  
Script to check list of variants in more detail.  
Question that is adressed:  
Are there any gRNA Sequence similarities in proximity?

- cas_offinder.ipynb  
Import potential off-target sites (found by cas-offinder) & export bam file with regions of interest  

- offfinder_redi.ipynb  
Import reads exported with reditools in all potential off-target sites (found by cas-offinder, <= 5 mismatches to gRNA) and plot to see a trend  

- compare_cov.ipynb  
Script to compare coverge across samples

-cass9_expr.ipynb
Script to compare nCas9 expression (requires cas_expr_start.sh to run first)

- compare_cov_allipynb
Script to compare genome coverage. 

 - count_tissuespec_vartypes.ipynb
Script to compare variantion types within tissue specifc variants

- signif_testing.ipynb
Script to test significance of AG variant proportion

 - input.txt / input2.txt   
Txt files that are used for bash_scripts/offinder.sh and contain the sgRNA + PAM sequences


#### Bash scripts
Syntax:  
a) Script to start script b on slurm  
b) Actual script  


a)coverage_start.sh  
b)coverage.sh  
script to extract read coverage in 100 bp bins  

a) offinder_start.sh  
b) offinder.sh  
script to extract potentail off-target sites by getting sites with few mismatches across the genome  

a)offinder_redi_start_DNA.sh   
b)offinder_redi_DNA.sh   
script to run reditools on potential off target positions with RNA data   

a) offinder_redi_start.sh   
b) offinder_redi.sh   
script to run reditools on potential off target positions with DNA data   


a) reditools_start.sh  
b) reditools.sh  
script to run reditools on area around target-site with RNA data  


a) cas_expr_start.sh
b) cas_expr.sh
Evaluate nCas9 read coverage on RNA-seq data

a) cas_expr_start_DNA  
signif_testing.ipynb.sh  
b) cas_expr_DNA.sh  
Evaluate nCas9 read coverage on WGS data  


readcount.sh  
Script to run reditools on area around target-site with RNA data  
