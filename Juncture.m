%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS LIST
%  Juncture
%  MotorPlottingInfo
%  PerceptualPlottingInfo
%  PlotMotor
%  PlotPerceptual

classdef Juncture
    % A juncture consists of a point in motor space and a point in
    % perceptual space, which here are just represented as their
    % coordinates

    %% PROPERTIES
    properties
        MotorPoint;
        PerceptualPoint;
    end

    %% METHODS
    methods
        % Creating an object
        function obj = Juncture(motorPoint, perceptualPoint)
            obj.MotorPoint = motorPoint;
            obj.PerceptualPoint = perceptualPoint;
        end
        % Getting info for plotting (motor)
        function [x, y, color] = MotorPlottingInfo(obj, color)
            x = obj.MotorPoint.x;
            y = obj.MotorPoint.y;
        end
        
        % Getting info for plotting (perceptual)
        function [x, y, color] = PerceptualPlottingInfo(obj, color)
            x = obj.PerceptualPoint.x;
            y = obj.PerceptualPoint.y;
        end

        % Plotting (motor)
        function PlotMotor(obj, axes, color)
            [x, y, color] = obj.MotorPlottingInfo(color);
            scatter(axes, x, y, 100, color, "filled");
        end
        
        % Plotting (perceptual)
        function PlotPerceptual(obj, axes, color)
            [x, y, color] = obj.PerceptualPlottingInfo(color);
            scatter(axes, x, y, 100, color, "filled");
        end
    end
end