%picture's reader (YUV)
Imref=imread('Picture','bmp');
    
 %picture showing and recording (for PSNR)   
figure(1)
imshow(Imref);
IMWRITE(Imref,'Imref','bmp');
 
%add artificial noise (impulsive and gaussian)
 
%Imref = IMNOISE(Imref,'gaussian',0,0.001);
figure(11)
imshow(Imref);
 
%Imref = IMNOISE(Imref,'salt & pepper',0.001);
Imref = rgb2ycbcr(Imref);
temp=Imref(: , : , 1);
 
%temp = IMNOISE(temp,'salt & pepper',0.003);
Imref(:,:,1)=temp;
 
 
figure(2)
 
%Imref = IMNOISE(Imref,'salt & pepper',0.001);
imshow(ycbcr2rgb(Imref));
 
%record of the corrupted picture
IMWRITE(ycbcr2rgb(Imref),'Imcorupt','bmp');
 
Imref = cast(Imref,'double');
 
filtered=Imref(:,:,1);
[row,colomn]=size(temp);
 
level=temp;
 
for Z=1:3,%one dimension for each channel (Y,U,V)
    Im=Imref(:,:,Z);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%corner issue (3x1 average)%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for I=2:(row-1),
        for J=1:2,
            filtered(I,J)=1/3*(Im(I-1, J)+Im(I, J)+Im(I+1, J));
        end
    end
    
    for I=2:(row-1),
        for J=(colomn-2):colomn,
            filtered(I,J)=1/3*(Im(I-1, J)+Im(I, J)+Im(I+1, J));
        end
    end
    
    for I=1:2,
        for J=2:(colomn-1),
            filtered(I,J)=1/3*(Im(I, J-1)+Im(I, J)+Im(I, J+1));
        end
    end    
    for I=(row-2):row,
        for J=2:(colomn-1),
            filtered(I,J)=1/3*(Im(I, J-1)+Im(I, J)+Im(I, J+1));
        end
    end     
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%cross extremum calculus%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for I=3:(row-3),
        for J=3:(colomn-3),
            tab=[ Im(I-2, J-2) Im(I-1,J-2) Im(I,J-2) Im(I+1,J-2) Im(I+2,J-2) Im(I-2, J-1) Im(I-1,J-1) Im(I,J-1) Im(I+1,J-1) Im(I+2,J-1) Im(I-2,J) Im(I-1,J) Im(I,J) Im(I+1,J) Im(I+2,J) Im(I-2,J+1) Im(I-1,J+1) Im(I,J+1) Im(I+1,J+1) Im(I+2,J+1) Im(I-2,J+2) Im(I-1,J+2) Im(I,J+2) Im(I+1,J+2) Im(I+2,J+2)];
            cross=[tab(8) tab(14) tab(18) tab(12)];
            centre=tab(13);
            max=abs(centre-cross(1));
            for Cr=2:4,
                if(abs((centre-cross(Cr)))>max)
                    max=abs(centre-cross(Cr));
                end
            end
                
           threshold=abs(max);
           level(I,J)=0;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%pepper%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if(threshold>50) %10
                min=abs(centre-cross(1));
                for Crm=2:4,
                    if(abs((centre-cross(Crm)))<min)
                        min=abs(centre-cross(Crm));
                    end
                end
                threshold2=abs(min);
                if(threshold2>5) %(tunable)
                %CWM FILTER
                    if(Z==1)%luminance
                        kernel=[tab(1) tab(2) tab(3) tab(4) tab(5) tab(6) tab(7) tab(8) tab(9) tab(10) tab(11) tab(12) tab(13) tab(13) tab(13) tab(13) tab(13) tab(13) tab(13) tab(13) tab(13) tab(13) tab(13) tab(13) tab(13) tab(13) tab(13) tab(14) tab(15) tab(16) tab(17) tab(18) tab(19) tab(20) tab(21) tab(22) tab(23) tab(24) tab(25)];
                        temp=kernel;
                        for K=1:19,
                            test=kernel(K);
                            for M=K:(39),
                                swift=kernel(M);
                                if (swift<test)
                                    kernel(M)=test;
                                    kernel(K)=swift;
                                    test= swift;
                                end
                                temp(K)=test;
                            end
                        filtered(I,J)=temp(19);
                        end
                    else%chrominance
                        kernel=[tab(1) tab(2) tab(3) tab(4) tab(5) tab(6) tab(7) tab(8) tab(9) tab(10) tab(11) tab(12) tab(13) tab(13) tab(13) tab(13) tab(13) tab(14) tab(15) tab(16) tab(17) tab(18) tab(19) tab(20) tab(21) tab(22) tab(23) tab(24) tab(25)];
                        temp=kernel;
                        for K=1:14,
                            test=kernel(K);
                            for M=K:(29),
                                swift=kernel(M);
                                if (swift<test)
                                    kernel(M)=test;
                                    kernel(K)=swift;
                                    test= swift;
                                end
                                temp(K)=test;
                            end
                        filtered(I,J)=temp(14);
                        end  
                    end 
                else
                    filtered(I,J)=tab(13);
                end
 
            %%%%%%%%%%%%%%%%no pepper : Gaussian noise%%%%%%%%%%%%%%%%%%
            else                          
                min=tab(1);               %
                lowermax=tab(1);
                lowermin=tab(1);          %
                lower1=tab(1);
                lower2=tab(1);            %
                indexlowermin=1;
                indexmin=1;               %
                indexmax=1;
                indexlowermax=1;          %
                max=tab(1);               
                for K=1:25,               %
                    if (tab(K)<=min)       
                        lowermin=lower1;  %
                        lower1=min;
                        min=tab(K);       %
                        indexlowermin=indexmin;
                        indexmin=K;
                    end                   % range extremum calculus
                    
                    if (tab(K)>=max)      %
                        lowermax=lower2;
                        lower2=max;       %
                        max=tab(K);       
                        indexlowermax=indexmax;
                        indexmax=K;       %
                    end
                end
                tab(indexmax)=tab(13);
                tab(indexmin)=tab(13);
                tab(indexlowermin)=tab(13);
                tab(indexlowermax)=tab(13);
		    %GAUSSIAN FILTER
                if( lowermax-lowermin<10)% 5x5 Gaussian filter
                    level(I,J)=254;
 			filtered(I,J)=(1/306)*(1*tab(1) +4*tab(2) +7*tab(3) +4*tab(4) +1*tab(5) +4*tab(6) +18*tab(7) +30*tab(8) +18*tab(9) +4*tab(10) +7*tab(11) +30*tab(12) +50*tab(13) +30*tab(14) +7*tab(15) +4*tab(16) +18*tab(17) +30*tab(18) +18*tab(19) +4*tab(20) +1*tab(21) +4*tab(22) +7*tab(23) +4*tab(24) +1*tab(25));                 
                
                elseif (lowermax-lowermin>=10 && lowermax-lowermin<20)% 3x3
                    level(I,J)=200;
                    filtered(I,J)=(1/15)*(1*tab(7)+2*tab(8) +1*tab(9) +2*tab(12) +3*tab(13) +2*tab(14) +1*tab(17)+ 2*tab(18)+ 1*tab(19));
         
                else    
                    filtered(I,J)=tab(13);%details issue: no filtering
                end               
            end  
        end
    end
    Imref(:,:,Z)=filtered;
    %%Imref=filtered;%pour W&B.
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    level = cast(level,'uint8');%%
    figure(3)                   %%filter's used area (for information only)
    imshow(level);              %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
 
%cast and converstion to RGB
Imref = cast(Imref,'uint8');
Imref = ycbcr2rgb(Imref);
 
figure(4);
imshow(Imref);
IMWRITE(Imref,'Im','bmp');%write the denoised picture.
 




%PSNR fonction. Use the recorded pictures of this program.

format long
Imref=imread('Imref','bmp');
Im=imread('Im','bmp');
 
imshow(Im);
Imref = rgb2ycbcr(Imref);
Im = rgb2ycbcr(Im);
Imref = cast(Imref,'double');
Im = cast(Im,'double');
PSNR=0;
 
for Z=1:3,%clacul of PSNR for each channel
     
     ImrefZ=Imref(:,:,Z);
     ImZ=Im(:,:,Z);
     error_diff = mean(mean((ImrefZ - ImZ).^2));
     PSNR=error_diff+PSNR;
 
end  
PSNR=PSNR/3;
decibels = 20*log10(255/PSNR); % calcul of PSNR in dB.