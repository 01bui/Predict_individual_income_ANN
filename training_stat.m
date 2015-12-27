function training_app_main()
clc;
experiment_count = 10;

for k=1:experiment_count
    fprintf('-------------------------\n');
    fprintf('Experiment %d\n', k);
    [weights, errors, training_time(k)] = train();
    
    regression_error(k) = errors.test.regression;
    classification_error(k) = errors.test.classification;    
end
fprintf('-------------------------\n');
fprintf('Training Time\n');
fprintf('\t %g (mean)\n', mean(training_time));
fprintf('\t %g (std)\n', std(training_time));
fprintf('\t %g (max)\n', max(training_time));

fprintf('Regression Error\n');
fprintf('\t %g (mean)\n', mean(regression_error));
fprintf('\t %g (std)\n', std(regression_error));
fprintf('\t %g (max)\n', max(regression_error));

fprintf('-------------------------\n');

fprintf('\t %g\t%g\t%g\n', mean(training_time), std(training_time), max(training_time));
fprintf('\t %g\t%g\t%g\n', mean(regression_error), std(regression_error), max(regression_error));

