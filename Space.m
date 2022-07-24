 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS LIST
%  Space
%
%  TURN ACTIVATION OF CLUSTERS INTO ACTIVATION OF JUNCTURES
%  ClusterToJunctureActivations
%
%  AVERAGE VALUES FROM ACTIVATION
%  AverageJuncture
%
%  PLOTTING INFO
%  MotorClusterPlottingInfo
%  PerceptualClusterPlottingInfo
%
%  PLOTTING INFO 3D
%  MotorClusterPlottingInfo3D
%  PerceptualClusterPlottingInfo3D

classdef Space
    %% PROPERTIES
    properties
        Clusters; % All the clusters in the space
        ClusterSizes; % List of the number of junctures in each cluster
        CanonicalJunctureOrder; 
            % List of all the junctures in the cluster in a canonical order
            % that will be used for everything, such as plotting
        SpaceTransformation;
        MaxDistanceWithActivationM;
        MaxDistanceWithActivationP;
    end
    %% METHODS
    methods
        % Creating an object
        function obj = Space(Clusters, MtoPTransformation, Options)
            arguments
                Clusters
                MtoPTransformation
                Options.MaxDistanceWithActivationM {mustBeNumeric} = 10
                Options.MaxDistanceWithActivationP {mustBeNumeric} = 10
            end
            % First have to check that the transformation fits with the
            % clusters
            obj.Clusters = Clusters;
            CSizes = zeros(1, length(obj.Clusters));
            for c = 1:length(CSizes)
                cCluster = obj.Clusters(c);
                CSizes(c) = length(cCluster.Junctures);
            end
            obj.ClusterSizes = CSizes;
            CanonicalOrder = Juncture.empty(0, sum(obj.ClusterSizes));
            oIndex = 1;
            for c = 1:length(obj.Clusters)
                CurrentCluster = obj.Clusters(c);
                for j = 1:length(CurrentCluster.Junctures)
                    CanonicalOrder(oIndex) = CurrentCluster.Junctures(j);
                    oIndex = oIndex + 1;
                end
            end
            obj.CanonicalJunctureOrder = CanonicalOrder;
            obj.SpaceTransformation = MtoPTransformation;
            obj.MaxDistanceWithActivationM = Options.MaxDistanceWithActivationM;
            obj.MaxDistanceWithActivationP = Options.MaxDistanceWithActivationP;
        end

        %% TURN ACTIVATION OF CLUSTERS INTO ACTIVATION OF JUNCTURES
        %  FUNCTIONS
        %  ClusterToJunctureActivations
        function JunctureActivations = ClusterToJunctureActivations(...
                obj, ClusterActivations)
            JunctureActivations = zeros(size(obj.CanonicalJunctureOrder));
            genIndex = 1;
            for cIndex = 1:length(obj.Clusters)
                CurrentCluster = obj.Clusters(cIndex);
                CurrentActivation = ClusterActivations(cIndex);
                for jIndex = 1:length(CurrentCluster.Junctures)
                    JunctureActivations(genIndex) = CurrentActivation;
                    genIndex = genIndex + 1;
                end
            end
        end

        %% AVERAGE VALUES FROM ACTIVATION
        %  FUNCTIONS
        %  AverageJuncture

        % AVERAGE JUNCTURE IN MOTOR SPACE FROM ACTIVATIONS
        % Activations, which is the activations of the junctures, needs to 
        % be listed in the canonical juncture order.
        function AverageFauxJuncture = AverageJuncture(obj, Activations)
            assert(numel(Activations) == numel(obj.CanonicalJunctureOrder), ...
                "The number of activations needs to match the " + ...
                "number of junctures, but there are " + ...
                numel(Activations) + " activations and " + ...
                numel(obj.CanonicalJunctureOrder) + " junctures.");
            % Initialize
            SumOfMotorCoordinates = zeros(size(obj.CanonicalJunctureOrder(1).MotorPoint.Coordinates));
            SumOfActivations = 0;
            for JIndex = 1:length(obj.CanonicalJunctureOrder)
                CurrentActivation = Activations(JIndex);
                CurrentCoordinates = obj.CanonicalJunctureOrder(JIndex).MotorPoint.Coordinates;
                AdditionalWeightedCoordinates = CurrentActivation * CurrentCoordinates;
                SumOfMotorCoordinates = SumOfMotorCoordinates + AdditionalWeightedCoordinates;
                SumOfActivations = SumOfActivations + CurrentActivation;
            end
            if (SumOfActivations == 0)
                fprintf("Sum of activations is zero\n");
                % Returning a never real value
                AverageFauxJuncture = Juncture( ...
                    MotorPoint(-1000000 * ones(size( ...
                    obj.CanonicalJunctureOrder(1).MotorPoint.Coordinates))), ...
                    PerceptualPoint(-1000000 * ones(size( ...
                    obj.CanonicalJunctureOrder(1).PerceptualPoint.Coordinates))));
                return;
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
        %  FUNCTIONS
        %  MotorClusterPlottingInfo
        %  PerceptualClusterPlottingInfo

        % Motor Cluster plotting info
        function [xValues, yValues, ColorValues, AlphaValues] = ...
                MotorClusterPlottingInfo(obj, ColorArray, ...
                AlphaClusterValues)
            % Initialize for the right sizes
            xValues = nan(1, length(obj.CanonicalJunctureOrder));
            yValues = nan(1, length(obj.CanonicalJunctureOrder));
            ColorValues = nan(length(obj.CanonicalJunctureOrder), 3);
            AlphaValues = nan(1, length(obj.CanonicalJunctureOrder));
            StartIndex = 1;
            for cIndex = 1:length(obj.Clusters)
                CurrentCluster = obj.Clusters(cIndex);
                xCoordinates = CurrentCluster.xMotor;
                yCoordinates = CurrentCluster.yMotor;
                EndIndex = StartIndex + length(xCoordinates) - 1;
                xValues(StartIndex:EndIndex) = xCoordinates;
                yValues(StartIndex:EndIndex) = yCoordinates;
                ColorValues(StartIndex:EndIndex, :) = ones(length(xCoordinates), 1) * ColorArray(cIndex, :);
                AlphaValues(StartIndex:EndIndex) = AlphaClusterValues(cIndex, 1);
                StartIndex = EndIndex + 1;
            end
        end

        % Perceptual Cluster plotting info
        function [xValues, yValues, ColorValues, AlphaValues] = ...
                PerceptualClusterPlottingInfo(obj, ColorArray, ...
                AlphaClusterValues)
            % Initialize for the right sizes
            xValues = nan(1, length(obj.CanonicalJunctureOrder));
            yValues = nan(1, length(obj.CanonicalJunctureOrder));
            ColorValues = nan(length(obj.CanonicalJunctureOrder), 3);
            AlphaValues = nan(1, length(obj.CanonicalJunctureOrder));
            StartIndex = 1;
            for cIndex = 1:length(obj.Clusters)
                CurrentCluster = obj.Clusters(cIndex);
                xCoordinates = CurrentCluster.xPerceptual;
                yCoordinates = CurrentCluster.yPerceptual;
                EndIndex = StartIndex + length(xCoordinates) - 1;
                xValues(StartIndex:EndIndex) = xCoordinates;
                yValues(StartIndex:EndIndex) = yCoordinates;
                ColorValues(StartIndex:EndIndex, :) = ones(length(xCoordinates), 1) * ColorArray(cIndex, :);
                AlphaValues(StartIndex:EndIndex) = AlphaClusterValues(cIndex, 1);
                StartIndex = EndIndex + 1;
            end
        end
    
        %% PLOTTING INFO 3D
        %  FUNCTIONS
        %  MotorClusterPlottingInfo3D
        %  PerceptualClusterPlottingInfo3D

        % Motor Cluster plotting info 3D
        function [xValues, yValues, zValues, ColorValues, AlphaValues] = ...
                MotorClusterPlottingInfo3D(obj, ColorArray, ...
                AlphaClusterValues)
            % Initialize for the right sizes
            xValues = nan(1, length(obj.CanonicalJunctureOrder));
            yValues = nan(1, length(obj.CanonicalJunctureOrder));
            zValues = nan(1, length(obj.CanonicalJunctureOrder));
            ColorValues = nan(length(obj.CanonicalJunctureOrder), 3);
            AlphaValues = nan(1, length(obj.CanonicalJunctureOrder));
            StartIndex = 1;
            for cIndex = 1:length(obj.Clusters)
                CurrentCluster = obj.Clusters(cIndex);
                xCoordinates = CurrentCluster.xMotor;
                yCoordinates = CurrentCluster.yMotor;
                zCoordinates = CurrentCluster.zMotor;
                EndIndex = StartIndex + length(xCoordinates) - 1;
                xValues(StartIndex:EndIndex) = xCoordinates;
                yValues(StartIndex:EndIndex) = yCoordinates;
                zValues(StartIndex:EndIndex) = zCoordinates;
                ColorValues(StartIndex:EndIndex, :) = ones(length( ...
                    xCoordinates), 1) * ColorArray(mod(cIndex - 1, size(ColorArray, 1)) + 1, :);
                AlphaValues(StartIndex:EndIndex) = AlphaClusterValues( ...
                    mod(cIndex - 1, size(AlphaClusterValues, 1)) + 1, 1);
                StartIndex = EndIndex + 1;
            end
        end

        % Perceptual Cluster plotting info
        function [xValues, yValues, zValues, ColorValues, AlphaValues] = ...
                PerceptualClusterPlottingInfo3D(obj, ColorArray, ...
                AlphaClusterValues)
            % Initialize for the right sizes
            xValues = nan(1, length(obj.CanonicalJunctureOrder));
            yValues = nan(1, length(obj.CanonicalJunctureOrder));
            zValues = nan(1, length(obj.CanonicalJunctureOrder));
            ColorValues = nan(length(obj.CanonicalJunctureOrder), 3);
            AlphaValues = nan(1, length(obj.CanonicalJunctureOrder));
            StartIndex = 1;
            for cIndex = 1:length(obj.Clusters)
                CurrentCluster = obj.Clusters(cIndex);
                xCoordinates = CurrentCluster.xPerceptual;
                yCoordinates = CurrentCluster.yPerceptual;
                zCoordinates = CurrentCluster.zPerceptual;
                EndIndex = StartIndex + length(xCoordinates) - 1;
                xValues(StartIndex:EndIndex) = xCoordinates;
                yValues(StartIndex:EndIndex) = yCoordinates;
                zValues(StartIndex:EndIndex) = zCoordinates;
                ColorValues(StartIndex:EndIndex, :) = ones(length( ...
                    xCoordinates), 1) * ColorArray(cIndex, :);
                AlphaValues(StartIndex:EndIndex) = AlphaClusterValues( ...
                    cIndex, 1);
                StartIndex = EndIndex + 1;
            end
        end
    end
end