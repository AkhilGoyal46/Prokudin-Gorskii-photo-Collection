
function corners_idx = harris(img,N)
    oimg = img;
    img = double(img);
    img_size= size(img);
    
    sobel_size = 3;
    n= floor(sobel_size/2);
    sobel_y= [1,2,1;0 0 0;-1 -2 -1]/8;
    sobel_x=[-1,0,1;-2,0,2;-1,0,1]/8;
    
    Ix= zeros(img_size(1)-2*n,img_size(2)-2*n);
    Iy= zeros(img_size(1)-2*n,img_size(2)-2*n);
    
    for i=n+1:img_size(1)-n
        for j= n+1:img_size(2)-n
            
            x=img(i-n:i+n,j-n:j+n).*sobel_x;
            y=img(i-n:i+n,j-n:j+n).*sobel_y;
            Ix(i-n,j-n) = sum(x(:));
            Iy(i-n,j-n) = sum(y(:));
 
        end
    end
    Ixx=Ix.*Ix;
    Iyy=Iy.*Iy;
    Ixy=Ix.*Iy;
    
    size2= size(Ix);
    
    Windo_size = 3 ;
    k = 0.04;
    m = floor(Windo_size/2);
    R = zeros(size2(1)-2*m,size2(2)-2*m);
    corner_image = zeros(size2(1)-2*m,size2(2)-2*m);
    
    for i=m+1:size2(1)-m
        for j= m+1:size2(2)-m
            
            xx =Ixx(i-m:i+m,j-m:j+m);
            yy =Iyy(i-m:i+m,j-m:j+m);
            xy =Ixy(i-m:i+m,j-m:j+m);
            
            Sxx=sum(xx(:));
            Syy=sum(yy(:));
            Sxy=sum(xy(:));
            
            H=[Sxx,Sxy;Sxy,Syy];
            
            R(i-m,j-m)= det(H)-k*(trace(H))^2; 
        end
    end
    
    size3=size(R);
    
    
    temp_R=R(:);
    sorted_r=sort( temp_R,'descend');
    Threshold= sorted_r(N+1);
    f=0;
    for i=1:size3(1)
        for j=1:size3(2)
            if R(i,j)>Threshold
                f=f+1;
                corner_image(i,j)=1;
                corner_idx(f,1)=i+n+m;
                corner_idx(f,2)=j+n+m;
            end
        end
    end 
%     figure;
%     imshow(uint8(Ix));
%     figure;
%     imshow(uint8(Iy));
%     figure;
%     imshow(uint8(Ixx));
%     figure;
%     imshow(uint8(Iyy));
%     figure;
%     imshow(uint8(Ixy));
%     figure;
%     imagesc(R);
    
    
%     figure;
% 
%     imshow(oimg);
%     hold on
%     plot(corner_idx(:,2),corner_idx(:,1),'r*', 'MarkerSize', 1);
%     hold off
    corners_idx=  corner_idx;
    
end


