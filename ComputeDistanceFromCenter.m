%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function TotalDistance = ComputeDistanceFromCenter(Trajectory, CenterCoordinates)
    if class(Trajectory) == "MotorTrajectory"
        CenterPoint = MotorPoint(CenterCoordinates);
    elseif class(Trajectory) == "PerceptualTrajectory"
        CenterPoint = PerceptualPoint(CenterCoordinates);
    end
    TotalDistance = 0;
    for p = 1:length(Trajectory.Points)
        Distance = Trajectory.Points{p,1}.Distance(CenterPoint);
        TotalDistance = TotalDistance + Distance;
    end
end