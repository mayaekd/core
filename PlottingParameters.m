%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef PlottingParameters
    properties
        % I should make these so that if you change them online they update
        % -- i.e. I should use the sourcing framework for the color data or
        % whatever
        ClusterColorArray; % Will take the first however-many colors
        MotorSilhouetteColor1;
        MotorSilhouetteColor2;
        MotorSilhouetteMinOpacity;
        MotorSilhouetteMaxOpacity;
        PerceptualTrajectoryColor1;
        PerceptualTrajectoryColor2;
        ResultTrajectoryColor1;
        ResultTrajectoryColor2;
        VisiblePointsPerStep;
        JunctureSizes;
        ResultPointSizes;
        ClusterActivationToAlphaFunction;
        NumberOfSilhouetteVertices;
        NumberOfPointsBetweenPoints;
        MotorBounds;
        PerceptualBounds;
    end
    methods
        function obj = PlottingParameters(ClusterColorArray, ...
                MotorSilhouetteColor1, MotorSilhouetteColor2, ...
                MotorSilhouetteMinOpacity, MotorSilhouetteMaxOpacity, ...
                PerceptualTrajectoryColor1, PerceptualTrajectoryColor2, ...
                ResultTrajectoryColor1, ResultTrajectoryColor2, ...
                VisiblePointsPerStep, JunctureSizes, ResultPointSizes, ...
                NumberOfSilhouetteVertices, ...
                NumberOfPointsBetweenPoints, MotorBounds, PerceptualBounds)
            obj.ClusterColorArray = ClusterColorArray;
            obj.MotorSilhouetteColor1 = MotorSilhouetteColor1;
            obj.MotorSilhouetteColor2 = MotorSilhouetteColor2;
            obj.MotorSilhouetteMinOpacity = MotorSilhouetteMinOpacity;
            obj.MotorSilhouetteMaxOpacity = MotorSilhouetteMaxOpacity;
            obj.PerceptualTrajectoryColor1 = PerceptualTrajectoryColor1;
            obj.PerceptualTrajectoryColor2 = PerceptualTrajectoryColor2;
            obj.ResultTrajectoryColor1 = ResultTrajectoryColor1;
            obj.ResultTrajectoryColor2 = ResultTrajectoryColor2;
            obj.VisiblePointsPerStep = VisiblePointsPerStep;
            obj.JunctureSizes = JunctureSizes;
            obj.ResultPointSizes = ResultPointSizes;
            obj.NumberOfSilhouetteVertices = NumberOfSilhouetteVertices;
            obj.NumberOfPointsBetweenPoints = NumberOfPointsBetweenPoints;
            obj.MotorBounds = MotorBounds;
            obj.PerceptualBounds = PerceptualBounds;
        end
    end
end