%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function DistanceVectors = FindDistanceVectorsFromCenterOfMotorGoals(GoalList, MotorTrajectoryList)
    DistanceVectors = zeros(length(MotorTrajectoryList{1,1}.Points), length(GoalList));
    for n = 1:length(GoalList)
        CenterTime = (1 + length(MotorTrajectoryList{1,1}.Points))/2;
        CurrentGoal = GoalList{1,n};
        CurrentCenterOfMotorGoal = CurrentGoal.Silhouette.Regions{CenterTime,1}.Center;
        CurrentMotorTrajectory = MotorTrajectoryList{1,n};
        CurrentDistanceVector = zeros(length(CurrentMotorTrajectory),1);
        for m = 1:length(CurrentMotorTrajectory.Points)
            CurrentDistanceVector(m,1) = CurrentMotorTrajectory.Points{m,1}.Distance(CurrentCenterOfMotorGoal);
        end
        % We'll use this in the future
        % TrajectorifiedPoint = MotorTrajectory({CurrentCenterOfMotorGoal});
        % CurrentDistanceVector = MotorTrajectoryList{n,1}.DistanceVectorToTrajectory(TrajectorifiedPoint);
        DistanceVectors(:,n) = CurrentDistanceVector;
    end
end
