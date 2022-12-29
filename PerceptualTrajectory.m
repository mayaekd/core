%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHOD LIST
%  PerceptualTrajectory
% 
%  DISTANCE
%  DistanceToTrajectory
%  DistanceVectorToTrajectory
%
%  ACTIVATION
%  ActivationOfPerceptualMatrix
%
%  PLOTTING
%  PlottingInfo
%  PlottingInfo3D
%  Plot

%% CLASS DEFINITION
classdef PerceptualTrajectory
    % A perceptual trajectory consists of its timestamps & the perceptual
    % points at those times
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
        function obj = PerceptualTrajectory(CoordinateMatrix, CoordinateOptions)
            arguments
                CoordinateMatrix (:,:) {mustBeNumeric}
                CoordinateOptions.xRowIndex {mustBeNumeric} = 1
                CoordinateOptions.yRowIndex {mustBeNumeric} = 2
                CoordinateOptions.zRowIndex {mustBeNumeric} = nan
                CoordinateOptions.xCoordinates (1,:) = nan
                CoordinateOptions.yCoordinates (1,:) = nan
                CoordinateOptions.zCoordinates (1,:) = nan
            end
            obj.CoordinateMatrix = CoordinateMatrix;
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

            [obj.Dimensions, obj.Length] = size(CoordinateMatrix);
        end

        %% DISTANCE
        %  FUNCTIONS
        %  DistanceToTrajectory
        %  DistanceVectorToTrajectory
        function Distance = DistanceToTrajectory(obj, OtherTrajectory)
            DistanceVector = obj.DistanceVectorToTrajectory(OtherTrajectory);
            Distance = mean(DistanceVector);
        end

        % Find the distance between the perceptual trajectory and another, 
        % using uniform shrinking if they don't have the same lengths
        % EXAMPLE: obj.Points is the set of points with coordinates
        % [1;2], [4;5], [10;17], [7;14], [19;2]
        % and OtherTrajectory.Points is the set of points with coordinates
        % [1;4], [5;6], [1;2], [3;2], [5;8], [9;12], [5;6]
        % Resulting point sets that we'll end up comparing should be
        % [1;2], [2;3], [3;4], [4;5], [6;9], [8;13], [10;17], [9;16], [8;15], [7;14], [11;10], [15;6], [19;2]
        % [1;4], [3;5], [5;6], [3;4], [1;2], [2;2], [3;2], [4;5], [5;8], [7;10], [9;12], [7;9], [5;6]
        % But there's a question if this interpolation makes sense given
        % that the trajectories being modeled can be discontinuous
        function DistanceVector = DistanceVectorToTrajectory(obj, OtherTrajectory)
            assert(obj.Length > 1 && OtherTrajectory.Length > 1, "The trajectories have to have length greater than one for this")
            StartingCoordinateListA = obj.CoordinateMatrix;
                % EX| StartingCoordinateListA = [1 4 10 7 19; 2 5 17 14 2]
            StartingCoordinateListB = OtherTrajectory.CoordinateMatrix;
                % EX| StartingCoordinateListB = [1 5 1 3 5 9 5; 4 6 2 2 8 12 6]
            assert(obj.Length == OtherTrajectory.Length, "The " + ...
                "perceptual trajectories must have the same number " + ...
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

        %% ACTIVATION
        %  ActivationOfPerceptualMatrix
        function Activation = ActivationOfPerceptualMatrix(obj, ...
                PerceptualMatrix, HighestActivation, DropoffSlope)
            NumCoord = size(obj.CoordinateMatrix, 1);
            assert(NumCoord == size(PerceptualMatrix, 1), "The " + ...
                "perceptual trajectory and perceptual point matrix " + ...
                "must have the same number of dimensions (i.e. the " + ...
                "dimensions of perceputal space must be " + ...
                "consistent), but the trajectory has " + NumCoord + ...
                " perceptual dimensions and the matrix has " + ...
                size(PerceptualMatrix, 1) + " dimensions.")
            SumOfSquaresMatrix = zeros(size(PerceptualMatrix, 2), obj.Length);
            for d = 1:NumCoord
                DifferencesSquared = (transpose(PerceptualMatrix(d, :)) - obj.CoordinateMatrix(d, :)).^2;
                SumOfSquaresMatrix = SumOfSquaresMatrix + DifferencesSquared;
            end
            DistanceMatrix = sqrt(SumOfSquaresMatrix);
            ActivationMatrix = max(0, HighestActivation - ...
                (DropoffSlope * DistanceMatrix));
            Activation = mean(ActivationMatrix, "all");
        end

        %% PLOTTING
        %  FUNCTIONS
        %  PlottingInfo
        %  PlottingInfo3D
        %  Plot

        % Plotting info
        function [xValues, yValues, colorValues] = PlottingInfo(obj, color1, color2)
            % Initialize
            xValues = obj.xCoordinates;
            yValues = obj.yCoordinates;
            colorValues1 = transpose(linspace(color1(1,1), color2(1,1), length(xValues)));
            colorValues2 = transpose(linspace(color1(1,2), color2(1,2), length(xValues)));
            colorValues3 = transpose(linspace(color1(1,3), color2(1,3), length(xValues)));
            colorValues = horzcat(colorValues1, colorValues2, colorValues3);
        end

        % Plotting info 3D
        function [xValues, yValues, zValues, colorValues] = PlottingInfo3D(obj, color1, color2)
            % Initialize
            xValues = obj.xCoordinates;
            yValues = obj.yCoordinates;
            zValues = obj.zCoordinates;
            colorValues1 = transpose(linspace(color1(1,1), color2(1,1), length(xValues)));
            colorValues2 = transpose(linspace(color1(1,2), color2(1,2), length(xValues)));
            colorValues3 = transpose(linspace(color1(1,3), color2(1,3), length(xValues)));
            colorValues = horzcat(colorValues1, colorValues2, colorValues3);
        end
        
        % Plotting
        function Plot(obj, axes, color1, color2)
            [xValues, yValues, colorValues] = obj.PlottingInfo(color1, color2);
            scatter(axes, xValues, yValues, 200, colorValues, "filled", "Marker", "hexagram");
        end


    end
end
