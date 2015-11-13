


CROSS_VALIDATION_SIZE = 10
K =25

filename = 'glass.data';
data = [0,3,0;2,0,0;0,1,3;0,1,2;-1,0,1;1,1,1];
labels = {'red','red','red','green','green','red'};

lines = csvread(filename);
dims = size(lines);
randp = randperm(dims(1));
%data  = lines(:,2:dims(2)-1);
% randp = randperm(size(data,1));
% labels = lines(:,dims(2));
labels = lines(randp,dims(2));
data  = lines(randp,2:dims(2)-1);
M = floor(size(data,1)/CROSS_VALIDATION_SIZE);
all_idx = [1:size(data,1)];
shuf_data = data ; %data(randp,:);
shuf_std_data = standardization(shuf_data);

for k = 1 : K    
    xvalidation_error = 0;
    matlab_xvalidation_error = 0;
    std_xvalidation_error = 0;
    std_matlab_xvalidation_error = 0;
    for j = 1:CROSS_VALIDATION_SIZE
        validation_idxs = [(j - 1) * M + 1 : j *M ];
        training_idxs = setdiff( all_idx, validation_idxs );        
        xvalidation_error     =     xvalidation_error + get_error(     shuf_data( validation_idxs ,: ), labels( validation_idxs), shuf_data(     training_idxs ,:), labels( training_idxs), k );       
        std_xvalidation_error = std_xvalidation_error + get_error( shuf_std_data( validation_idxs ,: ), labels( validation_idxs), shuf_std_data( training_idxs ,:), labels( training_idxs), k );
        matlab_xvalidation_error = matlab_xvalidation_error + get_error_matlabknn( shuf_data( validation_idxs ,: ), labels( validation_idxs), shuf_data( training_idxs ,:), labels( training_idxs), k );       
        std_matlab_xvalidation_error =std_matlab_xvalidation_error +get_error_matlabknn( shuf_std_data( validation_idxs ,: ), labels( validation_idxs), shuf_std_data( training_idxs ,:), labels( training_idxs), k );
    end
    not_std_error(k) = xvalidation_error / CROSS_VALIDATION_SIZE; 
    std_error(k) = std_xvalidation_error / CROSS_VALIDATION_SIZE;
    matlab_error(k)=matlab_xvalidation_error/CROSS_VALIDATION_SIZE;
    std_matlab_error(k) = std_matlab_xvalidation_error /CROSS_VALIDATION_SIZE ;

end

std_error = std_error * 100;
not_std_error = not_std_error * 100;
matlab_error = matlab_error *100;
std_matlab_error = std_matlab_error *100
figure(1)
hold on
plot(std_error  , 'r')
plot(not_std_error  , 'b')
plot(matlab_error  , 'k')
plot(std_matlab_error , 'c')
legend('standardizied error','not standardizied error','matlab error','standardisized matlab error')
title('Glass nearest neighburs 10-fold cross-validation error (regular vs standardisized)')
ylabel('% error')
xlabel('k (amount of nearest neighbors voting)')
hold off


% figure(2)
% hold on
% plot(std_error  , 'r')
% plot(not_std_error  , 'b')
% legend('standardizied error','not standardizied error')
% title('Glass nearest neighburs 10-fold cross-validation error (regular vs standardisized)')
% ylabel('% error')
% xlabel('k (amount of nearest neighbors voting)')
% axis([1 25 50 100])
% hold off
% 
% 
% figure(3)
% hold on
% plot(std_error  , 'r')
% plot(not_std_error  , 'b')
% legend('standardizied error','not standardizied error')
% title('Glass nearest neighburs 10-fold cross-validation error (regular vs standardisized)')
% ylabel('% error')
% xlabel('k (amount of nearest neighbors voting)')
% axis([1 25 0 100])
% hold off

       % training_set = shuf_data(training_idx);%etdiff(all_idx,validation_idx));
