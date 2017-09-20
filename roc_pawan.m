%% Fetch Training data
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

%% Calculate mean and covariance of training data
U1=mean_DS(training_data_class_1);
COV1=covariance_calculate(training_data_class_1,U1);

U2=mean_DS(training_data_class_2);
COV2=covariance_calculate(training_data_class_2,U2);

U3=mean_DS(training_data_class_3);
COV3=covariance_calculate(training_data_class_3,U3);

%% Fetch Testing Data
testing_data = zeros(450,2);
testing_data(1:150,:) = data(351:500,:);
testing_data(151:300,:) = data(851:1000,:);
testing_data(301:450,:) = data(1351:1500,:);

%% Calculating True Positive Rate & False Positive Rate For all the 5 cases
% Case1 : Covariance Same for all classes
[TPR,FPR] = calculate_tpr_fpr(U1,U2,U3,COV1,COV1,COV1,testing_data);
plot(FPR(1,:),TPR(1,:),'LineWidth',3);
hold on;

% Case2 : Covariance different for all classes
[TPR1,FPR1] = calculate_tpr_fpr(U1,U2,U3,COV1,COV2,COV3,testing_data);
plot(FPR1(1,:),TPR1(1,:),'LineWidth',3);

% Case3 : Naive Bayes Covariance C = sigma^2 I for all classes
COV = zeros(size(COV1,1),size(COV1,2));
for i=1:size(COV1,1)
    for j=1:size(COV1,2)
        if i==j
            COV(i,j) = COV1(1,1);
        else
            COV(i,j) = 0;
        end
    end
end

[TPR2,FPR2] = calculate_tpr_fpr(U1,U2,U3,COV,COV,COV,testing_data);
plot(FPR2(1,:),TPR2(1,:),'LineWidth',3);

% Case4 : Naive Bayes Covariance C = same for all classes
COV = zeros(size(COV1,1),size(COV1,2));
for i=1:size(COV1,1)
    for j=1:size(COV1,2)
        if i==j
            COV(i,j) = COV1(i,j);
        else
            COV(i,j) = 0;
        end
    end
end

[TPR3,FPR3] = calculate_tpr_fpr(U1,U2,U3,COV,COV,COV,testing_data);
plot(FPR3(1,:),TPR3(1,:),'LineWidth',3);

% Case5 : Naive Bayes Covariance different for all classes
COVN1 = zeros(size(COV1,1),size(COV1,2));
COVN2 = zeros(size(COV1,1),size(COV1,2));
COVN3 = zeros(size(COV1,1),size(COV1,2));

for i=1:size(COV1,1)
    for j=1:size(COV1,2)
        if i==j
            COVN1(i,j) = COV1(i,j);
            COVN2(i,j) = COV2(i,j);
            COVN3(i,j) = COV3(i,j);
        else
            COVN1(i,j) = 0;
            COVN2(i,j) = 0;
            COVN3(i,j) = 0;
        end
    end
end

[TPR4,FPR4] = calculate_tpr_fpr(U1,U2,U3,COVN1,COVN2,COVN3,testing_data);
plot(FPR4(1,:),TPR4(1,:),'LineWidth',3);

xlabel('False Positive Rate');
ylabel('True Positive Rate');
title('ROC curve for non linear seperable Data');
legend('Case1','Case2','Case3','Case4','Case5');
set(gca,'FontSize',18,'FontWeight','bold');



