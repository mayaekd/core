 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function fullFigureData = FullFigureDataMotorResults( ...
    plottingParameters, GoalList, JunctureResults, ActivationsList, ...
    ActivationsTime, NumVerticalTiles, NumHorizontalTiles, WindowState)
    
    %% CREATE FIGURE AND AXES
    [Figure, axesList] = MakeFigureAndAxes([0.2 0 0.3], ...
    [1 1 1], NumVerticalTiles, NumHorizontalTiles, ...
    plottingParameters.MotorBounds(1, :), ...
    plottingParameters.MotorBounds(2, :));
    Figure.WindowState = WindowState;
    
    %% INITIALIZE SIZES OF LISTS
    NumAxes = NumVerticalTiles * NumHorizontalTiles;
    assert(NumAxes == length(GoalList));
    clusterXList = cell(NumAxes, 1);
    clusterYList = cell(NumAxes, 1);
    clusterColorList = cell(NumAxes, 1);
    clusterAlphaList = cell(NumAxes, 1);
    silhouetteFaceList = cell(NumAxes, 1);
    silhouetteVertexList = cell(NumAxes, 1);
    silhouetteColorList = cell(NumAxes, 1);
    silhouetteAlphaList = cell(NumAxes, 1);
    trajectoryXList = cell(NumAxes, 1);
    trajectoryYList = cell(NumAxes, 1);
    trajectoryColorList = cell(NumAxes, 1);
    resultXList = cell(NumAxes, 1);
    resultYList = cell(NumAxes, 1);
    resultColorList = cell(NumAxes, 1);

    %% GOING THROUGH EACH OF THE AXES
    for n = 1:NumAxes
        goal = GoalList(n);

        % Cluster values
        AlphaClusterValues = ones(length(goal.Space.Clusters),1);
        [MCXValues, MCYValues, MCColorValues, ~] = ...
                    goal.Space.MotorClusterPlottingInfo(...
                    plottingParameters.ClusterColorArray, AlphaClusterValues);
        clusterXList{n} = MCXValues;
        clusterYList{n} = MCYValues;
        clusterColorList{n} = MCColorValues;
        if ActivationsTime == 0
            clusterAlphaList{n} = 0.5 * ones(size(ActivationsList{n}(:, 1)));
        else
            clusterAlphaList{n} = ActivationsList{n}(:, ActivationsTime);
        end

        % Silhouette values
        [VertexData, FaceData, AlphaData] = ...
            goal.Silhouette.PlottingInfo( ...
            plottingParameters.MotorSilhouetteMinOpacity, ...
            plottingParameters.MotorSilhouetteMaxOpacity);
        silhouetteColorArray = zeros(size(FaceData, 1), 3);
        for sColors = 1:size(silhouetteColorArray, 1)
            silhouetteColorArray(sColors,:) = plottingParameters.MotorSilhouetteColor1;
        end

        silhouetteFaceList{n} = FaceData;
        silhouetteVertexList{n} = VertexData;
        silhouetteColorList{n} = silhouetteColorArray;
        silhouetteAlphaList{n} = AlphaData;

        % Trajectory values
        [trajectoryXValues, trajectoryYValues, trajectoryColorValues] = ...
            goal.Exemplar.PlottingInfo(...
            plottingParameters.PerceptualTrajectoryColor1, ...
            plottingParameters.PerceptualTrajectoryColor2);
        trajectoryXList{n} = trajectoryXValues;
        trajectoryYList{n} = trajectoryYValues;
        trajectoryColorList{n} = trajectoryColorValues;

        % Result values
        CurrentJunctureResults = JunctureResults{n};
        MotorPoints = nan( ...
            length(CurrentJunctureResults(1).MotorPoint.Coordinates), ...
            length(CurrentJunctureResults));
        for j = 1:length(CurrentJunctureResults)
            MotorPoints(:, j) = CurrentJunctureResults(j).MotorPoint.Coordinates;
        end
        MResultTrajectory = MotorTrajectory(MotorPoints);
        [rawResultXValues, rawResultYValues, rawResultColorValues] = ...
            MResultTrajectory.PlottingInfo(...
            plottingParameters.ResultTrajectoryColor1, ...
            plottingParameters.ResultTrajectoryColor2);

        interpXM = transpose(1: ...
            plottingParameters.NumberOfPointsBetweenPoints: ...
            plottingParameters.NumberOfPointsBetweenPoints * ...
            length(rawResultXValues) + 1 - ...
            plottingParameters.NumberOfPointsBetweenPoints);
        interpXQM = transpose(1: ...
            plottingParameters.NumberOfPointsBetweenPoints ...
            * length(rawResultXValues) + 1 - ...
            plottingParameters.NumberOfPointsBetweenPoints);
    
        resultXValues = interp1(interpXM, rawResultXValues, interpXQM);
        resultYValues = interp1(interpXM, rawResultYValues, interpXQM);
        resultColorValues = interp1(interpXM, rawResultColorValues, interpXQM);
    
        resultXList{n} = resultXValues;
        resultYList{n} = resultYValues;
        resultColorList{n} = resultColorValues;
    end

    %% ADDITIONAL VALUES

    junctureSizes = plottingParameters.JunctureSizes;
    resultPointSizes = plottingParameters.ResultPointSizes;
    

    %% MAKING FINAL OUTPUT
    fullFigureData = FullFigureData(axesList, clusterXList, ...
                clusterYList, clusterColorList, clusterAlphaList, ...
                silhouetteFaceList, silhouetteVertexList, ...
                silhouetteColorList, silhouetteAlphaList, ...
                trajectoryXList, trajectoryYList, trajectoryColorList, ...
                resultXList, resultYList, resultColorList, ...
                junctureSizes, resultPointSizes);
end
