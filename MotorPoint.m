%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS LIST
%  MotorPoint
%  Distance
%  FindPerceptualPoint
%  MakeJuncture

classdef MotorPoint
    % A motor point consists of its coordinates and the values that we
    % want to use for x, y, and z when plotting.
    
    %% PROPERTIES
    properties
        Coordinates;
        x;
        y;
        z;
    end

    %% METHODS
    methods
        % Creating an object
        function obj = MotorPoint(coordinates)
            obj.Coordinates = coordinates;
            obj.x = coordinates(1,1);
            obj.y = coordinates(2,1);
            obj.z = 0;
        end
        
        % Distance between two motor points is Euclidean distance
        function dist = Distance(obj, otherMotorPoint)
            SumOfSquares = 0;
            for i = 1:length(otherMotorPoint.Coordinates)
                SumOfSquares = SumOfSquares + (obj.Coordinates(i,1) - ...
                    otherMotorPoint.Coordinates(i,1))^2;
            end
            dist = sqrt(SumOfSquares);
        end
        
        % Find corresponding PerceptualPoint
        function PPoint = FindPerceptualPoint(obj, SpaceTransformationToUse)
            MotorCoordinates = obj.Coordinates;
            PerceptualCoordinates = SpaceTransformationToUse.TransformationFunction(MotorCoordinates);
            PPoint = PerceptualPoint(PerceptualCoordinates);
        end
        
        % Create a juncture with assumed mapping from FindPerceptualPoint
        function juncture = MakeJuncture(obj, SpaceTransformationToUse)
            PPoint = obj.FindPerceptualPoint(SpaceTransformationToUse);
            juncture = Juncture(obj, PPoint);
        end
    end
end