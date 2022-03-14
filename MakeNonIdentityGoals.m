%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

StandardSpaceTransformation
CurrentSpaceTransformation = standardSpaceTransformation;
MotorBounds = [0 40];

%% PREPPING TO MAKE SPACES

MaxDistanceValue = 10;

xStart = 1;
yStart = 1;
StepSize = 1;
SideLength = 3;
DistanceBetweenClusters = 2;
NumClustersPerSide = 8;

ClusterArray = MakeManySquareClusters(xStart, yStart, StepSize, ...
    SideLength, DistanceBetweenClusters, NumClustersPerSide, ...
    CurrentSpaceTransformation);


%% MAKING SPACES
CurrentSpace = Space(ClusterArray, CurrentSpaceTransformation, ...
    MotorBounds, MaxDistanceValue);

%% PREPPING TO MAKE GOALS

DistanceRangeBetweenAdjacentTimes = [3 10];
NoiseBounds = [-4 4];

SilhouetteRadius = 4;

TotalNumberOfGoals = 100;
NumberOfIntegersSupplied = 10000;
LengthOfGoals = 5;
TimesBetweenSilhouttePoints = 3;
SilhouetteLength = LengthOfGoals + ((LengthOfGoals - 1) * TimesBetweenSilhouttePoints);

NumPointsBetweenTrajectoryPoints = 10 * ones(LengthOfGoals - 1, 1);

%% MAKING GOALS
% Setting the seed -- this is what we can change to change it
rng(0); 
% This gives a matrix of possible points where PossibleMotorPoints(1,3,5)
% would be the 3rd possible x value for the 5th goal, and 
% PossibleMotorPoints(2,3,5) would be the 3rd possible y value for the 5th 
% goal
PossibleMotorPoints = randi(MotorBounds, [2, NumberOfIntegersSupplied, TotalNumberOfGoals]);
% This gives a matrix of values where NoiseForPerceptualGoal(1,3,5) would 
% be the amount of noise to add to the 3rd point's x value for the 5th 
% goal, and NoiseForPerceptualGoal(2,3,5) would be the amount of noise to 
% add to the 3rd point's y value for the 5th goal
NoiseForPerceptualGoal = randi(NoiseBounds, [2, LengthOfGoals, TotalNumberOfGoals]);

AllMotorPointLists = cell(TotalNumberOfGoals,1);
for n = 1:TotalNumberOfGoals
    MotorPointList = cell(LengthOfGoals, 1);
    rCurrent = 1;
    gCurrent = 1;
    while gCurrent <= LengthOfGoals
        if rCurrent > NumberOfIntegersSupplied
            error("Ran out of integers to use");
        end
        CurrentPossibleMotorPoint = MotorPoint(PossibleMotorPoints(:,rCurrent,n));
        if gCurrent == 1
            MotorPointList{gCurrent, 1} = CurrentPossibleMotorPoint;
            gCurrent = gCurrent + 1;
        else
            CurrentDistance = CurrentPossibleMotorPoint.Distance(MotorPointList{gCurrent - 1,1});
            if CurrentDistance >= DistanceRangeBetweenAdjacentTimes(1,1)
                if CurrentDistance <= DistanceRangeBetweenAdjacentTimes(1,2)
                    MotorPointList{gCurrent, 1} = CurrentPossibleMotorPoint;
                    gCurrent = gCurrent + 1;
                end
            end
        end
        rCurrent = rCurrent + 1;
    end
    AllMotorPointLists{n,1} = MotorPointList;
end

AllMotorPointsForPerceptual = cell(TotalNumberOfGoals, 1);
for n = 1:TotalNumberOfGoals
    MotorPointsForPerceptual = cell(LengthOfGoals, 1);
    for m = 1:LengthOfGoals
        OriginalMotorPointCoordinates = AllMotorPointLists{n,1}{m,1}.Coordinates;
        MotorPointWithNoise = MotorPoint(OriginalMotorPointCoordinates + NoiseForPerceptualGoal(:,m,n));
        CorrespondingPerceptualPoint = MotorPointWithNoise.FindPerceptualPoint(CurrentSpaceTransformation);
        MotorPointsForPerceptual{m,1} = CorrespondingPerceptualPoint;
    end
    AllMotorPointsForPerceptual{n,1} = MotorPointsForPerceptual;
end


NonIdentityGoalList = cell(1, TotalNumberOfGoals);
for g = 1:TotalNumberOfGoals
    CurrentSilhouette = MakeSilhouetteWithPointsAndRadiuses(...
        AllMotorPointLists{g,1}, ...
        TimesBetweenSilhouttePoints * ones(LengthOfGoals - 1,1), ...
        SilhouetteRadius * ones(SilhouetteLength,1));
    CurrentMotorTrajectory = MotorTrajectory( ...
        AllMotorPointsForPerceptual{g,1}, NumPointsBetweenTrajectoryPoints);
    CurrentTrajectory = CurrentMotorTrajectory.FindPerceptualTrajectory(...
        CurrentSpaceTransformation);
    CurrentGoal = Goal(CurrentSpace, CurrentSilhouette, CurrentTrajectory);
    NonIdentityGoalList{1,g} = CurrentGoal;
    fprintf("Finished goal ");
    fprintf("%d", g);
    fprintf("\n");
end

