A=load('group_3.txt');
W1=zeros(500,2);
W2=zeros(500,2);
W3=zeros(500,2);

for i=1:500     
W1(i,:)=A(i,:);
end
for i=501:1000    
W2(i-500,:)=A(i,:);
end
for i=1001:1500
W3(i-1000,:)=A(i,:);
end

W1tr=W1(1:350,:);W1tes=W1(351:500,:);
W2tr=W2(1:350,:);W2tes=W2(351:500,:);
W3tr=W3(1:350,:);W3tes=W3(351:500,:);

U1=mean_DS(W1tr);
COV1=covariance_calculate(W1tr,U1);

U2=mean_DS(W2tr);
COV2=covariance_calculate(W2tr,U2);

U3=mean_DS(W3tr);
COV3=covariance_calculate(W3tr,U3);

class_info=zeros(450,5);
class_info(1:150,5)=1;
class_info(151:300,5)=2;
class_info(301:450,5)=3;

TR=zeros(450,1);
FR=zeros(450,1);
j=1;
  
    for i=1:150      % Input Loop
        X(1,1)=W1tes(i,1);X(2,1)=W1tes(i,2);        % Input Vector
              
        class_info(i,1)=(1/(2*3.14*(det(COV1))^0.5))*exp(-0.5*(X-U1)'*inv(COV1)*(X-U1));       %post prob of w1
        class_info(i,2)=(1/(2*3.14*(det(COV2))^0.5))*exp(-0.5*(X-U2)'*inv(COV2)*(X-U2));       %post prob of w2
        class_info(i,3)=(1/(2*3.14*(det(COV3))^0.5))*exp(-0.5*(X-U3)'*inv(COV3)*(X-U3));       %post prob of w3
        class_info(i,4)=max(class_info(i,2),class_info(i,3));
    end
    for i=1:150      % Input Loop
        X(1,1)=W2tes(i,1);X(2,1)=W2tes(i,2);        % Input Vector
              
        class_info(150+i,1)=(1/(2*3.14*(det(COV1))^0.5))*exp(-0.5*(X-U1)'*inv(COV1)*(X-U1));       %post prob of w1
        class_info(150+i,2)=(1/(2*3.14*(det(COV2))^0.5))*exp(-0.5*(X-U2)'*inv(COV2)*(X-U2));       %post prob of w2
        class_info(150+i,3)=(1/(2*3.14*(det(COV3))^0.5))*exp(-0.5*(X-U3)'*inv(COV3)*(X-U3));       %post prob of w3
        class_info(150+i,4)=max(class_info(150+i,1),class_info(150+i,3));
    end
    for i=1:150      % Input Loop
        X(1,1)=W3tes(i,1);X(2,1)=W3tes(i,2);        % Input Vector
              
        class_info(300+i,1)=(1/(2*3.14*(det(COV1))^0.5))*exp(-0.5*(X-U1)'*inv(COV1)*(X-U1));       %post prob of w1
        class_info(300+i,2)=(1/(2*3.14*(det(COV2))^0.5))*exp(-0.5*(X-U2)'*inv(COV2)*(X-U2));       %post prob of w2
        class_info(300+i,3)=(1/(2*3.14*(det(COV3))^0.5))*exp(-0.5*(X-U3)'*inv(COV3)*(X-U3));       %post prob of w3
        class_info(300+i,4)=max(class_info(300+i,1),class_info(300+i,2));
    end
            
    TR=[class_info(1:150,1);class_info(151:300,2);class_info(301:450,3)];
    FR=[class_info(1:150,2);class_info(1:150,2);class_info(151:300,1);class_info(151:300,3);class_info(301:450,1);class_info(301:450,2)];
   [P_miss,P_fa] = Compute_DET(TR(1:450,1),FR(1:450,1));
    
figure;
Plot_DET(P_miss,P_fa,'r');
title('DET Cuve plot for Real Data');

% miss=P_miss(451:900,1);
% fa=P_fa(1:450,1);
% plot(miss,fa);
   