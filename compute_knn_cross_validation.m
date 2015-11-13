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
sampleFoldId = mod(1:size(data,1),NUM_OF_FOLDS) + 1 ; 
withoutStandAccuracy = zeros(1,K);
standAccuracy = zeros(1,K);
for k = 1 : K
    foldAccuracy = 0;
    standardFoldAccuracy = 0;
    for j = 1 : NUM_OF_FOLDS
        validationInds = find(sampleFoldId == j);
        trainingInds = setdiff( 1:size(data,1), validationInds );        
        foldAccuracy = foldAccuracy + getAccuracy( samples(validationInds,: ), lables(validationInds),samples(trainingInds,:),lables(trainingInds),k);       
        standardFoldAccuracy = standardFoldAccuracy + getAccuracy( standardSamples( validationInds ,: ), lables( validationInds), standardSamples( trainingInds ,:), lables( trainingInds), k );
    end
    
    % take the avarage accuracy over all valdiation sets (fold) accuracy
    withoutStandAccuracy(k) = foldAccuracy / NUM_OF_FOLDS;
    standAccuracy(k) = standardFoldAccuracy / NUM_OF_FOLDS;
end


%% Plots
figure(1)
hold on
plot(standAccuracy , 'r')
plot(withoutStandAccuracy )
legend('standardizied accuracy','not standardizied accuracy')
title('Glass nearest neighburs 10-fold cross-validation accuracy(regular vs standardisized)')
ylabel('% Accuracy')
xlabel('k (amount of nearest neighbors voting)')
hold off

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
