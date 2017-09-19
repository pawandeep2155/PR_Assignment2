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

Act_class=zeros(1,1500);
        if(i<=500)      % Actual class calculation 
            Act_class(1,i)=1;
        end
        if(500<i<=1000)
            Act_class(1,i)=2;
        end
        if(1000<i)
            Act_class(1,i)=3;
        end
        
pxw=zeros(1,3);
TPR=zeros(1,11);
FPR=zeros(1,11);
j=1;
for th=[0:0.1:1]        % Threshold loop
    TP=0;TN=0;FP=0;FN=0;
    for i=1:1500      % Input Loop
        X(1,1)=A(i,1);X(2,1)=A(i,2);        % Input Vector
        
       
         

        pxw(1,1)=(1/(2*3.14*(det(COV1))^0.5))*exp(-0.5*(X-U1)'*inv(COV1)*(X-U1));       %post prob of w1
        pxw(1,2)=(1/(2*3.14*(det(COV2))^0.5))*exp(-0.5*(X-U2)'*inv(COV2)*(X-U2));       %post prob of w2
        pxw(1,3)=(1/(2*3.14*(det(COV3))^0.5))*exp(-0.5*(X-U3)'*inv(COV3)*(X-U3));       %post prob of w3

        if(pxw(1,1)>=pxw(1,2))        % Max of pxw1,pxw2,pxw3
            if(pxw(1,1)>=pxw(1,3))
                Pred_class=1;
            else
                Pred_class=3;
            end
        else
            if(pxw(1,2)>=pxw(1,3))
                Pred_class=2;
            else
                Pred_class=3;
            end
        end
        
        
        if(Pred_class==Act_class(1,i))
            if(pxw(1,Pred_class)>=th)
                TP=TP+1;
            else
                TN=TN+1;
            end
        else
            if(pxw(1,Pred_class)>=th)
                FP=FP+1;
            else
                FN=FN+1;
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