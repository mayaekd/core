%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHOD LIST
%  MotorPoint
%  Distance
%  FindPerceptualPoint
%  MakeJuncture

%% CLASS DEFINITION
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
        function obj = MotorPoint(coordinates, CoordinateOptions)
            arguments
                coordinates (:,:) {mustBeNumeric}
                CoordinateOptions.xRowIndex {mustBeNumeric} = 1
                CoordinateOptions.yRowIndex {mustBeNumeric} = 2
                CoordinateOptions.zRowIndex {mustBeNumeric} = nan
                CoordinateOptions.xCoordinates (1,:) = nan
                CoordinateOptions.yCoordinates (1,:) = nan
                CoordinateOptions.zCoordinates (1,:) = nan
            end
            obj.Coordinates = coordinates;
            obj.x = coordinates(CoordinateOptions.xRowIndex, :);
            obj.y = coordinates(CoordinateOptions.yRowIndex, :);
            if isnan(CoordinateOptions.zRowIndex)
                obj.z = nan;
            else
                obj.z = coordinates(CoordinateOptions.zRowIndex, :);
            end

            % If there are provided plotting coordinates, override with
            % them
            if ~isnan(CoordinateOptions.xCoordinates)
                obj.x = CoordinateOptions.xCoordinates;
            end
            if ~isnan(CoordinateOptions.yCoordinates)
                obj.y = CoordinateOptions.yCoordinates;
            end
            if ~isnan(CoordinateOptions.zCoordinates)
                obj.z = CoordinateOptions.zCoordinates;
            end
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