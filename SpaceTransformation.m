%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHOD LIST
%  SpaceTransformation
%  CreateCluster
%  CreateSpace

%% CLASS DEFINITION

classdef SpaceTransformation
    properties
        TransformationFunction;
    end
    methods
        % Creating an object
        % EX: If TransformationFunction's name is ExampleFunction, then to
        % make this object, you write NewSpaceTransformation =
        % SpaceTransformation(@ExampleFunction).
        function obj = SpaceTransformation(TransformationFunction)
            obj.TransformationFunction = TransformationFunction;
        end

        function ResultingCluster = CreateCluster(obj, ...
                MotorCoordinateMatrix, CoordinateOptions)
            arguments
                obj
                MotorCoordinateMatrix (:,:) {mustBeNumeric}
                CoordinateOptions.xMotorRowIndex {mustBeNumeric} = 1
                CoordinateOptions.yMotorRowIndex {mustBeNumeric} = 2
                CoordinateOptions.zMotorRowIndex {mustBeNumeric} = nan
                CoordinateOptions.xPerceptualRowIndex {mustBeNumeric} = 1
                CoordinateOptions.yPerceptualRowIndex {mustBeNumeric} = 2
                CoordinateOptions.zPerceptualRowIndex {mustBeNumeric} = nan
            end
            %% Motor coordinate plotting info
            % If xMotorRowIndex or yMotorRowIndex is nan, override it
            if isnan(CoordinateOptions.xMotorRowIndex)
                xMotorRowIndex = 1;
            else
                xMotorRowIndex = CoordinateOptions.xMotorRowIndex;
            end
            if isnan(CoordinateOptions.yMotorRowIndex)
                yMotorRowIndex = 2;
            else
                yMotorRowIndex = CoordinateOptions.yMotorRowIndex;
            end
            zMotorRowIndex = CoordinateOptions.zMotorRowIndex;
            %% Perceptual coordinate plotting info
            % If xPerceptualRowIndex or yPerceptualRowIndex is nan, override it
            if isnan(CoordinateOptions.xPerceptualRowIndex)
                xPerceptualRowIndex = 1;
            else
                xPerceptualRowIndex = CoordinateOptions.xPerceptualRowIndex;
            end
            if isnan(CoordinateOptions.yPerceptualRowIndex)
                yPerceptualRowIndex = 2;
            else
                yPerceptualRowIndex = CoordinateOptions.yPerceptualRowIndex;
            end
            zPerceptualRowIndex = CoordinateOptions.zPerceptualRowIndex;
            %%
            NumPerceptualDimensions = length(obj.TransformationFunction( ...
                MotorCoordinateMatrix(:, 1)));
            PerceptualCoordinateMatrix = nan(NumPerceptualDimensions, ...
                size(MotorCoordinateMatrix, 2));
            for p = 1:size(PerceptualCoordinateMatrix, 2)
                PerceptualCoordinateMatrix(:, p) = obj.TransformationFunction(MotorCoordinateMatrix(:, p));
            end
            ResultingCluster = Cluster(MotorCoordinateMatrix, ...
                PerceptualCoordinateMatrix, ...
                "xMotorRowIndex", xMotorRowIndex, ...
                "yMotorRowIndex", yMotorRowIndex, ...
                "zMotorRowIndex", zMotorRowIndex, ...
                "xPerceptualRowIndex", xPerceptualRowIndex, ...
                "yPerceptualRowIndex", yPerceptualRowIndex, ...
                "zPerceptualRowIndex", zPerceptualRowIndex);
        end

        % Making a space out of motor points & using this transformation
        % EXAMPLE: 
        % TransformationFunction([x; y]) = [x - 2; y^2]
        % MotorPointMatrixList = {[3 4 3; 4 4 5]; [6 6; 5 6]};
        function ResultingSpace = CreateSpace(obj, ...
                MotorCoordinateMatrixList, Options)
            arguments
                obj
                MotorCoordinateMatrixList
                Options.xMotorRowIndex {mustBeNumeric} = 1
                Options.yMotorRowIndex {mustBeNumeric} = 2
                Options.zMotorRowIndex {mustBeNumeric} = nan
                Options.xPerceptualRowIndex {mustBeNumeric} = 1
                Options.yPerceptualRowIndex {mustBeNumeric} = 2
                Options.zPerceptualRowIndex {mustBeNumeric} = nan
                Options.MaxDistanceWithActivationM {mustBeNumeric} = 10
                Options.MaxDistanceWithActivationP {mustBeNumeric} = 10
            end
            ClusterList = Cluster.empty(0);
            for cIndex = 1:length(MotorCoordinateMatrixList) % EX| cIndex = 1:2
                CurrentMotorCoordinateMatrix = MotorCoordinateMatrixList{cIndex};
                    % EX| when cIndex = 1, CurrentMotorPointList = 
                    % EX| [3 4 3; 4 4 5]
                    % EX| when cIndex = 2, CurrentMotorPointList = 
                    % EX| [6 6; 5 6]
                CurrentCluster = obj.CreateCluster( ...
                    CurrentMotorCoordinateMatrix, ...
                    "xMotorRowIndex", Options.xMotorRowIndex, ...
                    "yMotorRowIndex", Options.yMotorRowIndex, ...
                    "zMotorRowIndex", Options.zMotorRowIndex, ...
                    "xPerceptualRowIndex", Options.xPerceptualRowIndex, ...
                    "yPerceptualRowIndex", Options.yPerceptualRowIndex, ...
                    "zPerceptualRowIndex", Options.zPerceptualRowIndex);
                ClusterList(cIndex) = CurrentCluster;
                    % EX| ClusterList(1) is ClusterA and 
                    % EX| ClusterList(2) is ClusterB where these 
                    % EX| clusters contain the junctures with the following
                    % EX| MotorPoint Coordinates (MPC) and PerceptualPoint
                    % EX| Coordinates (PPC):
                    % EX| ClusterA:
                    % EX| MPC = [3; 4] & PPC = [1; 16]
                    % EX| MPC = [4; 4] & PPC = [2; 16]
                    % EX| MPC = [3; 5] & PPC = [1; 25]
                    % EX| ClusterB:
                    % EX| MPC = [6; 5] & PPC = [4; 25]
                    % EX| MPC = [6; 6] & PPC = [4; 36]
            end
            ResultingSpace = Space(ClusterList, obj, ...
                "MaxDistanceWithActivationM", ...
                Options.MaxDistanceWithActivationM, ...
                "MaxDistanceWithActivationP", ...
                Options.MaxDistanceWithActivationP);
                % EX| ResultingSpace.Clusters = [ClusterA ClusterB]
                % EX| ResultingSpace.SpaceTransformation = obj
        end
    end
end