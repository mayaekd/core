%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHOD LIST
%
%  Cluster
%
%  ACTIVATION
%  FindActivation
%  FindSilhouetteActivation
%  FindExemplarActivation
%  FindActivationWithWindow
%
%  ACTIVATION SETTINGS
%  DistanceToActivationMap
%  DistanceToActivationMapLinear
%  CombineActivation
%
%  CENTROIDS FOR CLUSTER FORCES
%  Center
%  Center_AverageJunctureAll
%
%  PLOTTING INFO
%  MotorPlottingInfo
%  PerceptualPlottingInfo
%
%  PLOTTING
%  PlotMotor
%  PlotPerceptual

%% CLASS DEFINITION
classdef Cluster
    % A cluster consists of a cell array of its junctures
    properties
        MotorCoordinateMatrix;
        PerceptualCoordinateMatrix;
        Junctures;
        xMotor; % For plotting
        yMotor; % For plotting
        zMotor; % For plotting
        xPerceptual; % For plotting
        yPerceptual; % For plotting
        zPerceptual; % For plotting
    end
    
    methods
        % Create object
         function obj = Cluster(MotorCoordinateMatrix, ...
                PerceptualCoordinateMatrix, CoordinateOptions)
            arguments
                MotorCoordinateMatrix (:,:) {mustBeNumeric}
                PerceptualCoordinateMatrix (:,:) {mustBeNumeric}
                CoordinateOptions.xMotorRowIndex {mustBeNumeric} = 1
                CoordinateOptions.yMotorRowIndex {mustBeNumeric} = 2
                CoordinateOptions.zMotorRowIndex {mustBeNumeric} = nan
                CoordinateOptions.xPerceptualRowIndex {mustBeNumeric} = 1
                CoordinateOptions.yPerceptualRowIndex {mustBeNumeric} = 2
                CoordinateOptions.zPerceptualRowIndex {mustBeNumeric} = nan
                CoordinateOptions.xMotor (1,:) = nan
                CoordinateOptions.yMotor (1,:) = nan
                CoordinateOptions.zMotor (1,:) = nan
                CoordinateOptions.xPerceptual (1,:) = nan
                CoordinateOptions.yPerceptual (1,:) = nan
                CoordinateOptions.zPerceptual (1,:) = nan
            end
            assert(size(MotorCoordinateMatrix, 2) == ...
                size(PerceptualCoordinateMatrix, 2), "The " + ...
                "MotorCoordinateMatrix and " + ...
                "PerceptualCoordinateMatrix have to correspond to " + ...
                "the same number of points as each other but " + ...
                "MotorCoordinateMatrix defines " + ...
                size(MotorCoordinateMatrix, 2) + " points and " + ...
                "PerceptualCoordinateMatrix defines " + ...
                size(PerceptualCoordinateMatrix, 2) + " points.")
            obj.MotorCoordinateMatrix = MotorCoordinateMatrix;
            obj.PerceptualCoordinateMatrix = PerceptualCoordinateMatrix;

            %% Motor coordinate plotting info
            % If xMotorRowIndex or yMotorRowIndex is nan, override it
            if isnan(CoordinateOptions.xMotorRowIndex)
                xMotorRowIndex = 1;
            else
                xMotorRowIndex = CoordinateOptions.xMotorRowIndex;
            end
            if isnan(CoordinateOptions.xMotorRowIndex)
                yMotorRowIndex = 2;
            else
                yMotorRowIndex = CoordinateOptions.yMotorRowIndex;
            end
            % Set obj.xMotor and obj.yMotor based on the indices
            obj.xMotor = MotorCoordinateMatrix(xMotorRowIndex, :);
            obj.yMotor = MotorCoordinateMatrix(yMotorRowIndex, :);
            if isnan(CoordinateOptions.zMotorRowIndex)
                obj.zMotor = nan;
            else
                obj.zMotor = MotorCoordinateMatrix(CoordinateOptions.zMotorRowIndex, :);
            end
            % If there are provided plotting coordinates, override with
            % them
            if ~isnan(CoordinateOptions.xMotor)
                obj.xMotor = CoordinateOptions.xMotor;
            end
            if ~isnan(CoordinateOptions.yMotor)
                obj.yMotor = CoordinateOptions.yMotor;
            end
            if ~isnan(CoordinateOptions.zMotor)
                obj.zMotor = CoordinateOptions.zMotor;
            end

            %% Perceptual coordinate plotting info
            % If xPerceptualRowIndex or yPerceptualRowIndex is nan, override it
            if isnan(CoordinateOptions.xPerceptualRowIndex)
                xPerceptualRowIndex = 1;
            else
                xPerceptualRowIndex = CoordinateOptions.xPerceptualRowIndex;
            end
            if isnan(CoordinateOptions.xPerceptualRowIndex)
                yPerceptualRowIndex = 2;
            else
                yPerceptualRowIndex = CoordinateOptions.yPerceptualRowIndex;
            end
            % Set obj.xPerceptual and obj.yPerceptual based on the indices
            obj.xPerceptual = PerceptualCoordinateMatrix( ...
                xPerceptualRowIndex, :);
            obj.yPerceptual = PerceptualCoordinateMatrix( ...
                yPerceptualRowIndex, :);
            if isnan(CoordinateOptions.zPerceptualRowIndex)
                obj.zPerceptual = nan;
            else
                obj.zPerceptual = PerceptualCoordinateMatrix( ...
                    CoordinateOptions.zPerceptualRowIndex, :);
            end
            % If there are provided plotting coordinates, override with
            % them
            if ~isnan(CoordinateOptions.xPerceptual)
                obj.xPerceptual = CoordinateOptions.xPerceptual;
            end
            if ~isnan(CoordinateOptions.yPerceptual)
                obj.yPerceptual = CoordinateOptions.yPerceptual;
            end
            if ~isnan(CoordinateOptions.zPerceptual)
                obj.zPerceptual = CoordinateOptions.zPerceptual;
            end
            %% Juncture list
            JunctureList = Juncture.empty(0, size( ...
                MotorCoordinateMatrix, 2));
            for j = 1:size(MotorCoordinateMatrix, 2)
                motorPoint = MotorPoint(MotorCoordinateMatrix(:,j), ...
                    "xCoordinates", obj.xMotor, ...
                    "yCoordinates", obj.yMotor, ...
                    "zCoordinates", obj.zMotor);
                perceptualPoint = PerceptualPoint( ...
                    PerceptualCoordinateMatrix(:,j), "xCoordinates", ...
                    obj.xPerceptual, "yCoordinates", obj.yPerceptual, ...
                    "zCoordinates", obj.zPerceptual);
                JunctureList(j) = Juncture(motorPoint, perceptualPoint);
            end
            obj.Junctures = JunctureList;
        end
        
        %% ACTIVATION
        %  FUNCTIONS:
        %  FindActivation
        %  FindSilhouetteActivation
        %  FindExemplarActivation
        %  FindActivationWithWindow

        % COMBINED ACTIVATION
        % Finding activation from a silhouette and a perceptual trajectory,
        % at a certain time.  Have to decide whether we use
        % FindTrajectoryActivationSum or some other function
        function Activation = FindActivation(obj, Silhouette, Time, ...
                Exemplar, HighestActivationM, DropoffSlopeM, ...
                HighestActivationP, DropoffSlopeP)
            % The function used here to find the activation from the
            % silhouette could be changed to something different
            % FIX!!!!
            SilhouetteActivation = obj.FindSilhouetteActivation( ...
                Silhouette, Time, HighestActivationM, DropoffSlopeM);
            % The function used here to find the activation from the
            % trajectory could be changed to something different
            ExemplarActivation = obj.FindExemplarActivation(...
                Exemplar, HighestActivationP, DropoffSlopeP);
            % The function used here to combined the activations could be
            % changed to something different
            Activation = obj.CombineActivation(SilhouetteActivation, ...
                ExemplarActivation);
        end
        
        % FROM SILHOUETTE AT SPECIFIC TIME (I.E. FROM MOTOR REGION)
        % Finding activation of the cluster that comes from just a 
        % silhouette at a certain time, based on the distance between the
        % cluster and the silhouette at that time.
        % MAKE THIS FASTER IN THE FUTURE WITH USING THE MOTOR COORDINATE
        % MATRIX
        function Activation = FindSilhouetteActivation(obj, Silhouette, ...
                Time, HighestActivation, DropoffSlope)
            Activation = Silhouette.Regions( ...
                Time).ActivationOfMotorMatrix( ...
                obj.MotorCoordinateMatrix, HighestActivation, ...
                DropoffSlope);
        end

        function Activation = FindExemplarActivation(obj, Exemplar, ...
                HighestActivation, DropoffSlope)
            Activation = Exemplar.ActivationOfPerceptualMatrix( ...
                obj.PerceptualCoordinateMatrix, HighestActivation, ...
                DropoffSlope);
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
                Exemplar, Time, LookBackWindow, LookAheadWindow, ...
                HighestActivationM, DropoffSlopeM, ...
                HighestActivationP, DropoffSlopeP)
            % Need to fix this but for now, the window size will just be
            % determined in terms of number of points forward in the
            % silhouette
            ActivationSum = 0;
            TemporalSum = 0;
            for SilhouetteRegion = 1:length(Silhouette.Regions)
                % EX| for SilhouetteRegion = 1:6
                DistanceFromCurrentTimeToRegion = SilhouetteRegion - Time;

                % The amount of influence, based on its temoral distance, 
                % that this part of the silhouette has on the cluster
                TemporalActivationScalar = ...
                    Silhouette.DropoffScalar( ...
                    DistanceFromCurrentTimeToRegion, ...
                    LookAheadWindow, LookBackWindow);
                % The amount of influence, based on its spatial distance
                % from the cluster, that this part of the silhouette has on
                % the cluster -- the more raw effect of the silhouette on
                % activating the cluster
                RawActivationScalar = obj.FindActivation(...
                    Silhouette, SilhouetteRegion, Exemplar, ...
                    HighestActivationM, DropoffSlopeM, ...
                    HighestActivationP, DropoffSlopeP);
                % Overall activation that will get added to the cluster
                % from this region of the silhouette
                AdditionalActivation = ...
                    TemporalActivationScalar * RawActivationScalar;
                % Add this to the total activation
                ActivationSum = ActivationSum + AdditionalActivation;
                TemporalSum = TemporalSum + TemporalActivationScalar;
            end
            Activation = ActivationSum / TemporalSum;
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
            Activation = max(0, HighestActivation - ( ...
                DropoffSlope * Distance));
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
            Activation = (SilhouetteActivation^me * ...
                PerceptualActivation^pe)^(1/RootDenominator);
%             Activation = SilhouetteActivation + PerceptualActivation;
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
            MPoint = MotorPoint(mean(obj.MotorCoordinateMatrix, 2));
                % EX| MPoint = MotorPoint([5; 1])
            PPoint = PerceptualPoint(mean(obj.PerceptualCoordinateMatrix, 2));
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
            xValues = obj.xMotor;
            yValues = obj.yMotor;
            ColorValues = zeros(length(xValues),3);
            for i = 1:length(xValues)
                ColorValues(i,:) = color;
            end
        end
        
        % Perceptual plotting info -- arrays of xValues, yValues, and
        % ColorValues ready for the scatter function.
        function [xValues, yValues, ColorValues] = ...
                PerceptualPlottingInfo(obj, color)
            % Initialize coordinate lists
            xValues = obj.xPerceptual;
            yValues = obj.yPerceptual;
            ColorValues = zeros(length(xValues),3);
            for i = 1:length(xValues)
                ColorValues(i,:) = color;
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