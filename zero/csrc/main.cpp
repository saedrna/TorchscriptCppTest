#include <torch/torch.h>
#include <torch/script.h>

#include <iostream>
#include <vector>

int main(int argc, char **argv)
{
    if (argc != 2)
    {
        std::cerr << "usage: Torchscript <path-to-exported-script-module" << std::endl;
        return -1;
    }

    // Load the torchscript module
    torch::jit::script::Module module = torch::jit::load(argv[1]);

    // Create a vector of inputs.
    std::vector<torch::jit::IValue> inputs;

    // random points in 3D
    inputs.push_back(torch::randn({1000, 3}));

    // Execute the model and turn its output into a tensor.
    at::Tensor output = module.forward(inputs).toTensor();

    std::cout << output << std::endl;

    return 0;
}
