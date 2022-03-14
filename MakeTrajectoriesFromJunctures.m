%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [MTrajectory, PTrajectory] = MakeTrajectoriesFromJunctures( ...
    JunctureList)
    MotorPointList = cell(length(JunctureList), 1);
    PerceptualPointList = cell(length(JunctureList), 1);
    for j = 1:length(JunctureList)
        MotorPointList{j,1} = JunctureList{j,1}.MotorPoint;
        PerceptualPointList{j,1} = JunctureList{j,1}.PerceptualPoint;
    end
    % I think there shouldn't be any additional points between these points
    PointsBetweenEachPoint = zeros(length(JunctureList) - 1, 1);
    MTrajectory = MotorTrajectory(MotorPointList, PointsBetweenEachPoint);
    PTrajectory = PerceptualTrajectory(PerceptualPointList);
end