%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS LIST
%  Goal
%  AtoA_Default
%  AtoA_CappedAtOne
%  AtoA_FractionOfMax
%  AtoA_RootFractionOfMax
%  Activations_DefaultFromTraj
%  TempActivations
%  ActivationVector
%  Activations_SumFromTraj
%  SpreadActivationsInMotorSpace
%  SpreadActivationsInPerceptualSpace
%  MotorDistanceSpreadToActivation
%  PerceptualDistanceSpreadToActivation
%  SimpleMacroEstimates
%  SimpleMacroEstimatesWithAdjustments
%  PauseFunction

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
% to Cluster2.  Suppose the perceptual trajectory goes approximately from
% Cluster3 to Cluster1 to Cluster2.
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
    % Goal1.Trajectory = Trajectory1
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

classdef Goal
    %% PROPERTIES
    properties
        Space;
        Silhouette; % The motor part of the goal
        Trajectory; % The perceptual part of the goal
        TimeLength;
    end
    %% METHODS
    methods
        %% CREATE OBJECT
        function obj = Goal(Space, silhouette, trajectory)
            obj.Space = Space;
            obj.Silhouette = silhouette;
            obj.Trajectory = trajectory;
            obj.TimeLength = length(obj.Silhouette.Regions);
        end

        %% ACTIVATION TO ALPHA FUNCTIONS
        % These are all the possible functions that take an activation
        % array as an input and give an alpha array -- an array of opacity 
        % values, for the purposes of plotting -- as an output.  We'll 
        % probably only end up using one but they're all here as options.
        
        % The default funciton that will be called by other functions 
        % outside of this section -- that way we don't have to change the 
        % calls throughout the code -- just change which other function in 
        % this section is called by this function for the activation to
        % alpha map to be changed everywhere
        function AlphaMatrix = AtoA_Default(obj, ActivationMatrix)
            % Change this in order to change map globally
            AlphaMatrix = obj.AtoA_RootFractionOfMax(ActivationMatrix);
        end
        
        % For each activation value, its corresponding alpha is: equal to
        % one, if the activation is >= 1; equal to the activation,
        % otherwise
        function AlphaMatrix = AtoA_CappedAtOne(~, ActivationMatrix)
            % For example: if ActivationMatrix = [1 2; 0.5 0.3] then
            % AlphaMatrix = [1 1; 0.5 0.3]
            AlphaMatrix = min(ActivationMatrix, 1);
        end
        
        % Divides every activation value by the max absolute activation 
        % value so that the max absolute alpha value is 1 -- that is, every
        % alpha is within the range [-1, 1], and one of those endpoints is
        % actually achieved; if the max activation value is 0, this means
        % that all the activations are 0, in which case all the alphas are 
        % set to 0.
        % EXAMPLE -- shown in full here & throughout the code
        % Input matrix: [5 -20; 0 -5]
        % MaxActivation: abs(-20) = 20
        % Normalized matrix: [5 -20; 0 -5]/20 = [0.25 -1; 0 -0.25]
        function AlphaMatrix = AtoA_FractionOfMax(~, ActivationMatrix)
            % EX| ActivationMatrix = [5 -20; 0 -5]
            MaxActivation = max(ActivationMatrix, [], "all");
                % EX| MaxActivation = 20
            if MaxActivation ~= 0
                AlphaMatrix = ActivationMatrix/MaxActivation;
                    % EX| AlphaMatrix = [5 -20; 0 -5]/20 = [0.25 -1; 0 -0.25]
            else % If MaxActivation == 0
                AlphaMatrix = ActivationMatrix; % All zeros
            end
        end
        
        % Divides every activation value by the max absolute activation 
        % value, and then takes the square root (or the negative square 
        % root of the negative, if necessary -- i.e. 0.25 becomes 0.5 and 
        % -0.25 becomes -0.5) so that the max absolute alpha value is 1 -- 
        % that is, every alpha is within the range [-1, 1], and one of 
        % those endpoints is actually achieved; if the max activation value
        % is 0, this means that all the activations are 0, in which case 
        % all the alphas are set to 0.
        % EXAMPLE -- shown in full here & throughout the code
        % Input matrix: [5 -20; 0 -5]
        % MaxActivation: abs(-20) = 20
        % Normalized matrix: [5 -20; 0 -5]/20 = [0.25 -1; 0 -0.25]
        % "Square root" with accomodation for negatives : [0.5 -1; 0 -0.5]
        function AlphaMatrix = AtoA_RootFractionOfMax(~, ActivationMatrix)
            % EX| ActivationMatrix = [5 -20; 0 -5]
            MaxActivation = max(abs(ActivationMatrix), [], "all"); 
                % EX| 20
            if MaxActivation ~= 0
                NormalizedMatrix = ActivationMatrix/MaxActivation; 
                    % EX| NormalizedMatrix = [0.25 -1; 0 -0.25]
                PositiveNormalizedMatrix = abs(NormalizedMatrix);
                    % EX| PositiveNormalizedMatrix = [0.25 1; 0 0.25]
                RootMatrix = sqrt(PositiveNormalizedMatrix);
                    % EX| RootMatrix = [0.5 1; 0 0.5]
                AlphaMatrix = NormalizedMatrix./RootMatrix;
                    % EX| [0.25 -1; 0 -0.25] divided elementwise by 
                    % [0.5 1; 0 0.5] yielding AlphaMatrix = [0.5 -1; 0 -0.5]
            else % If MaxActivation == 0
                AlphaMatrix = ActivationMatrix; % All zeros
            end
        end

        %% ACTIVATION

        function Activations = Activations_DefaultFromTraj(obj)
            Activations = obj.Activations_SumFromTraj();
        end

        % ACTIVATIONS OF CLUSTERS OVER TIME
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
        % Suppose executionParameters = ExecutionParameters(2, 4, "none")
        function ActivationsOverTime = TempActivations(obj, ...
                executionParameters)
            HighestActivation = 1;
            DropoffSlope = HighestActivation/obj.Space.MaxDistanceWithActivation;
                % EX| DropoffSlope = 8
            % Initializing output
            ActivationsOverTime = cell(obj.TimeLength, ...
                length(obj.Space.Clusters));
                % EX| ActivationsOverTime = {[] [] [];
                %                            [] [] [];
                %                            [] [] [];
                %                            [] [] [];
                %                            [] [] [];
                %                            [] [] []}
            % Go through each cluster
            for clusterIndex = 1:length(obj.Space.Clusters)
                % EX| for clusterIndex = 1:3
                cluster = obj.Space.Clusters{clusterIndex};
                    % EX| clusterIndex = 1 : cluster = Cluster1
                    % EX| clusterIndex = 2 : cluster = Cluster2
                    % EX| clusterIndex = 3 : cluster = Cluster3
                % Go through each time
                for timeIndex = 1:length(obj.Silhouette.Regions)
                    % EX| timeIndex = 1:6
                    ActivationsOverTime{timeIndex, clusterIndex} = ...
                        cluster.FindActivationWithWindow(...
                        obj.Silhouette, obj.Trajectory, timeIndex, ...
                        executionParameters.LookBackAmount, ...
                        executionParameters.LookAheadAmount, ...
                        HighestActivation, DropoffSlope);
                        % EX| ActivationsOverTime{1, 1}
                        % EX| ActivationsOverTime{2, 1}
                        % EX| ActivationsOverTime{3, 1}
                        % EX| ActivationsOverTime{4, 1}
                        % EX| ActivationsOverTime{5, 1}
                        % EX| ActivationsOverTime{6, 1}
                        % EX| ActivationsOverTime{1, 2}
                        % EX| ActivationsOverTime{2, 2}
                        % EX| ActivationsOverTime{3, 2}
                        % EX| ActivationsOverTime{4, 2}
                        % EX| ActivationsOverTime{5, 2}
                        % EX| ActivationsOverTime{6, 2}
                        % EX| ActivationsOverTime{1, 3}
                        % EX| ActivationsOverTime{2, 3}
                        % EX| ActivationsOverTime{3, 3}
                        % EX| ActivationsOverTime{4, 3}
                        % EX| ActivationsOverTime{5, 3}
                        % EX| ActivationsOverTime{6, 3}
                end
            end
        end

        % ACTIVATIONS OF JUNCTURES OVER TIME
        % Returns a vector that takes the information from the output of 
        % the TempActivations function and puts it in a format that gives 
        % the activation values for each *juncture* instead of each
        % cluster.  The output Activations is such that 
        % Activaitons{t,1}(j,1) is the activation of the the jth juncture,
        % where the junctures are listed in the canonical juncture order
        function Activations = ActivationVector(obj, executionParameters)

            % Initialize size of output
            Activations = cell(obj.TimeLength, 1);

            % Find activations, just not organized properly
            ActivationsOverTimeMatrix = obj.TempActivations(executionParameters);
            
            % Find the number of junctures that will be plotted and how
            % many are in each cluster
            NumberOfJunctures = length(obj.Space.CanonicalJunctureOrder);

            for t = 1:obj.TimeLength
                % Initialize the size
                ActivationsAtTime = zeros(NumberOfJunctures, 1);

                % Fill in alpha values for each cluster
                for i = 1:length(obj.Space.ClusterSizes)

                    % Starting index in arrays for alpha values to go
                    a = sum(obj.Space.ClusterSizes(1:i-1)) + 1;
                    % Ending index in arrays for alpha values to go
                    b = sum(obj.Space.ClusterSizes(1:i));
    
                    % Set AlphaValues at appropriate indices
                    ActivationsAtTime(a:b,1) = ActivationsOverTimeMatrix{t, i};
                end
                Activations{t,1} = ActivationsAtTime;
            end
        end
        
        % ACTIVATIONS OF CLUSTER FROM TRAJECTORY
        % Gives the activations of the clusters from just the trajectory, 
        % based on the function Cluster.FindTrajectoryActivationSum.  The
        % output Activation is such that Activations{c, 1} is the 
        % activation of the cth cluster.  There is no time element to this
        % function because the activation from the trajectory is not
        % temporal.
        function Activations = Activations_SumFromTraj(obj)
            Activations = obj.Space.Activations_SumFromTraj(obj.Trajectory);
        end

        % TURN JUNCTURE ACTIVATIONS INTO JUNCTURE ACTIVATIONS AFTER MOTOR SPREAD
        % EXAMPLE -- shown here in full as well as throughout the function
        % Suppose this diagram represents motor space,  with two clusters,
        % with activations 3 and 4 repsectively, shown, and the distance 
        % between each non-space character being one.
        % . 3 3 . . . . 4 4
        % . 3 3 . . . . 4 4
        % We'll say the cluster on the left, which we'll call Cluster A, is
        % listed first in the cluster list, and the cluster on the right,
        % Cluster B, is listed second.  Suppose the coordinates shown in
        % this graph are x ranging from 0 to 9 and y ranging from 0 to 1.
        % ActivationsBeforeSpread: [3; 3; 3; 3; 4; 4; 4; 4]
        % ActivationsAfterSpread will be [4.2; 4.2; 4.2; 4.2; 4.9; 4.9; 4.9; 4.9]
        function ActivationsAfterSpread = ...
                SpreadActivationsInMotorSpace(obj, ActivationsBeforeSpread)
            % Initialize
            ActivationsAfterSpread = zeros(size(ActivationsBeforeSpread));
                % EX| ActivationsAfterSpread = [0; 0; 0; 0; 0; 0; 0; 0]
            NIndex = 1;
            for N = 1:length(obj.Space.Clusters)
                % EX| for N = 1:2
                ClusterN = obj.Space.Clusters{N,1};
                    % EX| when N = 1, ClusterN is Cluster A,
                    % EX| when N = 2, ClusterN is Cluster B
                % Central motor point of ClusterN
                MotorCenterN = ClusterN.Centroid.MotorPoint;
                    % EX| when N = 1, MotorCenterN has coordinates that are
                    % EX| the average of all the motor coordinates of the
                    % EX| junctures in Cluster A -- the average of (1,0),
                    % EX| (2,0), (1,1), (2,1).  So MotorCenterN has
                    % EX| coordinates (1.5, 0.5).
                    % EX| Similarly, when N = 2, MotorCenterN has
                    % EX| coordinates (8.5, 0.5).
                % Activation multiplier vector for activation from ClusterN
                ActivationMultiplierN = zeros(size(ActivationsBeforeSpread));
                    % EX| ActivationMultiplierN = [0; 0; 0; 0; 0; 0; 0; 0]
                MIndex = 1;
                for M = 1:length(obj.Space.Clusters)
                    % Finding the activation multiplier ClusterN gives to ClusterM
                    ClusterM = obj.Space.Clusters{M,1};
                        % EX| when M = 1, ClusterM is Cluster A,
                        % EX| when M = 2, ClusterM is Cluster B
                    MotorCenterM = ClusterM.Centroid.MotorPoint;
                        % EX| when M = 1, MotorCenterM has cooridnates
                        % EX| (1.5,0.5); when M = 2, MotorCenterM has
                        % EX| coordinates (8.5,0.5)
                    ClusterDistance = MotorCenterN.Distance(MotorCenterM);
                        % EX| when N = 1 & M = 1: the distance between the
                        % EX| center of Cluster A & the center of Cluster A
                        % EX| when N = 1 & M = 2: the distance between the
                        % EX| center of Cluster A & the center of Cluster B
                        % EX| when N = 2 & M = 1: the distance between the
                        % EX| center of Cluster B & the center of Cluster A
                        % EX| when N = 2 & M = 2: the distance between the
                        % EX| center of Cluster B & the center of Cluster B
                        % EX| THAT IS:
                        % EX| N = 1 & M = 1: ClusterDistance = 0
                        % EX| N = 1 & M = 2: ClusterDistance = 7
                        % EX| N = 2 & M = 1: ClusterDistance = 7
                        % EX| N = 2 & M = 2: ClusterDistance = 0

                    SpreadActivation = obj.MotorSpreadDistanceToActivation(ClusterDistance);
                        % EX| if obj.MotorSpreadDistanceToActivation(...
                        % EX| Distance) = max(0, 1 - (0.1 * Distance));
                        % EX| N = 1 & M = 1: SpreadActivation = 1
                        % EX| N = 1 & M = 2: SpreadActivation = 0.3
                        % EX| N = 2 & M = 1: SpreadActivation = 0.3
                        % EX| N = 2 & M = 2: SpreadActivation = 1

                    % Replacing the activation values at all the indices of
                    % junctures in ClusterM with the appropriate activation
                    MEndIndex = MIndex + obj.Space.ClusterSizes(M,1) - 1;
                        % EX| when M = 1, MEndIndex = 1 + 4 - 1 = 4
                        % EX| when M = 2, MEndIndex = 5 + 4 - 1 = 8
                    ActivationMultiplierN(MIndex:MEndIndex,1) = SpreadActivation;
                        % EX| when M = 1, set ActivationMultiplierN(1:4),
                        % EX| when M = 2, set ActivationMultiplierN(5:8)
                    % Incrementing for the next ClusterM
                    MIndex = MEndIndex + 1;
                        % EX| when M = 1, MIndex = 4 + 1 = 5
                        % EX| when M = 2, MIndex = 8 + 1 = 9 (not used)
                end
                    % EX| after above for loop:
                    % EX| when N = 1, ActivationMultiplierN = 
                    % EX| [1; 1; 1; 1; 0.3; 0.3; 0.3; 0.3] and
                    % EX| when N = 2, ActivationMultiplierN = 
                    % EX| [0.3; 0.3; 0.3; 0.3; 1; 1; 1; 1]
                ClusterNActivation = ActivationsBeforeSpread(NIndex);
                    % EX| when N = 1, ClusterNActivation = 3,
                    % EX| when N = 2, ClusterNActivation = 4
                ActivationsAfterSpread = ActivationsAfterSpread + (ClusterNActivation * ActivationMultiplierN);
                    % EX| when N = 1, ActivationsAfterSpread = 
                    % EX| [0; 0; 0; 0; 0; 0; 0; 0] 
                    % EX| + (3 * [1; 1; 1; 1; 0.3; 0.3; 0.3; 0.3])
                    % EX| = [3; 3; 3; 3; 0.9; 0.9; 0.9; 0.9]
                    % EX| when N = 2, ActivationsAfterSpread = 
                    % EX| [3; 3; 3; 3; 0.9; 0.9; 0.9; 0.9]
                    % EX| + (4 * [0.3; 0.3; 0.3; 0.3; 1; 1; 1; 1])
                    % EX| = [4.2; 4.2; 4.2; 4.2; 4.9; 4.9; 4.9; 4.9]
                NIndex = NIndex + obj.Space.ClusterSizes(N,1);
                    % EX| when N = 1, NIndex = 1 + 4 = 5
                    % EX| when N = 1, NIndex = 5 + 4 = 9 (not used)
            end
        end

        % TURN ACTIVATIONS INTO ACTIVATIONS AFTER PERCEPTUAL SPREAD
        % For an example, see the function SpreadActivationsInMotorSpace --
        % it's the same thing, but this function measures distance in
        % Perceptual Space rather than in Motor Space
        function ActivationsAfterSpread = ...
                SpreadActivationsInPerceptualSpace(obj, ...
                ActivationsBeforeSpread)
            % Initialize
            ActivationsAfterSpread = zeros(size(ActivationsBeforeSpread));
            NIndex = 1;
            for N = 1:length(obj.Space.Clusters)
                ClusterN = obj.Space.Clusters{N,1};
                % Central motor point of ClusterN.
                PerceptualCenterN = ...
                    ClusterN.Centroid.PerceptualPoint;
                % Activation multiplier vector for activation from ClusterN
                ActivationMultiplierN = ...
                    zeros(size(ActivationsBeforeSpread));
                MIndex = 1;
                for M = 1:length(obj.Space.Clusters)
                    % Finding the activation multiplier ClusterN gives to ClusterM
                    ClusterM = obj.Space.Clusters{M,1};
                    PerceptualCenterM = ...
                        ClusterM.Centroid.PerceptualPoint;
                    ClusterDistance = ...
                        PerceptualCenterN.Distance(PerceptualCenterM);
                    SpreadActivation = ...
                        obj.PerceptualSpreadDistanceToActivation(...
                        ClusterDistance);

                    % Replacing the activation values at all the indices of
                    % junctures in ClusterM with the appropriate activation
                    MEndIndex = MIndex + obj.Space.ClusterSizes(M,1) - 1;
                    ActivationMultiplierN(MIndex:MEndIndex,1) = ...
                        SpreadActivation;
                    % Incrementing for the next ClusterM
                    MIndex = MEndIndex + 1;
                end
                ClusterNActivation = ActivationsBeforeSpread(NIndex);
                ActivationsAfterSpread = ActivationsAfterSpread + ...
                    (ClusterNActivation * ActivationMultiplierN);
                NIndex = NIndex + obj.Space.ClusterSizes(N,1);
            end
        end

        % Function that tells us the activation that comes from a cluster
        % that is distance Distance away in motor space
        function Activation = MotorSpreadDistanceToActivation(~, Distance)
            Activation = max(0, 1 - (0.1 * Distance));
%             if Distance == 0
%                 Activation = 1;
%             else
%                 Activation = 3/(1 + Distance)^2;
%             end
        end

        % Function that tells us the activation that comes from a cluster
        % that is distance Distance away in perceptual space
        function Activation = PerceptualSpreadDistanceToActivation(~, Distance)
            Activation = max(0, 1 - (0.1 * Distance));
%             if Distance == 0
%                 Activation = 1;
%             else
%                 Activation = 3/(1 + Distance)^2;
%             end
        end

        
        %% ESTIMATES

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
        function [AverageJunctureEstimates, FinalJunctureActivationValues] = ...
                SimpleMacroEstimates(obj, Spread, executionParameters)
            % Initializing
            ClusterActivations = obj.TempActivations(executionParameters);
            FinalClusterActivationValues = cell(obj.TimeLength, 1);
            FinalJunctureActivationValues = cell(obj.TimeLength, 1);
            AverageJunctureEstimates = cell(obj.TimeLength, 1);

            % Finding inputs for next function
            if Spread == "none"
                for t = 1:obj.TimeLength
                    FinalActivations = transpose(cell2mat(ClusterActivations(t,:)));
                    FinalClusterActivationValues{t,1} = FinalActivations;
                end
            else
                for t = 1:obj.TimeLength
                    FinalActivations = NewerSpreadFunction(obj.Space.Clusters, Spread, transpose(cell2mat(ClusterActivations(t,:))));
                    FinalClusterActivationValues{t,1} = FinalActivations;
                end
            end
            for t = 1:obj.TimeLength
                CurrentJunctureActivations = obj.Space.ClusterToJunctureActivations(FinalClusterActivationValues{t,1});
                AverageFauxJuncture = obj.Space.AverageJuncture(CurrentJunctureActivations);
                FinalJunctureActivationValues{t,1} = CurrentJunctureActivations;
                AverageJunctureEstimates{t,1} = AverageFauxJuncture;
            end
        end

        function [AverageJunctureEstimates, FinalActivationValues] = ...
                SimpleMacroEstimatesWithAdjustments(obj, Spread, executionParameters, Adjustments, LengthOfAdjustments)
            [AverageJunctureEstimates, FinalActivationValues] = obj.SimpleMacroEstimates(Spread, executionParameters);
            for a = 1:length(Adjustments)
                adjTime = Adjustments(a,1);
                CurrentPerceptualLocation = AverageJunctureEstimates{adjTime, 1}.PerceptualPoint;

                % Get trajectory activation pattern -- shouldn't just be
                % the clusters it hits but should actually be like varied
                % within a cluster & decreasing away from the points it
                % hits

                % ActualActivation = obj.Space.ActivationFromPerceptualPoint(CurrentPerceptualLocation);
                ActualActivation = FinalActivationValues{adjTime, 1};
                    % This ActualActivation could be what's in the plan as
                    % far as an activation, what we find to be activated
                    % when we look at our current location and see the
                    % activation it corresponds with, or maybe other things
                ClosestPointOnExemplar = obj.Trajectory.ClosestPartToOtherPoint(CurrentPerceptualLocation);
                DesiredActivation = obj.Space.ClusterToJunctureActivations(obj.Space.ActivationFromPerceptualPoint(ClosestPointOnExemplar));
                    % This DesiredActivation could be several things as
                    % well

                NeededChangeInActivationJunctures = obj.Space.CorrectionActivation(ActualActivation, DesiredActivation);
                for subsequentTimes = adjTime:min(adjTime + LengthOfAdjustments(a,1),length(FinalActivationValues))
                    FinalActivationValues{subsequentTimes,1} = DesiredActivation;
                end
                for jIndex = 1:length(FinalActivationValues)
                    AverageFauxJuncture = obj.Space.AverageJuncture(...
                        FinalActivationValues{jIndex, 1});
                    AverageJunctureEstimates{jIndex, 1} = AverageFauxJuncture;
                end
            end
        end

        %% PAUSE FUNCTION

        % Pause function that takes PauseLength as an input and executes a
        % pause of length based on that input: if PauseLength is "manual",
        % the pause will only be terminated when a key is pressed by the
        % user; if PauseLength is a number, the pause terminate after that
        % many seconds.
        function PauseFunction(~, PauseLength)
            if isa(PauseLength, "string") && PauseLength == "manual"
                pause;
            else
                pause(PauseLength);
            end
        end
    end
end

