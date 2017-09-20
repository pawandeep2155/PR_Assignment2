% this is the main script of the first demo.  Run this script from inside
% Matlab.  Remember to first add the bosaris toolkit to your path
% using addpath(genpath(path_to_bosaris_toolkit))

close all;

fprintf('You need to run this script in Matlab''s graphical mode to see the plots.\n');

% % create a Normalized Bayes Error-rate plot
% demo_plot_nber;
% 
% % create a DET plot
% demo_plot_det;

% fuse two systems.

% calculate an effective prior from target prior, Cmiss, and Cfa
prior = effective_prior(0.33,1,1);
% 
% % make synthetic scores for fusion demo
% numtraintar = 10000;
% numtrainnon = 10000;
% numtesttar = 5000;
% numtestnon = 15000;
% train_data = demo_make_data_for_fusion(numtraintar,numtrainnon);
% test_data = demo_make_data_for_fusion(numtesttar,numtestnon);
% 
% % fuse the two systems
% fused_scores = demo_fusion(train_data,test_data,prior);

% split fused scores into target and nontarget scores

%%%%%% My code starts here

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
g1 = calculate_gix(testing_data(1:150,:),COV1,COV2,COV3,U1,U2,U3);
g2 = calculate_gix(testing_data(151:300,:),COV2,COV1,COV3,U2,U1,U3);
g3 = calculate_gix(testing_data(301:450,:),COV3,COV1,COV2,U3,U1,U2);

% % Calculate non target score
h1 = calculate_gix(testing_data(1:150,:),COV2,COV1,COV3,U2,U1,U3);
h2 = calculate_gix(testing_data(1:150,:),COV3,COV1,COV2,U3,U1,U2);
h3 = calculate_gix(testing_data(151:300,:),COV1,COV2,COV3,U1,U2,U3);
h4 = calculate_gix(testing_data(151:300,:),COV3,COV1,COV2,U3,U1,U2);
h5 = calculate_gix(testing_data(301:450,:),COV1,COV2,COV3,U1,U2,U3);
h6 = calculate_gix(testing_data(301:450,:),COV2,COV1,COV3,U2,U1,U3);

target_score = [g1;g2;g3]';
non_target_score = [h1;h2;h3;h4;h5;h6]';

test_data.tar_f = target_score;
test_data.non_f = non_target_score;


% 
% %%%%% My code ends here
% 
% 
% 
% test_data.tar_f = fused_scores(1:numtesttar);
% test_data.non_f = fused_scores(numtesttar+1:end);

% make a DET plot of the two systems and the fused system.
demo_plot_det_for_fusion(test_data,prior);
% 
% % display numerical measures for separate systems and fused system
% fprintf('Calculating stats for systems and their fusion.\n');
% [actdcf1,mindcf1,prbep1,eer1] = fastEval(test_data.tar1,test_data.non1,prior);
% [actdcf2,mindcf2,prbep2,eer2] = fastEval(test_data.tar2,test_data.non2,prior);
% [actdcf_f,mindcf_f,prbep_f,eer_f] = fastEval(test_data.tar_f,test_data.non_f,prior);
% fprintf('system 1: eer: %5.2f%%; mindcf: %5.2f%%; actdcf: %5.2f%%\n',eer1*100,mindcf1*100,actdcf1*100);
% fprintf('system 2: eer: %5.2f%%; mindcf: %5.2f%%; actdcf: %5.2f%%\n',eer2*100,mindcf2*100,actdcf2*100);
% fprintf('fused system: eer: %5.2f%%; mindcf: %5.2f%%; actdcf: %5.2f%%\n',eer_f*100,mindcf_f*100,actdcf_f*100);
% 
% 











