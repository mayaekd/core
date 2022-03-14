%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS LIST
%  Juncture
%  MotorPlottingInfo
%  PlotMotor
%  PerceptualPlottingInfo
%  SlowlyPlotMotor
%  SlowlyPlotPerceptual

classdef Juncture
    % A juncture consists of a point in motor space and a point in
    % perceptual space

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
        % Plotting (motor)
        function PlotMotor(obj, axes, color)
            [x, y, color] = obj.MotorPlottingInfo(color);
            scatter(axes, [x], [y], 100, color, "filled");
        end
        
        % Getting info for plotting (perceptual)
        function [x, y, color] = PerceptualPlottingInfo(obj, color)
            x = obj.PerceptualPoint.x;
            y = obj.PerceptualPoint.y;
        end
        % Plotting (perceptual)
        function PlotPerceptual(obj, axes, color)
            [x, y, color] = obj.PerceptualPlottingInfo(color);
            scatter(axes, [x], [y], 100, color, "filled");
        end
        
        % Plotting the motor side of a juncture, having it start out more
        % transparent and slowly get more opaque
        function SlowlyPlotMotor(obj, axis, color, size)
            [x, y, color] = obj.MotorPlottingInfo(color);
            JuncturePlot = scatter(axis, [x], [y], size, color, "filled", ...
                    "MarkerFaceAlpha", "flat", ...
                    "MarkerEdgeAlpha", "flat", ...
                    "AlphaDataMapping", "none", "AlphaData", 0);
            for i=2:20
                pause(1/40);
                JuncturePlot.AlphaData = (1/(21-i))^1;
            end
        end
        
        % Plotting the perceptual side of a juncture, having it start out more
        % transparent and slowly get more opaque
        function SlowlyPlotPerceptual(obj, axis, color, size)
            [x, y, color] = obj.PerceptualPlottingInfo(color);
            JuncturePlot = scatter(axis, [x], [y], size, color, "filled", ...
                    "MarkerFaceAlpha", "flat", ...
                    "MarkerEdgeAlpha", "flat", ...
                    "AlphaDataMapping", "none", "AlphaData", 0);
            for i=2:20
                pause(1/40);
                JuncturePlot.AlphaData = (1/(21-i))^1;
            end
        end
    end
end