%% METHODS LIST
%  ExecutionParameters

classdef ExecutionParameters
    
    %% PROPERTIES
    properties
        LookBackAmount;
        LookAheadAmount;
        Spread;
    end
    
    %% METHODS
    methods
        %% CREATE OBJECT
        function obj = ExecutionParameters(LookBackAmount, ...
                LookAheadAmount, Spread)
            obj.LookBackAmount = LookBackAmount;
            obj.LookAheadAmount = LookAheadAmount;
            obj.Spread = Spread;
        end
    end
end

