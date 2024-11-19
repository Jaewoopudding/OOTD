import gym
import torch
from gym.wrappers.flatten_observation import FlattenObservation


def wrap_gym(env: gym.Env, rescale_actions: bool = True) -> gym.Env:
    if rescale_actions:
        env = gym.wrappers.RescaleAction(env, -1, 1)

    if isinstance(env.observation_space, gym.spaces.Dict):
        env = FlattenObservation(env)

    env = gym.wrappers.ClipAction(env)

    return env


# Make transition dataset from REDQ replay buffer.
def make_inputs_from_replay_buffer(
        replay_buffer,
        model_terminals: bool = False,
) -> torch.tensor:
    ptr_location = replay_buffer._pointer
    obs = replay_buffer._states[:ptr_location]
    actions = replay_buffer._actions[:ptr_location]
    next_obs = replay_buffer._next_states[:ptr_location]
    rewards = replay_buffer._rewards[:ptr_location]
    inputs = [obs, actions, rewards, next_obs]
    
    if model_terminals:
        terminals = replay_buffer._dones[:ptr_location].to(torch.float32)
        inputs.append(terminals)
    
    return torch.cat(inputs, dim=1)
