clc;clear;close all;

% create data
fid=fopen('syn3d_30_c.bin','r');
dc=fread(fid,[126,32*32],'float');
dc=reshape(dc,126,32,32);

fid=fopen('syn3d_30_n.bin','r');
dn=fread(fid,[126,32*32],'float');
dn=reshape(dn,126,32,32);

fid=fopen('obs_hyp.bin','r');
d0=fread(fid,[126,32*32],'float');
d0=reshape(d0,126,32,32);

fid=fopen('mask_hyp.bin','r');
mask=fread(fid,[126,32*32],'float');
mask=reshape(mask,126,32,32);

% decimate
% [nt,nx,ny]=size(dc);
% ratio=0.5;
% mask=yc_genmask(reshape(dc,nt,nx*ny),ratio,'c',201415);
% mask=reshape(mask,nt,nx,ny);
% d0=dn.*mask;
figure;imagesc([dc(:,:,10),dn(:,:,10),d0(:,:,10)]);colormap(seis);


w1=15;
w2=15;
w3=15;
s1z=1;
s2z=1;
s3z=1;
inpsize= w1*w2*w3;


D1 = 4000;
D2 = ceil(D1/2);
D3 = ceil(D2/2);
D4 = ceil(D3/2);
D5 = ceil(D4/2);
D6 = ceil(D5/2);
D7 = ceil(D6/2);

layers = [
    featureInputLayer(inpsize,'Name','input')
   
    ];

lgraph = layerGraph(layers);

e1= fullyConnectedLayer(D1,'Name','e1');
e1_relu = reluLayer('Name','e1_relu');
lgraph = addLayers(lgraph,e1);
lgraph = addLayers(lgraph,e1_relu);
lgraph = connectLayers(lgraph,'input','e1');
lgraph = connectLayers(lgraph,'e1','e1_relu');


e2= fullyConnectedLayer(D2,'Name','e2');
e2_relu = reluLayer('Name','e2_relu');
lgraph = addLayers(lgraph,e2);
lgraph = addLayers(lgraph,e2_relu);
lgraph = connectLayers(lgraph,'e1_relu','e2');
lgraph = connectLayers(lgraph,'e2','e2_relu');


concat_1 = concatenationLayer(1,2,'Name','concat_1');
lgraph = addLayers(lgraph,concat_1);
lgraph = connectLayers(lgraph,'e1_relu','concat_1/in1');
lgraph = connectLayers(lgraph,'e2_relu','concat_1/in2');

e3= reshapeLayer('e3');
lgraph = addLayers(lgraph,e3);
lgraph = connectLayers(lgraph,'concat_1','e3');
e3g = globalAveragePooling2dLayer('Name','e3g');
lgraph = addLayers(lgraph,e3g);
lgraph = connectLayers(lgraph,'e3','e3g');

e4= fullyConnectedLayer(4,'Name','e4');
e4_relu = reluLayer('Name','e4_relu');
lgraph = addLayers(lgraph,e4);
lgraph = addLayers(lgraph,e4_relu);
lgraph = connectLayers(lgraph,'e3g','e4');
lgraph = connectLayers(lgraph,'e4','e4_relu');

se = e1.OutputSize + e2.OutputSize;
e4s= fullyConnectedLayer(se,'Name','e4s');
e4_sig = sigmoidLayer('Name','e4_sig');
lgraph = addLayers(lgraph,e4s);
lgraph = addLayers(lgraph,e4_sig);
lgraph = connectLayers(lgraph,'e4_relu','e4s');
lgraph = connectLayers(lgraph,'e4s','e4_sig');


e4_sigR= reshapeRLayer('e4_sigR');
lgraph = addLayers(lgraph,e4_sigR);
lgraph = connectLayers(lgraph,'e4_sig','e4_sigR');


mul_1 = multiplicationLayer(2,'Name','mul_1');
lgraph = addLayers(lgraph,mul_1);
lgraph = connectLayers(lgraph,'e4_sigR','mul_1/in1');
lgraph = connectLayers(lgraph,'concat_1','mul_1/in2');

e5= fullyConnectedLayer(D3,'Name','e5');
e5_relu = reluLayer('Name','e5_relu');
lgraph = addLayers(lgraph,e5);
lgraph = addLayers(lgraph,e5_relu);
lgraph = connectLayers(lgraph,'mul_1','e5');
lgraph = connectLayers(lgraph,'e5','e5_relu');


concat_2 = concatenationLayer(1,2,'Name','concat_2');
lgraph = addLayers(lgraph,concat_2);
lgraph = connectLayers(lgraph,'mul_1','concat_2/in1');
lgraph = connectLayers(lgraph,'e5_relu','concat_2/in2');




e6= reshapeLayer('e6');
lgraph = addLayers(lgraph,e6);
lgraph = connectLayers(lgraph,'concat_2','e6');
e6g = globalAveragePooling2dLayer('Name','e6g');
lgraph = addLayers(lgraph,e6g);
lgraph = connectLayers(lgraph,'e6','e6g');

e7= fullyConnectedLayer(4,'Name','e7');
e7_relu = reluLayer('Name','e7_relu');
lgraph = addLayers(lgraph,e7);
lgraph = addLayers(lgraph,e7_relu);
lgraph = connectLayers(lgraph,'e6g','e7');
lgraph = connectLayers(lgraph,'e7','e7_relu');

se1 = e1.OutputSize + e2.OutputSize + e5.OutputSize;
e7s= fullyConnectedLayer(se1,'Name','e7s');
e7_sig = sigmoidLayer('Name','e7_sig');
lgraph = addLayers(lgraph,e7s);
lgraph = addLayers(lgraph,e7_sig);
lgraph = connectLayers(lgraph,'e7_relu','e7s');
lgraph = connectLayers(lgraph,'e7s','e7_sig');

e7_sigR= reshapeRLayer('e7_sigR');
lgraph = addLayers(lgraph,e7_sigR);
lgraph = connectLayers(lgraph,'e7_sig','e7_sigR');

mul_2 = multiplicationLayer(2,'Name','mul_2');
lgraph = addLayers(lgraph,mul_2);
lgraph = connectLayers(lgraph,'e7_sigR','mul_2/in1');
lgraph = connectLayers(lgraph,'concat_2','mul_2/in2');


concat_3 = concatenationLayer(1,2,'Name','concat_3');
lgraph = addLayers(lgraph,concat_3);
lgraph = connectLayers(lgraph,'mul_1','concat_3/in1');
lgraph = connectLayers(lgraph,'mul_2','concat_3/in2');


outx = fullyConnectedLayer(2*inpsize,'Name','outx');
outx_relu = reluLayer('Name','outx_relu');
lgraph = addLayers(lgraph, outx);
lgraph = addLayers(lgraph, outx_relu);
lgraph = connectLayers(lgraph, 'concat_3', 'outx');
lgraph = connectLayers(lgraph, 'outx', 'outx_relu');

 
 outy = fullyConnectedLayer(inpsize,'Name','outy');
 lgraph = addLayers(lgraph, outy);
 lgraph = connectLayers(lgraph, 'outx_relu', 'outy');

 outr = regressionLayer('Name','outr');
 lgraph = addLayers(lgraph, outr);
 lgraph = connectLayers(lgraph, 'outy', 'outr');

 
figure
plot(lgraph)
analyzeNetwork(lgraph)


%15 15 15 2 2 2 -- >2048
batchsize = 2048;
batchsize_1=batchsize-1;
%'LearnRateSchedule','piecewise', ...
%'LearnRateDropFactor',0.1, ...
%'LearnRateDropPeriod',10, ...
%'Plots','training-progress'
[n1,n2,n3] = size(d0);
niter=10;
a = (niter-(1:niter))/(niter-1);
%a = ones(1,niter);
d1 = d0;
%X1 = yc_patch3d(d0,1,w1,w2,w3,s1z,s2z,s3z);

cc=1;
figure(100);imagesc([dc(:,:,10),dn(:,:,10),d1(:,:,10)]);colormap(seis);


%zo=20*ones(50,1);
%zo(25:end)=100;
zo=100*ones(50,1);
%%
for iter=1:niter 
    iter
options = trainingOptions('adam', ...
'MaxEpochs',zo(iter),   ...
'Verbose',true, ...0
'MiniBatchSize',batchsize, ...
'InitialLearnRate', 0.001);


   %% Proposed DL
   dbef(iter,:,:,:) = d1;
   % Patching
    X = yc_patch3d(d1,1,w1,w2,w3,s1z,s2z,s3z);
    X = X';
    le=length(X);
    %% Selecting patches based on variance.
    v = var(X');
    [ord,indx] = sort(v);
    lex = round(length(indx)*0.25);
    % Train DenseNet (Image Piror)
    net = trainNetwork(X(indx(lex:end),:),X(indx(lex:end),:),lgraph,options);
    % Predict DenseNet output
    outDN = DL_Predict(net,X,le,batchsize,cc);
    % UnPatching
    d2=yc_patch3d_inv(outDN',1,n1,n2,n3,w1,w2,w3,s1z,s2z,s3z);
    dafter(iter,:,:,:) = d2;

    %% Interpolation
    %POCS
    d1=a(iter)*d0.*mask+(1-a(iter))*d2.*mask+d2.*(1-mask);
    Pafter(iter,:,:,:) = d1;
    
    %figure(iter)
    %subplot(3,1,1);yc_imagesc(reshape(dbef(iter,:,:,:),126,32*32),99);
    %subplot(3,1,2);yc_imagesc(reshape(dafter(iter,:,:,:),126,32*32),99);
    %subplot(3,1,3);yc_imagesc(reshape(Pafter(iter,:,:,:),126,32*32),99);
    
    %% Print SNR
    fprintf(' The SNR of iteration # %d is %0.3f dB \n', iter, yc_snr(dc,d1,2))
end
% yc_snr(dc,d1,2)
figure;imagesc([dc(:,:,10),dn(:,:,10),d0(:,:,10),d1(:,:,10)]);colormap(seis);
% 
% Write Outputs
fg = fopen('den_hyp.bin','w');
fwrite(fg,d1,'float');
fclose(fg);

fg = fopen('err_hyp.bin','w');
fwrite(fg,dc-d1,'float');
fclose(fg);



