 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS LIST
%  Space
% % %  ActivationFromPerceptualPoint
% % %  JustGreatestActivationFromTraj
% % %  Activations_SumFromTraj
% % %  CorrectionActivation
% % %  CorrectionActivationProportional
% % %  CorrectionActivationMultiplier
% % %  CorrectionActivationRaw
% % %  CorrectionActivationCutAtZero
% % %  CorrectionActivationShiftedToPositive
% % %  QuantizeJunctureActivationPattern
%  ThresholdJunctureActivationPattern
%  ClusterToJunctureActivations
%  AverageJuncture
% % %  ActivationWeightedAverageJuncture
%  PositiveActivationWeightedAverageJuncture
%  MotorClusterPlottingInfo
%  PerceptualClusterPlottingInfo

classdef Space
    %% PROPERTIES
    properties
        Clusters; % All the clusters in the space
        ClusterSizes; % List of the number of junctures in each cluster
        CanonicalJunctureOrder; 
            % List of all the junctures in the cluster in a canonical order
            % that will be used for everything, such as plotting
        SpaceTransformation;
        MotorBounds;
        MaxDistanceWithActivation;
    end
    %% METHODS
    methods
        % Creating an object
        function obj = Space(Clusters, MtoPTransformation, MotorBounds, ...
                MaxDistanceWithActivation)
            % First have to check that the transformation fits with the
            % clusters
            obj.Clusters = Clusters;
            CSizes = zeros(length(obj.Clusters),1);
            for c = 1:length(CSizes)
                cCluster = obj.Clusters{c,1};
                CSizes(c,1) = length(cCluster.Junctures);
            end
            obj.ClusterSizes = CSizes;
            CanonicalOrder = cell(sum(obj.ClusterSizes), 1);
            oIndex = 1;
            for c = 1:length(obj.Clusters)
                CurrentCluster = obj.Clusters{c,1};
                for j = 1:length(CurrentCluster.Junctures)
                    CanonicalOrder{oIndex,1} = CurrentCluster.Junctures{j,1};
                    oIndex = oIndex + 1;
                end
            end
            obj.CanonicalJunctureOrder = CanonicalOrder;
            obj.SpaceTransformation = MtoPTransformation;
            obj.MotorBounds = MotorBounds;
            obj.MaxDistanceWithActivation = MaxDistanceWithActivation;
        end

        %% ACTIVATION PATTERNS
        % Gives a vector of the activations of all the clusters from the
        % perceptual point provided as input.  ActivationOfClusters(3,1)
        % would be the activation of the 3rd cluster in the space from the 
        % perceptual point perceptualPoint.
%         function ActivationOfClusters = ActivationFromPerceptualPoint(...
%                 obj, perceptualPoint)
%             ActivationOfClusters = zeros(length(obj.Clusters),1);
%             for clusterIndex = 1:length(ActivationOfClusters)
%                 CurrentCluster = obj.Clusters{clusterIndex, 1};
%                 distToPoint = CurrentCluster.AverageDistanceToPoint(perceptualPoint);
%                 CurrentActivation = CurrentCluster.DistanceToActivationMap(distToPoint);
%                 ActivationOfClusters(clusterIndex, 1) = CurrentActivation;
%             end
%         end

%         function Activations = JustGreatestActivationFromTraj(obj, perceptualTrajectory)
%             AllClusterActivations = obj.Activations_SumFromTraj(perceptualTrajectory);
%             maxActivation = max(AllClusterActivations);
%             Activations = zeros(size(AllClusterActivations));
%             for a = 1:length(Activations)
%                 if AllClusterActivations(a,1) == maxActivation
%                     Activations(a,1) = maxActivation;
%                 end
%             end
%         end

        % ACTIVATIONS OF CLUSTER FROM TRAJECTORY
        % Gives the activations of the clusters from just the trajectory, 
        % based on the function Cluster.FindTrajectoryActivationSum.  The
        % output Activation is such that Activations{c, 1} is the 
        % activation of the cth cluster.  There is no time element to this
        % function because the activation from the trajectory is not
        % temporal.
%         function Activations = Activations_SumFromTraj(obj, perceptualTrajectory)
%             Activations = zeros(length(obj.Clusters),1);
%             for clusterIndex = 1:length(Activations)
%                 CurrentCluster = obj.Clusters{clusterIndex, 1};
%                 CurrentActivation = ...
%                     CurrentCluster.FindTrajectoryActivationSum(perceptualTrajectory);
%                 Activations(clusterIndex, 1) = CurrentActivation;
%             end
%         end

        %% HOW TO COME UP WITH A CORRECTION ACTIVATION GIVEN TWO ACTIVATIONS
        
%         function CorrectionValues = CorrectionActivation(obj, ActualActivation, DesiredActivation)
%             CorrectionValues = obj.CorrectionActivationRaw(ActualActivation, DesiredActivation);
%         end

%         function CorrectionMultipliers = CorrectionActivationProportional(obj, ActualActivation, DesiredActivation, CurrentMean)
%             CorrectionMultipliers = (DesiredActivation - ActualActivation) * (CurrentMean - mean(ActualActivation));
%         end
% 
%         function CorrectionMultipliers = CorrectionActivationMultiplier(obj, ActualActivation, DesiredActivation)
%             CorrectionMultipliers = DesiredActivation./ActualActivation;
%         end
% 
%         function CorrectionValues = CorrectionActivationRaw(~, ActualActivation, DesiredActivation)
%             CorrectionValues = DesiredActivation - ActualActivation;
%         end
% 
%         function CorrectionValues = CorrectionActivationCutAtZero(~, ActualActivation, DesiredActivation)
%             DifferenceActivation = DesiredActivation - ActualActivation;
%             ZeroVector = zeros(size(DifferenceActivation));
%             CorrectionValues = max(ZeroVector, DifferenceActivation);
%         end

%         function CorrectionValues = CorrectionActivationShiftedToPositive(~, ActualActivation, DesiredActivation)
%             DifferenceActivation = DesiredActivation - ActualActivation;
%             minActivation = min(DifferenceActivation);
%             if minActivation < 0
%                 CorrectionValues = DifferenceActivation - minActivation;
%             else
%                 CorrectionValues = DifferenceActivation;
%             end
%         end

%         function NewJunctureActivations = QuantizeJunctureActivationPattern(obj, CurrentJunctureActivations)
%             ClusterActivations = zeros(length(obj.Clusters),1);
%             jIndex = 1;
%             for cIndex = 1:length(obj.Clusters)
%                 ClusterActivations(cIndex, 1) = CurrentJunctureActivations(jIndex,1);
%                 jIndex = jIndex + obj.ClusterSizes(cIndex,1);
%             end
%             MaxActivation = max(ClusterActivations);
%             for m = 1:length(ClusterActivations)
%                 if ClusterActivations(m,1) == MaxActivation
%                     ClusterActivations(m,1) = 1;
%                 else
%                     ClusterActivations(m,1) = 0;
%                 end
%             end
%             NewJunctureActivations = obj.ClusterToJunctureActivations(ClusterActivations);
%         end

        function NewJunctureActivations = ...
            ThresholdJunctureActivationPattern(~, ...
                CurrentJunctureActivations, Threshold)
%             ClusterActivations = zeros(length(obj.Clusters),1);
%             jIndex = 1;
%             for cIndex = 1:length(obj.Clusters)
%                 ClusterActivations(cIndex, 1) = CurrentJunctureActivations(jIndex,1);
%                 jIndex = jIndex + obj.ClusterSizes(cIndex,1);
%             end
%             for m = 1:length(ClusterActivations)
%                 if ClusterActivations(m,1) == MaxActivation
%                     ClusterActivations(m,1) = 1;
%                 else
%                     ClusterActivations(m,1) = 0;
%                 end
%             end
%             NewJunctureActivations = obj.ClusterToJunctureActivations(ClusterActivations);
            NewJunctureActivations = zeros(size(CurrentJunctureActivations));
            for j = 1:length(NewJunctureActivations)
                if CurrentJunctureActivations(j,1) >= Threshold
                    NewJunctureActivations(j,1) = 1;
                else
                    NewJunctureActivations(j,1) = CurrentJunctureActivations(j,1);
                end
            end
        end


        %% TURN ACTIVATION OF CLUSTERS INTO ACTIVATION OF JUNCTURES
        function JunctureActivations = ClusterToJunctureActivations(...
                obj, ClusterActivations)
            JunctureActivations = zeros(size(obj.CanonicalJunctureOrder));
            genIndex = 1;
            for cIndex = 1:length(obj.Clusters)
                CurrentCluster = obj.Clusters{cIndex, 1};
                CurrentActivation = ClusterActivations(cIndex, 1);
                for jIndex = 1:length(CurrentCluster.Junctures)
                    JunctureActivations(genIndex, 1) = CurrentActivation;
                    genIndex = genIndex + 1;
                end
            end
        end

        %% AVERAGE VALUES FROM ACTIVATION

        % AVERAGE JUNCTURE IN MOTOR SPACE FROM ACTIVATIONS
        % Activations, which is the activations of the junctures, needs to 
        % be listed in the canonical juncture order.
        function AverageFauxJuncture = AverageJuncture(obj, Activations)
            AverageFauxJuncture = obj.PositiveActivationWeightedAverageJuncture(Activations);
        end

%         function AverageFauxJuncture = ActivationWeightedAverageJuncture(obj, Activations)
%             SumOfMotorCoordinates = zeros(size(obj.CanonicalJunctureOrder{1,1}));
%             SumOfActivations = 0;
%             for JIndex = 1:length(obj.CanonicalJunctureOrder)
%                 CurrentActivation = Activations(JIndex, 1);
%                 CurrentCoordinates = obj.CanonicalJunctureOrder{JIndex, 1}.MotorPoint.Coordinates;
%                 AdditionalWeightedCoordinates = CurrentActivation * CurrentCoordinates;
%                 SumOfMotorCoordinates = SumOfMotorCoordinates + AdditionalWeightedCoordinates;
%                 SumOfActivations = SumOfActivations + CurrentActivation;
%             end
%             RawAverageCoordinates = SumOfMotorCoordinates/SumOfActivations;
%             % Now we need to correct it so that it is inside the bounds --
%             % AverageCoordinates will reflect this
%             MotorMins = obj.MotorBounds(:,1);
%             MotorMaxes = obj.MotorBounds(:,2);
%             AverageCoordinates = max(min(RawAverageCoordinates, MotorMaxes), MotorMins);
%             AverageMotorPoint = MotorPoint(AverageCoordinates);
%             AverageFauxJuncture = AverageMotorPoint.MakeJuncture(obj.SpaceTransformation);
%         end

        % Gets rid of any negative activations (changes them to zero), then
        % finds the weighted average motor coordiantes, then based on the
        % transformation finds the perceptual coordinates cooresponding to
        % those motor coordinates (NOT necessarily the average of the
        % perceptual coordinates depending on the transformation)
        function AverageFauxJuncture = PositiveActivationWeightedAverageJuncture(obj, Activations)
            % Before anything, make any negative activations be just 0
            ZeroVector = zeros(size(Activations));
            Activations = max(ZeroVector, Activations);

            % Initialize
            SumOfMotorCoordinates = zeros(size(obj.CanonicalJunctureOrder{1,1}.MotorPoint.Coordinates));
            SumOfActivations = 0;
            for JIndex = 1:length(obj.CanonicalJunctureOrder)
                CurrentActivation = Activations(JIndex, 1);
                CurrentCoordinates = obj.CanonicalJunctureOrder{JIndex, 1}.MotorPoint.Coordinates;
                AdditionalWeightedCoordinates = CurrentActivation * CurrentCoordinates;
                SumOfMotorCoordinates = SumOfMotorCoordinates + AdditionalWeightedCoordinates;
                SumOfActivations = SumOfActivations + CurrentActivation;
            end
            RawAverageCoordinates = SumOfMotorCoordinates/SumOfActivations;
            % Now we need to correct it so that it is inside the bounds --
            % AverageCoordinates will reflect this
%             MotorMins = obj.MotorBounds(:,1);
%             MotorMaxes = obj.MotorBounds(:,2);
%             AverageCoordinates = max(min(RawAverageCoordinates, MotorMaxes), MotorMins);
            AverageMotorPoint = MotorPoint(RawAverageCoordinates);
            AverageFauxJuncture = AverageMotorPoint.MakeJuncture(obj.SpaceTransformation);
        end

        %% PLOTTING INFO

        % Motor Cluster plotting info
        function [xValues, yValues, ColorValues, AlphaValues] = ...
                MotorClusterPlottingInfo(obj, ColorArray, ...
                AlphaClusterValues)
            % Initialize for the right sizes
            xValues = zeros(length(obj.CanonicalJunctureOrder), 1);
            yValues = zeros(length(obj.CanonicalJunctureOrder), 1);
            ColorValues = zeros(length(obj.CanonicalJunctureOrder), 3);
            AlphaValues = zeros(length(obj.CanonicalJunctureOrder), 1);
            GenIndex = 1;
            for cIndex = 1:length(obj.Clusters)
                CurrentCluster = obj.Clusters{cIndex, 1};
                for jIndex = 1:length(CurrentCluster.Junctures)
                    CurrentJuncture = CurrentCluster.Junctures{jIndex, 1};
                    xValues(GenIndex, 1) = CurrentJuncture.MotorPoint.x;
                    yValues(GenIndex, 1) = CurrentJuncture.MotorPoint.y;
                    ColorValues(GenIndex, :) = ColorArray(cIndex, :);
                    AlphaValues(GenIndex, 1) = AlphaClusterValues(cIndex, 1);
                    GenIndex = GenIndex + 1;
                end
            end
        end

        % Perceptual Cluster plotting info
        function [xValues, yValues, ColorValues, AlphaValues] = ...
                PerceptualClusterPlottingInfo(obj, ColorArray, ...
                AlphaClusterValues)
            % Initialize for the right sizes
            xValues = zeros(length(obj.CanonicalJunctureOrder), 1);
            yValues = zeros(length(obj.CanonicalJunctureOrder), 1);
            ColorValues = zeros(length(obj.CanonicalJunctureOrder), 3);
            AlphaValues = zeros(length(obj.CanonicalJunctureOrder), 1);
            GenIndex = 1;
            for cIndex = 1:length(obj.Clusters)
                CurrentCluster = obj.Clusters{cIndex, 1};
                for jIndex = 1:length(CurrentCluster.Junctures)
                    CurrentJuncture = CurrentCluster.Junctures{jIndex, 1};
                    xValues(GenIndex, 1) = CurrentJuncture.PerceptualPoint.x;
                    yValues(GenIndex, 1) = CurrentJuncture.PerceptualPoint.y;
                    ColorValues(GenIndex, :) = ColorArray(cIndex, :);
                    AlphaValues(GenIndex, 1) = AlphaClusterValues(cIndex, 1);
                    GenIndex = GenIndex + 1;
                end
            end
        end
    end
end