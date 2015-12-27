function [weights, errors, epoch] = train()

data = importdata('totaldata.mat');

data_sets.input_count = 34;
data_sets.output_count = 2;

% 50% for training
% 25% for validation
% 25% for testing
n_sample = size(data,1);
ntrain = floor(n_sample*50/100);
nvalid = floor(n_sample*25/100);
ntest = n_sample - ntrain - nvalid;

data_sets.training_count = ntrain;
data_sets.validation_count = nvalid;
data_sets.test_count = ntest;

data_sets.training.inputs = data(1:ntrain,1:34);
data_sets.training.outputs = data(1:ntrain,35:36);
data_sets.training.classes = data(1:ntrain,37);

data_sets.validation.inputs = data(ntrain+1:ntrain+nvalid,1:34);
data_sets.validation.outputs = data(ntrain+1:ntrain+nvalid,35:36);
data_sets.validation.classes = data(ntrain+1:ntrain+nvalid,37);

data_sets.test.inputs = data(ntrain+nvalid+1:n_sample,1:34);
data_sets.test.outputs = data(ntrain+nvalid+1:n_sample,35:36);
data_sets.test.classes = data(ntrain+nvalid+1:n_sample,37);

data_sets.training.bias = ones(data_sets.training_count, 1);
data_sets.validation.bias = ones(data_sets.validation_count, 1);
data_sets.test.bias = ones(data_sets.test_count, 1);

data_sets.training.count = data_sets.training_count;
data_sets.validation.count = data_sets.validation_count;
data_sets.test.count = data_sets.test_count;

max_weight = 1/2;
max_iterations = 2000;
eta = .5;
validation_stop_threshold = .15;

weights = (2*rand(data_sets.input_count + 1, data_sets.output_count)-1) * max_weight;

epoch = 1;

while true
    
    weights = backpropagation(data_sets.training.inputs,...
        weights,...
        data_sets.training.bias,...
        eta,...
        data_sets.training.outputs);
    
    [training_regression_error(epoch), ...
        training_classification_error(epoch)] = ...
        eval_network(...
        data_sets.training,...
        weights);
    
    [validation_regression_error(epoch), ...
        validation_classification_error(epoch)] = ...
        eval_network(...
        data_sets.validation,...
        weights);
    
    [test_regression_error(epoch), ...
        test_classification_error(epoch)] = ...
        eval_network(...
        data_sets.test,...
        weights);
    
    %loop maintenance
    if (validation_regression_error(epoch)) < validation_stop_threshold || (epoch >= max_iterations)
        break;
    end
    
    epoch = epoch + 1;
end

[errors.training.regression, ...
    errors.training.classification] = ...
    eval_network(...
    data_sets.training,...
    weights);

[errors.validation.regression, ...
    errors.validation.classification] = ...
    eval_network(...
    data_sets.validation,...
    weights);

[errors.test.regression, ...
    errors.test.classification] = ...
    eval_network(...
    data_sets.test,...
    weights);

plot1 = plot([...
    training_regression_error; ...
    validation_regression_error;...
    test_regression_error;...
    ]');

title('Error vs. Learning Time');
xlabel('Epochs');
ylabel('Average Error');

set(plot1(1),'Color',[1 0 0], 'LineStyle','-');
set(plot1(2),'Color',[0 .7 .7], 'LineStyle','-');
set(plot1(3),'Color',[.8 .9 0], 'LineStyle','-');

legend({'Training', 'Validation','Test'});
end
