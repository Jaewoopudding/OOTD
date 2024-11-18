envs=(
    halfcheetah-random-v2 halfcheetah-medium-v2 halfcheetah-medium-replay-v2 halfcheetah-medium-expert-v2
    walker2d-random-v2 walker2d-medium-v2 walker2d-medium-replay-v2 walker2d-medium-expert-v2
    hopper-random-v2 hopper-medium-v2 hopper-medium-replay-v2 hopper-medium-expert-v2
    antmaze-umaze-v2 antmaze-medium-play-v2 antmaze-large-play-v2 antmaze-umaze-diverse-v2 antmaze-medium-diverse-v2 antmaze-large-diverse-v2
    pen-human-v1 relocate-human-v1 hammer-human-v1 door-human-v1
)

# Total number of GPUs available
NUM_GPUS=8

# Iterate over environments
for i in "${!envs[@]}"
do
    # Compute the GPU ID by taking the index modulo the number of GPUs
    GPU_ID=$((i % NUM_GPUS))
    
    # Select the environment from the list
    env="${envs[$i]}"
    
    # Run the process on the specified GPU in the background
    CUDA_VISIBLE_DEVICES=$GPU_ID python /home/taeyoung/jaewoo/OOTD/synther/diffusion/train_diffuser.py \
        --dataset "$env" \
        --results_folder ./results/"$env" &
    
    # Wait for all 8 processes to finish before starting the next batch
    if (( (i + 1) % NUM_GPUS == 0 )); then
        wait  # Wait for all background processes to complete
    fi
done

# Wait for any remaining processes to complete
wait