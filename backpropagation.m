function weights=update_backpropagation(inputs, weights, bias, eta, target_outputs)

[sample_count cols] = size(inputs);
% y=floor(rand(1, 1)*sample_count);
sample_index = randint(1, 1, sample_count) + 1;

[output, net] = feedforward(inputs(sample_index,:), weights, bias(sample_index));

error = target_outputs(sample_index,:) - output;
delta = error .* (1*(1 - tanh(net).^2)/2);

weights_delta = eta*kron([inputs(sample_index,:), bias(sample_index)]', delta);
weights = weights + weights_delta;
