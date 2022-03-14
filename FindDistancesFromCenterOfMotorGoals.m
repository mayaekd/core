%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Distances = FindDistancesFromCenterOfMotorGoals(GoalList, MotorTrajectoryList)
    Distances = zeros(1,length(GoalList));
    for n = 1:length(GoalList)
        CurrentGoal = GoalList{1,n};
        CurrentSilhouette = CurrentGoal.Silhouette;
        MotorPointList = cell(size(CurrentSilhouette.Regions));
        for p = 1:length(MotorPointList)
            MotorPointList{p,1} = CurrentSilhouette.Regions{p,1}.Center;
        end
        CurrentMotorGoal = MotorTrajectory(MotorPointList, zeros(length(MotorPointList)-1,1));
        CurrentMotorTrajectory = MotorTrajectoryList{1,n};
        CurrentDistance = CurrentMotorTrajectory.DistanceToTrajectory( ...
            CurrentMotorGoal);
        Distances(1,n) = CurrentDistance;
    end
end
