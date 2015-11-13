
function error = get_error_matlabknn(test_set,test_labels,training_set,training_labels,k)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    error_counter =0;                
    model = ClassificationKNN.fit(training_set,training_labels);
    model.NumNeighbors = k;
    for j = 1:size(test_set,1)
        %res = knn(test_set(j, :),training_set,training_labels,k);
        res =predict(model,test_set(j,:));%'NumNeighbors',k,'prior'='uniform');
        %if (strcmp(test_labels(j),res)==0)
        if (test_labels(j) ~= res )
            error_counter = error_counter +1;
        end        
    end
    error = error_counter/size(test_set,1);
return