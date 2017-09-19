%Mean%
%covariance%
a=load('3_ls.txt');
figure,
w1=zeros(150,2);
w2=zeros(150,2);
w3=zeros(150,2);
for i=351:500    
w1(i-350,:)=a(i,:);
end
scatter(w1(:,1),w1(:,2),25,'filled');
hold on

for i=851:1000    
w2(i-850,:)=a(i,:);
end
scatter(w2(:,1),w2(:,2),25,'filled');

for i=1351:1500
w3(i-1350,:)=a(i,:);
end
scatter(w3(:,1),w3(:,2),25,'filled');


% % 1 vs all
% t1=w1;
% t2=[w2;w3];
% u1=mean_DS(t1);
% cov1=covariance_calculate(t1,u1);
% A1=-0.5*inv(cov1);
% B1=inv(cov1)*u1;
% C1=-(0.5)*u1'*inv(cov1)*u1-0.5*log(det(cov1));
% 
% u2=mean_DS(t2);
% cov2=covariance_calculate(t2,u2);
% A2=-0.5*inv(cov2);
% B2=inv(cov2)*u2;
% C2=-(0.5)*u2'*inv(cov2)*u2-0.5*log(det(cov2));
% 
% f=@(x,y) x.^2.*(A1(1,1)-A2(1,1))+y.^2.*(A1(2,2)-A2(2,2))+x.*y.*(A1(1,2)+A1(2,1)-A2(1,2)-A2(2,1))+x.*(B1(1,1)-B2(1,1))+y.*(B1(2,1)-B2(2,1))+C1-C2;
% fimplicit(f);

% 2 vs all
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
fimplicit(f1,'LineWidth',2);



% 3 vs all
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

f=@(x,y) x.^2.*(A1(1,1)-A2(1,1))+y.^2.*(A1(2,2)-A2(2,2))+x.*y.*(A1(1,2)+A1(2,1)-A2(1,2)-A2(2,1))+x.*(B1(1,1)-B2(1,1))+y.*(B1(2,1)-B2(2,1))+C1-C2;
fimplicit(f,'LineWidth',2);



hold off
legend({'Class 1','Class 2','Class 3'},'FontSize',12,'FontWeight','bold');
xlabel('X1','FontSize',12,'FontWeight','bold');
ylabel('X2','FontSize',12,'FontWeight','bold');
title('Decision Surface', 'FontSize',12);
% u2=;
% v2=;
% x=[1,2];
% d=2;
% pc1=0.5;
% g1=(-(0.5)*(x-u)'*inv(v)*(x-u)-(d/2)*log(2*(22/7))-(0.5)*log(det(v))+log(pc1))

% A=[8,9,10,11,12];
% u=mean(A);
% v=var(A);
% x=1;
% d=1;
% pc1=0.5;
% g2=(-(0.5)*(x-u)'*inv(v)*(x-u)-(d/2)*log(2*(22/7))-(0.5)*log(det(v))+log(pc1))
