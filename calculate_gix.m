function gi = calculate_gix(test_data,COV1,COV2,COV3,U1,U2,U3)

    gi = zeros(size(test_data,1),1);
    
    for i=1:size(test_data,1)
        gi(i) = (1/(2*3.14*(det(COV1))^0.5)) * exp (-(0.5)*(test_data(i,:)' - U1)'*inv(COV1)*(test_data(i,:)' - U1)) * 1/3; 
        t1 = gi(i);
        t2 = (1/(2*3.14*(det(COV2))^0.5))*exp(-(0.5)*(test_data(i,:)' - U2)'*inv(COV2)*(test_data(i,:)' - U2)) * 1/3;
        t3 = (1/(2*3.14*(det(COV3))^0.5))*exp(-(0.5)*(test_data(i,:)' - U3)'*inv(COV3)*(test_data(i,:)' - U3)) * 1/3;
        gi(i) = gi(i)/(t1+t2+t3); 
        
    end
end