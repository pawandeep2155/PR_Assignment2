%% Find mean and covariance for all the three classes

%Read Real Data as a Matrix from text file
data1 = load('class1.txt');
data2 = load('class2.txt');
data3 = load('class3.txt');
data = [data1;data2;data3];

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

%% Plot the gaussian for all the three classes

% [x,y] = meshgrid(-10:.2:25,-15:.2:20);
% x1 = zeros(size(x,1) * size(x,1),1);
% y1 = x1;
% l = 1;
% 
% for i=1:size(x,1)
%     for j=1:size(x,1)
%         x1(l,1) = x(i,j);
%         y1(l,1) = y(i,j);
%         l = l+1;
%     end
% end
% 
% Surface1 and countour1
% figure(1);
% z1 = [x1,y1];
% clf;
% 
% z2 = calculate_gaussian(covariance_class_1,mean_class_1,z1);
% z = vec2mat(z2,size(x,1));
% surf(x,y,z);
% hold on;
% [~,hContour] = contourf(x,y,z,10,'edgecolor','white');
% hContour.ContourZLevel = -0.1; % set the contour's Z position
% hold on;
% 
% Surface2 and countour2 
% z3 = calculate_gaussian(covariance_class_2,mean_class_2,z1);
% z = vec2mat(z3,size(x,1));
% [~,hContour] = contourf(x,y,z,10,'edgecolor','white');
% hContour.ContourZLevel = -0.1; % set the contour's Z position
% surf(x,y,z);
% hold on;
% 
% Surface3 and countour3
% z4 = calculate_gaussian(covariance_class_3,mean_class_3,z1);
% z = vec2mat(z4,size(x,1));
% [~,hContour] = contourf(x,y,z,10,'edgecolor','white');
% hContour.ContourZLevel = -0.1; % set the contour's Z position
% surf(x,y,z);
% 
% title('Gaussian Surface & Contour - Linear');
% set(gca,'fontsize',18)
% xlabel('Feature 1');
% ylabel('Feature 2')
% zlabel('Probability');
% 




%% Draw Confusion Matrix. Assume covariance of all class equal
% test_rows = uint16(class_rows * .3);
% w1actual = ones(test_rows,1);
% w2actual = 2*ones(test_rows,1);
% w3actual = 3*ones(test_rows,1);
% 
% wactual = vertcat(w1actual,w2actual,w3actual);
% 
% test_data_1 = data(training_rows+1:training_rows+test_rows,:);
% test_data_2 = data(class_rows+training_rows+1:class_rows+training_rows + test_rows,:);
% test_data_3 = data(2*class_rows+training_rows+1:num_of_rows,:);
% 
% test_data = vertcat(test_data_1,test_data_2,test_data_3);
% 
% g1 = calculate_gix(test_data,covariance_class_1,mean_class_1);
% g2 = calculate_gix(test_data,covariance_class_1,mean_class_2);
% g3 = calculate_gix(test_data,covariance_class_1,mean_class_3);
% 
% wpredicted = zeros(size(test_data,1),1);
% gtemp = zeros(3,1);
% 
% for i=1:size(wpredicted,1)
%     gtemp = [g1(i);g2(i);g3(i)];
%     [M,I] = max(gtemp);
%     wpredicted(i) = I;
% end
% 
% wactual = wactual';
% wpredicted = wpredicted';
% 
% target = zeros(3,length(wactual));
% output = zeros(3,length(wactual));
% 
% target_id = sub2ind(size(target), wactual, 1:length(wactual));
% output_id = sub2ind(size(output), wpredicted, 1:length(wactual));
% 
% target(target_id) = 1;
% output(output_id) = 1;
% 
% % Plot confusion matrix
% plotconfusion(target,output);
% xticklabels({'w1','w2','w3','score'});
% yticklabels({'w1','w2','w3','score'});
% set(gca,'fontsize',18);

%% Draw Eigen Vector and contour
% [x,y] = meshgrid(-10:.2:25,-15:.2:20);
% x1 = zeros(size(x,1) * size(x,1),1);
% y1 = x1;
% l = 1;
% 
% for i=1:size(x,1)
%     for j=1:size(x,1)
%         x1(l,1) = x(i,j);
%         y1(l,1) = y(i,j);
%         l = l+1;
%     end
% end
% 
% Contour
% clf;
% figure(1);
% z1 = [x1,y1];
% clf;
% 
% z2 = calculate_gaussian(covariance_class_1,mean_class_1,z1);
% z = vec2mat(z2,size(x,1));
% contour(x,y,z,'LineWidth',8);
% hold on;
% z3 = calculate_gaussian(covariance_class_1,mean_class_2,z1);
% z = vec2mat(z3,size(x,1));
% contour(x,y,z,'LineWidth',8);
% z4 = calculate_gaussian(covariance_class_1,mean_class_3,z1);
% z = vec2mat(z4,size(x,1));
% contour(x,y,z,'LineWidth',8);
% hold on;
% 
% Eigen Vector
% [eigen_vector,eigen_value1] = eig(covariance_class_1);
% eigen_vector = eigen_vector.*20;
% 
% plot([mean_class_1(1) eigen_vector(1,1)],[mean_class_1(2) eigen_vector(2,1)],'LineWidth',6);
% plot([mean_class_1(1) eigen_vector(1,2)],[mean_class_1(2) eigen_vector(2,2)],'LineWidth',6);
% 
% [eigen_vector,eigen_value2] = eig(covariance_class_2);
% eigen_vector = eigen_vector.*20;
% 
% plot([mean_class_2(1) eigen_vector(1,1)],[mean_class_2(2) eigen_vector(2,1)],'LineWidth',6);
% plot([mean_class_2(1) eigen_vector(1,2)],[mean_class_2(2) eigen_vector(2,2)],'LineWidth',6);
% 
% [eigen_vector,eigen_value] = eig(covariance_class_3);
% eigen_vector = eigen_vector.*20;
% plot([mean_class_3(1) eigen_vector(1,1)],[mean_class_3(2) eigen_vector(2,1)],'LineWidth',6);
% plot([mean_class_3(1) eigen_vector(1,2)],[mean_class_3(2) eigen_vector(2,2)],'LineWidth',6);
% 
% title('Constant Density Curve and Eigen Vectors');
% xlabel('Feature 1');
% ylabel('Feature 2');
% set(gca,'fontsize',18);

%% Plot decision surface & Contour

w1=zeros(150,2);
w2=zeros(150,2);
w3=zeros(150,2);
for i=351:500    
w1(i-350,:)=data(i,:);
end

for i=851:1000    
w2(i-850,:)=data(i,:);
end

for i=1351:1500
w3(i-1350,:)=data(i,:);
end

%1 vs all
t1=w1;
t2=[w2;w3];
u1=mean_DS(t1);
cov1=covariance_calculate(t1,u1);
A1=-0.5*inv(cov1);
B1=inv(cov1)*u1;
C1=-(0.5)*u1'*inv(cov1)*u1-0.5*log(det(cov1));
u2=mean_DS(t2);
cov2=covariance_calculate(t2,u2);
A2=-0.5*inv(cov2);
B2=inv(cov2)*u2;
C2=-(0.5)*u2'*inv(cov2)*u2-0.5*log(det(cov2));
f=@(x,y) x.^2.*(A1(1,1)-A2(1,1))+y.^2.*(A1(2,2)-A2(2,2))+x.*y.*(A1(1,2)+A1(2,1)-A2(1,2)-A2(2,1))+x.*(B1(1,1)-B2(1,1))+y.*(B1(2,1)-B2(2,1))+C1-C2;

%2 vs all
t1=w2;
t2=[w1;w3];
u1=mean_DS(t1);
cov1=covariance_calculate(t1,u1);
A1=-0.5*inv(cov1);
B1=inv(cov1)*u1;
C1=-(0.5)*u1'*inv(cov1)*u1-0.5*log(det(cov1));
u2=mean_DS(t2);
cov2=covariance_calculate(t2,u2);
A2=-0.5*inv(cov2);
B2=inv(cov2)*u2;
C2=-(0.5)*u2'*inv(cov2)*u2-0.5*log(det(cov2));
f1=@(x,y) x.^2.*(A1(1,1)-A2(1,1))+y.^2.*(A1(2,2)-A2(2,2))+x.*y.*(A1(1,2)+A1(2,1)-A2(1,2)-A2(2,1))+x.*(B1(1,1)-B2(1,1))+y.*(B1(2,1)-B2(2,1))+C1-C2;

%3 vs all
t1=w3;
t2=[w1;w2];
u1=mean_DS(t1);
cov1=covariance_calculate(t1,u1);
A1=-0.5*inv(cov1);
B1=inv(cov1)*u1;
C1=-(0.5)*u1'*inv(cov1)*u1-0.5*log(det(cov1));
u2=mean_DS(t2);
cov2=covariance_calculate(t2,u2);
A2=-0.5*inv(cov2);
B2=inv(cov2)*u2;
C2=-(0.5)*u2'*inv(cov2)*u2-0.5*log(det(cov2));
f2=@(x,y) x.^2.*(A1(1,1)-A2(1,1))+y.^2.*(A1(2,2)-A2(2,2))+x.*y.*(A1(1,2)+A1(2,1)-A2(1,2)-A2(2,1))+x.*(B1(1,1)-B2(1,1))+y.*(B1(2,1)-B2(2,1))+C1-C2;

[x,y] = meshgrid(-10:.2:25,-15:.2:20);
x1 = zeros(size(x,1) * size(x,1),1);
y1 = x1;
l = 1;

for i=1:size(x,1)
    for j=1:size(x,1)
        x1(l,1) = x(i,j);
        y1(l,1) = y(i,j);
        l = l+1;
    end
end

z1 = [x1,y1];
z2 = calculate_gaussian(covariance_class_1,mean_class_1,z1);
z = vec2mat(z2,size(x,1));
%contour(x,y,z,'LineWidth',4);
hold on;
z3 = calculate_gaussian(covariance_class_2,mean_class_2,z1);
z = vec2mat(z3,size(x,1));
%contour(x,y,z,'LineWidth',4);

z4 = calculate_gaussian(covariance_class_3,mean_class_3,z1);
z = vec2mat(z4,size(x,1));
%contour(x,y,z,'LineWidth',4);

fimplicit(f,'LineWidth',2);
fimplicit(f1,'LineWidth',2);
fimplicit(f2,'LineWidth',2);
h1 = scatter(w1(:,1),w1(:,2),25,'filled');
h2 = scatter(w2(:,1),w2(:,2),25,'filled');
h3 = scatter(w3(:,1),w3(:,2),25,'filled');

legend([h1 h2 h3],{'Class 1','Class 2', 'Class 3'},'FontSize',18,'FontWeight','bold');
xlabel('Feature1','FontSize',18,'FontWeight','bold');
ylabel('Feature2','FontSize',18,'FontWeight','bold');
title('Decision Surface', 'FontSize',18);


