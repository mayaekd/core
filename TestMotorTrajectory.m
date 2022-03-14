%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function tests = TestMotorTrajectory
    tests = functiontests(localfunctions);
end

function TestCreateObject(testCase)
    actCoordinates1 = testCase.TestData.MotorTrajectory1.Points{1,1}.Coordinates;
    actCoordinates2 = testCase.TestData.MotorTrajectory1.Points{2,1}.Coordinates;
    actCoordinates3 = testCase.TestData.MotorTrajectory1.Points{3,1}.Coordinates;
    actCoordinates4 = testCase.TestData.MotorTrajectory4.Points{1,1}.Coordinates;
    actCoordinates5 = testCase.TestData.MotorTrajectory4.Points{2,1}.Coordinates;
    actCoordinates6 = testCase.TestData.MotorTrajectory4.Points{3,1}.Coordinates;
    actCoordinates7 = testCase.TestData.MotorTrajectory4.Points{4,1}.Coordinates;
    actCoordinates8 = testCase.TestData.MotorTrajectory4.Points{5,1}.Coordinates;
    actCoordinates9 = testCase.TestData.MotorTrajectory4.Points{6,1}.Coordinates;
    actCoordinates10 = testCase.TestData.MotorTrajectory4.Points{7,1}.Coordinates;
    expCoordinates1 = [10; 12];
    expCoordinates2 = [12; 15];
    expCoordinates3 = [14; 18];
    expCoordinates4 = [10; 20];
    expCoordinates5 = [6; 30];
    expCoordinates6 = [2; 40];
    expCoordinates7 = [0; 45];
    expCoordinates8 = [-2; 50];
    expCoordinates9 = [-4; 55];
    expCoordinates10 = [-6; 60];
    verifyEqual(testCase, actCoordinates1, expCoordinates1);
    verifyEqual(testCase, actCoordinates2, expCoordinates2);
    verifyEqual(testCase, actCoordinates3, expCoordinates3);
    verifyEqual(testCase, actCoordinates4, expCoordinates4);
    verifyEqual(testCase, actCoordinates5, expCoordinates5);
    verifyEqual(testCase, actCoordinates6, expCoordinates6);
    verifyEqual(testCase, actCoordinates7, expCoordinates7);
    verifyEqual(testCase, actCoordinates8, expCoordinates8);
    verifyEqual(testCase, actCoordinates9, expCoordinates9);
    verifyEqual(testCase, actCoordinates10, expCoordinates10);
end

function TestPlottingInfo(testCase)
    [actX1, actY1, actColor1] = ...
        testCase.TestData.MotorTrajectory1.PlottingInfo([1 0 0], [1 0 1]);
    [actX2, actY2, actColor2] = ...
        testCase.TestData.MotorTrajectory2.PlottingInfo([1 0 0], [1 0 1]);
    [actX3, actY3, actColor3] = ...
        testCase.TestData.MotorTrajectory3.PlottingInfo([1 0 0], [1 0 1]);
    [actX4, actY4, actColor4] = ...
        testCase.TestData.MotorTrajectory4.PlottingInfo([1 0 0], [1 0 0.72]);
    expX1 = [10; 12; 14];
    expY1 = [12; 15; 18];
    expColor1 = [1 0 0; 1 0 0.5; 1 0 1];
    expX2 = [2; 4; 8];
    expY2 = [6; 3; 0];
    expColor2 = [1 0 0; 1 0 0.5; 1 0 1];
    expX3 = [10; 2; -6];
    expY3 = [20; 40; 60];
    expColor3 = [1 0 0; 1 0 0.5; 1 0 1];
    expX4 = [10; 6; 2; 0; -2; -4; -6];
    expY4 = [20; 30; 40; 45; 50; 55; 60];
    expColor4 = [1 0 0; 1 0 0.12; 1 0 0.24; 1 0 0.36; 1 0 0.48; 1 0 0.60; 1 0 0.72];
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

function TestFindPerceptualTrajectory(testCase)
    actPerceptualTrajectory1 = ...
        testCase.TestData.MotorTrajectory1.FindPerceptualTrajectory( ...
        testCase.TestData.spaceTransformation1);
    actPerceptualTrajectory2 = ...
        testCase.TestData.MotorTrajectory2.FindPerceptualTrajectory( ...
        testCase.TestData.spaceTransformation2);
    actPerceptualTrajectory3 = ...
        testCase.TestData.MotorTrajectory3.FindPerceptualTrajectory( ...
        testCase.TestData.spaceTransformation3);
    actPerceptualTrajectory4 = ...
        testCase.TestData.MotorTrajectory4.FindPerceptualTrajectory( ...
        testCase.TestData.spaceTransformation4);
    actCoordinates1 = actPerceptualTrajectory1.Points{1,1}.Coordinates;
    actCoordinates2 = actPerceptualTrajectory1.Points{2,1}.Coordinates;
    actCoordinates3 = actPerceptualTrajectory1.Points{3,1}.Coordinates;
    actCoordinates4 = actPerceptualTrajectory2.Points{1,1}.Coordinates;
    actCoordinates5 = actPerceptualTrajectory2.Points{2,1}.Coordinates;
    actCoordinates6 = actPerceptualTrajectory2.Points{3,1}.Coordinates;
    actCoordinates7 = actPerceptualTrajectory3.Points{1,1}.Coordinates;
    actCoordinates8 = actPerceptualTrajectory3.Points{2,1}.Coordinates;
    actCoordinates9 = actPerceptualTrajectory3.Points{3,1}.Coordinates;
    actCoordinates10 = actPerceptualTrajectory4.Points{1,1}.Coordinates;
    actCoordinates11 = actPerceptualTrajectory4.Points{2,1}.Coordinates;
    actCoordinates12 = actPerceptualTrajectory4.Points{3,1}.Coordinates;
    actCoordinates13 = actPerceptualTrajectory4.Points{4,1}.Coordinates;
    actCoordinates14 = actPerceptualTrajectory4.Points{5,1}.Coordinates;
    actCoordinates15 = actPerceptualTrajectory4.Points{6,1}.Coordinates;
    actCoordinates16 = actPerceptualTrajectory4.Points{7,1}.Coordinates;
    expCoordinates1 = [10; 12];
    expCoordinates2 = [12; 15];
    expCoordinates3 = [14; 18];
    expCoordinates4 = [102; 406];
    expCoordinates5 = [104; 403];
    expCoordinates6 = [108; 400];
    expCoordinates7 = [1; 2];
    expCoordinates8 = [1; 2];
    expCoordinates9 = [1; 2];
    expCoordinates10 = [10; 20];
    expCoordinates11 = [6; 30];
    expCoordinates12 = [8; 40];
    expCoordinates13 = [10; 45];
    expCoordinates14 = [12; 50];
    expCoordinates15 = [14; 55];
    expCoordinates16 = [16; 60];
    verifyEqual(testCase, actCoordinates1, expCoordinates1);
    verifyEqual(testCase, actCoordinates2, expCoordinates2);
    verifyEqual(testCase, actCoordinates3, expCoordinates3);
    verifyEqual(testCase, actCoordinates4, expCoordinates4);
    verifyEqual(testCase, actCoordinates5, expCoordinates5);
    verifyEqual(testCase, actCoordinates6, expCoordinates6);
    verifyEqual(testCase, actCoordinates7, expCoordinates7);
    verifyEqual(testCase, actCoordinates8, expCoordinates8);
    verifyEqual(testCase, actCoordinates9, expCoordinates9);
    verifyEqual(testCase, actCoordinates10, expCoordinates10);
    verifyEqual(testCase, actCoordinates11, expCoordinates11);
    verifyEqual(testCase, actCoordinates12, expCoordinates12);
    verifyEqual(testCase, actCoordinates13, expCoordinates13);
    verifyEqual(testCase, actCoordinates14, expCoordinates14);
    verifyEqual(testCase, actCoordinates15, expCoordinates15);
    verifyEqual(testCase, actCoordinates16, expCoordinates16);
end

function TestDistanceToTrajectory(testCase)
    actDistance1 = testCase.TestData.MotorTrajectory1.DistanceToTrajectory(testCase.TestData.MotorTrajectory1);
    actDistance2 = testCase.TestData.MotorTrajectory1.DistanceToTrajectory(testCase.TestData.MotorTrajectory2);
    actDistance3 = testCase.TestData.MotorTrajectory1.DistanceToTrajectory(testCase.TestData.MotorTrajectory3);
    actDistance4 = testCase.TestData.MotorTrajectory1.DistanceToTrajectory(testCase.TestData.MotorTrajectory4);
    actDistance5 = testCase.TestData.MotorTrajectory2.DistanceToTrajectory(testCase.TestData.MotorTrajectory1);
    actDistance6 = testCase.TestData.MotorTrajectory2.DistanceToTrajectory(testCase.TestData.MotorTrajectory2);
    actDistance7 = testCase.TestData.MotorTrajectory2.DistanceToTrajectory(testCase.TestData.MotorTrajectory3);
    actDistance8 = testCase.TestData.MotorTrajectory2.DistanceToTrajectory(testCase.TestData.MotorTrajectory4);
    actDistance9 = testCase.TestData.MotorTrajectory3.DistanceToTrajectory(testCase.TestData.MotorTrajectory1);
    actDistance10 = testCase.TestData.MotorTrajectory3.DistanceToTrajectory(testCase.TestData.MotorTrajectory2);
    actDistance11 = testCase.TestData.MotorTrajectory3.DistanceToTrajectory(testCase.TestData.MotorTrajectory3);
    actDistance12 = testCase.TestData.MotorTrajectory3.DistanceToTrajectory(testCase.TestData.MotorTrajectory4);
    actDistance13 = testCase.TestData.MotorTrajectory4.DistanceToTrajectory(testCase.TestData.MotorTrajectory1);
    actDistance14 = testCase.TestData.MotorTrajectory4.DistanceToTrajectory(testCase.TestData.MotorTrajectory2);
    actDistance15 = testCase.TestData.MotorTrajectory4.DistanceToTrajectory(testCase.TestData.MotorTrajectory3);
    actDistance16 = testCase.TestData.MotorTrajectory4.DistanceToTrajectory(testCase.TestData.MotorTrajectory4);
    expDistance1 = 0;
    expDistance2 = 14.47;
    expDistance3 = 27.15;
    expDistance4 = 30.13;
    expDistance5 = 14.47;
    expDistance6 = 0;
    expDistance7 = 38.26;
    expDistance8 = 40.68;
    expDistance9 = 27.15;
    expDistance10 = 38.26;
    expDistance11 = 0;
    expDistance12 = 3.08;
    expDistance13 = 30.13;
    expDistance14 = 40.68;
    expDistance15 = 3.08;
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
    testCase.TestData.MotorTrajectory1 = MotorTrajectory({ ...
        MotorPoint([10; 12]); MotorPoint([12; 15]); MotorPoint([14; 18])});
    testCase.TestData.MotorTrajectory2 = MotorTrajectory({ ...
        MotorPoint([2; 6]); MotorPoint([4; 3]); MotorPoint([8; 0])}, zeros(2,1));
    testCase.TestData.MotorTrajectory3 = MotorTrajectory({ ...
        MotorPoint([10; 20]); MotorPoint([2; 40]); MotorPoint([-6; 60])});
    testCase.TestData.MotorTrajectory4 = MotorTrajectory({ ...
        MotorPoint([10; 20]); MotorPoint([2; 40]); MotorPoint([-6; 60])}, [1; 3]);
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

