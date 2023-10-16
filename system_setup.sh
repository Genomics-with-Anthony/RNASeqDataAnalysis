#!/bin/bash

# This file will provide all the commands required to prepare system for RNASeq Data Analysis workflow

# The first step is to set up virtual machines due to limited individual computational power of local maschine.  
# The virtual machine’s connection information is provided IP(10.20.102.4 is hypothetical IP) and key(filename.txt)

ssh ubuntu@10.20.102.4 -i pathtofile/filename.txt

# The key for VM’s connection will not work due to permission restrictions. The chmod 600 command can be used for file permission.
# chmod is command for permission changing. The number 6 means user got read and write permission but other have no permission (--rw------).
# File path given at the end of command.

chmod 600 pathtofile/filename.txt

# The second step of system set up will be to install conda. To download directly from websites, wget command followed by URL will used. 
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe

# Installing Miniconda: The Miniconda is written in bash programming language that is why it has .sh extension and installation performed by running bash command on downloaded file
bash Miniconda3-py39_4.12.0-Linux-x86_64.sh

# The following command will install conda-forge as well as bioconda channels.
conda install scipy --channel 
conda-forge --channel bioconda

conda create --name bio # create environment bio
conda activate bio # activate bio
conda deactivate  # deactivate bio
conda list -n bio # to list all packages installed to bio environment
conda info --envs  # OR
conda env list # to list all environment in conda 
conda config --add channels bioconda
conda create -n mapping star
conda install star
conda env
conda activate

# Installing jupyterlab
conda install jupyterlab 
conda install -c conda-forge bash_kernel

# Installing fastqc 
conda install -c bioconda fastqc 

# Installing flexbar  and flexbar is only available on Ubuntu 
conda install -c bioconda flexbar
flexbar -h # open flexbar help to test the flexbar installation and to check available commands

# Installing cutadapt  if you are not working on Ubuntu
conda install -c bioconda cutadapt
cutadapt -h # open cutadapt help to test the cutadapt installation and to check available commands

# create new environment mapping and also install star 
conda create -n mapping star
conda install star
conda env list # to list all conda environment
conda activate mapping # activate mapping environment

# Installing Picard
conda install -c bioconda picard
picard -h # open picard help to test the picard installation and to check available commands

# Installing Bamtools
conda install -c bioconda bamtools
bamtools -h # open bamtools help to test the bamtools installation and to check available commands

# create new environment featurecounts and also install featureCounts 
# subread is conda package which includes featureCounts program and following coomand can be used to install it
conda create -n featurecounts -c bioconda subread

# to test if featurecounts created type following command
conda activate featurecounts






