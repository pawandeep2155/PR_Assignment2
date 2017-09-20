A1=load('3_ls1.txt');
A2=load('3_ls2.txt');
A3=load('3_ls3.txt');
A=[A1;A2;A3];
W1=zeros(1000,2);
W2=zeros(1000,2);
W3=zeros(1000,2);

for i=1:1000     
W1(i,:)=A(i,:);
end
for i=1001:2000    
W2(i-1000,:)=A(i,:);
end
for i=2001:3000
W3(i-2000,:)=A(i,:);
end

W1tr=W1(1:700,:);W1tes=W1(701:1000,:);
W2tr=W2(1:700,:);W2tes=W2(701:1000,:);
W3tr=W3(1:700,:);W3tes=W3(701:1000,:);

U1=mean_DS(W1tr);
COV1=covariance_calculate(W1tr,U1);

U2=mean_DS(W2tr);
COV2=covariance_calculate(W2tr,U2);

U3=mean_DS(W3tr);
COV3=covariance_calculate(W3tr,U3);

class_info=zeros(900,5);
class_info(1:300,5)=1;
class_info(301:600,5)=2;
class_info(601:900,5)=3;

TR=zeros(900,1);
FR=zeros(900,1);
j=1;
  
    for i=1:300      % Input Loop
        X(1,1)=W1tes(i,1);X(2,1)=W1tes(i,2);        % Input Vector
              
        class_info(i,1)=(1/(2*3.14*(det(COV1))^0.5))*exp(-0.5*(X-U1)'*inv(COV1)*(X-U1));       %post prob of w1
        class_info(i,2)=(1/(2*3.14*(det(COV2))^0.5))*exp(-0.5*(X-U2)'*inv(COV2)*(X-U2));       %post prob of w2
        class_info(i,3)=(1/(2*3.14*(det(COV3))^0.5))*exp(-0.5*(X-U3)'*inv(COV3)*(X-U3));       %post prob of w3
        class_info(i,4)=max(class_info(i,2),class_info(i,3));
    end
    for i=1:300      % Input Loop
        X(1,1)=W2tes(i,1);X(2,1)=W2tes(i,2);        % Input Vector
              
        class_info(300+i,1)=(1/(2*3.14*(det(COV1))^0.5))*exp(-0.5*(X-U1)'*inv(COV1)*(X-U1));       %post prob of w1
        class_info(300+i,2)=(1/(2*3.14*(det(COV2))^0.5))*exp(-0.5*(X-U2)'*inv(COV2)*(X-U2));       %post prob of w2
        class_info(300+i,3)=(1/(2*3.14*(det(COV3))^0.5))*exp(-0.5*(X-U3)'*inv(COV3)*(X-U3));       %post prob of w3
        class_info(300+i,4)=max(class_info(300+i,1),class_info(300+i,3));
    end
    for i=1:300      % Input Loop
        X(1,1)=W3tes(i,1);X(2,1)=W3tes(i,2);        % Input Vector
              
        class_info(600+i,1)=(1/(2*3.14*(det(COV1))^0.5))*exp(-0.5*(X-U1)'*inv(COV1)*(X-U1));       %post prob of w1
        class_info(600+i,2)=(1/(2*3.14*(det(COV2))^0.5))*exp(-0.5*(X-U2)'*inv(COV2)*(X-U2));       %post prob of w2
        class_info(600+i,3)=(1/(2*3.14*(det(COV3))^0.5))*exp(-0.5*(X-U3)'*inv(COV3)*(X-U3));       %post prob of w3
        class_info(600+i,4)=max(class_info(600+i,1),class_info(600+i,2));
    end
            
    TR=[class_info(1:300,1);class_info(301:600,2);class_info(601:900,3)];
    FR=[class_info(1:300,2);class_info(1:300,2);class_info(301:600,1);class_info(301:600,3);class_info(601:900,1);class_info(601:900,2)];
   [P_miss,P_fa] = Compute_DET(TR(1:900,1),FR(1:900,1));
    
figure;
Plot_DET(P_miss,P_fa,'b');
title('DET Curve plot for Non Linear Data');

% miss=P_miss(451:900,1);
% fa=P_fa(1:450,1);
% plot(miss,fa);
   