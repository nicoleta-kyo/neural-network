%of nodes in input layer
W = randn(2,3);
V = randn(1,3);
A1 = forp(XOR_IN(:,1), W);
A2 = forp(A1, V);
%Calculate error(cost)
C = (A2 - XOR_OUT(1)).^2;
stop = 0;
while (stop < 4)
    Ctot = 0;
    for i = 1:4
        [dEdW, dEdV] = errors(XOR_IN, XOR_OUT, W,V,i);
        W = W - 0.1*dEdW;
        V = V - 0.1*dEdV;
        %Forward-propagation
        A1 = forp(XOR_IN(:,i), W);
        A2 = forp(A1, V);
        %Calculate error(cost)
        C = (A2 - XOR_OUT(i)).^2;
        Ctot = Ctot+C;
    end
    
    stop = 0;
    for i = 1:4
        %Forward-propagation
        A1 = forp(XOR_IN(:,i), W);
        A2 = forp(A1, V);
        stop = stop + (A2 > 0.5 == XOR_OUT(i));
    end
    Ctot
end

for i = 1:4
    %Forward-propagation
    A1 = forp(XOR_IN(:,i), W);
    A2 = forp(A1, V);
    outexp = [A2 > 0.5, XOR_OUT(i)]
end