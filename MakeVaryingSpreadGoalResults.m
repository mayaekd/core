%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% EXAMPLE
% GoalList = {Goal1}
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
        % Space1.MaxDistanceWithActivation
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
function [GoalResultsM, GoalResultsP] = MakeVaryingSpreadGoalResults( ...
    GoalList, spread)
    % Assuming that GoalList{1,g} is the gth goal
    
    % Some fixed values
    CorrectionTimes = [];
    AdjustmentSpread = spread;
    CurrentExecutionParameters = ExecutionParameters(2, 4, spread);
    LengthOfAdjustments = [];

    % Initializing
    NumGoals = length(GoalList);
        % EX| NumGoals = 1
    GoalResultsM = cell(1, NumGoals);
        % EX| GoalResultsM = {[]}
    GoalResultsP = cell(1, NumGoals);
        % EX| GoalResultsP = {[]}
    % Filling in
    for g = 1:NumGoals
        CurrentGoal = GoalList{1,g};
            % EX| CurrentGoal = Goal1
        [AverageJunctureEstimates, FinalActivationValues] = ...
            CurrentGoal.SimpleMacroEstimatesWithAdjustments( ...
            AdjustmentSpread, CurrentExecutionParameters, ...
            CorrectionTimes, LengthOfAdjustments);
        [MTrajectory, PTrajectory] = ...
            MakeTrajectoriesFromJunctures( ...
            AverageJunctureEstimates);
        GoalResultsM{1,g} = MTrajectory;
        GoalResultsP{1,g} = PTrajectory;
        fprintf("Finished goal: ");
        fprintf("%d", g);
        fprintf("\n");
    end
end