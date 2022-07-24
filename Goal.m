%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHOD LIST
%  Goal
%  ActivationsFromExemplar
%  TempActivations
%  SimpleMacroEstimates

%% OVERALL EXAMPLE
% EXAMPLE: Suppose we have three clusters, Cluster1, Cluster2, and Cluster3 
% which each consist of four junctures and are laid out in the following
% way.
%       
%       MOTOR SPACE                   PERCEPTUAL SPACE
%       2 2 . . . .                   . . . 2 2 .
%       2 2 . . . .                   . . . 2 2 .
%       . . . . . .                   . . . . . .
%       1 1 . 3 3 .                   1 1 . 3 3 .
%       1 1 . 3 3 .                   1 1 . 3 3 .
%
% Suppose the motor silhouette goes approximately from Cluster3 to Cluster1
% to Cluster2.  Suppose the exemplar goes approximately from Cluster3 to
% Cluster1 to Cluster2.
% The details of the coordinates of everything and the space transformation
% are given below.
% EXAMPLE GOAL: Goal1
    % Goal1.Space = Space1
        % Space1.Clusters = {Cluster1; Cluster2; Cluster3}
            % Cluster1.Junctures = {Juncture1a; Juncture1b; Juncture1c; Juncture1d}
                % Juncture1a.MotorPoint.Coordinates = [0; 0]
                % Juncture1a.PerceptualPoint.Coordinates = [0; 0]
                % Juncture1b.MotorPoint.Coordinates = [2; 0]
                % Juncture1b.PerceptualPoint.Coordinates = [2; 0]
                % Juncture1c.MotorPoint.Coordinates = [0; 2]
                % Juncture1c.PerceptualPoint.Coordinates = [0; 2]
                % Juncture1d.MotorPoint.Coordinates = [2; 2]
                % Juncture1d.PerceptualPoint.Coordinates = [2; 2]
            % Cluster2.Junctures = {Juncture2a; Juncture2b; Juncture2c; Juncture2d}
                % Juncture2a.MotorPoint.Coordinates = [0; 6]
                % Juncture2a.PerceptualPoint.Coordinates = [6; 6]
                % Juncture2b.MotorPoint.Coordinates = [2; 6]
                % Juncture2b.PerceptualPoint.Coordinates = [8; 6]
                % Juncture2c.MotorPoint.Coordinates = [0; 8]
                % Juncture2c.PerceptualPoint.Coordinates = [6; 8]
                % Juncture2d.MotorPoint.Coordinates = [2; 8]
                % Juncture2d.PerceptualPoint.Coordinates = [8; 8]
            % Cluster3.Junctures = {Juncture3a; Juncture3b; Juncture3c; Juncture3d}
                % Juncture3a.MotorPoint.Coordinates = [6; 0]
                % Juncture3a.PerceptualPoint.Coordinates = [6; 0]
                % Juncture3b.MotorPoint.Coordinates = [8; 0]
                % Juncture3b.PerceptualPoint.Coordinates = [8; 0]
                % Juncture3c.MotorPoint.Coordinates = [6; 2]
                % Juncture3c.PerceptualPoint.Coordinates = [6; 2]
                % Juncture3d.MotorPoint.Coordinates = [8; 2]
                % Juncture3d.PerceptualPoint.Coordinates = [8; 2]
        % Space1.ClusterSizes = {4; 4; 4}
        % Space1.CanonicalJunctureOrder = {
        %       Juncture1a; Juncture1b; Juncture1c; Juncture1d;
        %       Juncture2a; Juncture2b; Juncture2c; Juncture2d;
        %       Juncture3a; Juncture3b; Juncture3c; Juncture3d}
        % Space1.SpaceTransformation is the function that takes (x,y) as
        %    an input and gives an output of:  (x, y) if y <= 5
        %                                      (x + 6, y) if y > 5 & x < 4
        %                                      (x - 4, y) if y > 5 & x >= 4
        % Space1.MotorBounds = [0 10; 0 10]
        % Space1.MaxDistanceWithActivation = 8
    % Goal1.Silhouette = Silhouette1
        % Silhouette1.Regions = {Region1; Region2; Region3; Region4; Region5; Region6}
            % Region1.Center.Coordinates = [8; 2]
            % Region1.Radius = 2
            % Region2.Center.Coordinates = [6; 2]
            % Region2.Radius = 2
            % Region3.Center.Coordinates = [4; 2]
            % Region3.Radius = 2
            % Region4.Center.Coordinates = [2; 2]
            % Region4.Radius = 2
            % Region5.Center.Coordinates = [2; 4]
            % Region5.Radius = 2
            % Region6.Center.Coordinates = [2; 6]
            % Region6.Radius = 2
    % Goal1.Exemplar = Trajectory1
        % Trajectory1.Points = {P1; P2; P3; P4; P5; P6; P7; P8; P9; P10; P11; P12}
        % P1.Coordinates = [8; 1]
        % P2.Coordinates = [7; 1]
        % P3.Coordinates = [6; 1]
        % P4.Coordinates = [5; 1]
        % P5.Coordinates = [4; 1]
        % P6.Coordinates = [3; 1]
        % P7.Coordinates = [2; 1]
        % P8.Coordinates = [2; 2]
        % P9.Coordinates = [2; 3]
        % P10.Coordinates = [2; 4]
        % P11.Coordinates = [2; 5]
        % P12.Coordinates = [2; 6]
    % Goal1.TimeLength = 6

%% CLASS DEFINITION
classdef Goal
    %% PROPERTIES
    properties
        Space;
        Silhouette; % The motor part of the goal
        Exemplar; % The perceptual part of the goal
        TimeLength;
    end
    %% METHODS
    methods
        %% CREATE OBJECT
        function obj = Goal(Space, silhouette, exemplar)
            obj.Space = Space;
            obj.Silhouette = silhouette;
            obj.Exemplar = exemplar;
            obj.TimeLength = length(obj.Silhouette.Regions);
        end


        %% ACTIVATION
        %  FUNCTIONS:
        %  TempActivations
        %  ActivationsFromExemplar

        % ACTIVATIONS OF CLUSTERS OVER TIME
        % Returns a cell array that gives the activation of each cluster
        % over time, based on activation from the silhouette and from the
        % exemplar, by using the function
        % Cluster.FindActivationWithWindow for each cluster at each time.
        % The output ActivationsOverTime is such that
        % ActivationsOverTime(c,t) is the activation of the cth cluster at
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
        % Cluster1 to Cluster2.  Suppose the exemplar goes 
        % approximately from Cluster3 to Cluster1 to Cluster2.
        % The details of the coordinates of everything and the space 
        % transformation are given below.
        % Clusters = [Cluster1 Cluster2 Cluster3]
        % Cluster1 Motor Coordinates: [0 2 0 2; 0 0 2 2]
        % Cluster1 Perceptual Coordinates: [0 2 0 2; 0 0 2 2]
        % Cluster2 Motor Coordinates: [0 2 0 2; 6 6 8 8]
        % Cluster2 Perceptual Coordinates: [6 8 6 8; 6 6 8 8]
        % Cluster3 Motor Coordinates: [6 8 6 8; 0 0 2 2]
        % Cluster3 Perceptual Coordinates: [6 8 6 8; 0 0 2 2]
        % The Space Transformation is the function that takes (x,y) as
        %    an input and gives an output of:  (x, y) if y <= 5
        %                                      (x + 6, y) if y > 5 & x < 4
        %                                      (x - 4, y) if y > 5 & x >= 4
        % MaxDistanceWithActivation = 8
        %
        % Silhouette Regions:
        %
        % Region 1: MotorVertexList = [0 0; 0 3; 4 3; 4 0]
        % SimplexMatrix = [1 2 3; 1 3 4],  Weights = [2 8]
        %
        % Region 2: MotorVertexList = [0 0; 0 6; 8 6; 8 0]
        % SimplexMatrix = [1 2 3; 1 3 4],  Weights = [1 1]
        %
        % Region 3: MotorVertexList = [3 4; 3 7; 7 7; 7 4]
        % SimplexMatrix = [1 2 3; 1 3 4],  Weights = [1 4]
        %
        % Exemplar Points: [8 7 6 5 4 3 2 2 2 2 2 2; 
        % 1 1 1 1 1 1 1 2 3 4 5 6]
        % Suppose executionParameters = ExecutionParameters(2, 4)
        function ActivationsOverTime = TempActivations(obj, ...
                executionParameters)
            HighestActivationM = 1;
            DropoffSlopeM = HighestActivationM/obj.Space.MaxDistanceWithActivationM;
            HighestActivationP = 1;
            DropoffSlopeP = HighestActivationP/obj.Space.MaxDistanceWithActivationP;
                % EX| DropoffSlope = 0.1
            % Initializing output
            ActivationsOverTime = nan(length(obj.Space.Clusters), ...
                obj.TimeLength);
                % EX| ActivationsOverTime = [NaN NaN NaN;
                %                            NaN NaN NaN;
                %                            NaN NaN NaN;
                %                            NaN NaN NaN;
                %                            NaN NaN NaN;
                %                            NaN NaN NaN]
            % Go through each cluster
            for clusterIndex = 1:length(obj.Space.Clusters)
                % EX| for clusterIndex = 1:3
                cluster = obj.Space.Clusters(clusterIndex);
                    % EX| clusterIndex = 1 : cluster = Cluster1
                    % EX| clusterIndex = 2 : cluster = Cluster2
                    % EX| clusterIndex = 3 : cluster = Cluster3
                % Go through each time
                for timeIndex = 1:length(obj.Silhouette.Regions)
                    % EX| timeIndex = 1:6
                    ActivationsOverTime(clusterIndex, timeIndex) = ...
                        cluster.FindActivationWithWindow(...
                        obj.Silhouette, obj.Exemplar, timeIndex, ...
                        executionParameters.LookBackAmount, ...
                        executionParameters.LookAheadAmount, ...
                        HighestActivationM, DropoffSlopeM, ...
                        HighestActivationP, DropoffSlopeP);
                end
            end
        end

        % ACTIVATIONS OF CLUSTER FROM EXEMPLAR
        % Gives the activations of the clusters from just the exemplar, 
        % based on the function Cluster.FindExemplarActivationSum.  The
        % output Activation is such that Activations{c, 1} is the 
        % activation of the cth cluster.  There is no time element to this
        % function because the activation from the exemplar is not
        % temporal.
        function Activations = ActivationsFromExemplar(obj)
            Activations = nan(1, length(obj.Space.Clusters));
            HighestActivation = 1;
            DropoffSlope = HighestActivation/obj.Space.MaxDistanceWithActivationP;
            for c = 1:length(obj.Space.Clusters)
                CurrentCluster = obj.Space.Clusters(c);
                Activations(c) = ...
                    CurrentCluster.FindExemplarActivation( ...
                    obj.Exemplar, HighestActivation, DropoffSlope);
            end
        end


        %% ESTIMATES
        %  FUNCTIONS:
        %  SimpleMacroEstimates

        % EXTERNAL LOCATION ESTIMATES, OVER TIME
        % EXAMPLE
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
        % Cluster1 to Cluster2.  Suppose the exemplar goes 
        % approximately from Cluster3 to Cluster1 to Cluster2.
        % The details of the coordinates of everything and the space 
        % transformation are given below.
        % Clusters = [Cluster1 Cluster2 Cluster3]
        % Cluster1 Motor Coordinates: [0 2 0 2; 0 0 2 2]
        % Cluster1 Perceptual Coordinates: [0 2 0 2; 0 0 2 2]
        % Cluster2 Motor Coordinates: [0 2 0 2; 6 6 8 8]
        % Cluster2 Perceptual Coordinates: [6 8 6 8; 6 6 8 8]
        % Cluster3 Motor Coordinates: [6 8 6 8; 0 0 2 2]
        % Cluster3 Perceptual Coordinates: [6 8 6 8; 0 0 2 2]
        % The Space Transformation is the function that takes (x,y) as
        %    an input and gives an output of:  (x, y) if y <= 5
        %                                      (x + 6, y) if y > 5 & x < 4
        %                                      (x - 4, y) if y > 5 & x >= 4
        % MaxDistanceWithActivation = 8
        %
        % Silhouette Regions:
        %
        % Region 1: MotorVertexList = [0 0; 0 3; 4 3; 4 0]
        % SimplexMatrix = [1 2 3; 1 3 4],  Weights = [2 8]
        %
        % Region 2: MotorVertexList = [0 0; 0 6; 8 6; 8 0]
        % SimplexMatrix = [1 2 3; 1 3 4],  Weights = [1 1]
        %
        % Region 3: MotorVertexList = [3 4; 3 7; 7 7; 7 4]
        % SimplexMatrix = [1 2 3; 1 3 4],  Weights = [1 4]
        %
        % Exemplar Points: [8 7 6 5 4 3 2 2 2 2 2 2; 
        % 1 1 1 1 1 1 1 2 3 4 5 6]
        % Suppose executionParameters = ExecutionParameters(2, 4)
        function [AverageJunctureEstimates, FinalJunctureActivationValues] = ...
                SimpleMacroEstimates(obj, executionParameters)
            % Initializing
            ClusterActivations = obj.TempActivations(executionParameters);
            FinalJunctureActivationValues = nan( ...
                length(obj.Space.CanonicalJunctureOrder), obj.TimeLength);
            AverageJunctureEstimates = Juncture.empty(0, obj.TimeLength);

            for t = 1:obj.TimeLength
                CurrentJunctureActivations = ...
                    obj.Space.ClusterToJunctureActivations( ...
                    ClusterActivations(:, t));
                AverageFauxJuncture = obj.Space.AverageJuncture( ...
                    CurrentJunctureActivations);
                FinalJunctureActivationValues(:, t) = ...
                    CurrentJunctureActivations;
                % If all the activations are zero, we can't find an average
                % juncture
                if all(AverageFauxJuncture.MotorPoint.Coordinates == ...
                        -1000000 * ones(size( ...
                        AverageFauxJuncture.MotorPoint.Coordinates)))
                    fprintf("Activations are all zero at time %d \n", t);
                    % So if all activations are zero and it's the first
                    % time step, we 
                    if (t == 1)
                        AverageJunctureEstimates(t) = Juncture( ...
                            MotorPoint(-1 * ones(size( ...
                            AverageFauxJuncture.MotorPoint.Coordinates))), ...
                            PerceptualPoint(-1 * ones(size( ...
                            AverageFauxJuncture.MotorPoint.Coordinates))));
                    else
                        AverageJunctureEstimates(t) = ...
                            AverageJunctureEstimates(t-1);
                    end
                else
                    AverageJunctureEstimates(t) = AverageFauxJuncture;
                end
            end
        end
    end
end

