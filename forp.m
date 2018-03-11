function activation = forp(input, weights)
    input = [input; ones(1,size(input,2))];
    activation = 1./(1+ exp(-(weights*input)));
end