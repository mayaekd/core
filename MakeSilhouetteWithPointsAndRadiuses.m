%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ResultingSilhouette = MakeSilhouetteWithPointsAndRadiuses(...
    MotorPointList, PointsBetweenEachPoint, Radiuses)
    TotalNumPoints = length(MotorPointList) + ...
        sum(PointsBetweenEachPoint);
    FinalPoints = cell(TotalNumPoints, 1);
    StartIndex = 1;
    if length(MotorPointList) == 1
        FinalPoints = MotorPointList;
    end
    % Otherwise (this for loop won't execute if length(PerceptualPointCellArray) = 1)
    for n = 1:length(MotorPointList) - 1
        CurrentVectorX = transpose(linspace(MotorPointList{n,1}.x, MotorPointList{n + 1,1}.x, PointsBetweenEachPoint(n,1) + 2));
        CurrentVectorY = transpose(linspace(MotorPointList{n,1}.y, MotorPointList{n + 1,1}.y, PointsBetweenEachPoint(n,1) + 2));
        for p = 1:length(CurrentVectorX)
            FinalPoints{StartIndex + p - 1,1} = PerceptualPoint([CurrentVectorX(p,1); CurrentVectorY(p,1)]);
        end
        StartIndex = StartIndex + PointsBetweenEachPoint(n, 1) + 1;
    end
    RegionList = cell(TotalNumPoints, 1);
    for r = 1:length(RegionList)
        RegionList{r,1} = MotorRegionTemp(FinalPoints{r,1}, Radiuses(r,1));
    end
    ResultingSilhouette = MotorSilhouette(RegionList);
end