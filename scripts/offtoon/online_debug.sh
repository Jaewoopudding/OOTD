CUDA_VISIBLE_DEVICES=2 python /home/taeyoung/jaewoo/OOTD/synther/offline-to-online/cal_ql.py \
--load_model models/halfcheetah-medium-v2/checkpoint_299999_seed_0_pretrained.pt \
--env halfcheetah-medium-v2 \
--diffusion.path /home/taeyoung/jaewoo/OOTD/models/halfcheetah-medium-v2/model-100000.pt \
--start_from_pretrained_policy_and_diffusion True \
--reset_freq 100000 --continual_learning_freq 20000
