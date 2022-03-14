%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% PARAMETERS
% Import the goal parameter file necessary here
SetOfGoalsWithDenserClusters

FigureData = true;
SaveFigureData = true;
FilePathForFigureData = ".\Individual_Outcomes\";
AdjustmentSpread = "none";

% These will be decided
CurrentSpace = currentSpace;
CurrentExecutionParameters = currentExecutionParameters;
CurrentPlottingParameters = currentPlottingParameters;
ClusterAdjacencyList = clusterAdjacencyList;
SilhouetteRadius = silhouetteRadius;
NumPointsBetweenSilPoints = numPointsBetweenSilPoints;
NumPointsBetweenTrajPoints = numPointsBetweenTrajPoints;
% ComparisonList = comparisonList;

% These will be determined from random generation, or by writing here for
% the purposes of temporary testing
AllFirstClusters = allFirstClusters;
AllClusterLists = allClusterLists;
AllSilhouetteParts = allSilhouetteParts;
AllTrajectoryParts = allTrajectoryParts;
TimesToAdjust = timesToAdjust;
LengthsOfAdjustments = lengthsOfAdjustments;
NumberOfGoals = numberOfGoals;


%% DOING SOME PREP - THESE SHOULDN'T BE ALTERED
NumberOfClusters = length(AllClusterLists{1,1}) + 1;
PointsBetweenSilPointsVector = ...
    NumPointsBetweenSilPoints * ones(NumberOfClusters - 1, 1);
PointsBetweenTrajPointsVector = ...
    NumPointsBetweenTrajPoints * ones(NumberOfClusters - 1, 1);

NumberOfSilRegions = NumberOfClusters + sum(PointsBetweenSilPointsVector);
SilhouetteRadiuses = SilhouetteRadius * ones(NumberOfSilRegions, 1);
GoalList = cell(NumberOfGoals, 1);
NumberOfAdjustments = length(TimesToAdjust);
NumberOfAdjustmentLengths = length(LengthsOfAdjustments);
NumberOfExecutionParameters = length(CurrentExecutionParameters);

AverageJunctureEstimatesMatrix = cell(NumberOfGoals, NumberOfAdjustments, NumberOfAdjustmentLengths, NumberOfExecutionParameters);
FinalActivationValuesMatrix = cell(NumberOfGoals, NumberOfAdjustments, NumberOfAdjustmentLengths, NumberOfExecutionParameters);
ResultingMotorTrajectoryMatrix = cell(NumberOfGoals, NumberOfAdjustments, NumberOfAdjustmentLengths, NumberOfExecutionParameters);
ResultingPerceptualTrajectoryMatrix = cell(NumberOfGoals, NumberOfAdjustments, NumberOfAdjustmentLengths, NumberOfExecutionParameters);
MotorTrajectoryLengthMatrix = zeros(NumberOfGoals, NumberOfAdjustments, NumberOfAdjustmentLengths, NumberOfExecutionParameters);
PerceptualTrajectoryLengthMatrix = zeros(NumberOfGoals, NumberOfAdjustments, NumberOfAdjustmentLengths, NumberOfExecutionParameters);
% PerceptualDifferencesMatrix = zeros(length(ComparisonList), NumberOfGoals);

if FigureData == true
    MotorAxesMatrix = cell(NumberOfGoals, NumberOfAdjustments, NumberOfAdjustmentLengths, NumberOfExecutionParameters);
    PerceptualAxesMatrix = cell(NumberOfGoals, NumberOfAdjustments, NumberOfAdjustmentLengths, NumberOfExecutionParameters);
    FigureDataMatrix = cell(NumberOfGoals, NumberOfAdjustments, NumberOfAdjustmentLengths, NumberOfExecutionParameters);
    
    FigureColors = {[1 0 0]; [1 0.5 0]; [1 1 0]; 
        [0 0.8 0.2]; [0.3 0.3 1]; [0 0 1]; [0.5 0 1]};

    for g = 1:NumberOfGoals
        for a = 1:NumberOfAdjustments
            for l = 1:NumberOfAdjustmentLengths
                for p = 1:NumberOfExecutionParameters
                    [Figure, AxesList] = MakeFigureAndAxes(FigureColors{g,1}, ...
                        [0.3 0 0.3], 4, 6, ...
                        [0 40], [0 40]);
                    FinalMAxesList = AxesList(1:11, 1);
                    FinalPAxesList = AxesList(13:23, 1);
                    MotorAxesMatrix{g,a,l,p} = FinalMAxesList;
                    PerceptualAxesMatrix{g,a,l,p} = FinalPAxesList;
                end
            end
        end
    end
end

%% CHOOSING THE COLORS
ColorArray = {[1 0 1]; [0 0 1]; [0 0.8 0.8]; [1 0.2 0]; [0.5 0 1]; [1 0.8 0]};

%% MAKE THE GOALS
rCurrent = 1;
gCurrent = 1;
while gCurrent <= NumberOfGoals
    if rCurrent > length(AllFirstClusters)
        error("Ran out of integers to use");
    end
    FirstClusterIndex = AllFirstClusters(rCurrent,1);
    ClusterDeterminingList = AllClusterLists{rCurrent,1};
    SilhouettePartList = AllSilhouetteParts{rCurrent,1};
    TrajectoryPartList = AllTrajectoryParts{rCurrent,1};
    
    [currentGoal, ClusterIndicesHit] = MakeGoalFromIntegers(CurrentSpace, ClusterAdjacencyList, ...
        FirstClusterIndex, ClusterDeterminingList, SilhouettePartList, ...
        TrajectoryPartList, PointsBetweenSilPointsVector, ...
        PointsBetweenTrajPointsVector, SilhouetteRadiuses);
    [GC, GR] = groupcounts(ClusterIndicesHit);
    if max(GC) == 1
        GoalList{gCurrent,1} = currentGoal;
        gCurrent = gCurrent + 1;
    else
        fprintf("Repeats in Clusters: ");
        fprintf("%d ", ClusterIndicesHit);
        fprintf("\n");
    end
    rCurrent = rCurrent + 1;
end

%% FIND RESULTING PATHS
% Finding the activation over time, with each adjustment applied to each
% goal
for g = 1:NumberOfGoals
    CurrentGoal = GoalList{g,1};
    for a = 1:NumberOfAdjustments
        CurrentTimesToAdjust = TimesToAdjust{a,1};
        for l = 1:NumberOfAdjustmentLengths
            CurrentLengthsOfAdjustments = LengthsOfAdjustments{l,1} * ones(size(CurrentTimesToAdjust));
            for p = 1:NumberOfExecutionParameters
                fprintf("g, a, l, p: %d %d %d %d", g, a, l, p);
                currentExecutionParameters = CurrentExecutionParameters{p,1};
                [AverageJunctureEstimates, FinalActivationValues] = ...
                    CurrentGoal.SimpleMacroEstimatesWithAdjustments(AdjustmentSpread, ...
                    currentExecutionParameters, CurrentTimesToAdjust, ...
                    CurrentLengthsOfAdjustments);
                if FigureData == true
                    MotorAxesList = MotorAxesMatrix{g,a,l,p};
                    PerceptualAxesList = PerceptualAxesMatrix{g,a,l,p};
                    CurrentFigureData = Dec14FindFullFigureData(MotorAxesList, PerceptualAxesList, ...
                        AverageJunctureEstimates, FinalActivationValues, CurrentGoal, ...
                        currentExecutionParameters, CurrentPlottingParameters);
                    FigureDataMatrix{g,a,l,p} = CurrentFigureData;
                end
                [MTrajectory, PTrajectory] = MakeTrajectoriesFromJunctures(...
                    AverageJunctureEstimates);
                AverageJunctureEstimatesMatrix{g,a,l,p} = AverageJunctureEstimates;
                FinalActivationValuesMatrix{g,a,l,p} = FinalActivationValues;
                ResultingMotorTrajectoryMatrix{g,a,l,p} = MTrajectory;
                ResultingPerceptualTrajectoryMatrix{g,a,l,p} = PTrajectory;
                MotorTrajectoryLengthMatrix(g,a,l,p) = ComputeTrajectoryLength(MTrajectory);
                PerceptualTrajectoryLengthMatrix(g,a,l,p) = ComputeTrajectoryLength(PTrajectory);
            end
        end
    end
end

%% FIND ALL THE DIFFERENCES BETWEEN RESULTING PERCEPTUAL TRAJECTORIES
% for g = 1:NumberOfGoals
%     % Later I might add the goal trajectory to this list
%     CompletePerceptualTrajectoryList = ResultingPerceptualTrajectoryMatrix{g,1};
%     PerceptualDifferences = DistancesBetweenListOfTrajectories( ...
%         CompletePerceptualTrajectoryList, ComparisonList);
%     PerceptualDifferencesMatrix(:,g) = PerceptualDifferences;
% end

%% FIND THE DISTANCES FROM THE GOAL

DistancesFromGoalsMatrix = zeros(NumberOfGoals, NumberOfAdjustments, NumberOfAdjustmentLengths, NumberOfExecutionParameters);
for g = 1:NumberOfGoals
    CurrentGoal = GoalList{g,1};
    for a = 1:NumberOfAdjustments
        for l = 1:NumberOfAdjustmentLengths
            for p = 1:NumberOfExecutionParameters
                dist = CurrentGoal.Trajectory.DistanceToTrajectory(ResultingPerceptualTrajectoryMatrix{g,a,l,p});
                DistancesFromGoalsMatrix(g,a,l,p) = dist;
            end
        end
    end
end

%% MAKE GRAPHS

% ALPGDistancesFromGoalsMatrix = permute(DistancesFromGoalsMatrix,[2 3 4 1]);
FreqChecking = ["Check never", ...
    "Check at times 1, 4, 8, 11", ...
    "Check at times 1, 3, 4, 5, 7, 8, 9, 11", ...
    "Check at all times"];
GoalNumbers = ["Goal 1"; "Goal 2"; "Goal 3"; "Goal 4"; "Goal 5"];
NewFigure1 = figure();
% heatmap(NewFigure1, FreqChecking, GoalNumbers, ...
%     DistancesFromGoalsMatrix(:,:,1,1))
NewFigure2 = figure();
% heatmap(NewFigure2, FreqChecking, GoalNumbers, ...
%     DistancesFromGoalsMatrix(:,:,1,2))
NewAxes1 = axes(NewFigure1);
NewAxes2 = axes(NewFigure2);
DistanceMatrix1 = DistancesFromGoalsMatrix(:,:,1,1);
DistanceMatrix2 = DistancesFromGoalsMatrix(:,:,1,2);
plot(NewAxes1, transpose(DistanceMatrix1), "LineWidth", 2);
plot(NewAxes2, transpose(DistanceMatrix2), "LineWidth", 2);

%% SAVING INDIVIDUAL PATHS
if SaveFigureData
    for A = 1:NumberOfGoals
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


%% GRAPH THE DIFFERENCES ON THE SAME GRAPH
% Want to graph ... ? on the x axis, and each element of
% PerceptualDifferencesMatrix on the y axis.  For now we'll just graph 1,
% 2, 3, ... on the x axis
% Figure1 = figure();
% Figure2 = figure();
% Axes1 = axes(Figure1);
% Axes2 = axes(Figure2);
% DistFromAlwaysLines = plot(Axes1, - PerceptualDifferencesMatrix, "LineWidth", 2);
% for l = 1:length(DistFromAlwaysLines)
%     DistFromAlwaysLines(l,1).Color = ColorArray{l,1};
% end
% 
% DistFromGoalPlot = plot(DistancesFromGoalsMatrix, "LineWidth", 2);
% for l = 1:length(DistFromGoalPlot)
%     DistFromGoalPlot(l,1).Color = ColorArray{l,1};
% end


