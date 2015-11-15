%%this plots a comparisment between knn with standatization and without
%%standardization. the comparesment is used using 10 fold cross validation 
% the file 'filname' should be a scv where the first columns is ignored and
% the last column is the labels
clc;
clear all;

NUM_OF_FOLDS = 10;
filename = 'data/glass.data'
K = 25
data = csvread(filename);

%% shuffle data  for Cross-Validation
data = data(randperm(size(data,1)),:);
samples  = data(:,2:size(data,2)-1);
lables = data(:,size(data,2));
standardSamples = standardization(samples);

% Divide sample for equally sizes folds
% the +1 for the foldId to start from 1 and not from 0
% sampleFoldId = mod(1:size(data,1),NUM_OF_FOLDS) + 1 ; 
without_stand_std = zeros(1,K);
stand_std = zeros(1,K);
for k = 1 : K
    %[idxs, centroids, sum_cent_diviation ,distance_point_2cent ]
%     clusters= kmeans(samples , k)    ;
% std_clusters = kmeans(standardSamples , k)    ;
% without_stand_std(k) =  sum(clusters(3)) / k;
    [idxs1, centroids, sum_cent_diviation1  ] = kmeans(samples , k);    
    [idxs2, centroids, sum_cent_diviation2  ] = kmeans(standardSamples , k);    
    for j = 1:k
%         distance_point_2cent(idxs == j)
%         sum_cent_diviation(j)
        without_stand_std(k) = without_stand_std(k) +  sum_cent_diviation1(j) * sum(idxs1 == j); % weighted avrage ( by elements in cluster)
        stand_std(k)= stand_std(k) + sum_cent_diviation2(j) * sum(idxs2 == j); % sum(idx2 ~- 'c') = 214
    end
    without_stand_std(k) = without_stand_std(k) / k;
    stand_std(k)= stand_std(k) / k;
    
%     without_stand_std(k) =  sum(sum_cent_diviation .* idxs  ) / k;    
%     stand_std(k)=  sum(sum_cent_diviation) / k;
end



% %% Plots
% figure(1)
% hold on
% plot(stand_std , 'r')
% plot(without_stand_std )
% legend('standardizied error loss','not standardizied error loss')
% % title('Glass nearest neighburs 10-fold cross-validation accuracy(regular vs standardisized)')
% ylabel('avg distance from centroid')
% xlabel('k amount of clusters')
% hold off

%% Plots
figure(1)
hold on
plot(log ( stand_std ) , 'r')
plot(log ( without_stand_std) )
legend('standardizied clustering','not standardizied clustering')
title('avrage moise (sqrt) on the centroids of k-mean algorithm(regular vs standardisized)')
ylabel('log avg distance from centroid')
xlabel('k amount of clusters')
hold off


% figure(2)
% hold on
% % plot(stand_std , 'r')
% plot(without_stand_std.^2 )
% legend('not standardizied error loss')
% % title('Glass nearest neighburs 10-fold cross-validation accuracy(regular vs standardisized)')
% ylabel('% Accuracy')
% xlabel('k amount of clusters')
% hold off

% 
% figure(2)
% hold on
% plot(standAccuracy  , 'r')
% plot(withoutStandAccuracy  , 'b')
% legend('standardizied accuracy','not standardizied accuracy')
% title('Glass nearest neighburs 10-fold cross-validation accuracy (regular vs standardisized)')
% ylabel('% Accuracy')
% xlabel('k (amount of nearest neighbors voting)')
% axis([1 25 50 80])
% hold off
% 
% 
% figure(3)
% hold on
% plot(standAccuracy  , 'r')
% plot(withoutStandAccuracy  , 'b')
% legend('standardizied accuracy','not standardizied accuracy')
% title('Glass nearest neighburs 10-fold cross-validation accuracy (regular vs standardisized)')
% ylabel('% Accuracy')
% xlabel('k (amount of nearest neighbors voting)')
% axis([1 25 20 90])
% hold off
