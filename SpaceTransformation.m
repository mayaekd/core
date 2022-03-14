%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

        % Making a space out of motor points & using this transformation
        % EXAMPLE: 
        % TransformationFunction([x; y]) = [x - 2; y^2]
        % MotorPointListList = {
        % {MotorPoint([3; 4]); MotorPoint([4; 4]); MotorPoint([3; 5])};
        % {MotorPoint([6; 5]); MotorPoint([6; 6])} };
        function ResultingSpace = CreateSpace(obj, MotorPointListList)
            ClusterList = cell(length(MotorPointListList), 1);
                % EX| ClusterList = {[]; []}
            for cIndex = 1:length(ClusterList) % EX| cIndex = 1:2
                CurrentMotorPointList = MotorPointListList{cIndex, 1};
                    % EX| when cIndex = 1, CurrentMotorPointList = 
                    % EX| {MotorPoint([3; 4]); MotorPoint([4; 4]); 
                    % EX| MotorPoint([3; 5])}
                    % EX| when cIndex = 2, CurrentMotorPointList = 
                    % EX| {MotorPoint([6; 5]); MotorPoint([6; 6])}
                CurrentJunctureList = cell(length(CurrentMotorPointList), 1);
                    % EX| when cIndex = 1, CurrentJunctureList = cell(3, 1)
                    % EX| when cIndex = 2, CurrentJunctureList = cell(2, 1)
                for jIndex = 1:length(CurrentJunctureList)
                    CurrentMotorPoint = CurrentMotorPointList{jIndex, 1};
                        % EX| when cIndex = 1 & jIndex = 1,
                        % EX| CurrentMotorPoint = MotorPoint([3; 4])
                        % EX| when cIndex = 1 & jIndex = 2,
                        % EX| CurrentMotorPoint = MotorPoint([4; 4])
                        % EX| when cIndex = 1 & jIndex = 3,
                        % EX| CurrentMotorPoint = MotorPoint([3; 5])
                        % EX| when cIndex = 2 & jIndex = 1,
                        % EX| CurrentMotorPoint = MotorPoint([6; 5])
                        % EX| when cIndex = 2 & jIndex = 2,
                        % EX| CurrentMotorPoint = MotorPoint([6; 6])
                    % Turning all these motor points into junctures, to 
                    % subsequently be added to appropriate clusters -- 
                    % example results shown below
                    CurrentJuncture = CurrentMotorPoint.MakeJuncture(obj.TransformationFunction);
                    CurrentJunctureList{jIndex, 1} = CurrentJuncture;
                end
                CurrentCluster = Cluster(CurrentJunctureList);
                ClusterList{cIndex, 1} = CurrentCluster;
                    % EX| ClusterList{1, 1} is ClusterA and 
                    % EX| ClusterList{2, 1} is ClusterB where these 
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
            ResultingSpace = Space(ClusterList, obj);
                % EX| ResultingSpace.Clusters = {ClusterA; ClusterB}
                % EX| ResultingSpace.SpaceTransformation = obj
        end
    end
end