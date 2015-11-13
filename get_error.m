function error = get_error(test_set,test_labels,training_set,training_labels,k)    
    error_counter =0;        
    for j=1:size(test_set,1)
        res = knn(test_set(j, :),training_set,training_labels,k);
        %m = ClassificationKNN.fit(data,lables)
        %if (strcmp(test_labels(j),res)==0)
        if (test_labels(j) ~= res )
            error_counter = error_counter +1;
        end        
    end
    error = error_counter/size(test_set,1);
return