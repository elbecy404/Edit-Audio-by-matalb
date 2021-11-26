%ORIGINAL SIGNAL
place = 'C:\Users\ZBOOK\Desktop\final project';
[signal,fs]=audioread(fullfile(place,'org_sig.wav'));
N=706223;
t=linspace(0,length(signal),N);
f=linspace(-fs/2,fs/2,N);
sig_f=abs(fftshift(fft(signal)));


L=signal(: ,1);         %for left speaker
R=signal(: ,2) ;       %for right speaker
%sound(signal,fs);

figure;
subplot(2,1,1);
plot(signal);
title('SIGNAL IN T DOMAIN');
subplot(2,1,2);
plot(f,sig_f);
title('SIGNAL IN F DOMAIN');
%---------------------------------------------------
%CHANNEL
D= fs;
h1 =[1 zeros(1,D-1)] ;
h2 =exp(-2*pi*5000*t);
h3=exp(-2*pi*1000*t);
h4 = [ 2   zeros(1,D-2)   0.5];

select= input('Select your channel : \n 1- h1 = [ 1 zeros(1,N-1)] \n 2- h2 =exp(-2*pi*5000*t) \n 3- h3=exp(-2*pi*1000*t)\n 4- h4 = [ 2 zeros(1,N-2) 0.5]   \n ENTER YOUR SELECT :=>');

switch select 
    case 1
        y1_R=conv(R,h1);
        y1_L=conv(L,h1);
        y1_tot= [ y1_L  y1_R] ;
       sound(y1_tot,fs)
        figure;
       subplot(2,1,1)
        plot(y1_R);
        title(' CONV FOR RIGHT SIGNAL ');
       subplot(2,1,2);
       plot(y1_L);
        title(' CONV FOR LEFT SIGNAL ');
        
       %NOISE
        out_sig=y1_tot ;
        sigma=input('please enter the value of sigma which sigma:=>');
        z= sigma.*randn(1,length(out_sig));
        Noise_signal = out_sig + [z' z'] ;
        %sound(Noise_signal,fs);
        noise_t=linspace(0,length(Noise_signal),length(Noise_signal));
        noise_f=linspace(-fs/2,fs/2,length(Noise_signal));
        Noise_signal_f=abs(fftshift(fft(Noise_signal)));
       figure;
       subplot(2,1,1);
      plot( noise_t,Noise_signal );
        title('SIGNAL WITH NOISE IN T DOMAIN');
      subplot(2,1,2);
        plot(noise_f,Noise_signal_f );
        title('SIGNAL WITH NOISE IN F DOMAIN');
   
       %CUT OFF & FILTER
        a=floor((length(Noise_signal_f)./fs)*(fs./2-3400));
        b=(length(Noise_signal_f )-floor((length(Noise_signal_f )./fs*(fs./2-3400)))+1);
        Noise_signal_f([ 1:a     b : length(Noise_signal_f ) ]  , [1  2])=0;
        Noise_signal=real(ifft(ifftshift(Noise_signal_f)));
       %sound( Noise_signal,fs);
        figure;
        subplot(2,1,1);
        plot(  Noise_signal );
        title('CUT OFF  IN T DOMAIN');
        subplot(2,1,2);
        plot(noise_f,Noise_signal_f );
        title('CUT OFF SIGNALF DOMAIN');
       
    
       
       
       
              
    case 2
        h2=h2';
        y2_R=conv(R,h2);
        y2_L=conv(L,h2);
        y2_tot= [ y2_L  y2_R] ;
      sound(y2_tot,fs)
       % figure;
      %  subplot(2,1,1)
       % plot(y2_R);
        %title(' CONV FOR RIGHT SIGNAL');
        %subplot(2,1,2);
       % plot(y2_L);
        %title('  CONV FOR LEFT SIGNAL');
        
      %NOISE
        out_sig=y2_tot ; 
        sigma=input('please enter the value of sigma :=>');
        z= sigma.*randn(1,length(out_sig));
        Noise_signal = out_sig + [z'  z'];
        %sound(Noise_signal,fs);
        noise_t=linspace(0,length(Noise_signal),length(Noise_signal));
        noise_f=linspace(-fs/2,fs/2,length(Noise_signal));
        Noise_signal_f=abs(fftshift(fft(Noise_signal)));
        figure;
        subplot(2,1,1);
        plot( noise_t,real(ifft(Noise_signal )));
        title('SIGNAL WITH NOISE IN T DOMAIN');
        subplot(2,1,2);
        plot(noise_f,Noise_signal_f );
        title('SIGNAL WITH NOISE IN F DOMAIN');
        
        %CUT OFF & FILTER
        a=floor((length(Noise_signal_f)./fs)*(fs./2-3400));
        b=(length(Noise_signal_f )-floor((length(Noise_signal_f )./fs*(fs./2-3400)))+1);
        Noise_signal_f([ 1:a     b : length(Noise_signal_f ) ]  , [1  2])=0;
        Noise_signal=real(ifft(ifftshift(Noise_signal_f)));
       % sound( Noise_signal,fs);
        figure;
        subplot(2,1,1);
        plot(  Noise_signal );
        title('CUT OFF  IN T DOMAIN');
        subplot(2,1,2);
        plot(noise_f,Noise_signal_f );
        title('CUT OFF SIGNALF DOMAIN');

 case 3
        h3=h3';
        y3_R=conv(R,h3);
        y3_L=conv(L,h3);
        y3_tot= [ y3_L  y3_R] ;
        %sound(y3_tot,fs);
         %figure;
       % subplot(2,1,1)
       % plot(y3_R);
       % title(' CONV FOR RIGHT SIGNAL ');
       % subplot(2,1,2);
       % plot(y3_L);
        %title('  CONV FOR LEFT SIGNAL ');
        
        %NOISE
        out_sig=y3_tot ;     
        sigma=input(' please enter the value of sigma:=>');
        z= sigma.*randn(1,length(out_sig));
        Noise_signal = out_sig + [z'  z' ];
        sound(Noise_signal,fs);
        noise_t=linspace(0,length(Noise_signal),length(Noise_signal));
        noise_f=linspace(-fs/2,fs/2,length(Noise_signal));
        Noise_signal_f=abs(fftshift(fft(Noise_signal)));
        figure;
        subplot(2,1,1);
        plot( noise_t,real(ifft(Noise_signal )));
        title('SIGNAL WITH NOISE IN T DOMAIN');
        subplot(2,1,2);
        plot(noise_f,Noise_signal_f );
        title('SIGNAL WITH NOISE IN F DOMAIN');
          
         %CUT OFF & FILTER
        a=floor((length(Noise_signal_f)./fs)*(fs./2-3400));
        b=(length(Noise_signal_f )-floor((length(Noise_signal_f )./fs*(fs./2-3400)))+1);
        Noise_signal_f([ 1:a     b : length(Noise_signal_f ) ]  , [1  2])=0;
        Noise_signal=real(ifft(ifftshift(Noise_signal_f)));
        %sound( Noise_signal,fs);
        figure;
        subplot(2,1,1);
        plot(  Noise_signal );
        title('CUT OFF  IN T DOMAIN');
        subplot(2,1,2);
        plot(noise_f,Noise_signal_f );
        title('CUT OFF SIGNALF DOMAIN');
        
   case 4
        y4_R=conv(R,h4);
        y4_L=conv(L,h4);
        y4_tot= [ y4_L  y4_R] ;
        %sound(y4_tot,fs)
        %figure;
       % subplot(2,1,1)
     %  plot(y4_R);
      %  title(' CONV FOR RIGHT SIGNAL');
      %  subplot(2,1,2);
        %plot(y4_L);
      %  title(' CONV FOR LEFT SIGNAL ');
        
        %NOISE
        out_sig=y4_tot ;     
        sigma=input('please enter the value of sigma which sigma:=>');
        z= sigma.*randn(1,length(out_sig));
        Noise_signal = out_sig + [z' z'];
        sound(Noise_signal,fs);
        noise_t=linspace(0,length(Noise_signal),length(Noise_signal));
        noise_f=linspace(-fs/2,fs/2,length(Noise_signal));
        Noise_signal_f=abs(fftshift(fft(Noise_signal)));
        figure;
        subplot(2,1,1);
        plot( noise_t,Noise_signal );
        title('SIGNAL WITH NOISE IN T DOMAIN');
        subplot(2,1,2);
        plot(noise_f,Noise_signal_f );
        title('SIGNAL WITH NOISE IN F DOMAIN');
        
        
         %CUT OFF & FILTER
       a=floor((length(Noise_signal_f)./fs)*(fs./2-3400));
        b=(length(Noise_signal_f )-floor((length(Noise_signal_f )./fs*(fs./2-3400)))+1);
        Noise_signal_f([ 1:a     b : length(Noise_signal_f ) ]  , [1  2])=0;
       Noise_signal=real(ifft(ifftshift(Noise_signal_f)));
       % sound( Noise_signal,fs);
        figure;
        subplot(2,1,1);
        plot(  Noise_signal );
        title('CUT OFF  IN T DOMAIN');
        subplot(2,1,2);
        plot(noise_f,Noise_signal_f );
        title('CUT OFF SIGNALF DOMAIN');
        
end








