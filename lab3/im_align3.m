
function [rShift , gShift , bShift] = im_align3(img,ref)
     
    I_r=img(:,:,1);
    I_g=img(:,:,2);
    I_b=img(:,:,3);
    
    harris_r=harris(I_r,200);
    harris_g=harris(I_g,200);
    harris_b=harris(I_b,200);
    
    if (ref=='r')
        ref_set = harris_r;
    elseif (ref=='g')
        ref_set = harris_g;
    else 
        ref_set = harris_b;
    end
    
    rShift=get_shift(ref_set,harris_r);
    gShift=get_shift(ref_set,harris_g);
    bShift=get_shift(ref_set,harris_b);
    

end

function shift_val = get_shift(set1,set2)
    shifted=[0,0];
    d=1;
    kl=1000;
    INL=0;
    for k=1:kl;
        Idx1=randsample(1:length(set1),1);
        Idx2=randsample(1:length(set2),1);
       
        d1=set1(Idx1,:);
        d2=set2(Idx2,:);
  
        shift= d1 - d2;
        sset=set2+shift;
        
        match=zeros(length(set1),1);
        
        for i=1:length(set1)
            for a=-d:d
                for b=-d:d
                    temp_set= sset + [ a , b ] ;
                    temp_set = (temp_set == set1(i,:));
                    q= temp_set(:,1).*temp_set(:,2);
                    suma=sum(q);
                    if (sum(q)>=1)
                        match(i) = match(i) + 1;
                    end
                  end
            end
        end
        inl=sum(match>=1);

        if inl>INL
            shifted=shift;
            INL=inl;
        end
    end
    shift_val=shifted;
end











