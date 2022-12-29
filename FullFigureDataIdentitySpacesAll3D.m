%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function fullFigureData = FullFigureDataIdentitySpacesAll3D( ...
    GoalList, MResultList, ActivationsList, ActivationsTime, ...
    NumVerticalAxes, NumHorizontalAxes)
    % Assumes that the transformation is the identity transformation and
    % plots everything in the same space
    PlottingParametersIceComparison;
    %% CREATE FIGURE AND AXES
    [Figure, axesList] = MakeFigureAndAxes3D([0.2 0 0.3], ...
    [1 1 1], NumVerticalAxes, NumHorizontalAxes, ...
    [0 20], [0 20], [0 20], "on", "perspective");
    Figure.WindowState = "maximized";
    
    %% INITIALIZE SIZES OF LISTS
    NumAxes = NumVerticalAxes * NumHorizontalAxes;
    clusterXList = cell(NumAxes, 1);
    clusterYList = cell(NumAxes, 1);
    clusterZList = cell(NumAxes, 1);
    clusterColorList = cell(NumAxes, 1);
    clusterAlphaList = cell(NumAxes, 1);
    silhouetteFaceList = cell(NumAxes, 1);
    silhouetteVertexList = cell(NumAxes, 1);
    silhouetteColorList = cell(NumAxes, 1);
    silhouetteAlphaList = cell(NumAxes, 1);
    trajectoryXList = cell(NumAxes, 1);
    trajectoryYList = cell(NumAxes, 1);
    trajectoryZList = cell(NumAxes, 1);
    trajectoryColorList = cell(NumAxes, 1);
    resultXList = cell(NumAxes, 1);
    resultYList = cell(NumAxes, 1);
    resultZList = cell(NumAxes, 1);
    resultColorList = cell(NumAxes, 1);

    %% GOING THROUGH EACH OF THE AXES
    for n = 1:NumAxes
        goal = GoalList(n);

        % Cluster values
        AlphaClusterValues = ones(length(goal.Space.Clusters),1);
        [MCXValues, MCYValues, MCZValues, MCColorValues, ~] = ...
                    goal.Space.MotorClusterPlottingInfo3D(...
                    plottingParameters.ClusterColorArray, AlphaClusterValues);
        clusterXList{n} = MCXValues;
        clusterYList{n} = MCYValues;
        clusterZList{n} = MCZValues;
        clusterColorList{n} = MCColorValues;
        if ActivationsTime == 0
            clusterAlphaList{n} = 0.2 * ones(size(ActivationsList{n}(:, 1)));
        else
            clusterAlphaList{n} = ActivationsList{n}(:, ActivationsTime);
        end

        % Silhouette values
        [VertexData, FaceData, AlphaData] = ...
            goal.Silhouette.PlottingInfo3D( ...
            plottingParameters.MotorSilhouetteMinOpacity, plottingParameters.MotorSilhouetteMaxOpacity);
        silhouetteColorArray = zeros(size(FaceData, 1), 3);
        for sColors = 1:size(silhouetteColorArray, 1)
            silhouetteColorArray(sColors,:) = plottingParameters.MotorSilhouetteColor1;
        end

        silhouetteFaceList{n} = FaceData;
        silhouetteVertexList{n} = VertexData;
        silhouetteColorList{n} = silhouetteColorArray;
        silhouetteAlphaList{n} = AlphaData;

        % Trajectory values
        [rawtrajectoryXValues, rawtrajectoryYValues, ...
            rawtrajectoryZValues, rawtrajectoryColorValues] = ...
            goal.Exemplar.PlottingInfo3D(...
            plottingParameters.PerceptualTrajectoryColor1, ...
            plottingParameters.PerceptualTrajectoryColor2);

        interpXM = transpose(1: ...
            plottingParameters.NumberOfPointsBetweenPoints: ...
            plottingParameters.NumberOfPointsBetweenPoints * ...
            length(rawtrajectoryXValues) + 1 - ...
            plottingParameters.NumberOfPointsBetweenPoints);
        interpXQM = transpose(1: ...
            plottingParameters.NumberOfPointsBetweenPoints ...
            * length(rawtrajectoryXValues) + 1 - ...
            plottingParameters.NumberOfPointsBetweenPoints);
    
        trajectoryXValues = interp1(interpXM, rawtrajectoryXValues, interpXQM);
        trajectoryYValues = interp1(interpXM, rawtrajectoryYValues, interpXQM);
        trajectoryZValues = interp1(interpXM, rawtrajectoryZValues, interpXQM);
        trajectoryColorValues = interp1(interpXM, rawtrajectoryColorValues, interpXQM);
    
        trajectoryXList{n} = trajectoryXValues;
        trajectoryYList{n} = trajectoryYValues;
        trajectoryZList{n} = trajectoryZValues;
        trajectoryColorList{n} = trajectoryColorValues;

        % Result values
        [rawResultXValues, rawResultYValues, rawResultZValues, rawResultColorValues] = ...
            MResultList(n).PlottingInfo3D(...
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
        resultZValues = interp1(interpXM, rawResultZValues, interpXQM);
        resultColorValues = interp1(interpXM, rawResultColorValues, interpXQM);
    
        resultXList{n,1} = resultXValues;
        resultYList{n,1} = resultYValues;
        resultZList{n,1} = resultZValues;
        resultColorList{n,1} = resultColorValues;
    end

    %% ADDITIONAL VALUES

    junctureSizes = plottingParameters.JunctureSizes;
    resultPointSizes = plottingParameters.ResultPointSizes;
    

    %% MAKING FINAL OUTPUT
    fullFigureData = FullFigureData3D(axesList, clusterXList, ...
                clusterYList, clusterZList, clusterColorList, clusterAlphaList, ...
                silhouetteFaceList, silhouetteVertexList, ...
                silhouetteColorList, silhouetteAlphaList, ...
                trajectoryXList, trajectoryYList, trajectoryZList, trajectoryColorList, ...
                resultXList, resultYList, resultZList, resultColorList, ...
                junctureSizes, resultPointSizes);
end
