#!/bin/bash
#SBATCH --job-name=training_job_multi_node
#SBATCH --account=<project_number>
#SBATCH --output=training_output_multi_node.log
#SBATCH --error=training_error_multi_node.log
#SBATCH --time=01:00:00  # Set the time limit for the job
#SBATCH --partition=accel  # Use the GPU partition
#SBATCH --gpus-per-node=2
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=14
#SBATCH --mem=120G

# Load the necessary module
module load Python/3.12.3-GCCcore-13.3.0

# Activate the virtual environment
source myenv/bin/activate

nodes=( $( scontrol show hostnames $SLURM_JOB_NODELIST))
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)

echo Node IP: $head_node_ip
export LOGLEVEL=INFO

# Run the Python script
srun torchrun --nnodes=2 --nproc_per_node=${SLURM_GPUS_PER_NODE:-2} --rdzv_id=$RANDOM --rdzv_backend=c10d 
--rdzv_endpoint=$head_node_ip:29500 ./multinode.py 50 10


# Deactivate the virtual environment
deactivate
