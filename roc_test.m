A=load('3_ls.txt');
W1=zeros(150,2);
W2=zeros(150,2);
W3=zeros(150,2);
for i=351:500    
W1(i-350,:)=A(i,:);
end
for i=851:1000    
W2(i-850,:)=A(i,:);
end
for i=1351:1500
W3(i-1350,:)=A(i,:);
end

U1=mean_DS(W1);
COV1=covariance_calculate(W1,U1);

U2=mean_DS(W2);
COV2=covariance_calculate(W2,U2);

U3=mean_DS(W3);
COV3=covariance_calculate(W3,U3);

class_info=zeros(450,4);
class_info(1:150,4)=1;
class_info(151:300,4)=2;
class_info(301:450,4)=3;

TPR=zeros(1,101);
FPR=zeros(1,101);
j=1;
  for th=[0:0.01:1]        % Threshold loop
    TP=0;TN=0;FP=0;FN=0;
    for i=1:450      % Input Loop
        X(1,1)=A(i,1);X(2,1)=A(i,2);        % Input Vector
              
        class_info(i,1)=(1/(2*3.14*(det(COV1))^0.5))*exp(-0.5*(X-U1)'*inv(COV1)*(X-U1));       %post prob of w1
        class_info(i,2)=(1/(2*3.14*(det(COV2))^0.5))*exp(-0.5*(X-U2)'*inv(COV2)*(X-U2));       %post prob of w2
        class_info(i,3)=(1/(2*3.14*(det(COV3))^0.5))*exp(-0.5*(X-U3)'*inv(COV3)*(X-U3));       %post prob of w3
        
            for k = 1:3
                %class=class_info(i,4);
                if (class_info(i,4) == k)
                
                    if(class_info(i,k)>=th)
                        TP=TP+1;
                    else
                        FN=FN+1;
                    end
                else
                    if(class_info(i,k)<=th)
                        TN=TN+1;
                    else
                        FP=FP+1;
                    end
               
                end
            end
                
        
       
    end  
       
        
        
   
    TPR(1,j)=TP/(TP+FN);
    FPR(1,j)=FP/(TN+FP);
    j=j+1;
end
plot(FPR(1,:),TPR(1,:));