%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Consider the following clusters and activations in motor space:
% 1 1 0 0 0 0
% 1 1 0 0 2 2
% 0 0 0 0 2 2
% 0 0 0 0 0 0
% 0 0 4 4 0 0
% 0 0 4 4 0 0
% Which means that there are three clusters, Cluster1, consisting of 
% junctures j1a, j1b, j1c, j1d; Cluster2, with junctures j2a, j2b, j2c,
% j2d; Cluster3, with junctures j3a, j3b, j3c, j3d, where the junctures 
% have the following motor coordinates and activations:
% CLUSTER       JUNCTURE    COORDINATES     ACTIVATION
% Cluster1      j1a         [4;  0]          4
% Cluster1      j1b         [6;  0]          4
% Cluster1      j1c         [4;  2]          4
% Cluster1      j1d         [6;  2]          4
% Cluster2      j2a         [0;  8]          1
% Cluster2      j2b         [2;  8]          1
% Cluster2      j2c         [0; 10]          1
% Cluster2      j2d         [2; 10]          1
% Cluster3      j3a         [8;  6]          2
% Cluster3      j3b         [10; 6]          2
% Cluster3      j3c         [8;  8]          2
% Cluster3      j3d         [10; 8]          2

% EX| ActivationsAfterSpread = NewerSpreadFunction(
% EX| {Cluster1; Cluster2; Cluster3}, "motor", [4; 1; 2])
function ActivationsAfterSpread = NewerSpreadFunction(Clusters, ...
    MotorOrPerceptual, InitialClusterActivations)
    ActivationMatrix = zeros(length(InitialClusterActivations));
        % EX| ActivationMatrix = [0 0 0; 0 0 0; 0 0 0]
    for r = 1:length(ActivationMatrix)
        for c = 1:length(ActivationMatrix)
            % The activation in row r column c will be the activation
            % of Cluster r from Cluster c
            ActivationMatrix(r,c) = ClusterToClusterActivation(...
                Clusters{c,1}, Clusters{r,1}, ...
                InitialClusterActivations(c,1), ...
                MotorOrPerceptual);
                % EX| ActivationMatrix = 
                % EX| [4            0.10557...   0.55778...
                % EX|  0.42228...   1            0.35076...
                % EX|  1.11556...   0.17538...   2]
        end
    end
    ActivationsAfterSpread = mean(ActivationMatrix,2);
        % EX| ActivationsAfterSpread = 
        % EX| [(4 + 0.10557... + 0.55778...) / 3
        % EX|  (0.42228... + 1 + 0.35076...) / 3
        % EX|  (1.11556... + 0.17538... + 2) / 3] =
        % EX| [(4.66335...) / 3
        % EX|  (0.42228... + 1 + 0.35076...) / 3
        % EX|  (1.11556... + 0.17538... + 2) / 3]
end

% Consider the following clusters and activations in motor space:
% 1 1 0 0 0 0
% 1 1 0 0 2 2
% 0 0 0 0 2 2
% 0 0 0 0 0 0
% 0 0 4 4 0 0
% 0 0 4 4 0 0
% Which means that there are three clusters, Cluster1, consisting of 
% junctures j1a, j1b, j1c, j1d; Cluster2, with junctures j2a, j2b, j2c,
% j2d; Cluster3, with junctures j3a, j3b, j3c, j3d, where the junctures 
% have the following motor coordinates and activations:
% CLUSTER       JUNCTURE    COORDINATES     ACTIVATION
% Cluster1      j1a         [4;  0]          4
% Cluster1      j1b         [6;  0]          4
% Cluster1      j1c         [4;  2]          4
% Cluster1      j1d         [6;  2]          4
% Cluster2      j2a         [0;  8]          1
% Cluster2      j2b         [2;  8]          1
% Cluster2      j2c         [0; 10]          1
% Cluster2      j2d         [2; 10]          1
% Cluster3      j3a         [8;  6]          2
% Cluster3      j3b         [10; 6]          2
% Cluster3      j3c         [8;  8]          2
% Cluster3      j3d         [10; 8]          2
% Then we are finding 
% CASE 1: ClusterToClusterActivation(Cluster1, Cluster1, 4, "motor")
% CASE 2: ClusterToClusterActivation(Cluster1, Cluster2, 4, "motor")
% CASE 3: ClusterToClusterActivation(Cluster1, Cluster3, 4, "motor")
% CASE 4: ClusterToClusterActivation(Cluster2, Cluster1, 1, "motor")
% CASE 5: ClusterToClusterActivation(Cluster2, Cluster2, 1, "motor")
% CASE 6: ClusterToClusterActivation(Cluster2, Cluster3, 1, "motor")
% CASE 7: ClusterToClusterActivation(Cluster3, Cluster1, 2, "motor")
% CASE 8: ClusterToClusterActivation(Cluster3, Cluster2, 2, "motor")
% CASE 9: ClusterToClusterActivation(Cluster3, Cluster3, 2, "motor")
function ActivationFromCluster = ClusterToClusterActivation(...
    SpreadingCluster, ReceivingCluster, SpreadingClusterActivation, ...
    MotorOrPerceptual)
    CenterJuncture1 = SpreadingCluster.Center_AverageJunctureAll();
        % EX| CASES 1, 2, 3     CenterJuncture1 = [5; 1]
        % EX| CASES 4, 5, 6     CenterJuncture1 = [1; 9]
        % EX| CASES 7, 8, 9     CenterJuncture1 = [9; 7]
    CenterJuncture2 = ReceivingCluster.Center_AverageJunctureAll();
        % EX| CASES 1, 4, 7     CenterJuncture1 = [5; 1]
        % EX| CASES 2, 5, 8     CenterJuncture1 = [1; 9]
        % EX| CASES 3, 6, 9     CenterJuncture1 = [9; 7]
    if MotorOrPerceptual == "motor"
        Distance = CenterJuncture1.MotorPoint.Distance(...
            CenterJuncture2.MotorPoint);
        % EX| CASE 1: Distance from [5; 1] to [5; 1] = sqrt(0) = 0;
        % EX| CASE 2: Distance from [5; 1] to [1; 9] = sqrt(80) = 8.9443...
        % EX| CASE 3: Distance from [5; 1] to [9; 7] = sqrt(52) = 7.2111...
        % EX| CASE 4: Distance from [1; 9] to [5; 1] = sqrt(80) = 8.9443...
        % EX| CASE 5: Distance from [1; 9] to [1; 9] = sqrt(0) = 0
        % EX| CASE 6: Distance from [1; 9] to [9; 7] = sqrt(68) = 8.2462...
        % EX| CASE 7: Distance from [9; 7] to [5; 1] = sqrt(52) = 7.2111...
        % EX| CASE 8: Distance from [9; 7] to [1; 9] = sqrt(68) = 8.2462...
        % EX| CASE 9: Distance from [9; 7] to [9; 7] = sqrt(0) = 0
    elseif MotorOrPerceptual == "perceptual"
        Distance = CenterJuncture1.PerceptualPoint.Distance(...
            CenterJuncture2.PerceptualPoint);
    end
    ActivationFromCluster = SpreadingClusterActivation * ...
        SpreadingCluster.DistanceToActivationMap(Distance);
        % EX| CASE 1: ActivationFromCluster = 4 * (1 - 0.1 * 0)         = 4
        % EX| CASE 2: ActivationFromCluster = 4 * (1 - 0.1 * 8.9443...) = 0.42228...
        % EX| CASE 3: ActivationFromCluster = 4 * (1 - 0.1 * 7.2111...) = 1.11556...
        % EX| CASE 4: ActivationFromCluster = 1 * (1 - 0.1 * 8.9443...) = 0.10557...
        % EX| CASE 5: ActivationFromCluster = 1 * (1 - 0.1 * 0)         = 1
        % EX| CASE 6: ActivationFromCluster = 1 * (1 - 0.1 * 8.2462...) = 0.17538...
        % EX| CASE 7: ActivationFromCluster = 2 * (1 - 0.1 * 7.2111...) = 0.55778...
        % EX| CASE 8: ActivationFromCluster = 2 * (1 - 0.1 * 8.2462...) = 0.35076...
        % EX| CASE 9: ActivationFromCluster = 2 * (1 - 0.1 * 0)         = 2
end
