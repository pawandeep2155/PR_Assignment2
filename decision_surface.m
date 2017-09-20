%% Find mean and covariance for all the three classes

%Read Real Data as a Matrix from text file
data = load('group_3.txt');

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
%cov2=cov1;
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
%cov2=cov1;
A2=-0.5*inv(cov2);
B2=inv(cov2)*u2;
C2=-(0.5)*u2'*inv(cov2)*u2-0.5*log(det(cov2));
f1=@(x,y) x.^2.*(A1(1,1)-A2(1,1))+y.^2.*(A1(2,2)-A2(2,2))+x.*y.*(A1(1,2)+A1(2,1)-A2(1,2)-A2(2,1))+x.*(B1(1,1)-B2(1,1))+y.*(B1(2,1)-B2(2,1))+C1-C2;

% %3 vs all
% t1=w3;
% t2=[w1;w2];
% u1=mean_DS(t1);
% cov1=covariance_calculate(t1,u1);
% A1=-0.5*inv(cov1);
% B1=inv(cov1)*u1;
% C1=-(0.5)*u1'*inv(cov1)*u1-0.5*log(det(cov1));
% u2=mean_DS(t2);
% cov2=covariance_calculate(t2,u2);cov2=cov1;
% A2=-0.5*inv(cov2);
% B2=inv(cov2)*u2;
% C2=-(0.5)*u2'*inv(cov2)*u2-0.5*log(det(cov2));
% f2=@(x,y) x.^2.*(A1(1,1)-A2(1,1))+y.^2.*(A1(2,2)-A2(2,2))+x.*y.*(A1(1,2)+A1(2,1)-A2(1,2)-A2(2,1))+x.*(B1(1,1)-B2(1,1))+y.*(B1(2,1)-B2(2,1))+C1-C2;

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

%fimplicit(f,'LineWidth',2);
fimplicit(f,'LineWidth',2);
fimplicit(f1,'LineWidth',2);
%fimplicit(f2,'LineWidth',2);
h1 = scatter(w1(:,1),w1(:,2),25,'filled');
h2 = scatter(w2(:,1),w2(:,2),25,'filled');
h3 = scatter(w3(:,1),w3(:,2),25,'filled');

legend([h1 h2 h3],{'Class 1','Class 2', 'Class 3'},'FontSize',18,'FontWeight','bold');
xlabel('Feature1','FontSize',18,'FontWeight','bold');
ylabel('Feature2','FontSize',18,'FontWeight','bold');
title('Decision Surface for Linear Data', 'FontSize',18);
