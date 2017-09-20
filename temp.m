data = load('3_ls.txt');

% Training data 
training_data_class_1 = zeros(350,2);
training_data_class_2 = zeros(350,2);
training_data_class_3 = zeros(350,2);

for i=1:350    
training_data_class_1(i,:)=data(i,:);
end
for i=501:850    
training_data_class_2(i-500,:)=data(i,:);
end
for i=1001:1350
training_data_class_3(i-1000,:)=data(i,:);
end

%Calculate mean and covariance of training data
U1=mean_DS(training_data_class_1);
COV1=covariance_calculate(training_data_class_1,U1);

U2=mean_DS(training_data_class_2);
COV2=covariance_calculate(training_data_class_2,U2);

U3=mean_DS(training_data_class_3);
COV3=covariance_calculate(training_data_class_3,U3);

%Get Testing Data
testing_data = zeros(450,2);
testing_data(1:150,:) = data(351:500,:);
testing_data(151:300,:) = data(851:1000,:);
testing_data(301:450,:) = data(1351:1500,:);

% Calculate target score
g1 = calculate_gix(testing_data(1:150,:),COV1,U1);
g2 = calculate_gix(testing_data(151:300,:),COV2,U2);
g3 = calculate_gix(testing_data(301:450,:),COV3,U3);

% Calculate non target score
h1 = calculate_gix(testing_data(1:150,:),COV2,U2);
h2 = calculate_gix(testing_data(151:300,:),COV3,U3);
h3 = calculate_gix(testing_data(301:450,:),COV1,U1);

target_score = [g1;g2;g3];
non_target_score = [h1;h2;h3];



