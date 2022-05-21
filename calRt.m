
Kc = 1.0107;
st = 4385;
en = 5114;
Ep = E*Kc;
C = 0.2;
%�����ʱ�ε�Rt
wm = 170.5;
imp = 0.0083;
b = 0.4;
WUM = 20;
WLM = 80;
WDM = 70.5;
wmax = [WUM,WLM,WDM];
%������w
wu = zeros(5114,1);
wl = zeros(5114,1);
wd = zeros(5114,1);
wu(st) = WUM/2;
wl(st) = WLM/2;
wd(st) = WDM/2;

temp = zeros(3,1);
ww = [wu,wl,wd];
%���� wu


%�������W
detw = zeros(5114,1);
 temp = [wu(st),wl(st),wd(st)];
for i = st:en

    
    wmm = wm*(1+b)/(1-imp);
    %�������wu wd wl
    %��˼�Ǿ��ǣ�����������������ˮ������ʵ����дһ��ѭ����д����ٰ��ĸ���������ȥ
   
    %ʵ��������ģ�
   %��Ϊ����ͼ��٣�
   if(i == st)
       a = 1;
   else
    temp = [wu(i-1),wl(i-1),wd(i-1)];
   detw(i-1) = P(i-1) - ee(i-1) - R(i-1);
    if(detw(i-1)<0)
        detw(i-1) = -detw(i-1);
    for j = 1:3;
        
        if(detw(i-1) ~= 0 )
            temp(1,j) = ww(i-1,j)-detw(i-1);
            if(temp(1,j) < 0)%������
                detw(i-1) = detw(i-1)+temp(1,j);
                temp(1,j) = 0;
                
            else%û�м���
                temp(1,j) = ww(i-1,j) - detw(i-1);
                detw(i-1) = 0;
            end
        end
    end
    else%�������
      for j = 1:3;
        if(detw(i-1) ~= 0 )
            temp(1,j) = ww(i-1,j)+detw(i-1);
            if(temp(1,j) > wmax(j))%�ӳ���
                detw(i-1) = detw(i-1)-(temp(1,j)-wmax(j));
                temp(1,j) = wmax(j);
               
            else%û�мӳ�
                temp(1,j) = ww(i-1,j) + detw(i-1);
                detw(i-1) = 0;
            end
        end
      end
    end
   end
    %�ع鸳ֵ
    wu(i) = temp(1);
    wl(i) = temp(2);
    wd(i) = temp(3);
    ww = [wu,wl,wd];
    w = ww(:,1)+ww(:,2)+ww(:,3);
    %����e
     if(wu(i) + P(i)>=Ep(i))
        eu(i) = Ep(i);
        el(i) = 0;
        ed(i) = 0;
    elseif(wl(i)>=C*WLM)
        eu(i) = wu(i)+P(i);
        el(i) = (Ep(i)-eu(i))*wl(i)/WLM;
        ed(i) = 0;
    elseif(wl(i)<C*(Ep(i)-eu(i)))
        eu(i) = wu(i) + P(i);
        el(i) = wl(i);
        ed(i) = C*(Ep(i)-eu(i))-el(i);
    else
         eu(i) = wu(i) + P(i);
        el(i) = C*(Ep(i)-eu(i));
        ed(i) =  0;
    end
    ee(i) = eu(i)+el(i)+ed(i);
    %����R
    a = wmm *  (1 - (1-w(i)/wm)^(1/(1+b)));
    if(a +P(i)-ee(i)>wmm)
        R(i) = P(i)-ee(i) - (wm-w(i));
    else
        R(i) = P(i)-ee(i)+w(i)-wm+wm*((1-(P(i)-ee(i)+a)/wmm)^(1+b));
    end
    if(P(i)-ee(i)<0)
        R(i) = 0;
    end
end




