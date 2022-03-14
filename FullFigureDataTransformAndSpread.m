%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function fullFigureData = FullFigureDataTransformAndSpread( ...
    Goal1, MResult1, PResult1, Goal2, MResult2, PResult2, ...
    Goal3, MResult3, PResult3, Goal4, MResult4, PResult4, ...
    plottingParameters)
    %% CREATE FIGURE AND AXES
    [Figure, axesList] = MakeFigureAndAxes([0.2 0 0.3], ...
    [1 1 1], 2, 4, [0 40], [0 40]);
    Figure.WindowState = "maximized";
    
    %% INITIALIZE SIZES OF LISTS
    NumAxes = 8;
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
    junctureSizes = cell(NumAxes, 1);
    resultPointSizes = cell(NumAxes, 1);
    
    %% CLUSTER VALUES
    AlphaClusterValues = ones(length(Goal1.Space.Clusters),1);
    [MCXValues1, MCYValues1, MCColorValues1, ~] = ...
                Goal1.Space.MotorClusterPlottingInfo(...
                plottingParameters.ClusterColorArray, AlphaClusterValues);
    [PCXValues1, PCYValues1, PCColorValues1, ~] = ...
                    Goal1.Space.PerceptualClusterPlottingInfo(...
                    plottingParameters.ClusterColorArray, AlphaClusterValues);
    [MCXValues2, MCYValues2, MCColorValues2, ~] = ...
                Goal2.Space.MotorClusterPlottingInfo(...
                plottingParameters.ClusterColorArray, AlphaClusterValues);
    [PCXValues2, PCYValues2, PCColorValues2, ~] = ...
                    Goal2.Space.PerceptualClusterPlottingInfo(...
                    plottingParameters.ClusterColorArray, AlphaClusterValues);
    [MCXValues3, MCYValues3, MCColorValues3, ~] = ...
                Goal3.Space.MotorClusterPlottingInfo(...
                plottingParameters.ClusterColorArray, AlphaClusterValues);
    [PCXValues3, PCYValues3, PCColorValues3, ~] = ...
                    Goal3.Space.PerceptualClusterPlottingInfo(...
                    plottingParameters.ClusterColorArray, AlphaClusterValues);
    [MCXValues4, MCYValues4, MCColorValues4, ~] = ...
                Goal4.Space.MotorClusterPlottingInfo(...
                plottingParameters.ClusterColorArray, AlphaClusterValues);
    [PCXValues4, PCYValues4, PCColorValues4, ~] = ...
                    Goal4.Space.PerceptualClusterPlottingInfo(...
                    plottingParameters.ClusterColorArray, AlphaClusterValues);

    clusterXList{1,1} = MCXValues1;
    clusterXList{2,1} = PCXValues1;
    clusterXList{3,1} = MCXValues2;
    clusterXList{4,1} = PCXValues2;
    clusterXList{5,1} = MCXValues3;
    clusterXList{6,1} = PCXValues3;
    clusterXList{7,1} = MCXValues4;
    clusterXList{8,1} = PCXValues4;

    clusterYList{1,1} = MCYValues1;
    clusterYList{2,1} = PCYValues1;
    clusterYList{3,1} = MCYValues2;
    clusterYList{4,1} = PCYValues2;
    clusterYList{5,1} = MCYValues3;
    clusterYList{6,1} = PCYValues3;
    clusterYList{7,1} = MCYValues4;
    clusterYList{8,1} = PCYValues4;

    clusterColorList{1,1} = MCColorValues1;
    clusterColorList{2,1} = PCColorValues1;
    clusterColorList{3,1} = MCColorValues2;
    clusterColorList{4,1} = PCColorValues2;
    clusterColorList{5,1} = MCColorValues3;
    clusterColorList{6,1} = PCColorValues3;
    clusterColorList{7,1} = MCColorValues4;
    clusterColorList{8,1} = PCColorValues4;

    AlphaJunctureValues = 0.5 * ones(size(MCXValues1));

    %% SILHOUETTE VALUES
    [VertexData1, FaceData1] = Goal1.Silhouette.PlottingInfo(...
        plottingParameters.NumberOfSilhouetteVertices);
    [VertexData2, FaceData2] = Goal2.Silhouette.PlottingInfo(...
        plottingParameters.NumberOfSilhouetteVertices);
    [VertexData3, FaceData3] = Goal3.Silhouette.PlottingInfo(...
        plottingParameters.NumberOfSilhouetteVertices);
    [VertexData4, FaceData4] = Goal4.Silhouette.PlottingInfo(...
        plottingParameters.NumberOfSilhouetteVertices);

    silhouetteVertexList{1,1} = VertexData1;
    silhouetteVertexList{3,1} = VertexData2;
    silhouetteVertexList{5,1} = VertexData3;
    silhouetteVertexList{7,1} = VertexData4;
    silhouetteFaceList{1,1} = FaceData1;
    silhouetteFaceList{3,1} = FaceData2;
    silhouetteFaceList{5,1} = FaceData3;
    silhouetteFaceList{7,1} = FaceData4;
    
    silhouetteColorArray = zeros(length(Goal1.Silhouette.Regions), 3);
    for sColors = 1:length(Goal1.Silhouette.Regions)
        silhouetteColorArray(sColors,:) = plottingParameters.MotorSilhouetteColor1;
    end
    silhouetteAlphaArray = 0.7 * ones(length(Goal1.Silhouette.Regions), 1);
    
    %% TRAJECTORY VALUES
    [trajectoryXValues1, trajectoryYValues1, trajectoryColorValues1] = ...
        Goal1.Trajectory.PlottingInfo(...
        plottingParameters.PerceptualTrajectoryColor1, ...
        plottingParameters.PerceptualTrajectoryColor2);
    [trajectoryXValues2, trajectoryYValues2, trajectoryColorValues2] = ...
        Goal2.Trajectory.PlottingInfo(...
        plottingParameters.PerceptualTrajectoryColor1, ...
        plottingParameters.PerceptualTrajectoryColor2);
    [trajectoryXValues3, trajectoryYValues3, trajectoryColorValues3] = ...
        Goal3.Trajectory.PlottingInfo(...
        plottingParameters.PerceptualTrajectoryColor1, ...
        plottingParameters.PerceptualTrajectoryColor2);
    [trajectoryXValues4, trajectoryYValues4, trajectoryColorValues4] = ...
        Goal4.Trajectory.PlottingInfo(...
        plottingParameters.PerceptualTrajectoryColor1, ...
        plottingParameters.PerceptualTrajectoryColor2);
    trajectoryXList{2,1} = trajectoryXValues1;
    trajectoryYList{2,1} = trajectoryYValues1;
    trajectoryColorList{2,1} = trajectoryColorValues1;
    trajectoryXList{4,1} = trajectoryXValues2;
    trajectoryYList{4,1} = trajectoryYValues2;
    trajectoryColorList{4,1} = trajectoryColorValues2;
    trajectoryXList{6,1} = trajectoryXValues3;
    trajectoryYList{6,1} = trajectoryYValues3;
    trajectoryColorList{6,1} = trajectoryColorValues3;
    trajectoryXList{8,1} = trajectoryXValues4;
    trajectoryYList{8,1} = trajectoryYValues4;
    trajectoryColorList{8,1} = trajectoryColorValues4;

    %% RESULT VALUES
    [resultXValues1, resultYValues1, resultColorValues1] = ...
        MResult1.PlottingInfo(...
        plottingParameters.ResultTrajectoryColor1, ...
        plottingParameters.ResultTrajectoryColor2);
    [resultXValues2, resultYValues2, resultColorValues2] = ...
        PResult1.PlottingInfo(...
        plottingParameters.ResultTrajectoryColor1, ...
        plottingParameters.ResultTrajectoryColor2);
    [resultXValues3, resultYValues3, resultColorValues3] = ...
        MResult2.PlottingInfo(...
        plottingParameters.ResultTrajectoryColor1, ...
        plottingParameters.ResultTrajectoryColor2);
    [resultXValues4, resultYValues4, resultColorValues4] = ...
        PResult2.PlottingInfo(...
        plottingParameters.ResultTrajectoryColor1, ...
        plottingParameters.ResultTrajectoryColor2);
    [resultXValues5, resultYValues5, resultColorValues5] = ...
        MResult3.PlottingInfo(...
        plottingParameters.ResultTrajectoryColor1, ...
        plottingParameters.ResultTrajectoryColor2);
    [resultXValues6, resultYValues6, resultColorValues6] = ...
        PResult3.PlottingInfo(...
        plottingParameters.ResultTrajectoryColor1, ...
        plottingParameters.ResultTrajectoryColor2);
    [resultXValues7, resultYValues7, resultColorValues7] = ...
        MResult4.PlottingInfo(...
        plottingParameters.ResultTrajectoryColor1, ...
        plottingParameters.ResultTrajectoryColor2);
    [resultXValues8, resultYValues8, resultColorValues8] = ...
        PResult4.PlottingInfo(...
        plottingParameters.ResultTrajectoryColor1, ...
        plottingParameters.ResultTrajectoryColor2);


        resultXList{1,1} = resultXValues1;
        resultYList{1,1} = resultYValues1;
        resultColorList{1,1} = resultColorValues1;
        resultXList{2,1} = resultXValues2;
        resultYList{2,1} = resultYValues2;
        resultColorList{2,1} = resultColorValues2;
        resultXList{3,1} = resultXValues3;
        resultYList{3,1} = resultYValues3;
        resultColorList{3,1} = resultColorValues3;
        resultXList{4,1} = resultXValues4;
        resultYList{4,1} = resultYValues4;
        resultColorList{4,1} = resultColorValues4;
        resultXList{5,1} = resultXValues5;
        resultYList{5,1} = resultYValues5;
        resultColorList{5,1} = resultColorValues5;
        resultXList{6,1} = resultXValues6;
        resultYList{6,1} = resultYValues6;
        resultColorList{6,1} = resultColorValues6;
        resultXList{7,1} = resultXValues7;
        resultYList{7,1} = resultYValues7;
        resultColorList{7,1} = resultColorValues7;
        resultXList{8,1} = resultXValues8;
        resultYList{8,1} = resultYValues8;
        resultColorList{8,1} = resultColorValues8;

%     ResultMotorPath = cell(size(AverageJunctureEstimates));
% 
%     for t = 1:length(AverageJunctureEstimates)
%         ResultMotorPath{t,1} = AverageJunctureEstimates{t,1}.MotorPoint;
%     end


    junctureSizes = plottingParameters.JunctureSizes;
    resultPointSizes = plottingParameters.ResultPointSizes;
    
    %% FINISH GOING THROUGH REPETETIVE THINGS FOR MOTOR
    for n = 1:2:NumAxes
        clusterAlphaList{n,1} = AlphaJunctureValues;
        silhouetteColorList{n,1} = silhouetteColorArray;
        silhouetteAlphaList{n,1} = silhouetteAlphaArray;
    end
    
    %% FINISH GOING THROUGH REPETETIVE THINGS FOR PERCEPTUAL
    for n = 2:2:NumAxes
        clusterAlphaList{n,1} = AlphaJunctureValues;
    end

    %% MAKING FINAL OUTPUT
    fullFigureData = FullFigureData(axesList, clusterXList, ...
                clusterYList, clusterColorList, clusterAlphaList, ...
                silhouetteFaceList, silhouetteVertexList, ...
                silhouetteColorList, silhouetteAlphaList, ...
                trajectoryXList, trajectoryYList, trajectoryColorList, ...
                resultXList, resultYList, resultColorList, ...
                junctureSizes, resultPointSizes);
end
