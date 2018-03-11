function fitness = fit(g,V,B)
%FIT evaluate fitness of phenotype
    v = 0;
    f = 0;
    for j=1:length(g)
        if g(j) == 1
            v = v + V(j);
        if v <= 20
              f = f + B(j);
        else
               f = 0;
        end
        end
    end
    fitness = f;
end