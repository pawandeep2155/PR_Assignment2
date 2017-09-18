function mean = mean_DS(input_matrix)
    mean(1,1)=sum(input_matrix(:,1)/size(input_matrix,1));
    mean(2,1)=sum(input_matrix(:,2)/size(input_matrix,1));
    
   
end