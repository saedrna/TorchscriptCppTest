import torch
import torch_cluster # Required to load the torch.ops

module = torch.jit.load("model.pt")
print(module.graph)

# Output:
pos = torch.randn(100, 3)
indices = module(pos)
print(indices)
