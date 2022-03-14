%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef PerceptualTrajectory
    % A perceptual trajectory consists of its timestamps & the perceptual
    % points at those times
    properties
        Points;
        CoordinateMatrix;
    end
    
    methods
        % Creating an object
        function obj = PerceptualTrajectory(PerceptualPointCellArray)
            obj.Points = PerceptualPointCellArray;
            CoordinateMatrix = zeros(length(PerceptualPointCellArray{1,1}.Coordinates),length(PerceptualPointCellArray));
            for p = 1:length(PerceptualPointCellArray)
                CoordinateMatrix(:,p) = PerceptualPointCellArray{p,1}.Coordinates;
            end
            obj.CoordinateMatrix = CoordinateMatrix;
        end

        function perceptualPoint = ClosestPartToOtherPoint(obj, otherPoint)
            closestPoint = obj.Points{1,1};
            minDistance = otherPoint.Distance(closestPoint);
            for pIndex = 1:length(obj.Points)
                CurrentTrajectoryPoint = obj.Points{pIndex, 1};
                CurrentDistanceFromPoint = otherPoint.Distance(...
                    CurrentTrajectoryPoint);
                if CurrentDistanceFromPoint < minDistance
                    closestPoint = CurrentTrajectoryPoint;
                    minDistance = CurrentDistanceFromPoint;
                end
            end
            perceptualPoint = closestPoint;
        end

        
        % Plotting info
        function [xValues, yValues, colorValues] = PlottingInfo(obj, color1, color2)
            % Initialize
            xValues = zeros(length(obj.Points), 1);
            yValues = zeros(length(obj.Points), 1);
            for i = 1:length(obj.Points)
                xValues(i,1) = obj.Points{i,1}.x;
                yValues(i,1) = obj.Points{i,1}.y;
            end
            colorValues1 = transpose(linspace(color1(1,1), color2(1,1), length(obj.Points)));
            colorValues2 = transpose(linspace(color1(1,2), color2(1,2), length(obj.Points)));
            colorValues3 = transpose(linspace(color1(1,3), color2(1,3), length(obj.Points)));
            colorValues = horzcat(colorValues1, colorValues2, colorValues3);
        end
        
        % Plotting
        function Plot(obj, axes, color1, color2)
            [xValues, yValues, colorValues] = obj.PlottingInfo(color1, color2);
            scatter(axes, xValues, yValues, 50, colorValues, "filled", "Marker", "hexagram");
        end

        function Distance = DistanceToTrajectory(obj, OtherTrajectory)
            DistanceVector = obj.DistanceVectorToTrajectory(OtherTrajectory);
            Distance = mean(DistanceVector);
        end

        % Find the distance between the perceptual trajectory and another, using
        % uniform shrinking if they don't have the same lengths
        % EXAMPLE: obj.Points is the set of points with coordinates
        % [1;2], [4;5], [10;17], [7;14], [19;2]
        % and OtherTrajectory.Points is the set of points with coordinates
        % [1;4], [5;6], [1;2], [3;2], [5;8], [9;12], [5;6]
        % Resulting point sets that we'll end up comparing should be
        % [1;2], [2;3], [3;4], [4;5], [6;9], [8;13], [10;17], [9;16], [8;15], [7;14], [11;10], [15;6], [19;2]
        % [1;4], [3;5], [5;6], [3;4], [1;2], [2;2], [3;2], [4;5], [5;8], [7;10], [9;12], [7;9], [5;6]
        function DistanceVector = DistanceVectorToTrajectory(obj, OtherTrajectory)
            % FIRST GETTING THE CURRENT COORDINATES INTO A MATRIX FORMAT
            CoordinateLength = length(obj.Points{1,1}.Coordinates);
                % EX| CoordinateLength = 2
            StartingCoordinateListA = zeros(CoordinateLength, length(obj.Points));
                % EX| StartingCoordinateListA = [0 0 0 0 0; 0 0 0 0 0]
            StartingCoordinateListB = zeros(CoordinateLength, length(OtherTrajectory.Points));
                % EX| StartingCoordinateListA = [0 0 0 0 0 0 0; 0 0 0 0 0 0 0]
            for p = 1:length(obj.Points)
                StartingCoordinateListA(:,p) = obj.Points{p,1}.Coordinates;
            end
                % EX| StartingCoordinateListA = [1 4 10 7 19; 2 5 17 14 2]
            for p = 1:length(OtherTrajectory.Points)
                StartingCoordinateListB(:,p) = OtherTrajectory.Points{p,1}.Coordinates;
            end
                % EX| StartingCoordinateListB = [1 5 1 3 5 9 5; 4 6 2 2 8 12 6]

            % MAKING THE NECESSARY INPUTS TO USE TO FIND THE EXPANDED
            % COORDINATES
            LengthOfExpandedPointLists = lcm(length(obj.Points) - 1, ...
                length(OtherTrajectory.Points) - 1) + 1;
                % EX| LengthOfExpandedPointLists = 13
            StepA = (LengthOfExpandedPointLists - 1)/(length(obj.Points) - 1);
                % EX| StepA = (13 - 1)/(5 - 1) = 12/4 = 3
            StepB = (LengthOfExpandedPointLists - 1)/(length(OtherTrajectory.Points) - 1);
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
                ExpandedCoordinateRowA = interp1(StartingInputA, StartingCoordinateRowA, EndingInput);
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
                ExpandedCoordinateRowB = interp1(StartingInputB, StartingCoordinateRowB, EndingInput);
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
