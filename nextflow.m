%次洪模型径流划分
group = 7;
fc = 3.2;
imp = 0.0083;
kkg = 0.95;
F = 2607;
wm = 170.5;

b = 0.4;
wmm = wm*(1+b)/(1-imp);
rg = 0;
rs = 0;

w = zeros(31,1);
w(1,1) = wm/2;
%计算R
R = zeros(30,1);
PE = ps(:,group)-es(:,group);
for i = 2:31
   
    a = wmm *  (1 - (1-w(i-1)/wm)^(1/(1+b)));
    if(a +PE(i-1)>wmm)
        R(i-1) = PE(i-1) - (wm-w(i-1));
    else
        R(i-1) = PE(i-1)+w(i-1)-wm+wm*((1-(PE(i-1)+a)/wmm)^(1+b));
    end
    if(PE(i-1)<0)
        R(i-1) = 0;
    end
     w(i) = w(i-1)+PE(i-1)-R(i-1);
end


RG = zeros(30,1);
RS = zeros(30,1);
for i = 1:30
    if(PE(i) > fc)
        
        RG(i) = RG(i) + fc*(R(i)-imp*(PE(i)))/(PE(i));
        
        RS(i) =  RS(i) + (PE(i)-fc)*(R(i)-imp*(PE(i)))/(PE(i));
    else
        RG(i) = RG(i) + R(i);
       
    end
end
