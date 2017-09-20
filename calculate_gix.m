function gi = calculate_gix(test_data,covariance_matrix,mean_matrix)

    gi = zeros(size(test_data,1),1);

    for i=1:size(test_data,1)
        %gaussian(i) = exp(-1/2 * (input_matrix(i,:)' - mean_matrix)' * inv(covariance_matrix) * (input_matrix(i,:)' - mean_matrix))/(power(2*pi,d/2)*sqrt(det(covariance_matrix)));
        gi(i) = -(0.5)*(test_data(i,:)' - mean_matrix)'*inv(covariance_matrix)*(test_data(i,:)' - mean_matrix);
    end

end