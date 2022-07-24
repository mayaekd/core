%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHOD LIST
%  MotorTrajectory
%  PlottingInfo
%  PlottingInfo3D
%  Plot
%  FindPerceptualTrajectory
%  DistanceToTrajectory
%  DistanceVectorToTrajectory

%% CLASS DEFINITION
classdef MotorTrajectory
    % A motor trajectory consists of its timestamps & the motor points at
    % those times
    properties
        CoordinateMatrix;
        xCoordinates; % For plotting
        yCoordinates; % For plotting
        zCoordinates; % For plotting
        Length;
        Dimensions;
    end
    
    methods
        % Creating an object
        function obj = MotorTrajectory(CoordinateMatrix, ...
                CoordinateOptions)
            % If PointsBetweenEachPoint is not specified, set all the
            % values to zero
            arguments
                CoordinateMatrix (:,:) {mustBeNumeric}
                CoordinateOptions.xRowIndex {mustBeNumeric} = 1
                CoordinateOptions.yRowIndex {mustBeNumeric} = 2
                CoordinateOptions.zRowIndex {mustBeNumeric} = nan
                CoordinateOptions.PointsBetweenEachPoint {mustBeNumeric} = 0
                CoordinateOptions.xCoordinates (1,:) = nan
                CoordinateOptions.yCoordinates (1,:) = nan
                CoordinateOptions.zCoordinates (1,:) = nan
            end

            obj.Length = size(CoordinateMatrix, 2); % This will potentially change
            InBetweenPoints = CoordinateOptions.PointsBetweenEachPoint * ones(obj.Length - 1, 1);
            TotalNumPoints = obj.Length + sum(InBetweenPoints);

            % If there's only one motor point, it's a special case.
            % Otherwise:
            if obj.Length ~= 1
                linInterpStart = nan(1, obj.Length);
                StartIndex = 1;
                linInterpStart(1) = StartIndex;
                for n = 2:obj.Length
                    StartIndex = StartIndex + InBetweenPoints(n-1) + 1;
                    linInterpStart(n) = StartIndex;
                end
                linInterpFinal = 1:TotalNumPoints;
                CoordinateMatrix = transpose(interp1(linInterpStart, ...
                    transpose(CoordinateMatrix), linInterpFinal));
            end

            % Set the properties
            obj.CoordinateMatrix = CoordinateMatrix;

            [obj.Dimensions, obj.Length] = size(CoordinateMatrix);

            % Set plotting coordinates according to index values
            obj.xCoordinates = CoordinateMatrix(CoordinateOptions.xRowIndex, :);
            obj.yCoordinates = CoordinateMatrix(CoordinateOptions.yRowIndex, :);
            if isnan(CoordinateOptions.zRowIndex)
                obj.zCoordinates = nan;
            else
                obj.zCoordinates = CoordinateMatrix(CoordinateOptions.zRowIndex, :);
            end

            % If there are provided plotting coordinates, override with
            % them
            if ~isnan(CoordinateOptions.xCoordinates)
                obj.xCoordinates = CoordinateOptions.xCoordinates;
            end
            if ~isnan(CoordinateOptions.yCoordinates)
                obj.yCoordinates = CoordinateOptions.yCoordinates;
            end
            if ~isnan(CoordinateOptions.zCoordinates)
                obj.zCoordinates = CoordinateOptions.zCoordinates;
            end
        end
        
        % Plotting info
        function [xValues, yValues, colorValues] = ...
                PlottingInfo(obj, color1, color2)
            % Initialize
            xValues = obj.xCoordinates;
            yValues = obj.yCoordinates;
            colorValues = interp1([1 length(xValues)], [color1; color2], 1:length(xValues));
        end
        
        % Plotting info 3D
        function [xValues, yValues, zValues, colorValues] = ...
                PlottingInfo3D(obj, color1, color2)
            % Initialize
            xValues = obj.xCoordinates;
            yValues = obj.yCoordinates;
            zValues = obj.zCoordinates;
            colorValues = interp1([1 length(xValues)], [color1; color2], 1:length(xValues));
        end
        
        % Plotting
        function Plot(obj, axes, color1, color2, Size)
            [xValues, yValues, colorValues] = obj.PlottingInfo(...
                color1, color2);
            scatter(axes, xValues, yValues, Size, colorValues, ...
                "filled", "Marker", "hexagram");
        end


        % Finding corresponding perceptual trajectory
        function perceptualTrajectory = FindPerceptualTrajectory(obj, ...
                SpaceTransformationToUse, PerceptualCoordinateOptions)
            arguments
                obj
                SpaceTransformationToUse
                PerceptualCoordinateOptions.xRowIndex {mustBeNumeric} = 1
                PerceptualCoordinateOptions.yRowIndex {mustBeNumeric} = 2
                PerceptualCoordinateOptions.zRowIndex {mustBeNumeric} = nan
            end
            PerceptualDimension = ...
                size(SpaceTransformationToUse.TransformationFunction( ...
                obj.CoordinateMatrix(:, 1)), 1);
            PerceptualPointMatrix = nan(PerceptualDimension, obj.Length);
            for p = 1:length(PerceptualPointMatrix)
                PerceptualPointMatrix(:, p) = ...
                    SpaceTransformationToUse.TransformationFunction( ...
                    obj.CoordinateMatrix(:, p));
            end
            perceptualTrajectory = PerceptualTrajectory(...
                PerceptualPointMatrix, ...
                "xRowIndex", PerceptualCoordinateOptions.xRowIndex, ...
                "yRowIndex", PerceptualCoordinateOptions.yRowIndex, ...
                "zRowIndex", PerceptualCoordinateOptions.zRowIndex);
        end


        function Distance = DistanceToTrajectory(obj, OtherTrajectory)
            DistanceVector = obj.DistanceVectorToTrajectory(OtherTrajectory);
            Distance = mean(DistanceVector);
        end
        
        % Find the distance between the motor trajectory and another, using
        % uniform shrinking(??) if they don't have the same lengths
        % EXAMPLE: obj.Points is the set of points with coordinates
        % [1;2], [4;5], [10;17], [7;14], [19;2]
        % and OtherTrajectory.Points is the set of points with coordinates
        % [1;4], [5;6], [1;2], [3;2], [5;8], [9;12], [5;6]
        % Resulting point sets that we'll end up comparing should be
        % [1;2], [2;3], [3;4], [4;5], [6;9], [8;13], [10;17], [9;16], [8;15], [7;14], [11;10], [15;6], [19;2]
        % [1;4], [3;5], [5;6], [3;4], [1;2], [2;2], [3;2], [4;5], [5;8], [7;10], [9;12], [7;9], [5;6]
        function DistanceVector = DistanceVectorToTrajectory(obj, OtherTrajectory)
            StartingCoordinateListA = obj.CoordinateMatrix;
                % EX| StartingCoordinateListA = [1 4 10 7 19; 2 5 17 14 2]
            StartingCoordinateListB = OtherTrajectory.CoordinateMatrix;
                % EX| StartingCoordinateListB = [1 5 1 3 5 9 5; 4 6 2 2 8 12 6]
            assert(obj.Dimensions == OtherTrajectory.Dimensions, "The " + ...
                "motor trajectories must have the same number " + ...
                "of coordinates but one of them is " + obj.Length + ...
                " dimensions and the other is " + ...
                OtherTrajectory.Length + " dimensions")
            CoordinateLength = obj.Dimensions;
                % EX| CoordinateLength = 2
            TrajectoryLengthA = size(StartingCoordinateListA, 2);
                % EX| TrajectoryLengthA = 5
            TrajectoryLengthB = size(StartingCoordinateListB, 2);
                % EX| TrajectoryLengthB = 7

            % MAKING THE NECESSARY INPUTS TO USE TO FIND THE EXPANDED
            % COORDINATES
            LengthOfExpandedPointLists = lcm(TrajectoryLengthA - 1, ...
                TrajectoryLengthB - 1) + 1;
                % EX| LengthOfExpandedPointLists = 13
            StepA = (LengthOfExpandedPointLists - 1)/(TrajectoryLengthA - 1);
                % EX| StepA = (13 - 1)/(5 - 1) = 12/4 = 3
            StepB = (LengthOfExpandedPointLists - 1)/(TrajectoryLengthB - 1);
                % EX| StepB = (13 - 1)/(7 - 1) = 12/6 = 2
            StartingInputA = 1:StepA:LengthOfExpandedPointLists;
                % EX| StartingInputA = 0:3:12 = [0 3 6 9 12]
            StartingInputB = 1:StepB:LengthOfExpandedPointLists;
                % EX| StartingInputB = 0:2:12 = [0 2 4 6 8 10 12]
            EndingInput = 1:LengthOfExpandedPointLists;
                % EX| EndingInput = 0:12 = [0 1 2 3 4 5 6 7 8 9 10 11 12]

            % INITIALIZING
            CoordinateListA = zeros(CoordinateLength, LengthOfExpandedPointLists);
                % EX| CoordinateListA = [0 0 0 0 0 0 0 0 0 0 0 0; 
                % EX| 0 0 0 0 0 0 0 0 0 0 0 0]
            CoordinateListB = zeros(CoordinateLength, LengthOfExpandedPointLists);
                % EX| CoordinateListB = [0 0 0 0 0 0 0 0 0 0 0 0; 
                % EX| 0 0 0 0 0 0 0 0 0 0 0 0]
            % MAKING EXPANDED COORDINATES
            for c = 1:CoordinateLength
                StartingCoordinateRowA = StartingCoordinateListA(c,:);
                    % EX| c = 1: StartingCoordinateRow = [1 4 10 7 19]
                    % EX| c = 2: StartingCoordinateRow = [2 5 17 14 2]
                ExpandedCoordinateRowA = interp1(StartingInputA, ...
                    StartingCoordinateRowA, EndingInput);
                    % EX| c = 1: ExpandedCoordinateRowA 
                    % EX| = [1 2 3 4 6 8 10 9 8 7 11 15 19]
                    % EX| c = 2: ExpandedCoordinateRowA
                    % EX| = [2 3 4 5 9 13 17 16 15 14 10 6 2]
                CoordinateListA(c,:) = ExpandedCoordinateRowA;
                    % EX| CoordinateListA = [1 2 3 4 6 8 10 9 8 7 11 15 19;
                    % EX| 2 3 4 5 9 13 17 16 15 14 10 6 2]
                StartingCoordinateRowB = StartingCoordinateListB(c,:);
                    % EX| c = 1: StartingCoordinateRow = [1 5 1 3 5 9 5]
                    % EX| c = 2: StartingCoordinateRow = [4 6 2 2 8 12 6]
                ExpandedCoordinateRowB = interp1(StartingInputB, ...
                    StartingCoordinateRowB, EndingInput);
                    % EX| c = 1: ExpandedCoordinateRowB
                    % EX| = [1 3 5 3 1 2 3 4 5 7 9 7 5]
                    % EX| c = 2: ExpandedCoordinateRowB
                    % EX| = [4 5 6 4 2 2 2 5 8 10 12 9 6]
                CoordinateListB(c,:) = ExpandedCoordinateRowB;
                    % EX| CoordinateListB = [1 3 5 3 1 2 3 4 5 7 9 7 5;
                    % EX| 4 5 6 4 2 2 2 5 8 10 12 9 6]
            end
            
            % NOW THAT THINGS ARE IN THE APPROPRIATE FORMAT, WE CAN FIND
            % THE DISTANCE
            DifferenceInCoordinates = CoordinateListA - CoordinateListB;
            DifferencesSquared = DifferenceInCoordinates.^2;
            SumOfSquares = sum(DifferencesSquared, 1);
            DistanceVector = sqrt(SumOfSquares);
        end
    end
end
