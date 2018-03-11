function [weights, bias] = randomtrainingregime2(in, target)
%RANDOMTRAININGREGIME Random training for a neural network
    Err = 1;
    W = randn(1, size(in,1));
    b = randn;
    while (Err ~= 0)
        W = randn(1, size(in,1));
        b = randn;
        Err = 0;
            A = W*in +b;
            output = A > 0.5;
            
            Err = (target - output).^2;
            Err = sum(Err);
    end
    weights = W;
    bias = b;
end