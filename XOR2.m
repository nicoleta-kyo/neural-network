Err = 0;
W1 = [0.6, 0.6]; %weights for OR gate
W2 = [-0.4, -0.8]; %weights and bis for NAND gate
b = 1.6;
hidW = [0.4, 0.1];
for i = 1:4
  A1 = W1*XOR_IN(1:2,i);
  A2 = W2*XOR_IN(1:2,i) +b;

  hidIn = [A1; A2];
  hidA = hidW*hidIn;
  if hidA >= 0.5
      output = 1;
  else
      output = 0;
  end
  Err = Err +(XOR_OUT(i) - output)^2;
end
Err