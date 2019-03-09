%A：the intensity matrix of a grayscale image
function [KK]=ExtendedNaturalVector(A)
format long
%[temp,~]=imread(image);
%A=rgb2gray(temp); 
L=256; %%represent 0，1，...，255 gray scale
[m,n]= size(A);
position=zeros(m*n,2*L);
U_grayScale_x=zeros(L,1);  U_grayScale_y=zeros(L,1); 
D10_grayScale=zeros(L,1);  
D11_grayScale=zeros(L,1);  D20_grayScale=zeros(L,1);  D02_grayScale=zeros(L,1);
%
K=zeros(L,6);
KK=zeros(6*L,1);

%Find position of each gray scale
for i=1:m
    for j=1:n
        k=0;
        element= A(i,j);
        k=element+1;
        number(k)=number(k)+1; 
        position(number(k),2*k-1:2*k)=[i,j];           
    end
end


%calculate extended natural vector
for kk=1:L  
    temp_x=position(1:number(kk),2*kk-1);
    temp_y=position(1:number(kk),2*kk);

 
      U_grayScale_x(kk)=sum(temp_x)/number(kk);
      U_grayScale_y(kk )=sum(temp_y)/number(kk);
      s10= ( ((temp_x-U_grayScale_x(kk)).^(1)))' * ( ((temp_y-U_grayScale_y(kk)).^(0)));
      D10_grayScale(kk)= s10/number(kk); 
      s11= ( ((temp_x-U_grayScale_x(kk)).^(1)))' * ( ((temp_y-U_grayScale_y(kk)).^(1)));
      D11_grayScale(kk)= s11/(number(kk)^2*m*n);
      s20= ( ((temp_x-U_grayScale_x(kk)).^(2)))' * ( ((temp_y-U_grayScale_y(kk)).^(0)));
      D20_grayScale(kk)= s20/((number(kk))^2*m*n);
      s02= ( ((temp_x-U_grayScale_x(kk)).^(0)))' * ( ((temp_y-U_grayScale_y(kk)).^(2)));
      D02_grayScale(kk)= s02/((number(kk))^2*m*n);
      if number(kk)==0
          U_grayScale_x(kk)=0;
          U_grayScale_y(kk)=0;
          D11_grayScale(kk)=0;
          D20_grayScale(kk)=0;
          D02_grayScale(kk)=0;
      end         
end
K=[number,U_grayScale_x,U_grayScale_y,...
    D11_grayScale,D20_grayScale,D02_grayScale]; %此时的K是一个256x6的矩阵
KK= reshape(K,6*L,1);
KK=KK';
