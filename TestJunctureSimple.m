%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% FUNCTIONS TESTED
%
%  Juncture
%  MotorPlottingInfo
%  PerceptualPlottingInfo
%  PlotMotor
%  PlotPerceptual

%% TESTS

function tests = TestJunctureSimple
    tests = functiontests(localfunctions);
end

function TestCreateObjectSimple(testCase)
    actCoordinates1 = testCase.TestData.Juncture1.MotorPoint.Coordinates;
    actCoordinates2 = testCase.TestData.Juncture1.PerceptualPoint.Coordinates;
    actCoordinates3 = testCase.TestData.Juncture2.MotorPoint.Coordinates;
    actCoordinates4 = testCase.TestData.Juncture2.PerceptualPoint.Coordinates;
    actCoordinates5 = testCase.TestData.Juncture3.MotorPoint.Coordinates;
    actCoordinates6 = testCase.TestData.Juncture3.PerceptualPoint.Coordinates;
    expCoordinates1 = [2; 5];
    expCoordinates2 = [-1; 10];
    expCoordinates3 = [3; 4];
    expCoordinates4 = [3; 4];
    expCoordinates5 = [-10; -20];
    expCoordinates6 = [8; 0];
    verifyEqual(testCase, actCoordinates1, expCoordinates1);
    verifyEqual(testCase, actCoordinates2, expCoordinates2);
    verifyEqual(testCase, actCoordinates3, expCoordinates3);
    verifyEqual(testCase, actCoordinates4, expCoordinates4);
    verifyEqual(testCase, actCoordinates5, expCoordinates5);
    verifyEqual(testCase, actCoordinates6, expCoordinates6);
end

function TestMotorPlottingInfoSimple(testCase)
    [actX1, actY1, actColor1] = testCase.TestData.Juncture1.MotorPlottingInfo([1 0 1]);
    [actX2, actY2, actColor2] = testCase.TestData.Juncture2.MotorPlottingInfo([0 0 1]);
    [actX3, actY3, actColor3] = testCase.TestData.Juncture3.MotorPlottingInfo([1 0 0.5]);
    expX1 = 2;
    expY1 = 5;
    expColor1 = [1 0 1];
    expX2 = 3;
    expY2 = 4;
    expColor2 = [0 0 1];
    expX3 = -10;
    expY3 = -20;
    expColor3 = [1 0 0.5];
    verifyEqual(testCase, actX1, expX1);
    verifyEqual(testCase, actY1, expY1);
    verifyEqual(testCase, actColor1, expColor1);
    verifyEqual(testCase, actX2, expX2);
    verifyEqual(testCase, actY2, expY2);
    verifyEqual(testCase, actColor2, expColor2);
    verifyEqual(testCase, actX3, expX3);
    verifyEqual(testCase, actY3, expY3);
    verifyEqual(testCase, actColor3, expColor3);
end

function TestPerceptualPlottingInfoSimple(testCase)
    [actX1, actY1, actColor1] = testCase.TestData.Juncture1.PerceptualPlottingInfo([1 0 1]);
    [actX2, actY2, actColor2] = testCase.TestData.Juncture2.PerceptualPlottingInfo([0 0 1]);
    [actX3, actY3, actColor3] = testCase.TestData.Juncture3.PerceptualPlottingInfo([1 0 0.5]);
    expX1 = -1;
    expY1 = 10;
    expColor1 = [1 0 1];
    expX2 = 3;
    expY2 = 4;
    expColor2 = [0 0 1];
    expX3 = 8;
    expY3 = 0;
    expColor3 = [1 0 0.5];
    verifyEqual(testCase, actX1, expX1);
    verifyEqual(testCase, actY1, expY1);
    verifyEqual(testCase, actColor1, expColor1);
    verifyEqual(testCase, actX2, expX2);
    verifyEqual(testCase, actY2, expY2);
    verifyEqual(testCase, actColor2, expColor2);
    verifyEqual(testCase, actX3, expX3);
    verifyEqual(testCase, actY3, expY3);
    verifyEqual(testCase, actColor3, expColor3);
end

function setupOnce(testCase)
    % Create and change to temporary folder
    testCase.TestData.origPath = pwd;
    testCase.TestData.tmpFolder = "tmpFolder" + ...
        string(datetime('now','Format',"yyyyMMdd'T'HHmmss"));
    mkdir(testCase.TestData.tmpFolder)
    cd(testCase.TestData.tmpFolder)
    % Create and save variables
    testCase.TestData.Juncture1 = Juncture(MotorPoint([2; 5]), PerceptualPoint([-1; 10]));
    testCase.TestData.Juncture2 = Juncture(MotorPoint([3; 4]), PerceptualPoint([3; 4]));
    testCase.TestData.Juncture3 = Juncture(MotorPoint([-10; -20]), PerceptualPoint([8; 0]));
end

function teardownOnce(testCase)
    cd(testCase.TestData.origPath)
    rmdir(testCase.TestData.tmpFolder)
end

