function [T2] = get_T2(T,N)
T2=zeros(size(T));
total=140*N;
for kk=1:total
    if T(kk)==0
        T2(kk)=0.001;
    end
end
