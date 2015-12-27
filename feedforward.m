function [outputs, net] = feedforward(inputs, weights, bias)

net = [inputs, bias] * weights;
outputs = 1*(tanh(net) + 1)/2;
