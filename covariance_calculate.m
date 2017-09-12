function covariance = covariance_calculate(input_matrix,mean_matrix)

    covariance = zeros(size(input_matrix,1),size(input_matrix,1));

    for i=1:size(input_matrix,1)
        covariance = covariance + (input_matrix(:,i) - mean_matrix(:,1))*(input_matrix(:,i) - mean_matrix(:,1))';
    end
    
    covariance = covariance/size(input_matrix,1);
    
end