#! /bin/bash
set -e ## Halt on errors

## Activate the conda base environment

if [[ -d "${HOME}/miniconda3/" ]]
then
source ${HOME}/miniconda3/etc/profile.d/conda.sh
elif [[ "${HOME}/miniforge3/" ]]
then
source ${HOME}/miniforge3/etc/profile.d/conda.sh
fi

RAMDISK=NO

echo "Ramdisk creation is set to $RAMDISK"

if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Running on macOS"
  ENV_NAME="conda_env_osx-64"
  export CONDA_SUBDIR=osx-64 ##  ## Enables creation of a Rosetta 2 emulated intel x86-64 environment on arm64
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo "Running on Linux"
  ENV_NAME="conda_env_linux-64"
  export CONDA_SUBDIR=linux-64
fi

## Setup a ramdisk for the environment. 
if [[ $RAMDISK == "YES" && "$OSTYPE" == "linux-gnu"* ]]; then
  ENV_DIR="/dev/shm/$(whoami)/tmp$(pwd)"  
  mkdir -p "$ENV_DIR"
  echo "Made folder on ramdisk for conda environment:${ENV_DIR}"
  ln -s "$ENV_DIR" ./${ENV_NAME}
  
  elif [[ $RAMDISK == "YES" && "$OSTYPE" == "darwin"* ]]; then
  diskutil erasevolume APFS RAM_Disk_5GiB $(hdiutil attach -nomount ram://10485760) ## See https://www.dr-lex.be/info-stuff/bytecalc.html
  ENV_DIR="/Volumes/RAM_Disk_5GiB/$(whoami)/tmp$(pwd)"
  mkdir -p "$ENV_DIR"
  echo "Made folder on ramdisk for conda environment:${ENV_DIR}"
  ln -s "$ENV_DIR" ./${ENV_NAME}
fi

## Create a local env
conda create -y -p ./${ENV_NAME} 'python=3.11' ## Need 3.10 not 3.11 for certain dependencies
conda activate ./${ENV_NAME}

## Add all the conda installable executable dependencies here
#conda install -y -c conda-forge rb-bio ## Probably installed to allow sequenceserver . IMO, just run sequenceserver via the docker container
conda install -y -c conda-forge pip
conda install -y -c conda-forge bash
conda install -y -c conda-forge ipykernel ## Enables Visual Studio Code Juptyer notebook execution
conda install -y -c conda-forge jupyter
conda install -y -c conda-forge pandas
conda install -y -c conda-forge pathvalidate
conda install -y -c conda-forge natsort
conda install -y -c conda-forge rdflib
conda install -y -c conda-forge openpyxl
#conda install -y -c conda-forge nodejs ## Typically, nodejs is not needed, so remove from default to lighten the install
conda install -y -c conda-forge parallel
conda install -y -c conda-forge argh
conda install -y -c conda-forge simplejson
conda install -y -c conda-forge libiconv ## An unstated dependency of needle/emboss

conda install -y -c bioconda 'nextflow>=24.10.4' ## Without the version pinning, installs a very old version.
conda install -y -c bioconda bedtools
conda install -y -c bioconda igvtools
conda install -y -c bioconda bcftools
conda install -y -c bioconda seqkit
conda install -y -c bioconda emboss
conda install -y -c bioconda kalign2
conda install -y -c bioconda 'gffutils>=0.12'
conda install -y -c bioconda genometools-genometools

#conda install -y -c bioconda ucsc-axtchain
#conda install -y -c bioconda ucsc-blat
#conda install -y -c bioconda ucsc-chainmergesort
#conda install -y -c bioconda ucsc-chainnet
#conda install -y -c bioconda ucsc-chainsort
#conda install -y -c bioconda ucsc-chainsplit
#conda install -y -c bioconda ucsc-fasplit
#conda install -y -c bioconda ucsc-fatotwobit
#conda install -y -c bioconda ucsc-liftover
#conda install -y -c bioconda ucsc-liftup
#conda install -y -c bioconda ucsc-netchainsubset
#conda install -y -c bioconda ucsc-twobitinfo

## Export the environment - see https://stackoverflow.com/questions/49174185/export-conda-environment-without-prefix-variable-which-shows-local-path-to-execu
conda env export > conda_env.yaml
conda env export --from-history > conda_env.from-history.yaml

## Install some non conda Python dependencies
pip install git-archive-all

## Install some non conda nodejs dependencies
#npm install g2p_mapper_cli

## Some weird library patches for kent tools
#cd conda_env_linux-64/lib/
#ln -s libssl.so.1.1 libssl.so.1.0.0
#ln -s libcrypto.so.1.1 libcrypto.so.1.0.0
#cd ../../

## If adding dependencies via containers, follow this pattern:
#mkdir -p containers
#cd containers
#apptainer pull docker://quay.io/biocontainers/agat:1.4.2--pl5321hdfd78af_0
#cd ../
  
