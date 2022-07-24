%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS TESTED
%  PerceptualTrajectory
%  DistanceToTrajectory
%  DistanceVectorToTrajectory
%  ActivationOfPerceptualMatrix
%  PlottingInfo
%  PlottingInfo3D
%  Plot

%% TESTS

function tests = TestPerceptualTrajectorySimple
    tests = functiontests(localfunctions);
end

function TestCreateObjectSimple(testCase)
    PT1 = PerceptualTrajectory([1 6; 2 5; 3 4]);
    PT2 = PerceptualTrajectory([1 3 4 8; 1 3 4 8]);

    actCoordinateMatrix1 = PT1.CoordinateMatrix;
    actCoordinateMatrix2 = PT2.CoordinateMatrix;

    expCoordinateMatrix1 = [1 6; 2 5; 3 4];
    expCoordinateMatrix2 = [1 3 4 8; 1 3 4 8];

    verifyEqual(testCase, actCoordinateMatrix1, expCoordinateMatrix1);
    verifyEqual(testCase, actCoordinateMatrix2, expCoordinateMatrix2);
end

function TestDistanceToTrajectorySimple(testCase)
    PT1 = PerceptualTrajectory([1 3 5; 2 4 6]);
    PT2 = PerceptualTrajectory([4 9 5; 6 12 6]);

    actDist1 = PT1.DistanceToTrajectory(PT2);
    actDist2 = PT2.DistanceToTrajectory(PT1);

    expDist = 5;
    
    verifyEqual(testCase, actDist1, expDist);
    verifyEqual(testCase, actDist2, expDist);
end

function TestDistanceVectorToTrajectorySimple(testCase)
    PT1 = PerceptualTrajectory([1 3 5; 2 4 6]);
    PT2 = PerceptualTrajectory([4 9 5; 6 12 6]);

    actDist1 = PT1.DistanceVectorToTrajectory(PT2);
    actDist2 = PT2.DistanceVectorToTrajectory(PT1);

    expDist = [5 10 0];
    
    verifyEqual(testCase, actDist1, expDist);
    verifyEqual(testCase, actDist2, expDist);
end

function TestActivationOfPerceptualMatrixSimple(testCase)
    PT1 = PerceptualTrajectory([1 2 3; 6 5 4]);
    PT2 = PerceptualTrajectory([1 3 4 8; 0 0 0 0]);
    PMA = [0 1 2; 2 0 1];
    PMB = [3 4 5 1 2; 8 5 4 1 3];

    HighestActivation = 1;
    DropoffSlope = 0.1;

    actActivation1A = PT1.ActivationOfPerceptualMatrix(PMA, ...
        HighestActivation, DropoffSlope);
    actActivation1B = PT1.ActivationOfPerceptualMatrix(PMB, ...
        HighestActivation, DropoffSlope);
    actActivation2A = PT2.ActivationOfPerceptualMatrix(PMA, ...
        HighestActivation, DropoffSlope);
    actActivation2B = PT2.ActivationOfPerceptualMatrix(PMB, ...
        HighestActivation, DropoffSlope);

    expActivation1A = 0.564814879790009;
    expActivation1B = 0.696621615025019;
    expActivation2A = 0.652439799235476;
    expActivation2B = 0.472823172072976;

    verifyEqual(testCase, actActivation1A, expActivation1A, ...
        "AbsTol", 0.0001);
    verifyEqual(testCase, actActivation1B, expActivation1B, ...
        "AbsTol", 0.0001);
    verifyEqual(testCase, actActivation2A, expActivation2A, ...
        "AbsTol", 0.0001);
    verifyEqual(testCase, actActivation2B, expActivation2B, ...
        "AbsTol", 0.0001);
end

function TestPlottingInfoSimple(testCase)
    PT1 = PerceptualTrajectory([1 6 10; 2 5 11; 3 4 12], "zRowIndex", 3);
    PT2 = PerceptualTrajectory([1 3 4 8; 1 3 4 8]);
    
    Color1A = [1 0 0.5];
    Color1B = [0 0 1];

    Color2A = [1 0 0.75];
    Color2B = [1 0.75 0];

    [actXValues1, actYValues1, actColorValues1] = PT1.PlottingInfo( ...
        Color1A, Color1B);
    [actXValues2, actYValues2, actColorValues2] = PT2.PlottingInfo( ...
        Color2A, Color2B);

    expXValues1 = [1 6 10];
    expYValues1 = [2 5 11];
    expColorValues1 = [1 0 0.5; 0.5 0 0.75; 0 0 1];

    expXValues2 = [1 3 4 8];
    expYValues2 = [1 3 4 8];
    expColorValues2 = [1 0 0.75; 1 0.25 0.5; 1 0.5 0.25; 1 0.75 0];

    verifyEqual(testCase, actXValues1, expXValues1, "AbsTol", 0.0001);
    verifyEqual(testCase, actYValues1, expYValues1, "AbsTol", 0.0001);
    verifyEqual(testCase, actColorValues1, expColorValues1, ...
        "AbsTol", 0.0001);

    verifyEqual(testCase, actXValues2, expXValues2, "AbsTol", 0.0001);
    verifyEqual(testCase, actYValues2, expYValues2, "AbsTol", 0.0001);
    verifyEqual(testCase, actColorValues2, expColorValues2, ...
        "AbsTol", 0.0001);
end

function TestPlottingInfo3DSimple(testCase)
    PT1 = PerceptualTrajectory([1 6 10; 2 5 11; 3 4 12], ...
        "zRowIndex", 3);
    PT2 = PerceptualTrajectory([1 3 4 8; 2 4 8 6; 3 5 16 4; 4 6 32 2], ...
        "zRowIndex", 3);
    
    Color1A = [1 0 0.5];
    Color1B = [0 0 1];

    Color2A = [1 0 0.75];
    Color2B = [1 0.75 0];

    [actXValues1, actYValues1, actZValues1, actColorValues1] = ...
        PT1.PlottingInfo3D(Color1A, Color1B);
    [actXValues2, actYValues2, actZValues2, actColorValues2] = ...
        PT2.PlottingInfo3D(Color2A, Color2B);

    expXValues1 = [1 6 10];
    expYValues1 = [2 5 11];
    expZValues1 = [3 4 12];
    expColorValues1 = [1 0 0.5; 0.5 0 0.75; 0 0 1];

    expXValues2 = [1 3 4 8];
    expYValues2 = [2 4 8 6];
    expZValues2 = [3 5 16 4];
    expColorValues2 = [1 0 0.75; 1 0.25 0.5; 1 0.5 0.25; 1 0.75 0];

    verifyEqual(testCase, actXValues1, expXValues1);
    verifyEqual(testCase, actYValues1, expYValues1);
    verifyEqual(testCase, actZValues1, expZValues1);
    verifyEqual(testCase, actColorValues1, expColorValues1);

    verifyEqual(testCase, actXValues2, expXValues2);
    verifyEqual(testCase, actYValues2, expYValues2);
    verifyEqual(testCase, actZValues2, expZValues2);
    verifyEqual(testCase, actColorValues2, expColorValues2);
end
