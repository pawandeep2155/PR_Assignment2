A=load('class123.txt');
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

U1=mean_DS(W1);
COV1=covariance_calculate(W1,U1);

U2=mean_DS(W2);
COV2=covariance_calculate(W2,U2);

U3=mean_DS(W3);
COV3=covariance_calculate(W3,U3);

Act_class=zeros(1,3000);
Act_class(1,1:1000)=1;
Act_class(1,1001:2000)=2;
Act_class(1,2001:3000)=3;
Pred_class=zeros(1,3000);
%         if(i<=1000)      % Actual class calculation 
%             Act_class(1,i)=1;
%         end
%         if(1000<i<=2000)
%             Act_class(1,i)=2;
%         end
%         if(2000<i)
%             Act_class(1,i)=3;
%         end
        
pxw=zeros(1,3);
TPR=zeros(1,11);
FPR=zeros(1,11);
j=1;
for th=[0:0.1:1]        % Threshold loop
    TP=0;TN=0;FP=0;FN=0;
    for i=1:3000      % Input Loop
        X(1,1)=A(i,1);X(2,1)=A(i,2);        % Input Vector
              
        pxw(1,1)=(1/(2*3.14*(det(COV1))^0.5))*exp(-0.5*(X-U1)'*inv(COV1)*(X-U1));       %post prob of w1
        pxw(1,2)=(1/(2*3.14*(det(COV2))^0.5))*exp(-0.5*(X-U2)'*inv(COV2)*(X-U2));       %post prob of w2
        pxw(1,3)=(1/(2*3.14*(det(COV3))^0.5))*exp(-0.5*(X-U3)'*inv(COV3)*(X-U3));       %post prob of w3

        if(pxw(1,1)>=pxw(1,2))        % Max of pxw1,pxw2,pxw3
            if(pxw(1,1)>=pxw(1,3))
                Pred_class(1,i)=1;
            else
                Pred_class(1,i)=3;
            end
        else
            if(pxw(1,2)>=pxw(1,3))
                Pred_class(1,i)=2;
            else
                Pred_class(1,i)=3;
            end
        end
        
        
        if(Pred_class(1,i)==Act_class(1,i))
            if(pxw(1,Pred_class(1,i))>=th)
                TP=TP+1;
            else
                FN=FN+1;
            end
        else
            if(pxw(1,Pred_class(1,i))>=th)
                FP=FP+1;
            else
                TN=TN+1;
            end
        end
        
        
    end
%     TP
%     FP
%     TN
%     FN
    TPR(1,j)=TP/(TP+FN);
    FPR(1,j)=FP/(TN+FP);
%     TPR(1,j)
%     FPR(1,j)
    j=j+1;
end
plot(FPR(1,:),TPR(1,:));