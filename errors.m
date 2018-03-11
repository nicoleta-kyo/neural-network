function [dEdW, dEdV] = errors(in, out, W, V,j)
A1 = forp(in(:,j), W);
A2 = forp(A1, V);
%Calculate error(cost)
C = (A2 - out(j)).^2;
%Back-propagation
%1.Calculate dError for the last layer
Out2 = A2;
dEdOut2 = Out2 - out(j);
%net = input*weight
dOut2dNet2 = A2*(1-A2); %derivative of sigmoid function
%we take only sample at a time: do for-loop for the whole back-prop
dEdW = 0;
for i=1:4   
    %we add one row for A1 because of the bias -> ???
    dNet2dV = repmat([A1; i]', size(V,1), 1); % second argument of size is number of nodes in output layer -> idk what that line is really doing
    dEdV = dEdOut2*dOut2dNet2*dNet2dV;
    %2.Calculate dError for hidden layer
    dNet2dOut1 = sum(V(:,1:end-1),1)'; %end - 1 because we need to get rid of the bias
    dOut1dNet1 = A1.*(1-A1);
    dNet1dW = repmat([in(:,j); 1]', size(W,1), 1);
    dEdW = dEdW + dNet1dW.*dOut1dNet1.*dNet2dOut1*dOut2dNet2*dEdOut2;
end
end
