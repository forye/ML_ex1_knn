function [res] = knn(x,data,labels,k , take_nearest_on_draw  ) 
%%given a data[NxM] matrix and labels vector[1XM], returns the k nearest
%%neighbur
    dist = bsxfun(@minus,data,x);
    dist_sq = sum(dist.^2,2); %');
    [~, sortedArgs] = sort(dist_sq);    
    NNLabels = labels(sortedArgs(1:k));
    
    if ( take_nearest_on_draw ~= 1 )
        res = mode(NNLabels);
        
    else
        [numOfOccurences,labelValues] = hist(NNLabels ,unique(NNLabels));
        nearest = labelValues(numOfOccurences == max(numOfOccurences));
        % if there is no draw in the voting
        if (length(nearest) == 1)
            res = (nearest);
        else 
            % We will take nearest point for draw
            % 'stable' keep order of NNLabels. shortest first
            labelsOfNearests = intersect(NNLabels,nearest,'stable'); 
            %nearest neighbour bewtween the k nearest neighbor 
            res = labelsOfNearests(1); 
        end
    end 
return



% 
% 
% function [res] = knn(x,data,labels,k)  
% %%given a data[NxM] matrix and labels vector[1XM], returns the k nearest
% %%neighbur
%     diff = bsxfun(@minus,data,x);    
%     % in the distance calculation - For effiency purposes, we didnt take in
%     % account the sqrt (sqrt function doesnt change the order bewtween positive numbers).
%     dist = sum(diff.^2,2); 
%     [~, sortedArgs] = sort(dist);
%     NNLabels = labels(sortedArgs(1:k));
%     [numOfOccurences,labelValues] = hist(NNLabels ,unique(NNLabels));
%     nearest = labelValues(numOfOccurences == max(numOfOccurences));
%     
%     % if there is no draw in the voting
%     if (length(nearest) == 1)
%         res = (nearest);
%     else 
%         
%         % We will take nearest point for draw
%         % 'stable' keep order of NNLabels. shortest first
%         labelsOfNearests = intersect(NNLabels,nearest,'stable'); 
%         
%         %nearest neighbour bewtween the k nearest neighbor 
%         res = labelsOfNearests(1); 
%     end
% return


    
    
    