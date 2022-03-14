%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS LIST
%  PerceptualPoint
%  Distance

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
        function obj = PerceptualPoint(coordinates)
            obj.Coordinates = coordinates;
            obj.x = coordinates(1,1);
            obj.y = coordinates(2,1);
            obj.z = 0;
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