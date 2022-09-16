classdef reshapeRLayer < nnet.layer.Layer
    properties
    end
    properties (Learnable)
    end
    methods
        function layer = reshapeRLayer(name)
            layer.Name = name;
        end
        function [Z] = predict(layer, X)
            Z = reshape(X,size(X,3),[]);
        end
    end
    
end