function data_set= fill_dataset()
%get all image in folder
img_folder='C:\Program Files\MATLAB\R2018a\bin\1. Upright front-back Single';
file_name=dir(fullfile(img_folder,'*.jpg'));

%get number of image in folder
num_img=numel(file_name);

%make matrix dataset 16*10 whice 16 is the number of currencys and 10 number of
%feature
data_set=zeros(16,10);


for i=1 :num_img
    %read each image
    directory=fullfile(img_folder,file_name(i).name);
    img=imread(directory);

    %convert to gray
    img_gray=rgb2gray(img);

    %remove noise using medium filter
    filter=medfilt2(img_gray,[3,3]);

    %extract LBF of each image
    %bytl3 10 features mn al sora 3shan kda ana 3aml line 11 kda
    feature=extractLBPFeatures(filter,'Upright',false);

    %fill dataset with feature
    data_set(i,:)=feature;
end


end
