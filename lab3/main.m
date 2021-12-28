clc 
clear all
tic
for i=1:6
    clear Icolor I_ssd I_ncc I_corner
    I=imread("image"+i+".jpg");
    idx=size(I);
    I_b=I(1:idx(1)/3,:);
    I_g=I(1+idx(1)/3:2*idx(1)/3,:);
    I_r=I(1+ 2*idx(1)/3:3*idx(1)/3,:);
    
    Icolor(:,:,1)=I_r;
    Icolor(:,:,2)=I_g;
    Icolor(:,:,3)=I_b;
    
    fprintf("using ssd on Image: " + i +"\n"); 
    [rShift , gShift , bShift] = im_align1(Icolor,'g');
    I_ssd(:,:,1)= shift_img(I_r, rShift);
    I_ssd(:,:,2)= shift_img(I_g, gShift);
    I_ssd(:,:,3)= shift_img(I_b, bShift);
    fprintf("\t rShift :" + int2str(rShift) +"\n");
    fprintf("\t gShift :" + int2str(gShift) +"\n"); 
    fprintf("\t bShift :" + int2str(bShift) +"\n");
    
    fprintf("using ncc on Image: " + i +"\n"); 
    [rShift , gShift , bShift] = im_align2(Icolor,'g');
    I_ncc(:,:,1)= shift_img(I_r, rShift);
    I_ncc(:,:,2)= shift_img(I_g, gShift);
    I_ncc(:,:,3)= shift_img(I_b, bShift);
    fprintf("\t rShift :" + int2str(rShift) +"\n");
    fprintf("\t gShift :" + int2str(gShift) +"\n"); 
    fprintf("\t bShift :" + int2str(bShift) +"\n");
    
    fprintf("using corner detection on Image: " + i +"\n"); 
    [rShift , gShift , bShift] = im_align3(Icolor,'g');
    I_corner(:,:,1)= shift_img(I_r, rShift);
    I_corner(:,:,2)= shift_img(I_g, gShift);
    I_corner(:,:,3)= shift_img(I_b, bShift);
    fprintf("\t rShift :" + int2str(rShift) +"\n");
    fprintf("\t gShift :" + int2str(gShift) +"\n"); 
    fprintf("\t bShift :" + int2str(bShift) +"\n");
    
    figure;
    subplot(1,4,1)
    imshow(Icolor)
    subplot(1,4,2)
    imshow(I_ssd)
    subplot(1,4,3)
    imshow(I_ncc)
    subplot(1,4,4)
    imshow(I_corner)
    
    imwrite(Icolor, "image" + i +"-color.jpg");
    imwrite(I_ssd, "image" + i +"-ssd.jpg");
    imwrite(I_ncc, "image" + i +"-ncc.jpg");
    imwrite(I_corner, "image" + i +"-corner.jpg");
end

toc

function shifted_img = shift_img( img , shiftVal )
    [ro , co] = size(img);
       
    extended_img= [ img,img,img;img,img,img;img,img,img];
    
    shifted_img=extended_img( ro+1 -shiftVal(1) : 2*ro-shiftVal(1)+1, co-shiftVal(2)+1 : 2*co-shiftVal(2)+1);
    
end