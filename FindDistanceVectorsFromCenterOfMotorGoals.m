%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function DistanceVectors = FindDistanceVectorsFromCenterOfMotorGoals( ...
    GoalList, MotorTrajectoryList)
    % Find the distance of each point in the motor trajectory from the
    % center of the motor goal (the silhouette part of the goal)
    % For example: DistanceVectors(a,b) is the distance of the ath point in
    % the motor trajectory from the center of the middle of the bth goal.
    % Only works for silhouettes with an odd number of regions.
    MaxMotorTrajectoryLength = 0;
    for m = 1:length(MotorTrajectoryList)
        MaxMotorTrajectoryLength = max(MaxMotorTrajectoryLength, length(MotorTrajectoryList{1,m}.Points));
    end
    DistanceVectors = zeros(MaxMotorTrajectoryLength, length(GoalList));
    for n = 1:length(GoalList)
        CurrentGoal = GoalList{1,n};
        CurrentMotorTrajectory = MotorTrajectoryList{1,n};
        CenterTime = (1 + length(CurrentGoal.Silhouette.Regions))/2;
        CurrentCenterOfMotorGoal = ...
            CurrentGoal.Silhouette.Regions{CenterTime,1}.Center;
        CurrentDistanceVector = zeros(length(CurrentMotorTrajectory),1);
        for m = 1:length(CurrentMotorTrajectory.Points)
            CurrentDistanceVector(m,1) = ...
                CurrentMotorTrajectory.Points{m,1}.Distance( ...
                CurrentCenterOfMotorGoal);
        end
        % We'll use this in the future
        % TrajectorifiedPoint = MotorTrajectory({CurrentCenterOfMotorGoal});
        % CurrentDistanceVector = MotorTrajectoryList{n,1}.DistanceVectorToTrajectory(TrajectorifiedPoint);
        DistanceVectors(1:length(CurrentDistanceVector),n) = CurrentDistanceVector;
    end
end
