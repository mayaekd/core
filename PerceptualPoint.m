%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHOD LIST
%  PerceptualPoint
%  Distance

%% CLASS DEFINITION
classdef PerceptualPoint
    % A perceptual point consists of its coordinates and the values that we
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
        function obj = PerceptualPoint(coordinates, CoordinateOptions)
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

        % Distance between two perceptual points is Euclidean distance
        function dist = Distance(obj, otherPerceptualPoint)
            SumOfSquares = 0;
            for i = 1:length(otherPerceptualPoint.Coordinates)
                SumOfSquares = SumOfSquares + (obj.Coordinates(i,1) - ...
                    otherPerceptualPoint.Coordinates(i,1))^2;
            end
            dist = sqrt(SumOfSquares);
        end
    end
end