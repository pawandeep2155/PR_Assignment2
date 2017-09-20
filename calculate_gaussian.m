function gaussian = calculate_gaussian(COV,U1,input_matrix)

    gaussian = zeros(size(input_matrix,1),1);
    d = size(input_matrix,2);
    
    for i=1:size(input_matrix,1)
        %gaussian(i) = exp(-1/2 * (input_matrix(i,:)' - mean_matrix)' * inv(covariance_matrix) * (input_matrix(i,:)' - mean_matrix))/(power(2*pi,d/2)*sqrt(det(covariance_matrix)));
        gaussian(i) = (1/(2*3.14*(det(COV))^0.5)) * exp (-(0.5)*(input_matrix(i,:)' - U1)'*inv(COV)*(input_matrix(i,:)' - U1));
    end
    
end