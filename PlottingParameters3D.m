%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef PlottingParameters3D
    properties
        % I should make these so that if you change them online they update
        % -- i.e. I should use the sourcing framework for the color data or
        % whatever
        ClusterColorArray; % Will take the first however-many colors
        MotorSilhouetteColorArray;
        PerceptualTrajectoryColor1;
        PerceptualTrajectoryColor2;
        ResultTrajectoryColor1;
        ResultTrajectoryColor2;
        VisiblePointsPerStep;
        JunctureSizes;
        ResultPointSizes;
        ClusterActivationToAlphaFunction;
        NumberOfPointsBetweenPoints;
    end
    methods
        function obj = PlottingParameters3D( ...
                ClusterColorArray, MotorSilhouetteColorArray, ...
                PerceptualTrajectoryColor1, PerceptualTrajectoryColor2, ...
                ResultTrajectoryColor1, ResultTrajectoryColor2, ...
                VisiblePointsPerStep, JunctureSizes, ResultPointSizes, ...
                NumberOfPointsBetweenPoints)
            obj.ClusterColorArray = ClusterColorArray;
            obj.MotorSilhouetteColorArray = MotorSilhouetteColorArray;
            obj.PerceptualTrajectoryColor1 = PerceptualTrajectoryColor1;
            obj.PerceptualTrajectoryColor2 = PerceptualTrajectoryColor2;
            obj.ResultTrajectoryColor1 = ResultTrajectoryColor1;
            obj.ResultTrajectoryColor2 = ResultTrajectoryColor2;
            obj.VisiblePointsPerStep = VisiblePointsPerStep;
            obj.JunctureSizes = JunctureSizes;
            obj.ResultPointSizes = ResultPointSizes;
            obj.NumberOfPointsBetweenPoints = NumberOfPointsBetweenPoints;
        end
    end
end