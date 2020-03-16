function [t] = kmnsbw(j)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
y=j;
[m,n]=size(y);

it=0;

a=[0 255];
nc=2;

c=zeros(m,n,nc);
o=zeros(nc);
  j=y;
   
t=zeros(1,nc-1);

for u=1:nc-1;
t(u)=(a(u)+a(u+1))/2;
end
for u=1:m
for v=1:n
for r=1:nc-1
if j(u,v)<=t(r)
j(u,v)=a(r);o(r)=o(r)+1;c(u,v,r)=y(u,v);break;
end
end
if j(u,v)>t(nc-1)
    j(u,v)=a(nc);o(nc)=o(nc)+1;c(u,v,nc)=y(u,v);

end
end
end
for r=1:nc
a(r)=sum(sum(c(:,:,r))')/o(r);
end

for u=1:nc-1;
t(u)=(a(u)+a(u+1))/2;
end

end

