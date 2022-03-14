%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHOD LIST
%  FindActivation
%  FindSilhouetteActivation
%  FindTrajectoryActivationSum
%  FindActivationWithWindow
%  DistanceToActivationMap
%  DistanceToActivationMapLinear
%  CombineActivation
%  AverageDistanceToTrajectory
%  AverageDistanceToSilhouette
%  AverageDistanceToPoint
%  Center
%  Center_AverageJunctureAll
%  MotorPlottingInfo
%  PerceptualPlottingInfo
%  PlotMotor
%  PlotPerceptual

%% CLASS DEFINITION
classdef Cluster
    % A cluster consists of a cell array of its junctures
    properties
        Junctures;
        MotorCoordinateMatrix;
        PerceptualCoordinateMatrix;
    end
    
    methods
        % Create object
        function obj = Cluster(JunctureCellArray)
            obj.Junctures = JunctureCellArray;
            MotorCoordinateMatrix = zeros(length( ...
                JunctureCellArray{1,1}.MotorPoint.Coordinates), ...
                length(JunctureCellArray));
            PerceptualCoordinateMatrix = zeros(length( ...
                JunctureCellArray{1,1}.PerceptualPoint.Coordinates), ...
                length(JunctureCellArray));
            for j = 1:length(JunctureCellArray)
                MotorCoordinateMatrix(:,j) = JunctureCellArray{j,1}.MotorPoint.Coordinates;
                PerceptualCoordinateMatrix(:,j) = JunctureCellArray{j,1}.PerceptualPoint.Coordinates;
            end
            obj.MotorCoordinateMatrix = MotorCoordinateMatrix;
            obj.PerceptualCoordinateMatrix = PerceptualCoordinateMatrix;
        end
        
        %% ACTIVATION
        %  FUNCTIONS:
        %  FindActivation
        %  FindSilhouetteActivation
        %  FindTrajectoryActivationSum
        %  FindActivationWithWindow

        % COMBINED ACTIVATION
        % Finding activation from a silhouette and a perceptual trajectory,
        % at a certain time.  Have to decide whether we use
        % FindTrajectoryActivationSum or some other function
        function Activation = FindActivation(obj, Silhouette, Time, ...
                Trajectory, HighestActivation, DropoffSlope)
            % The function used here to find the activation from the
            % silhoeutte could be changed to something different
            SilhouetteActivation = obj.FindSilhouetteActivation(...
                Silhouette, Time, HighestActivation, DropoffSlope);
            % The function used here to find the activation from the
            % trajectory could be changed to something different
            TrajectoryActivation = obj.FindTrajectoryActivationAverage(...
                Trajectory, HighestActivation, DropoffSlope);
            % The function used here to combined the activations could be
            % changed to something different
            Activation = obj.CombineActivation(SilhouetteActivation, TrajectoryActivation);
        end
        
        % FROM SILHOUETTE AT SPECIFIC TIME (I.E. FROM MOTOR REGION)
        % Finding activation of the cluster that comes from just a 
        % silhouette at a certain time, based on the distance between the
        % cluster and the silhouette at that time.
        function Activation = FindSilhouetteActivation(obj, Silhouette, ...
                Time, HighestActivation, DropoffSlope)
            Activation = obj.DistanceToActivationMapLinear(...
                obj.AverageDistanceToSilhouette(Silhouette, Time), ...
                HighestActivation, DropoffSlope);
        end
        
        % FROM TRAJECTORY -- SUMMED & CAPPED AT 1
        % Finding the sum of activations from the cluster to each point on
        % the perceptual trajectory, and putting a cap on activation at 1
        function Activation = FindTrajectoryActivationSum(obj, ...
                Trajectory, HighestActivation, DropoffSlope)
            SumOfActivations = 0;
            
            % Find activation for each point based on each point's
            % individual distance from the cluster
            for i = 1:length(Trajectory.Points)
                point = Trajectory.Points{i,1};
                dist = obj.AverageDistanceToPoint(point);
                AdditionalActivation = obj.DistanceToActivationMapLinear(dist, ...
                    HighestActivation, DropoffSlope);
                SumOfActivations = SumOfActivations + AdditionalActivation;
            end
            
            % Capping activation at 1
            Activation = min(SumOfActivations,1);
        end
        
        
        % FROM TRAJECTORY -- SUMMED & CAPPED AT 1
        % Finding the sum of activations from the cluster to each point on
        % the perceptual trajectory, and putting a cap on activation at 1
        function Activation = FindTrajectoryActivationAverage(obj, ...
                Trajectory, HighestActivation, DropoffSlope)
            SumOfActivations = 0;
            
            % Find activation for each point based on each point's
            % individual distance from the cluster
            for i = 1:length(Trajectory.Points)
                point = Trajectory.Points{i,1};
                dist = obj.AverageDistanceToPoint(point);
                AdditionalActivation = obj.DistanceToActivationMapLinear(dist, ...
                    HighestActivation, DropoffSlope);
                SumOfActivations = SumOfActivations + AdditionalActivation;
            end
            
            % Finding average
            Activation = SumOfActivations/length(Trajectory.Points);
        end
        
        % Finding activation from a silhouette and a perceptual trajectory,
        % at a certain time & including a lookahead window & lookback
        % window
        % Returns a cell array that gives the activation of each cluster
        % over time, based on activation from the silhouette and from the
        % perceptual trajectory, by using the function
        % Cluster.FindActivationWithWindow for each cluster at each time.
        % The output ActivationsOverTime is such that
        % ActivationsOverTime{t, c} is the activation of the cth cluster at
        % time t.
        % EXAMPLE: Suppose we have three clusters, Cluster1, Cluster2, and 
        % Cluster3 which each consist of four junctures and are laid out in
        % the following way.
        %       
        %       MOTOR SPACE                   PERCEPTUAL SPACE
        %       2 2 . . . .                   . . . 2 2 .
        %       2 2 . . . .                   . . . 2 2 .
        %       . . . . . .                   . . . . . .
        %       1 1 . 3 3 .                   1 1 . 3 3 .
        %       1 1 . 3 3 .                   1 1 . 3 3 .
        %
        % Suppose the motor silhouette goes approximately from Cluster3 to 
        % Cluster1 to Cluster2.  Suppose the perceptual trajectory goes 
        % approximately from Cluster3 to Cluster1 to Cluster2.
        % The details of the coordinates of everything and the space 
        % transformation are given below.
        % Clusters = {Cluster1; Cluster2; Cluster3}
        % Cluster1 Motor Coordinates: {[0; 0] [2; 0] [0; 2] [2; 2]}
        % Cluster1 Perceptual Coordinates: {[0; 0] [2; 0] [0; 2] [2; 2]}
        % Cluster2 Motor Coordinates: {[0; 6] [2; 6] [0; 8] [2; 8]}
        % Cluster2 Perceptual Coordinates: {[6; 6] [8; 6] [6; 8] [8; 8]}
        % Cluster3 Motor Coordinates: {[6; 0] [8; 0] [6; 2] [8; 2]}
        % Cluster3 Perceptual Coordinates: {[6; 0] [8; 0] [6; 2] [8; 2]}
        % The Space Transformation is the function that takes (x,y) as
        %    an input and gives an output of:  (x, y) if y <= 5
        %                                      (x + 6, y) if y > 5 & x < 4
        %                                      (x - 4, y) if y > 5 & x >= 4
        % MotorBounds = [0 10; 0 10]
        % MaxDistanceWithActivation = 8
        % Silhouette Region Centers: {[8; 2] [6; 2] [4; 2] [2; 2] [2; 4] [2; 6]}
        % Silhouette Region Radiuses: 2
        % Trajectory Points: {[8; 1] [7; 1] [6; 1] [5; 1] [4; 1] [3; 1] 
        % [2; 1] [2; 2] [2; 3] [2; 4] [2; 5] [2; 6]}
        % Suppose LookBackWindow = 2, LookAheadWindow = 4,
        % HighestActivation = 1, DropoffSlope = 0.125, and we'll show
        % Time = 1, 2, 3, 4, 5, 6
        function Activation = FindActivationWithWindow(obj, Silhouette, ...
                Trajectory, Time, LookBackWindow, LookAheadWindow, ...
                HighestActivation, DropoffSlope)
            % Need to fix this but for now, the window size will just be
            % determined in terms of number of points forward in the
            % silhouette
            Activation = 0;
            for SilhouetteRegion = 1:length(Silhouette.Regions)
                % EX| for SilhouetteRegion = 1:6
                DistanceFromCurrentTimeToRegion = SilhouetteRegion - Time;

                % The amount of influence, based on its temoral distance, 
                % that this part of the silhouette has on the cluster
                TemporalActivationScalar = ...
                    Silhouette.DropoffScalar(DistanceFromCurrentTimeToRegion, ...
                    LookAheadWindow, LookBackWindow);
                % The amount of influence, based on its spatial distance
                % from the cluster, that this part of the silhouette has on
                % the cluster -- the more raw effect of the silhouette on
                % activating the cluster
                RawActivationScalar = obj.FindActivation(...
                    Silhouette, SilhouetteRegion, Trajectory, ...
                    HighestActivation, DropoffSlope);
                % Overall activation that will get added to the cluster
                % from this region of the silhouette
                AdditionalActivation = ...
                    TemporalActivationScalar * RawActivationScalar;
                % Add this to the total activation
                Activation = Activation + AdditionalActivation;
            end
        end
        
        %% ACTIVATION SETTINGS
        %  FUNCTIONS:
        %  DistanceToActivationMap
        %  DistanceToActivationMapLinear
        %  CombineActivation
        
        % DISTANCE -> ACTIVATION DEFAULT
        % Takes as an input a distance between a cluster and region or a
        % cluster and trajectory, and gives as an output the amount of
        % activation a cluster gets from a trajectory or region that
        % distance away
        function Activation = DistanceToActivationMap(obj, Distance)
            Activation = obj.DistanceToActivationMapLinear(Distance, ...
                1, 0.1);
        end

        % DISTANCE -> ACTIVATION LINEAR
        function Activation = DistanceToActivationMapLinear(~, ...
                Distance, HighestActivation, DropoffSlope)
            Activation = max(0, HighestActivation - (DropoffSlope * Distance));
        end
        
        % SILHOUETTE ACTIVATION & TRAJECTORY ACTIVATION -> ACTIVATION
        % Function for combining activation from silhouette (this applies 
        % to just a certain time) and activation from a perceptual
        % trajectory (doesn't vary over time)
        function Activation = CombineActivation(~, ...
                SilhouetteActivation, PerceptualActivation)
            % Silhouette exponent
            me = 3;
            % Perceptual trajectory exponent
            pe = 3;
            % Root denominator
            RootDenominator = me + pe;
            Activation = (SilhouetteActivation^me * PerceptualActivation^pe)^(1/RootDenominator);
        end
        
        %% DISTANCE FUNCTIONS
        %  FUNCTIONS:
        %  AverageDistanceToTrajectory
        %  AverageDistanceToSilhouette
        %  AverageDistanceToPoint
        
        % TRAJECTORY (MOTOR OR PERCEPTUAL)
        % Finding the average distance between the cluster and a trajectory 
        % (will be used for perceptual trajectories, but the function can 
        % be general) -- the average of the distances between every pair of
        % (juncture from cluster) & (point on trajectory)
        function dist = AverageDistanceToTrajectory(obj, Trajectory)
            % For each point in the trajectory, find the distance between
            % the cluster and that point.  The distance from the cluster to
            % each point is from the function AverageDistanceToPoint, which
            % finds the average of the distances from each juncture in the
            % cluster to that point.
            SumOfDistances = 0;
            for i = 1:length(Trajectory.Points)
                SumOfDistances = SumOfDistances + ...
                    obj.AverageDistanceToPoint(Trajectory.Points{i,1});
            end
            % Take the average
            dist = SumOfDistances/length(Trajectory.Points);
        end
        
        % SILHOUETTE AT SPECIFIED TIME (I.E. REGION)
        % Finding the average distance betwween the cluster and a 
        % silhouette at a certain time (which corresponds to a certain 
        % region in that silhouette)
        function dist = AverageDistanceToSilhouette(obj, Silhouette, Time)
            % For right now, takes the average of the distances between the
            % region corresponding to Time and each of the junctures.  The 
            % distance between the region and a juncture is comes from a
            % method for the MotorRegionTemp object.
            %
            RegionCenter = Silhouette.Regions{Time,1}.Center.Coordinates;
            DistFromCenter = sqrt(sum((obj.MotorCoordinateMatrix - RegionCenter).^2,1));
            TrueDist = max(0, DistFromCenter - Silhouette.Regions{Time,1}.Radius);
            dist = mean(TrueDist);
%             SumOfDistances = 0;
%             for i = 1:length(obj.Junctures)
%                 SumOfDistances = SumOfDistances + Silhouette.Regions{...
%                     Time,1}.DistanceToJuncture(obj.Junctures{i,1}); 
%             end
%             dist = SumOfDistances/length(obj.Junctures);
        end

        
        % POINT (MOTOR OR PERCEPTUAL)
        % Finding the average distance between the cluster and a point 
        % (average of the distance between the point and each juncture in 
        % the cluster)
        function dist = AverageDistancesToTrajectoryVector(obj, Trajectory)
            % If the point is a motor point
            dist = zeros(1,length(Trajectory.Points));
            for p = 1:length(Trajectory.Points)
                dist(1,p) = obj.AverageDistanceToPoint(Trajectory.Points{p,1});
            end
%             if class(Trajectory) == "MotorTrajectory"
%                 SumOfDistances = 0;
%                 for i = 1:length(obj.Junctures)
%                     SumOfDistances = SumOfDistances + ...
%                         obj.Junctures{i,1}.MotorPoint.Distance(Point);
%                 end
%                 dist = SumOfDistances/length(obj.Junctures);
%             % If the point is a perceptual point
%             elseif class(Trajectory) == "PerceptualTrajectory"
%                 SumOfDistances = 0;
%                 for i = 1:length(obj.Junctures)
%                     SumOfDistances = SumOfDistances + ...
%                         obj.Junctures{i,1}.PerceptualPoint.Distance(Point);
%                 end
%                 dist = SumOfDistances/length(obj.Junctures);
%             end
        end
        
        % POINT (MOTOR OR PERCEPTUAL)
        % Finding the average distance between the cluster and a point 
        % (average of the distance between the point and each juncture in 
        % the cluster)
        function dist = AverageDistanceToPoint(obj, Point)
            % If the point is a motor point
            if class(Point) == "MotorPoint"
                Distances = sqrt(sum((obj.MotorCoordinateMatrix - Point.Coordinates).^2, 1));
                dist = mean(Distances);
            elseif class(Point) == "PerceptualPoint"
                Distances = sqrt(sum((obj.PerceptualCoordinateMatrix - Point.Coordinates).^2, 1));
                dist = mean(Distances);
            end
%             % If the point is a motor point
%             if class(Point) == "MotorPoint"
%                 SumOfDistances = 0;
%                 for i = 1:length(obj.Junctures)
%                     SumOfDistances = SumOfDistances + ...
%                         obj.Junctures{i,1}.MotorPoint.Distance(Point);
%                 end
%                 dist = SumOfDistances/length(obj.Junctures);
%             % If the point is a perceptual point
%             elseif class(Point) == "PerceptualPoint"
%                 SumOfDistances = 0;
%                 for i = 1:length(obj.Junctures)
%                     SumOfDistances = SumOfDistances + ...
%                         obj.Junctures{i,1}.PerceptualPoint.Distance(Point);
%                 end
%                 dist = SumOfDistances/length(obj.Junctures);
%             end
        end
        
        
        %% CENTROIDS FOR CLUSTER FORCES
        %  FUNCTIONS:
        %  Center
        %  Center_AverageJunctureAll
        % This gives the different functions that can be used to determine
        % what the "center of gravity" for a cluster is, that is, where it 
        % pulls towards when it's activated or activated in a certain way.
        % These aren't used for finding distances from the cluster to other
        % things, but it's used when a cluster is exerting some sort of
        % pull, what the exact point is that it's pulling from.
        
        % In general, each "juncture" output is a faux-juncture, in the 
        % sense that its motor point and perceptual point might not in fact
        % actually correspond to each other.
        
        function Centroid = Center(obj)
            % These inputs mode and WeightsOrSubset are 
            Centroid = obj.Center_AverageJunctureAll();
        end
        
        % Average of all the junctures in the cluster.  Faux-juncture.
        % Suppose the cluster consists of the following junctures
        % JUNCTURE  MOTOR COORDINATES   PERCEPTUAL COORDINATES
        % j1        [4; 0]              [8;  20]
        % j2        [6; 0]              [10; 20]
        % j3        [4; 2]              [12; 20]
        % j4        [6; 2]              [14; 20]
        function Centroid = Center_AverageJunctureAll(obj)
            CoordinateSumM = obj.Junctures{1,1}.MotorPoint.Coordinates;
                % EX| CoordinateSumM = [4; 0]
            CoordinateSumP = obj.Junctures{1,1}.PerceptualPoint.Coordinates;
                % EX| CoordinateSumP = [8; 20]
            for i = 2:length(obj.Junctures)
                CoordinateSumM = CoordinateSumM + ...
                    obj.Junctures{i,1}.MotorPoint.Coordinates;
                    % EX| i = 2: CoordinateSumM = [4;0] + [6;0] = [10;0]
                    % EX| i = 3: CoordinateSumM = [10;0] + [4;2] = [14;2]
                    % EX| i = 4: CoordinateSumM = [14;2] + [6;2] = [20;4]
                CoordinateSumP = CoordinateSumP + ...
                    obj.Junctures{i,1}.PerceptualPoint.Coordinates;
                    % EX| i = 2: CoordinateSumP = [8;20] + [10;20] = [18;40]
                    % EX| i = 3: CoordinateSumP = [18;40] + [12;20] = [30;60]
                    % EX| i = 4: CoordinateSumP = [30;60] + [14;20] = [44;80]
            end
            averageM = CoordinateSumM/length(obj.Junctures);
                % EX| averageM = [20; 4] / 4 = [5; 1]
            averageP = CoordinateSumP/length(obj.Junctures);
                % EX| averageP = [30; 60] / 4 = [7.5; 15]
            MPoint = MotorPoint(averageM);
                % EX| MPoint = MotorPoint([5; 1])
            PPoint = PerceptualPoint(averageP);
                % EX| PPoint = PerceptualPoint([7.5; 15])
            Centroid = Juncture(MPoint, PPoint);
        end
        
        
        %% PLOTTING INFO
        %  FUNCTIONS:
        %  MotorPlottingInfo
        %  PerceptualPlottingInfo
        
        % Motor plotting info -- arrays of xValues, yValues, and
        % ColorValues ready for the scatter function.
        function [xValues, yValues, ColorValues] = ...
                MotorPlottingInfo(obj, color)
            % Initialize coordinate lists
            xValues = zeros(size(obj.Junctures));
            yValues = zeros(size(obj.Junctures));
            ColorValues = zeros(length(obj.Junctures),3);
            
            % For each juncture, add the x value, y value & color from the
            % MotorPlottingInfo juncture method to the list
            for i = 1:length(obj.Junctures)
                [xValues(i,1), yValues(i,1), ColorValues(i,:)] = ...
                    obj.Junctures{i,1}.MotorPlottingInfo(color);
            end
        end
        
        % Perceptual plotting info -- arrays of xValues, yValues, and
        % ColorValues ready for the scatter function.
        function [xValues, yValues, ColorValues] = ...
                PerceptualPlottingInfo(obj, color)
            % Initialize coordinate lists
            xValues = zeros(size(obj.Junctures));
            yValues = zeros(size(obj.Junctures));
            ColorValues = zeros(length(obj.Junctures),3);
            
            % For each juncture, add the x value, y value & color from the
            % PerceptualPlottingInfo juncture method to the list
            for i = 1:length(obj.Junctures)
                [xValues(i,1), yValues(i,1), ColorValues(i,:)] = ...
                    obj.Junctures{i,1}.PerceptualPlottingInfo(color);
            end
        end
        
        %% PLOTTING
        %  FUNCTIONS:
        %  PlotMotor
        %  PlotPerceptual
        
        % Plot the cluster (motor)
        function PlotMotor(obj, axes, color)
            [xValues, yValues, ColorValues] = obj.MotorPlottingInfo(color);
            scatter(axes, xValues, yValues, 100, ColorValues, "filled");
        end
        
        % Plot the cluster (perceptual)
        function PlotPerceptual(obj, axes, color)
            [xValues, yValues, ColorValues] = ...
                obj.PerceptualPlottingInfo(color);
            scatter(axes, xValues, yValues, 100, ColorValues, "filled");
        end
        

    end
end