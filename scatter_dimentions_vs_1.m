%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
function scatter_dimentions_vs_1(samples,lables)
    colors = ['r','b','y','m','c','g','k']
    u_labls = unique(lables)
    for n = 2: size(samples,2)    
        figure(n)
        hold on
        for c = 1:size(u_labls,1)        
            scatter(samples(lables==u_labls(c),1),samples(lables==u_labls(c),n),colors(u_labls(c)), 'filled') %,colors(n-1)
        end
        hold off
    end
end