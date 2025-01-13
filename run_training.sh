#!/bin/bash
#SBATCH --job-name=training_job
#SBATCH --account=nn9997k
#SBATCH --output=training_output.log
#SBATCH --error=training_error.log
#SBATCH --time=01:00:00  # Set the time limit for the job
#SBATCH --partition=accel  # Use the GPU partition
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --gpus=1  # Request one GPU

# Load the necessary module
module load Python/3.12.3-GCCcore-13.3.0

# Activate the virtual environment
source myenv/bin/activate

# Run the Python script
python ./single_gpu.py 10 2 

# Deactivate the virtual environment
deactivate
