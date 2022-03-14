%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% IMPORTING SPACE TRANSFORMATION
StandardSpaceTransformation
CurrentSpaceTransformation = standardSpaceTransformation;

%% SETTING PARAMETERS TO MAKE SPACES
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

MotorBounds = [0 40];

%% MAKING SPACES
CurrentSpace = Space(ClusterArray, CurrentSpaceTransformation, ...
    MotorBounds, MaxDistanceValue);

%% SETTING PARAMETERS TO MAKE GOALS
NumberOfGoals = 100;
NumPointsBetweenThreePoints = 2;
SilhouetteRadiuses = 4;

ThreeClusterGoals = cell(1, NumberOfGoals);
TotalTime = 2 * NumPointsBetweenThreePoints + 3;

%% SETTING RANDOM VALUES
ClusterIndexRange = [1 64];
CoordinateChangeValues = [-6.5 -5.5 -4.5 -3.5 3.5 4.5 5.5 6.5];
CoordinateChangeRange = [1 length(CoordinateChangeValues)];
NumberOfIntegersSupplied = 2 * NumberOfGoals;

rng(0);
MiddleClusterIndices = randi(ClusterIndexRange, [1 NumberOfIntegersSupplied]);
BackwardCoordinateChangeIndices = randi(CoordinateChangeRange, [2 NumberOfIntegersSupplied]);
ForwardCoordinateChangeIndices = randi(CoordinateChangeRange, [2 NumberOfIntegersSupplied]);
BackwardCoordinateChanges = CoordinateChangeValues(BackwardCoordinateChangeIndices);
ForwardCoordinateChanges = CoordinateChangeValues(ForwardCoordinateChangeIndices);

%% MAKING GOALS
AttemptIndex = 1;
for n = 1:NumberOfGoals
    while AttemptIndex <= NumberOfIntegersSupplied
        % Find parameters for this goal
        MiddleClusterIndex = MiddleClusterIndices(1, AttemptIndex);
        BackwardChangeInMotorCoordinates = BackwardCoordinateChanges(1, AttemptIndex);
        ForwardChangeInMotorCoordinates = ForwardCoordinateChanges(1, AttemptIndex);
    
        % Find middle cluster
        MiddleCluster = CurrentSpace.Clusters{MiddleClusterIndex,1};
        MiddleMotorPointCoordinates = transpose(MiddleCluster.Center().MotorPoint.Coordinates);
    
        FirstMotorPointCoordinates = MiddleMotorPointCoordinates + BackwardChangeInMotorCoordinates;
        LastMotorPointCoordinates = MiddleMotorPointCoordinates + ForwardChangeInMotorCoordinates;
        AttemptIndex = AttemptIndex + 1;
        if ((FirstMotorPointCoordinates <= [40 40]) & ...
            (FirstMotorPointCoordinates >= [0 0])) & ...
            ((LastMotorPointCoordinates <= [40 40]) & ...
            (LastMotorPointCoordinates >= [0 0]))
            break
        else
            continue
        end
    end
    MotorPointCoordinateList = interp1([1 2 + NumPointsBetweenThreePoints TotalTime], ...
        [FirstMotorPointCoordinates; MiddleMotorPointCoordinates; LastMotorPointCoordinates], 1:TotalTime);

    MotorRegions = cell(TotalTime,1);
    JunctureList = cell(TotalTime,1);

    for t = 1:TotalTime
        MotorRegions{t,1} = MotorRegionTemp(MotorPoint(transpose(MotorPointCoordinateList(t,:))), SilhouetteRadiuses);
        JunctureList{t,1} = MotorPoint(transpose(MotorPointCoordinateList(t,:))).MakeJuncture(CurrentSpace.SpaceTransformation);
    end

    CurrentSilhouette = MotorSilhouette(MotorRegions);
    [~, CurrentTrajectory] = MakeTrajectoriesFromJunctures(JunctureList);
    CurrentGoal = Goal(CurrentSpace, CurrentSilhouette, CurrentTrajectory);
    ThreeClusterGoals{1,n} = CurrentGoal;
    fprintf("Goal %d finished, centered on cluster %d \n", n, MiddleClusterIndex)
end
