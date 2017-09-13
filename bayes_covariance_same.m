%%Linearly Seperable Data 

%Read Linearly Seperable Data as a Matrix from text file
data = load('3_ls.txt');

% Calculate Mean and covariance for each class in data. First 500 rows
% class w1 data, next 500 rows class w2 data, remaining 500 rows class w3
% data
num_of_rows = size(data,1);
class_rows = uint16(size(data,1)/3);
training_rows = uint16(class_rows * .7);

mean_class_1 = mean_calculate(data(1:training_rows,:));
mean_class_2 = mean_calculate(data(class_rows+1:class_rows+training_rows,:));
mean_class_3 = mean_calculate(data(2*class_rows+1:2*class_rows+training_rows,:));

covariance_class_1 = covariance_calculate(data(1:class_rows,:),mean_class_1);
covariance_class_2 = covariance_calculate(data(class_rows+1:2*class_rows,:),mean_class_2);
covariance_class_3 = covariance_calculate(data(2*class_rows+1:num_of_rows,:),mean_class_3);

% Plot the gaussian for all the three classes
%gaussian_class_1 = calculate_gaussian(covariance_class_1,mean_class_1,data(1:training_rows,:));
gaussian_class_2 = calculate_gaussian(covariance_class_2,mean_class_2,data(class_rows+1:2*class_rows,:));
gaussian_class_3 = calculate_gaussian(covariance_class_3,mean_class_3,data(2*class_rows+1:num_of_rows,:));

clf
x = linspace(-6,4,50);
y = linspace(-5,5,50);
p = [x',y'];
z = calculate_gaussian(covariance_class_1,mean_class_1,p);
xlabel('x');
ylabel('y');
zlabel('P');

plot3(x,y,z);


%% Real data





%% Non Linear Data












