%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function LengthOfTrajectory = ComputeTrajectoryLength(Trajectory)
    LengthOfTrajectory = 0;
    for p = 1:length(Trajectory.Points) - 1
        Distance = Trajectory.Points{p,1}.Distance(Trajectory.Points{p+1,1});
        LengthOfTrajectory = LengthOfTrajectory + Distance;
    end
end