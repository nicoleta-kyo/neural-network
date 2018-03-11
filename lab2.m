clear
%Feed-forward neural network by Nicoleta Kyosovska. 13/02/2018

%A.

%1,2,3.

AND_IN = [ [0;0], [1;0], [0;1], [1;1]];
AND_OUT = [0 0 0 1];

OR_IN = [ [0;0], [1;0], [0;1], [1;1]];
OR_OUT = [0 1 1 1];

XOR_IN = [ [0;0], [1;0], [0;1], [1;1]];
XOR_OUT = [ 0 1 1 0];

NOT_IN = [ 0 1];
NOT_OUT = [1 0];

NAND_IN = [ [0;0], [1;0], [0;1], [1;1]];
NAND_OUT = [1 1 1 0];

%4.
Weights
W = randn(1,2);

%5.
Inputs
I  = AND_IN(1:2,1);

%6.
%Activation A = the sum of each weight multiplied by each input
A = W*I;

% %7.
%Create threshold to do use for step function.
 if A > 0.5
     output = 1;
 else
     output = 0;
 end

% % 8.
%Error = (Desired - Output)^2
Err = (AND_OUT(1,1) - output)^2;

%9. GATE AND

 Err = 0;
 for i=1:4
     A = W*AND_IN(1:2,i);
     if A > 0.5
         output = 1;
     else
         output = 0;
     end
     Err = Err +(AND_OUT(1,i) - output)^2;
 end
 
 Err

%10. Setting the wights for gate AND by hand.

 W = [0.5,0.5]; %separately they need to be less than 0.5(threshold) because they
%                 won't reach the threshold for desired outputs 2 and 3
Err = 0;
for i=1:4
    A = W*AND_IN(1:2,i);
    if A > 0.5
        output = 1;
    else
        output = 0;
    end
    Err = Err +(AND_OUT(1,i) - output)^2;
end

Err

%B.1 GATE OR

W = randn(1,2);
Err = 0;
for i=1:4
    A = W*OR_IN(1:2,i);
    if A > 0.5
        output = 1;
    else
        output = 0;
    end
    Err = Err +(OR_OUT(1,i) - output)^2;
end

Err

W = [0.55,0.55]; %they need to be above threshold for desired outputs 2 and 3 to be true
Err = 0;
for i=1:4
    A = W*OR_IN(1:2,i)
    if A > 0.5
        output = 1;
    else
        output = 0;
    end
    Err = Err +(OR_OUT(1,i) - output)^2;
end

Err

%B.2 GATE NOT

Err = 0;
W = randn;
b = randn;  %set bias node
for i=1:2
    A = W*NOT_IN(i) + b
    if A > 0.5
        output = 1;
    else
        output = 0;
    end
    Err = Err +(NOT_OUT(i) - output)^2;
end

Err

Err = 0;
b = 0.6; %the bias should be above threshold for the first case to be true cause it's 0(W*0) + b
W = -0.1;%the weights should be negative for the second case to be true: A + 0.6 should be below threshold
for i=1:2
    A = W*NOT_IN(i) + b
    if A > 0.5
        output = 1;
    else
        output = 0;
    end
    Err = Err +(NOT_OUT(i) - output)^2;
end

Err

%B.3

[w,b] = randomtrainingregime2(AND_IN, AND_OUT);
x = AND_IN(1,:);
y = AND_IN(2,:);
scatter(x,y);
hold on
x = -1:0.1:2;
y = (0.5 - x*w(1) - b)/w(2);

p = plot(x,y);
axis([-0.5 1.5 -0.5 1.5]);
saveas(p, 'plotand.jpg');

%C.

%see separate function file

%D* GATE NAND needed for XOR

W = randn(1,2)
b = randn
Err = 0;
for i=1:4
    A = W*NAND_IN(1:2,i) + b;
    if A > 0.5
        output = 1;
    else
        output = 0;
    end
    Err = Err +(NAND_OUT(i) - output)^2;
end

Err

%Discovered:

W = [-0.4, -0.8];
b = 1.6;
Err = 0;
for i=1:4
    A = W*NAND_IN(1:2,i) + b;
    if A > 0.5
        output = 1;
    else
        output = 0;
    end
    Err = Err +(NAND_OUT(i) - output)^2;
end

Err


%D. GATE XOR

Err = 0;
W1 = [0.6, 0.6]; %weights for OR gate
W2 = [-0.4, -0.8]; %weights and bis for NAND gate
b = 1.6;
hidW = [0.4, 0.4];
for i = 1:4
  A1 = W1*OR_IN(1:2,i);
%     calculate output of hidden layer
  if A1 > 0.5
      output1 = 1;
  else
      output1 = 0;
  end
%     calculate output of output layer 
  A2 = W2*NAND_IN(1:2,i) +b;
  if A2 > 0.5
      output2 = 1;
  else
      output2 = 0;
  end
  hidIn = [output1; output2];
  hidA = hidW*hidIn;
  if hidA > 0.5
      output = 1;
  else
      output = 0;
  end
  Err = Err +(XOR_OUT(i) - output)^2;
end
Err

%E. 

Err = 1;
W1 = rand(1,2);
W2 = randn(1,2);
b = rand;
hidW = rand(1,2);
while (Err ~= 0)
  for i = 1:4
      Err = 0;
      W1 = rand(1,2);
      W2 = randn(1,2);
      b = rand;
      hidW = rand(1,2);
      A1 = W1*OR_IN(1:2,i);
      if A1 > 0.5
          output1 = 1;
      else
          output1 = 0;
      end
      A2 = W2*NAND_IN(1:2,i) +b;
      if A2 > 0.5
          output2 = 1;
      else
          output2 = 0;
      end
      hidIn = [output1; output2];
      hidA = hidW*hidIn;
      if hidA > 0.5
          output = 1;
      else
          output = 0;
      end
      Err = (XOR_OUT(i) - output).^2;
      Err = sum(Err);
  end
end


x = XOR_IN(1,:);
y = XOR_IN(2,:);
scatter(x,y);
hold on
x = -1:0.1:2;
y = (0.5 - x*W1(1))/W1(2);
f = plot(x,y);
y = (0.5 - x*W2(1) - b)/W2(2);
f = plot(x,y);
axis([-0.5 1.5 -0.5 1.5]);
saveas(f, 'plotxor.jpg');

%F.
%OR gate with sigmoid activation function.

W = randn(1,2);
Err = 0;
for i=1:4
    A = 1/(1 + exp(-(W*OR_IN(1:2,i))));
    if A > 0.5
        output = 1;
    else
        output = 0;
    end
    Err = Err +(OR_OUT(1,i) - output)^2;
end

Err


%G. Back-propagation

%Initialize weights: rows-number of nodes in output layer, columns-number
%of nodes in input layer
W = randn(2,3);
V = randn(1,3);
A1 = forp(XOR_IN(:,1), W);
A2 = forp(A1, V);
%Calculate error(cost)
C = (A2 - XOR_OUT(1)).^2;
while (C~=0)
[dEdW, dEdV] = errors(XOR_IN, XOR_OUT, W,V);
W = W + 0.1*dEdW;
V = V + 0.1*dEdV;
%Forward-propagation
A1 = forp(XOR_IN(:,1), W);
A2 = forp(A1, V);
%Calculate error(cost)
C = (A2 - XOR_OUT(1)).^2;
end

