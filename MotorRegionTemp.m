%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef MotorRegionTemp
    % What we'll temporarily use as a motor region for simplicity -- a
    % circle/sphere/polygon/polyhedron with a certain center and a certain 
    % radius
    properties
        Center; % This should be a motor point
        Radius;
    end
    methods
        % Creating an object
        function obj = MotorRegionTemp(CenterPoint, RadiusSize)
            obj.Center = CenterPoint;
            obj.Radius = RadiusSize;
        end
        
        %% DISTANCES & CONTAINTMENT
        % Finding the distance to a juncture (is the same as the distance
        % to the juncture's motor point)
        function dist = DistanceToJuncture(obj, juncture)
            dist = obj.DistanceToPoint(juncture.MotorPoint);
        end
        
        % Finding the distance to a motor point
        function dist = DistanceToPoint(obj, MotorPoint)
            DistanceToCenter = obj.Center.Distance(MotorPoint);
            % This will be correct unless the point was within the ball:
            dist = DistanceToCenter - obj.Radius;
            % If the point was within the ball, fix:
            if dist < 0
                dist = 0;
            end
        end
        
        % Finding whether a motor point is contained in the region --
        % returns 1 if it is, 0 if it isn't
        function BooleanInteger = Contains(obj, MotorPoint)
            Distance = obj.DistanceToPoint(MotorPoint);
            if Distance == 0
                BooleanInteger = 1;
            else
                BooleanInteger = 0;
            end
        end
        
        %% PLOTTING INFO
        % Plotting info -- gives a matrix where each row is the vertices of
        % the polygon that will represent this motor region -- it will be a
        % regular polygon with the NumberOfVertices given as input
        function VertexData = PolygonPlottingInfo(obj, NumberOfVertices)
            VertexData = zeros(NumberOfVertices, 2);
            xCenter = obj.Center.x;
            yCenter = obj.Center.y;
            for i = 1:NumberOfVertices
                Angle = i * 2 * pi/NumberOfVertices;
                VertexData(i,1) = obj.Radius * cos(Angle) + xCenter;
                VertexData(i,2) = obj.Radius * sin(Angle) + yCenter;
            end
        end
    end
end