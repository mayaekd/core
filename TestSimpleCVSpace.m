%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS TESTED
%
%  

%% TESTS

function tests = TestSimpleCVSpace()
    tests = functiontests(localfunctions);
end

function TestFunctionSimple(testCase)
    space = SimpleCVSpace;

    expCluster1Motor = [0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3; 
        0 0 0 0 1 1 1 1 2 2 2 2 3 3 3 3];
    expCluster2Motor = [5 6 7 8 5 6 7 8 5 6 7 8 5 6 7 8; 
        0 0 0 0 1 1 1 1 2 2 2 2 3 3 3 3];
    expCluster3Motor = [10 11 12 13 10 11 12 13 10 11 12 13 10 11 12 13; 
        0 0 0 0 1 1 1 1 2 2 2 2 3 3 3 3];
    expCluster4Motor = [15 16 17 18 15 16 17 18 15 16 17 18 15 16 17 18; 
        0 0 0 0 1 1 1 1 2 2 2 2 3 3 3 3];
    expCluster5Motor = [20 21 22 23 20 21 22 23 20 21 22 23 20 21 22 23; 
        0 0 0 0 1 1 1 1 2 2 2 2 3 3 3 3];
    expCluster6Motor = [25 26 27 28 25 26 27 28 25 26 27 28 25 26 27 28; 
        0 0 0 0 1 1 1 1 2 2 2 2 3 3 3 3];
    expCluster7Motor = [0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3; 
        18 18 18 18 19 19 19 19 20 20 20 20 21 21 21 21];
    expCluster8Motor = [5 6 7 8 5 6 7 8 5 6 7 8 5 6 7 8; 
        18 18 18 18 19 19 19 19 20 20 20 20 21 21 21 21];
    expCluster9Motor = [10 11 12 13 10 11 12 13 10 11 12 13 10 11 12 13; 
        18 18 18 18 19 19 19 19 20 20 20 20 21 21 21 21];
    expCluster10Motor = [15 16 17 18 15 16 17 18 15 16 17 18 15 16 17 18; 
        18 18 18 18 19 19 19 19 20 20 20 20 21 21 21 21];
    expCluster11Motor = [20 21 22 23 20 21 22 23 20 21 22 23 20 21 22 23; 
        18 18 18 18 19 19 19 19 20 20 20 20 21 21 21 21];
    expCluster12Motor = [25 26 27 28 25 26 27 28 25 26 27 28 25 26 27 28; 
        18 18 18 18 19 19 19 19 20 20 20 20 21 21 21 21];

    expCluster1Perceptual = [10 11 12 13 10 11 12 13 10 11 12 13 10 11 12 13; 
        0 0 0 0 1 1 1 1 2 2 2 2 3 3 3 3];
    expCluster2Perceptual = [15 16 17 18 15 16 17 18 15 16 17 18 15 16 17 18; 
        0 0 0 0 1 1 1 1 2 2 2 2 3 3 3 3];
    expCluster3Perceptual = [0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3; 
        0 0 0 0 1 1 1 1 2 2 2 2 3 3 3 3];
    expCluster4Perceptual = [5 6 7 8 5 6 7 8 5 6 7 8 5 6 7 8; 
        0 0 0 0 1 1 1 1 2 2 2 2 3 3 3 3];
    expCluster5Perceptual = [20 21 22 23 20 21 22 23 20 21 22 23 20 21 22 23; 
        0 0 0 0 1 1 1 1 2 2 2 2 3 3 3 3];
    expCluster6Perceptual = [25 26 27 28 25 26 27 28 25 26 27 28 25 26 27 28; 
        0 0 0 0 1 1 1 1 2 2 2 2 3 3 3 3];
    expCluster7Perceptual = [20 21 22 23 20 21 22 23 20 21 22 23 20 21 22 23; 
        18 18 18 18 19 19 19 19 20 20 20 20 21 21 21 21];
    expCluster8Perceptual = [25 26 27 28 25 26 27 28 25 26 27 28 25 26 27 28; 
        18 18 18 18 19 19 19 19 20 20 20 20 21 21 21 21];
    expCluster9Perceptual = [0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3; 
        18 18 18 18 19 19 19 19 20 20 20 20 21 21 21 21];
    expCluster10Perceptual = [5 6 7 8 5 6 7 8 5 6 7 8 5 6 7 8; 
        18 18 18 18 19 19 19 19 20 20 20 20 21 21 21 21];
    expCluster11Perceptual = [10 11 12 13 10 11 12 13 10 11 12 13 10 11 12 13; 
        18 18 18 18 19 19 19 19 20 20 20 20 21 21 21 21];
    expCluster12Perceptual = [15 16 17 18 15 16 17 18 15 16 17 18 15 16 17 18; 
        18 18 18 18 19 19 19 19 20 20 20 20 21 21 21 21];

    verifyEqual(testCase, space.Clusters(1).MotorCoordinateMatrix, ...
        expCluster1Motor, "AbsTol", 0.00001);
    verifyEqual(testCase, space.Clusters(2).MotorCoordinateMatrix, ...
        expCluster2Motor, "AbsTol", 0.00001);
    verifyEqual(testCase, space.Clusters(3).MotorCoordinateMatrix, ...
        expCluster3Motor, "AbsTol", 0.00001);
    verifyEqual(testCase, space.Clusters(4).MotorCoordinateMatrix, ...
        expCluster4Motor, "AbsTol", 0.00001);
    verifyEqual(testCase, space.Clusters(5).MotorCoordinateMatrix, ...
        expCluster5Motor, "AbsTol", 0.00001);
    verifyEqual(testCase, space.Clusters(6).MotorCoordinateMatrix, ...
        expCluster6Motor, "AbsTol", 0.00001);
    verifyEqual(testCase, space.Clusters(7).MotorCoordinateMatrix, ...
        expCluster7Motor, "AbsTol", 0.00001);
    verifyEqual(testCase, space.Clusters(8).MotorCoordinateMatrix, ...
        expCluster8Motor, "AbsTol", 0.00001);
    verifyEqual(testCase, space.Clusters(9).MotorCoordinateMatrix, ...
        expCluster9Motor, "AbsTol", 0.00001);
    verifyEqual(testCase, space.Clusters(10).MotorCoordinateMatrix, ...
        expCluster10Motor, "AbsTol", 0.00001);
    verifyEqual(testCase, space.Clusters(11).MotorCoordinateMatrix, ...
        expCluster11Motor, "AbsTol", 0.00001);
    verifyEqual(testCase, space.Clusters(12).MotorCoordinateMatrix, ...
        expCluster12Motor, "AbsTol", 0.00001);

    verifyEqual(testCase, space.Clusters(1).PerceptualCoordinateMatrix, ...
        expCluster1Perceptual, "AbsTol", 0.00001);
    verifyEqual(testCase, space.Clusters(2).PerceptualCoordinateMatrix, ...
        expCluster2Perceptual, "AbsTol", 0.00001);
    verifyEqual(testCase, space.Clusters(3).PerceptualCoordinateMatrix, ...
        expCluster3Perceptual, "AbsTol", 0.00001);
    verifyEqual(testCase, space.Clusters(4).PerceptualCoordinateMatrix, ...
        expCluster4Perceptual, "AbsTol", 0.00001);
    verifyEqual(testCase, space.Clusters(5).PerceptualCoordinateMatrix, ...
        expCluster5Perceptual, "AbsTol", 0.00001);
    verifyEqual(testCase, space.Clusters(6).PerceptualCoordinateMatrix, ...
        expCluster6Perceptual, "AbsTol", 0.00001);
    verifyEqual(testCase, space.Clusters(7).PerceptualCoordinateMatrix, ...
        expCluster7Perceptual, "AbsTol", 0.00001);
    verifyEqual(testCase, space.Clusters(8).PerceptualCoordinateMatrix, ...
        expCluster8Perceptual, "AbsTol", 0.00001);
    verifyEqual(testCase, space.Clusters(9).PerceptualCoordinateMatrix, ...
        expCluster9Perceptual, "AbsTol", 0.00001);
    verifyEqual(testCase, space.Clusters(10).PerceptualCoordinateMatrix, ...
        expCluster10Perceptual, "AbsTol", 0.00001);
    verifyEqual(testCase, space.Clusters(11).PerceptualCoordinateMatrix, ...
        expCluster11Perceptual, "AbsTol", 0.00001);
    verifyEqual(testCase, space.Clusters(12).PerceptualCoordinateMatrix, ...
        expCluster12Perceptual, "AbsTol", 0.00001);
end

