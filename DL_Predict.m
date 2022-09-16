function [outDl] = DL_Predict(net,X,le,batchsize,cc) 
    
    outDN=[];
    batchsize_1=batchsize-1;
    while cc<=le
        if cc+batchsize_1>le
        outDN(cc:le,:) = predict(net,X(cc:end,:));
        else
        outDN(cc:cc+batchsize_1,:) = predict(net,X(cc:cc+batchsize_1,:));
        end
        cc = cc + batchsize;
    end

outDl = outDN;
return