#!/bin/bash

basedir="/g/steinmetz/project/leonie_crispr/03_data/02_rnaseq/snakemake"
outdir="/g/steinmetz/project/leonie_crispr/03_data/02_rnaseq/snakemake/plots"
tissue_specdir="/g/steinmetz/project/leonie_crispr/03_data/02_rnaseq/snakemake/tissue_spec_vars"
annotation_dir="/g/steinmetz/project/leonie_crispr/03_data/02_rnaseq/snakemake/variant_caller_out/vartest/annovar_anno"
reference_seq="/g/steinmetz/project/leonie_crispr/03_data/01_heartproject/reference_genome/mm10_AAV.fa"
cas_offinder="/g/steinmetz/project/leonie_crispr/03_data/02_rnaseq/snakemake/offinder"
vartest="/g/steinmetz/project/leonie_crispr/03_data/02_rnaseq/snakemake/variant_caller_out/vartest/txt_files"
var_db_dir="/g/steinmetz/project/leonie_crispr/03_data/01_heartproject/known_variants_vcfs"
reditools="/g/steinmetz/project/leonie_crispr/02_repo/00_externalcode/02_downloads/reditools2.0"