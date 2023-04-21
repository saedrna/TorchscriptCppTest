import torch

from torch import Tensor
import pytorch_lightning as pl

from torch_geometric.nn import fps


class FpsModule(pl.LightningModule):
    def __init__(self, ratio=0.5, random_start=False):
        super().__init__()
        self.ratio = ratio
        self.random_start = random_start

    def forward(self, pos: Tensor):
        pos = fps(pos, ratio=self.ratio, random_start=self.random_start)
        return pos


if __name__ == "__main__":
    model = FpsModule()
    script = model.to_torchscript()
    print(script.graph)

    torch.jit.save(script, "model.pt")
