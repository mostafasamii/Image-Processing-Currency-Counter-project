function  val=detect_img(data_set,path)
 img=imread(path);
 img_gray=rgb2gray(img);
 img_bw=im2bw(img_gray,0.999999);
 img_bw=~img_bw;
 filter=medfilt2(img_bw,[7,7]);
 [l,num]=bwlabel(filter);

 %by3ml a2al BoundingBox 7wlen kol object fel sora
 % Orientation hal al object mlfof b angel mo3yna walla la
 state=regionprops(l,'BoundingBox','Orientation');
 count=0;


for i=1 :num
    %% bb de feha kol object hoa 3rfo w al angel bt3to
    bb=state(i).BoundingBox;

    # 3ayz a3ml lel sora al asly aly d5laly crop
    % BoundingBox byshel 4 value al topleft w al topright w al botton .... etc
    crop=imcrop(img , [bb(1) bb(2) bb(3) bb(4)]);

    % 3ayz ashof b3d m3mlt extract hal hoa kan mlfof f zwya walla la
    %m3mol negative 3shan arg3o 3ks al angle aly hoa mlfof beha
    if(state(i).Orientation<0 ||state(i).Orientation>0)
        angle= - state(i).Orientation;
        crop=imrotate(crop,angle);
        %crop= imresize(img,[360 700]);

        % hna lama hoa byrg3 mn al laffa btrg3 7wleh swad
        % fana 3ayz arg3ha al object aly 3mltlo rotate 3ayz atl3o mn baackgroud al sora de
        % fana b2os al sora mn al backgroud al soda 
        crop=imcrop(crop , [158 305 699 359]);%160 310 690 360
    end

    count=count+count_currency(crop,data_set);
end
val=count;
end
