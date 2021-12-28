
function [rShift , gShift , bShift] = im_align2(img,ref)
    s=100;
    d=20;
    I_r=img(:,:,1);
    I_g=img(:,:,2);
    I_b=img(:,:,3);
    
    if (ref=='r')
        ref_img = I_r;
    elseif (ref=='g')
        ref_img = I_g;
    else 
        ref_img = I_b;
    end
    
    [rg,cg] = size(ref_img);
    Windo = ref_img(ceil((rg-s)/2) :ceil((rg-s)/2) + s,ceil((cg-s)/2) :ceil((cg-s)/2) + s);
    
    rShift = get_shift(Windo,I_r,s,d);
    gShift = get_shift(Windo,I_g,s,d);
    bShift = get_shift(Windo,I_b,s,d);
    

end



function shift_val = get_shift(img1,img2,s,d)
    [img2_row,img2_col] = size(img2);
    img1 = double(img1);
    img2 = double(img2);
    MaX = -9999999999;
    r_idx = 0;
    r_dim = 1;
   
    for i = -d:d
        for j = -d:d
            img=shift_img(img2,[i,j]);
            cropped_img = img(ceil((img2_row-s)/2) : ceil((img2_row-s)/2) + s,ceil((img2_col-s)/2) :ceil((img2_col-s)/2) + s);
            mean1=mean(img1(:));
            mean2=mean(cropped_img(:));
            sdt1=std(img1(:));
            sdt2=std(cropped_img(:));
            
            x=(img1 - mean1).*(cropped_img - mean2);
            
            
            ncc = sum(x(:))/((sdt1*sdt2)*(img2_row*img2_col -1));
            
            if ncc > MaX
                MaX= ncc;
                r_idx = i;
                r_dim = j;
            end
        end
    end
    shift_val=[r_idx,r_dim];
    
end 
function shifted_img = shift_img( img , shiftVal )
    [ro , co] = size(img);
       
    extended_img= [ img,img,img;img,img,img;img,img,img];
    
    shifted_img=extended_img( ro+1 -shiftVal(1) : 2*ro-shiftVal(1)+1, co-shiftVal(2)+1 : 2*co-shiftVal(2)+1);
    
end
