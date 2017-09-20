function [TPR,FPR] = calculate_tpr_fpr(mean1,mean2,mean3,covariance1,covariance2,covariance3,testing_data)

class_table = zeros(size(testing_data,1),4);
class_size = uint16(1/3*size(testing_data,1));

class_table(1:class_size,4)=1;
class_table(class_size+1:2*class_size,4)=2;
class_table(2*class_size+1:3*class_size,4)=3;

TPR=zeros(1,201);
FPR=zeros(1,201);
j=1;
X = zeros(2,1);

 for th=0:0.005:1      
    TP=0;TN=0;FP=0;FN=0;
    for i=1:size(testing_data,1)      
        X(1,1)=testing_data(i,1);X(2,1)=testing_data(i,2);            
        class_table(i,1)=(1/(2*3.14*(det(covariance1))^0.5))*exp(-0.5*(X-mean1)'*inv(covariance1)*(X-mean1));       %post prob of w1
        class_table(i,2)=(1/(2*3.14*(det(covariance2))^0.5))*exp(-0.5*(X-mean2)'*inv(covariance2)*(X-mean2));       %post prob of w2
        class_table(i,3)=(1/(2*3.14*(det(covariance3))^0.5))*exp(-0.5*(X-mean3)'*inv(covariance3)*(X-mean3));       %post prob of w3
        
            for k = 1:3
                if (class_table(i,4) == k)
                
                    if(class_table(i,k)>=th)
                        TP=TP+1;
                    else
                        FN=FN+1;
                    end
                else
                    if(class_table(i,k)<=th)
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
end