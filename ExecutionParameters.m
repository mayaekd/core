%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHOD LIST
%  ExecutionParameters

%% CLASS DEFINITION
classdef ExecutionParameters
    
    %% PROPERTIES
    properties
        LookBackAmount;
        LookAheadAmount;
    end
    
    %% METHODS
    methods
        %% CREATE OBJECT
        function obj = ExecutionParameters(LookBackAmount, ...
                LookAheadAmount)
            obj.LookBackAmount = LookBackAmount;
            obj.LookAheadAmount = LookAheadAmount;
        end
    end
end

