function [T] = get_T(num_s,label)

hh=size(unique(label(:,1)),1);
ll=size(unique(label(1,:)),2);
mm=zeros(hh,14);
mm(1,:)=1;
mm(hh,:)=1;
mm(:,1)=1;
mm(:,ll)=1;
mm=reshape(mm,num_s,1);
% % mm=zeros(44,1);
% % mm(:,:)=1;

T=mm;