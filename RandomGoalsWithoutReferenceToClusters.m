%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

StandardSpaceTransformation
StandardPlottingParameters;
currentSpaceTransformation = standardSpaceTransformation;
MotorBounds = [0 40];

DistanceRangeBetweenAdjacentTimes = [3 10];
NoiseBounds = [-4 4];

SilhouetteRadius = 8;
NumberOfSpaces = 3;

TotalNumberOfGoals = 1;
NumberOfIntegersSupplied = 100;
LengthOfGoals = 5;

TimesToAdjust = {[];
%     [1; 4; 8; 11];
%     [1; 3; 4; 5; 7; 8; 9; 11];
    [1; 2; 3; 4; 5]
    };

LengthsOfAdjustments = {0};

NumberOfAdjustments = length(TimesToAdjust);
NumberOfAdjustmentLengths = length(LengthsOfAdjustments);
NumPointsBetweenTrajectoryPoints = 10 * ones(LengthOfGoals - 1, 1);

ClusterArrays = cell(NumberOfSpaces, 1);
MaxDistanceValues = cell(NumberOfSpaces, 1);

for s = 1:NumberOfSpaces
    if s == 1
        xStart = 1.9;
        yStart = 1.9;
        StepSize = 0.4;
        SideLength = 1.2;
        DistanceBetweenClusters = 3.8;
        NumClustersPerSide = 8;
    elseif s == 2
        xStart = 2;
        yStart = 2;
        StepSize = 2;
        SideLength = 6;
        DistanceBetweenClusters = 2;
        NumClustersPerSide = 4;
    elseif s == 3
        xStart = 1;
        yStart = 1;
        StepSize = 1;
        SideLength = 3;
        DistanceBetweenClusters = 2;
        NumClustersPerSide = 8;
    end
    CurrentSpaceTransformation = currentSpaceTransformation;
    ClusterArray = MakeManySquareClusters(xStart, yStart, ...
        StepSize, SideLength, DistanceBetweenClusters, ...
        NumClustersPerSide, CurrentSpaceTransformation);
    MaxDistance = SideLength + DistanceBetweenClusters;
    ClusterArrays{s,1} = ClusterArray;
    MaxDistanceValues{s,1} = MaxDistance;
end

%% MAKING SPACES
AllSpaces = cell(NumberOfSpaces, 1);
for n = 1:NumberOfSpaces
    CurrentSpace = Space(ClusterArrays{n,1}, currentSpaceTransformation, ...
        MotorBounds, MaxDistanceValues{n,1});
    AllSpaces{n, 1} = CurrentSpace;
end

%% MAKING GOALS
rng(0); % Setting the seed -- this is what we can change to change it
PossibleMotorPoints = randi(MotorBounds, [2, NumberOfIntegersSupplied, TotalNumberOfGoals]);
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
        CorrespondingPerceptualPoint = MotorPointWithNoise.FindPerceptualPoint(currentSpaceTransformation);
        MotorPointsForPerceptual{m,1} = CorrespondingPerceptualPoint;
    end
    AllMotorPointsForPerceptual{n,1} = MotorPointsForPerceptual;
end


GoalList = cell(TotalNumberOfGoals, NumberOfSpaces);
for n = 1:TotalNumberOfGoals
    for s = 1:NumberOfSpaces
        CurrentSpace = AllSpaces{s,1};
        CurrentSilhouette = MakeSilhouetteWithPointsAndRadiuses(...
            AllMotorPointLists{n,1}, zeros(LengthOfGoals - 1,1), SilhouetteRadius * ones(length(AllMotorPointLists{n,1}),1));
        CurrentMotorTrajectory = MotorTrajectory(AllMotorPointsForPerceptual{n,1}, NumPointsBetweenTrajectoryPoints);
        CurrentTrajectory = CurrentMotorTrajectory.FindPerceptualTrajectory(CurrentSpace.SpaceTransformation);
        CurrentGoal = Goal(CurrentSpace, CurrentSilhouette, CurrentTrajectory);
        GoalList{n,s} = CurrentGoal;
    end
end

%% MAKING OTHER THINGS THAT VARY

CurrentExecutionParameters = {...
    ExecutionParameters(1, 1, "perceptual")};
currentPlottingParameters = standardPlottingParameters;
NumberOfExecutionParameters = length(CurrentExecutionParameters);


%% PARAMETERS

FigureData = false;
SaveFigureData = false;
FilePathForFigureData = ".\Individual_Outcomes\";
AdjustmentSpread = "none";

%% INITIALIZE

AverageJunctureEstimatesMatrix = cell(NumberOfSpaces, TotalNumberOfGoals, NumberOfAdjustments, NumberOfAdjustmentLengths, NumberOfExecutionParameters);
FinalActivationValuesMatrix = cell(NumberOfSpaces, TotalNumberOfGoals, NumberOfAdjustments, NumberOfAdjustmentLengths, NumberOfExecutionParameters);
ResultingMotorTrajectoryMatrix = cell(NumberOfSpaces, TotalNumberOfGoals, NumberOfAdjustments, NumberOfAdjustmentLengths, NumberOfExecutionParameters);
ResultingPerceptualTrajectoryMatrix = cell(NumberOfSpaces, TotalNumberOfGoals, NumberOfAdjustments, NumberOfAdjustmentLengths, NumberOfExecutionParameters);
MotorTrajectoryLengthMatrix = zeros(NumberOfSpaces, TotalNumberOfGoals, NumberOfAdjustments, NumberOfAdjustmentLengths, NumberOfExecutionParameters);

if FigureData == true
    MotorAxesMatrix = cell(NumberOfSpaces, TotalNumberOfGoals, NumberOfAdjustments, NumberOfAdjustmentLengths, NumberOfExecutionParameters);
    PerceptualAxesMatrix = cell(NumberOfSpaces, TotalNumberOfGoals, NumberOfAdjustments, NumberOfAdjustmentLengths, NumberOfExecutionParameters);
    FigureDataMatrix = cell(NumberOfSpaces, TotalNumberOfGoals, NumberOfAdjustments, NumberOfAdjustmentLengths, NumberOfExecutionParameters);
    
    FigureColors = {[1 0 0]; [1 0.5 0]; [1 1 0]; 
        [0 0.8 0.2]; [0.3 0.3 1]; [0 0 1]; [0.5 0 1]};
    for s = 1:NumberOfSpaces
        for g = 1:TotalNumberOfGoals
            for a = 1:NumberOfAdjustments
                for l = 1:NumberOfAdjustmentLengths
                    for p = 1:NumberOfExecutionParameters
                        [Figure, AxesList] = MakeFigureAndAxes(FigureColors{g,1}, ...
                            [0.3 0 0.3], 4, 6, ...
                            [0 40], [0 40]);
                        FinalMAxesList = AxesList(1:11, 1);
                        FinalPAxesList = AxesList(13:23, 1);
                        MotorAxesMatrix{s, g,a,l,p} = FinalMAxesList;
                        PerceptualAxesMatrix{s, g,a,l,p} = FinalPAxesList;
                    end
                end
            end
        end
    end
end


%% FIND RESULTING PATHS
% Finding the activation over time, with each adjustment applied to each
% goal
for s = 1:NumberOfSpaces
    for g = 1:TotalNumberOfGoals
        CurrentGoal = GoalList{g,s};
        for a = 1:NumberOfAdjustments
            CurrentTimesToAdjust = TimesToAdjust{a,1};
            for l = 1:NumberOfAdjustmentLengths
                CurrentLengthsOfAdjustments = LengthsOfAdjustments{l,1} * ones(size(CurrentTimesToAdjust));
                for p = 1:NumberOfExecutionParameters
                    fprintf("s, g, a, l, p: %d %d %d %d %d", s, g, a, l, p);
                    currentExecutionParameters = CurrentExecutionParameters{p,1};
                    [AverageJunctureEstimates, FinalActivationValues] = ...
                        CurrentGoal.SimpleMacroEstimatesWithAdjustments(AdjustmentSpread, ...
                        currentExecutionParameters, CurrentTimesToAdjust, ...
                        CurrentLengthsOfAdjustments);
                    if FigureData == true
                        MotorAxesList = MotorAxesMatrix{s,g,a,l,p};
                        PerceptualAxesList = PerceptualAxesMatrix{s,g,a,l,p};
                        CurrentFigureData = Dec14FindFullFigureData(MotorAxesList, PerceptualAxesList, ...
                            AverageJunctureEstimates, FinalActivationValues, CurrentGoal, ...
                            currentExecutionParameters, CurrentPlottingParameters);
                        FigureDataMatrix{s,g,a,l,p} = CurrentFigureData;
                    end
                    [MTrajectory, PTrajectory] = MakeTrajectoriesFromJunctures(...
                        AverageJunctureEstimates);
                    AverageJunctureEstimatesMatrix{s,g,a,l,p} = AverageJunctureEstimates;
                    FinalActivationValuesMatrix{s,g,a,l,p} = FinalActivationValues;
                    ResultingMotorTrajectoryMatrix{s,g,a,l,p} = MTrajectory;
                    ResultingPerceptualTrajectoryMatrix{s,g,a,l,p} = PTrajectory;
                    MotorTrajectoryLengthMatrix(s,g,a,l,p) = ComputeTrajectoryLength(MTrajectory);
                end
            end
        end
    end
end

%% FIND THE DISTANCES FROM THE GOAL

DistancesFromGoalsMatrix = zeros(NumberOfSpaces, TotalNumberOfGoals, NumberOfAdjustments, NumberOfAdjustmentLengths, NumberOfExecutionParameters);
for s = 1:NumberOfSpaces
    for g = 1:TotalNumberOfGoals
        CurrentGoal = GoalList{g,s};
        for a = 1:NumberOfAdjustments
            for l = 1:NumberOfAdjustmentLengths
                for p = 1:NumberOfExecutionParameters
                    dist = CurrentGoal.Trajectory.DistanceToTrajectory(ResultingPerceptualTrajectoryMatrix{s,g,a,l,p});
                    DistancesFromGoalsMatrix(s,g,a,l,p) = dist;
                end
            end
        end
    end
end

%% MAKE GRAPHS

% ALPGDistancesFromGoalsMatrix = permute(DistancesFromGoalsMatrix,[2 3 4 1]);
% FreqChecking = ["Check never", ...
%     "Check at times 1, 4, 8, 11", ...
%     "Check at times 1, 3, 4, 5, 7, 8, 9, 11", ...
%     "Check at all times"];
% GoalNumbers = ["Goal 1"; "Goal 2"; "Goal 3"; "Goal 4"; "Goal 5"];
NewFigure1 = figure();
% heatmap(NewFigure1, FreqChecking, GoalNumbers, ...
%     DistancesFromGoalsMatrix(:,:,1,1))
NewFigure2 = figure();
% heatmap(NewFigure2, FreqChecking, GoalNumbers, ...
%     DistancesFromGoalsMatrix(:,:,1,2))
NewAxes1 = axes(NewFigure1);
NewAxes2 = axes(NewFigure2);
SAGLPDistancesFromGoalsMatrix = permute(DistancesFromGoalsMatrix, [1 3 2 4 5]);
DistanceMatrix1 = SAGLPDistancesFromGoalsMatrix(:,:,1,1,1);
DistanceMatrix2 = SAGLPDistancesFromGoalsMatrix(:,:,1,1,2);
plot(NewAxes1, transpose(DistanceMatrix1), "LineWidth", 2);
plot(NewAxes2, transpose(DistanceMatrix2), "LineWidth", 2);

%% SAVING INDIVIDUAL PATHS
if SaveFigureData
    for A = 1:TotalNumberOfGoals
        for B = 1:NumberOfAdjustments
            for C = 1:NumberOfAdjustmentLengths
                for D = 1:NumberOfExecutionParameters
                    CurrentFigure = FigureDataMatrix{A,B,C,D}.AxesList{1,1}.Parent;
                    CurrentFigure.WindowState = "maximized";
                    FigureDataMatrix{A,B,C,D}.PlotFigures()
                end
            end
        end
    end
end





