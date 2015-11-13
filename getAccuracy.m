function accuracy = getAccuracy(test_set,test_labels,training_set,training_labels,k)    
%calculates the knn and returns the accuracy of the calculation
    error_counter =0;        
    for j=1:size(test_set,1)
        res = knn(test_set(j, :),training_set,training_labels,k,1);
        if (test_labels(j) ~= res )
            error_counter = error_counter +1;
        end        
    end
    
   % return accuracy in percentage
    accuracy = 100 *(1 - error_counter/size(test_set,1) ); 
    
return