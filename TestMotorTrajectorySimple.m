%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS TESTED
%  MotorTrajectory
%  PlottingInfo
%  PlottingInfo3D
%  Plot
%  FindPerceptualTrajectory
%  DistanceToTrajectory
%  DistanceVectorToTrajectory

%% TESTS

function tests = TestMotorTrajectorySimple
    tests = functiontests(localfunctions);
end

function TestCreateObjectSimple(testCase)
    MotorTrajectory1 = MotorTrajectory([10 12 14; 12 15 18]);
    MotorTrajectory2 = MotorTrajectory([2 4 8; 6 3 0], "PointsBetweenEachPoint", 0);
    MotorTrajectory3 = MotorTrajectory([10 2 -6; 20 40 60]);
    MotorTrajectory4 = MotorTrajectory([10 2 -6; 20 40 60], "PointsBetweenEachPoint", 1);
    actCoordinates1 = MotorTrajectory1.CoordinateMatrix;
    actCoordinates2 = MotorTrajectory2.CoordinateMatrix;
    actCoordinates3 = MotorTrajectory3.CoordinateMatrix;
    actCoordinates4 = MotorTrajectory4.CoordinateMatrix;
    expCoordinates1 = [10 12 14; 12 15 18];
    expCoordinates2 = [2 4 8; 6 3 0];
    expCoordinates3 = [10 2 -6; 20 40 60];
    expCoordinates4 = [10 6 2 -2 -6; 20 30 40 50 60];
    verifyEqual(testCase, actCoordinates1, expCoordinates1);
    verifyEqual(testCase, actCoordinates2, expCoordinates2);
    verifyEqual(testCase, actCoordinates3, expCoordinates3);
    verifyEqual(testCase, actCoordinates4, expCoordinates4);
end

function TestPlottingInfoSimple(testCase)
    MotorTrajectory1 = MotorTrajectory([10 12 14; 12 15 18]);
    MotorTrajectory2 = MotorTrajectory([2 4 8; 6 3 0], ...
        "PointsBetweenEachPoint", 0);
    MotorTrajectory3 = MotorTrajectory([10 2 -6; 20 40 60]);
    MotorTrajectory4 = MotorTrajectory([10 2 -6; 20 40 60], ...
        "PointsBetweenEachPoint", 1);
    [actX1, actY1, actColor1] = MotorTrajectory1.PlottingInfo( ...
        [1 0 0], [1 0 1]);
    [actX2, actY2, actColor2] = MotorTrajectory2.PlottingInfo( ...
        [1 0 0], [1 0 1]);
    [actX3, actY3, actColor3] = MotorTrajectory3.PlottingInfo( ...
        [1 0 0], [1 0 1]);
    [actX4, actY4, actColor4] = MotorTrajectory4.PlottingInfo( ...
        [1 0 0], [1 0 1]);
    expX1 = [10 12 14];
    expY1 = [12 15 18];
    expColor1 = [1 0 0; 1 0 0.5; 1 0 1];
    expX2 = [2 4 8];
    expY2 = [6 3 0];
    expColor2 = [1 0 0; 1 0 0.5; 1 0 1];
    expX3 = [10 2 -6];
    expY3 = [20 40 60];
    expColor3 = [1 0 0; 1 0 0.5; 1 0 1];
    expX4 = [10 6 2 -2 -6];
    expY4 = [20 30 40 50 60];
    expColor4 = [1 0 0; 1 0 0.25; 1 0 0.5; 1 0 0.75; 1 0 1];
    verifyEqual(testCase, actX1, expX1);
    verifyEqual(testCase, actY1, expY1);
    verifyEqual(testCase, actColor1, expColor1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actX2, expX2);
    verifyEqual(testCase, actY2, expY2);
    verifyEqual(testCase, actColor2, expColor2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actX3, expX3);
    verifyEqual(testCase, actY3, expY3);
    verifyEqual(testCase, actColor3, expColor3, "AbsTol", 0.00000001);
    verifyEqual(testCase, actX4, expX4);
    verifyEqual(testCase, actY4, expY4);
    verifyEqual(testCase, actColor4, expColor4, "AbsTol", 0.00000001);
end

function TestPlottingInfo3DSimple(testCase)
    MotorTrajectory1 = MotorTrajectory([10 12 14; 12 15 18; 3 4 5], "zRowIndex", 3);
    MotorTrajectory2 = MotorTrajectory([2 4 8; 6 3 0; -2 -3 -4], ...
        "PointsBetweenEachPoint", 0, "zRowIndex", 3);
    MotorTrajectory3 = MotorTrajectory([10 2 -6; 20 40 60; 5 10 15], "zRowIndex", 3);
    MotorTrajectory4 = MotorTrajectory([10 2 -6; 20 40 60; 5 10 15], ...
        "PointsBetweenEachPoint", 1, "zRowIndex", 3);
    [actX1, actY1, actZ1, actColor1] = MotorTrajectory1.PlottingInfo3D( ...
        [1 0 0], [1 0 1]);
    [actX2, actY2, actZ2, actColor2] = MotorTrajectory2.PlottingInfo3D( ...
        [1 0 0], [1 0 1]);
    [actX3, actY3, actZ3, actColor3] = MotorTrajectory3.PlottingInfo3D( ...
        [1 0 0], [1 0 1]);
    [actX4, actY4, actZ4, actColor4] = MotorTrajectory4.PlottingInfo3D( ...
        [1 0 0], [1 0 1]);
    expX1 = [10 12 14];
    expY1 = [12 15 18];
    expZ1 = [3 4 5];
    expColor1 = [1 0 0; 1 0 0.5; 1 0 1];
    expX2 = [2 4 8];
    expY2 = [6 3 0];
    expZ2 = [-2 -3 -4];
    expColor2 = [1 0 0; 1 0 0.5; 1 0 1];
    expX3 = [10 2 -6];
    expY3 = [20 40 60];
    expZ3 = [5 10 15];
    expColor3 = [1 0 0; 1 0 0.5; 1 0 1];
    expX4 = [10 6 2 -2 -6];
    expY4 = [20 30 40 50 60];
    expZ4 = [5 7.5 10 12.5 15];
    expColor4 = [1 0 0; 1 0 0.25; 1 0 0.5; 1 0 0.75; 1 0 1];
    verifyEqual(testCase, actX1, expX1);
    verifyEqual(testCase, actY1, expY1);
    verifyEqual(testCase, actZ1, expZ1);
    verifyEqual(testCase, actColor1, expColor1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actX2, expX2);
    verifyEqual(testCase, actY2, expY2);
    verifyEqual(testCase, actZ2, expZ2);
    verifyEqual(testCase, actColor2, expColor2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actX3, expX3);
    verifyEqual(testCase, actY3, expY3);
    verifyEqual(testCase, actZ3, expZ3);
    verifyEqual(testCase, actColor3, expColor3, "AbsTol", 0.00000001);
    verifyEqual(testCase, actX4, expX4);
    verifyEqual(testCase, actY4, expY4);
    verifyEqual(testCase, actZ4, expZ4);
    verifyEqual(testCase, actColor4, expColor4, "AbsTol", 0.00000001);
end

function TestFindPerceptualTrajectorySimple(testCase)
    st1 = testCase.TestData.spaceTransformation1;
    st2 = testCase.TestData.spaceTransformation2;
    st3 = testCase.TestData.spaceTransformation3;
    st4 = testCase.TestData.spaceTransformation4;
    MotorTrajectory1 = MotorTrajectory([10 12 14; 12 15 18]);
    MotorTrajectory2 = MotorTrajectory([2 4 8; 6 3 0], ...
        "PointsBetweenEachPoint", 0);
    MotorTrajectory3 = MotorTrajectory([10 2 -6; 20 40 60]);
    MotorTrajectory4 = MotorTrajectory([10 2 -6; 20 40 60], ...
        "PointsBetweenEachPoint", 1);
    actPerceptualTrajectory1 = ...
        MotorTrajectory1.FindPerceptualTrajectory(st1);
    actPerceptualTrajectory2 = ...
        MotorTrajectory2.FindPerceptualTrajectory(st2);
    actPerceptualTrajectory3 = ...
        MotorTrajectory3.FindPerceptualTrajectory(st3);
    actPerceptualTrajectory4 = ...
        MotorTrajectory4.FindPerceptualTrajectory(st4);
    actCoordinates1 = actPerceptualTrajectory1.CoordinateMatrix;
    actCoordinates2 = actPerceptualTrajectory2.CoordinateMatrix;
    actCoordinates3 = actPerceptualTrajectory3.CoordinateMatrix;
    actCoordinates4 = actPerceptualTrajectory4.CoordinateMatrix;
    
    expCoordinates1 = [10 12 14; 12 15 18];
    expCoordinates2 = [102 104 108; 406 403 400];
    expCoordinates3 = [1 1 1; 2 2 2];
    expCoordinates4 = [10 6 8 12 16; 20 30 40 50 60];
    verifyEqual(testCase, actCoordinates1, expCoordinates1);
    verifyEqual(testCase, actCoordinates2, expCoordinates2);
    verifyEqual(testCase, actCoordinates3, expCoordinates3);
    verifyEqual(testCase, actCoordinates4, expCoordinates4);
end

function TestDistanceToTrajectorySimple(testCase)
    MotorTrajectory1 = MotorTrajectory([10 12 14; 12 15 18]);
    MotorTrajectory2 = MotorTrajectory([2 4 8; 6 3 0], "PointsBetweenEachPoint", 0);
    MotorTrajectory3 = MotorTrajectory([10 2 -6; 20 40 60]);
    MotorTrajectory4 = MotorTrajectory([10 2 -6; 20 40 60], "PointsBetweenEachPoint", 1);
    actDistance1 = MotorTrajectory1.DistanceToTrajectory(MotorTrajectory1);
    actDistance2 = MotorTrajectory1.DistanceToTrajectory(MotorTrajectory2);
    actDistance3 = MotorTrajectory1.DistanceToTrajectory(MotorTrajectory3);
    actDistance4 = MotorTrajectory1.DistanceToTrajectory(MotorTrajectory4);
    actDistance5 = MotorTrajectory2.DistanceToTrajectory(MotorTrajectory1);
    actDistance6 = MotorTrajectory2.DistanceToTrajectory(MotorTrajectory2);
    actDistance7 = MotorTrajectory2.DistanceToTrajectory(MotorTrajectory3);
    actDistance8 = MotorTrajectory2.DistanceToTrajectory(MotorTrajectory4);
    actDistance9 = MotorTrajectory3.DistanceToTrajectory(MotorTrajectory1);
    actDistance10 = MotorTrajectory3.DistanceToTrajectory(MotorTrajectory2);
    actDistance11 = MotorTrajectory3.DistanceToTrajectory(MotorTrajectory3);
    actDistance12 = MotorTrajectory3.DistanceToTrajectory(MotorTrajectory4);
    actDistance13 = MotorTrajectory4.DistanceToTrajectory(MotorTrajectory1);
    actDistance14 = MotorTrajectory4.DistanceToTrajectory(MotorTrajectory2);
    actDistance15 = MotorTrajectory4.DistanceToTrajectory(MotorTrajectory3);
    actDistance16 = MotorTrajectory4.DistanceToTrajectory(MotorTrajectory4);
    expDistance1 = 0;
    expDistance2 = 14.47;
    expDistance3 = 27.15;
    expDistance4 = 27.0781;
    expDistance5 = 14.47;
    expDistance6 = 0;
    expDistance7 = 38.26;
    expDistance8 = 37.9243;
    expDistance9 = 27.15;
    expDistance10 = 38.26;
    expDistance11 = 0;
    expDistance12 = 0;
    expDistance13 = 27.0781;
    expDistance14 = 37.9243;
    expDistance15 = 0;
    expDistance16 = 0;
    verifyEqual(testCase, actDistance1, expDistance1, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance2, expDistance2, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance3, expDistance3, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance4, expDistance4, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance5, expDistance5, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance6, expDistance6, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance7, expDistance7, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance8, expDistance8, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance9, expDistance9, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance10, expDistance10, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance11, expDistance11, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance12, expDistance12, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance13, expDistance13, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance14, expDistance14, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance15, expDistance15, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance16, expDistance16, "AbsTol", 0.01);
end

function TestDistanceVectorToTrajectorySimple(testCase)
    MotorTrajectory1 = MotorTrajectory([1 2 3 4; 5 6 7 8], "PointsBetweenEachPoint", 1);
    MotorTrajectory2 = MotorTrajectory([4 5 6 7; 9 10 11 12], "PointsBetweenEachPoint", 1);
    MotorTrajectory3 = MotorTrajectory([4 5 3 4; 9 10 7 8]);

    actDistanceVector1 = MotorTrajectory1.DistanceVectorToTrajectory(MotorTrajectory2);
    actDistanceVector2 = MotorTrajectory2.DistanceVectorToTrajectory(MotorTrajectory1);
    actDistanceVector3 = MotorTrajectory1.DistanceVectorToTrajectory(MotorTrajectory3);
    actDistanceVector4 = MotorTrajectory3.DistanceVectorToTrajectory(MotorTrajectory1);
    actDistanceVector5 = MotorTrajectory2.DistanceVectorToTrajectory(MotorTrajectory3);
    actDistanceVector6 = MotorTrajectory3.DistanceVectorToTrajectory(MotorTrajectory2);

    expDistanceVector1 = [5 5 5 5 5 5 5];
    expDistanceVector2 = [5 5 5 5 5 5 5];
    expDistanceVector3 = [5 5 5 2.5 0 0 0];
    expDistanceVector4 = [5 5 5 2.5 0 0 0];
    expDistanceVector5 = [0 0 0 2.5 5 5 5];
    expDistanceVector6 = [0 0 0 2.5 5 5 5];

    verifyEqual(testCase, actDistanceVector1, expDistanceVector1);
    verifyEqual(testCase, actDistanceVector2, expDistanceVector2);
    verifyEqual(testCase, actDistanceVector3, expDistanceVector3, ...
        "AbsTol", 0.00000001);
    verifyEqual(testCase, actDistanceVector4, expDistanceVector4, ...
        "AbsTol", 0.00000001);
    verifyEqual(testCase, actDistanceVector5, expDistanceVector5, ...
        "AbsTol", 0.00000001);
    verifyEqual(testCase, actDistanceVector6, expDistanceVector6, ...
        "AbsTol", 0.00000001);
end

%% SETUP AND TEARDOWN

function setupOnce(testCase)
    % Create and change to temporary folder
    testCase.TestData.origPath = pwd;
    testCase.TestData.tmpFolder = "tmpFolder" + ...
        string(datetime('now','Format',"yyyyMMdd'T'HHmmss"));
    mkdir(testCase.TestData.tmpFolder)
    cd(testCase.TestData.tmpFolder)
    % Create and save variables
    testCase.TestData.spaceTransformation1 = SpaceTransformation(@transformationFunction1);
    testCase.TestData.spaceTransformation2 = SpaceTransformation(@transformationFunction2);
    testCase.TestData.spaceTransformation3 = SpaceTransformation(@transformationFunction3);
    testCase.TestData.spaceTransformation4 = SpaceTransformation(@transformationFunction4);
end

function teardownOnce(testCase)
    cd(testCase.TestData.origPath)
    rmdir(testCase.TestData.tmpFolder)
end

function PerceptualCoordinates = transformationFunction1(MotorCoordinates)
    PerceptualCoordinates = MotorCoordinates;
end

function PerceptualCoordinates = transformationFunction2(MotorCoordinates)
    PerceptualCoordinates = MotorCoordinates + [100; 400];
end

function PerceptualCoordinates = transformationFunction3(MotorCoordinates)
    PerceptualCoordinates = 0 * MotorCoordinates + [1; 2];
end

function PerceptualCoordinates = transformationFunction4(MotorCoordinates)
    MX = MotorCoordinates(1,1);
    MY = MotorCoordinates(2,1);
    if MY < 40
        PX = MX;
        PY = MY;
    else
        PX = 10 - MX;
        PY = MY;
    end
    PerceptualCoordinates = [PX; PY];
end

