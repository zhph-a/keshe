
for i = 3 :24
    for j = 2:10
        DAT(j+i-3,i) = DAT(j,2)*DAT(1,i);
    end
end
for i = 2:32
    DAT(i,26) = sum(DAT(i,3:25));
end