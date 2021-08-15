function   value=count_currency(img,data_set)
%convert image to gray
img_gray=rgb2gray(img);

%remove noise from image
 filter=medfilt2(img_gray,[3,3]);

%extract LBF from this image
%false de 3shan al rotate
feature_test=extractLBPFeatures(filter,'Upright',false);

%make array of currency with the same arrange of reading
% leh msh mtrtba ... 3shan al loop bta3t al data set mktoba bel treteb dh
% fana 3ayz a3ml matrix feha nfs al trteb dh
out=[0.5,0.5,1,1,10,10,100,100,20,20,200,200,5,5,50,50];

%matrix to save distance bitween image and the other 16 currency
dist=zeros(1,16);

%get size of dataset
[H,W,L]=size(data_set);


for i=1:H
    sum=0;
    for j=1:W
    % 3shan al swr aly rg3a mn al dataset momkn tb2a mt8yra shwaya
    % fana b7tag ashof al features
    %calculate eculean distance bitween features
    d = (feature_test(j) - data_set(i,j))*(feature_test(j) - data_set(i,j));
    sum = sum + d;
    end
    root=sqrt(sum);
    dist(i)=root;
end

% 3ayz a2al value 3shan hykon de al prediction bta3y alsa7
%get the min value of feature and go to the index of out array to get
%correct currency
[min_value,index]=min(dist);
value=out(index);
end
