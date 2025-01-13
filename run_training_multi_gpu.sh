#!/bin/bash
#SBATCH --job-name=training_job_multi_gpu
#SBATCH --account=nn9997k
#SBATCH --output=training_output_multi_gpu.log
#SBATCH --error=training_error_multi_gpu.log
#SBATCH --time=01:00:00  # Set the time limit for the job
#SBATCH --partition=accel  # Use the GPU partition
#SBATCH --gpus=2
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=14
#SBATCH --mem=120G

# Load the necessary module
module load Python/3.12.3-GCCcore-13.3.0

# Activate the virtual environment
source myenv/bin/activate

# Run the Python script
srun torchrun --standalone --nnodes=1 --nproc_per_node=${SLURM_GPUS_PER_NODE:-2} ./multi_gpu.py 50 10


# Deactivate the virtual environment
deactivate
