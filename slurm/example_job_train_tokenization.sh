#!/bin/bash
#SBATCH --job-name=Tokenization
#SBATCH --nodes=1
#SBATCH --account=m2612
#SBATCH --qos regular
#SBATCH --constraint=gpu
#SBATCH --ntasks=1
#SBATCH -G 4
#SBATCH --time=048:00:00
#SBATCH --module=cvmfs
#SBATCH --output=/global/u2/p/pjana/ML_Fermilab/omnijet_alpha/omnijet_logs/slurm_log/%x_%j.out
#SBATCH --open-mode=append     # Append output to log files
#SBATCH --requeue


echo "Starting job $SLURM_JOB_ID with the following script:"
echo "----------------------------------------------------------------------------"
echo
cat $0

export REPO_DIR="/global/u2/p/pjana/ML_Fermilab/omnijet_alpha"  # ADJUST THIS to your repository path
export PYTHONPATH="${REPO_DIR}:${PYTHONPATH}"

cd $REPO_DIR

LOGFILE="/global/u2/p/pjana/ML_Fermilab/omnijet_alpha/omnijet_logs/slurm_log/${SLURM_JOB_NAME}_${SLURM_JOB_ID}.log"  # ADJUST THIS to your log path

PYTHON_COMMAND="python scripts/create_tokenized_aspen_open_jetdataset_files.py --ckpt_path=/global/u2/p/pjana/ML_Fermilab/omnijet_alpha/omnijet_logs/omnijet-example-tokenization/runs/2026-02-16_19-20-50_nid001061_StretchLenience/checkpoints/last.ckpt --n_files_train=80 --n_files_val=16 --n_files_test=24"

shifter --module=gpu --image=jobirk/omnijet:latest bash -c \
    "source /opt/conda/bin/activate && export PYTHONPATH=${REPO_DIR}:${PYTHONPATH} && cd $REPO_DIR && $PYTHON_COMMAND"

## ---------------------- End of job script -----------------------------------
################################################################################
