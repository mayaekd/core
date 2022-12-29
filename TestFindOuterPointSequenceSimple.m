%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS TESTED
%
% 

%% TESTS

function tests = TestFindOuterPointSequenceSimple()
    tests = functiontests(localfunctions);
end

function TestFunctionOneRegionSimple(testCase)
    Region1 = WeightedMotorSimplicialComplex([1 7; 1 14; 7 7; 7 14], [1 3 4; 1 2 4], [1 1]);
    RegionsToCombine = [Region1];
    [actPointA, actPointB, actPointC, actPointD, actPointE, actPointF, ...
        actPointG, actPointH, actOuterPointSequence, ...
        actUpperRight, actUpperLeft, actLowerRight, actLowerLeft, ...
        actCIndex, actEIndex, actGIndex, actLastIndex] = ...
        FindOuterPointSequence(RegionsToCombine);
    expPointA = [1; 14];
    expPointB = [7; 14];
    expPointC = [7; 14];
    expPointD = [7; 7];
    expPointE = [7; 7];
    expPointF = [1; 7];
    expPointG = [1; 7];
    expPointH = [1; 14];
    expOuterPointSequence = [1 7 7 1; 14 14 7 7];
    expUpperRight = [7; 14];
    expUpperLeft = [1; 14];
    expLowerRight = [7; 7];
    expLowerLeft = [1; 7];
    expCIndex = 2;
    expEIndex = 3;
    expGIndex = 4;
    expLastIndex = 4;
    verifyEqual(testCase, actPointA, expPointA, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointB, expPointB, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointC, expPointC, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointD, expPointD, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointE, expPointE, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointF, expPointF, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointG, expPointG, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointH, expPointH, "AbsTol", 0.00001);
    verifyEqual(testCase, actOuterPointSequence, expOuterPointSequence, "AbsTol", 0.00001);
    verifyEqual(testCase, actUpperRight, expUpperRight, "AbsTol", 0.00001);
    verifyEqual(testCase, actUpperLeft, expUpperLeft, "AbsTol", 0.00001);
    verifyEqual(testCase, actLowerRight, expLowerRight, "AbsTol", 0.00001);
    verifyEqual(testCase, actLowerLeft, expLowerLeft, "AbsTol", 0.00001);
    verifyEqual(testCase, actCIndex, expCIndex, "AbsTol", 0.00001);
    verifyEqual(testCase, actEIndex, expEIndex, "AbsTol", 0.00001);
    verifyEqual(testCase, actGIndex, expGIndex, "AbsTol", 0.00001);
    verifyEqual(testCase, actLastIndex, expLastIndex, "AbsTol", 0.00001);
end

function TestFunctionDoubleRegionSimple(testCase)
    Region1 = WeightedMotorSimplicialComplex([5 4; 5 12; 10 4; 10 12], [1 3 4; 1 2 4], [1 1]);
    Region2 = WeightedMotorSimplicialComplex([5 4; 5 12; 10 4; 10 12], [1 3 4; 1 2 4], [1 1]);
    RegionsToCombine = [Region1 Region2];
    [actPointA, actPointB, actPointC, actPointD, actPointE, actPointF, ...
        actPointG, actPointH, actOuterPointSequence, ...
        actUpperRight, actUpperLeft, actLowerRight, actLowerLeft, ...
        actCIndex, actEIndex, actGIndex, actLastIndex] = ...
        FindOuterPointSequence(RegionsToCombine);
    expPointA = [5; 12];
    expPointB = [10; 12];
    expPointC = [10; 12];
    expPointD = [10; 4];
    expPointE = [10; 4];
    expPointF = [5; 4];
    expPointG = [5; 4];
    expPointH = [5; 12];
    expOuterPointSequence = [5 10 10 5; 12 12 4 4];
    expUpperRight = [10 10; 12 12];
    expUpperLeft = [5 5; 12 12];
    expLowerRight = [10 10; 4 4];
    expLowerLeft = [5 5; 4 4];
    expCIndex = 2;
    expEIndex = 3;
    expGIndex = 4;
    expLastIndex = 4;
    verifyEqual(testCase, actPointA, expPointA, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointB, expPointB, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointC, expPointC, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointD, expPointD, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointE, expPointE, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointF, expPointF, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointG, expPointG, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointH, expPointH, "AbsTol", 0.00001);
    verifyEqual(testCase, actOuterPointSequence, expOuterPointSequence, "AbsTol", 0.00001);
    verifyEqual(testCase, actUpperRight, expUpperRight, "AbsTol", 0.00001);
    verifyEqual(testCase, actUpperLeft, expUpperLeft, "AbsTol", 0.00001);
    verifyEqual(testCase, actLowerRight, expLowerRight, "AbsTol", 0.00001);
    verifyEqual(testCase, actLowerLeft, expLowerLeft, "AbsTol", 0.00001);
    verifyEqual(testCase, actCIndex, expCIndex, "AbsTol", 0.00001);
    verifyEqual(testCase, actEIndex, expEIndex, "AbsTol", 0.00001);
    verifyEqual(testCase, actGIndex, expGIndex, "AbsTol", 0.00001);
    verifyEqual(testCase, actLastIndex, expLastIndex, "AbsTol", 0.00001);
end


function TestFunctionSimple(testCase)
    Region1 = WeightedMotorSimplicialComplex([1 7; 1 14; 7 7; 7 14], [1 3 4; 1 2 4], [1 1]);
    Region2 = WeightedMotorSimplicialComplex([2 1; 2 10; 12 1; 12 10], [1 3 4; 1 2 4], [1 1]);
    Region3 = WeightedMotorSimplicialComplex([5 4; 5 12; 10 4; 10 12], [1 3 4; 1 2 4], [1 1]);
    RegionsToCombine = [Region1 Region2 Region3];
    [actPointA, actPointB, actPointC, actPointD, actPointE, actPointF, ...
        actPointG, actPointH, actOuterPointSequence, ...
        actUpperRight, actUpperLeft, actLowerRight, actLowerLeft, ...
        actCIndex, actEIndex, actGIndex, actLastIndex] = ...
        FindOuterPointSequence(RegionsToCombine);
    expPointA = [1; 14];
    expPointB = [7; 14];
    expPointC = [12; 10];
    expPointD = [12; 1];
    expPointE = [12; 1];
    expPointF = [2; 1];
    expPointG = [1; 7];
    expPointH = [1; 14];
    expOuterPointSequence = [1 7 10 12 12 2 1; 14 14 12 10 1 1 7];
    expUpperRight = [7 12 10; 14 10 12];
    expUpperLeft = [1 2 5; 14 10 12];
    expLowerRight = [7 12 10; 7 1 4];
    expLowerLeft = [1 2 5; 7 1 4];
    expCIndex = 4;
    expEIndex = 5;
    expGIndex = 7;
    expLastIndex = 7;
    verifyEqual(testCase, actPointA, expPointA, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointB, expPointB, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointC, expPointC, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointD, expPointD, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointE, expPointE, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointF, expPointF, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointG, expPointG, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointH, expPointH, "AbsTol", 0.00001);
    verifyEqual(testCase, actOuterPointSequence, expOuterPointSequence, "AbsTol", 0.00001);
    verifyEqual(testCase, actUpperRight, expUpperRight, "AbsTol", 0.00001);
    verifyEqual(testCase, actUpperLeft, expUpperLeft, "AbsTol", 0.00001);
    verifyEqual(testCase, actLowerRight, expLowerRight, "AbsTol", 0.00001);
    verifyEqual(testCase, actLowerLeft, expLowerLeft, "AbsTol", 0.00001);
    verifyEqual(testCase, actCIndex, expCIndex, "AbsTol", 0.00001);
    verifyEqual(testCase, actEIndex, expEIndex, "AbsTol", 0.00001);
    verifyEqual(testCase, actGIndex, expGIndex, "AbsTol", 0.00001);
    verifyEqual(testCase, actLastIndex, expLastIndex, "AbsTol", 0.00001);
end


function TestFunctionSimple2(testCase)
    Region1 = WeightedMotorSimplicialComplex([1 7; 1 14; 7 7; 7 14], [1 3 4; 1 2 4], [1 1]);
    Region2 = WeightedMotorSimplicialComplex([2 1; 2 10; 12 1; 12 10], [1 3 4; 1 2 4], [1 1]);
    Region3 = WeightedMotorSimplicialComplex([5 4; 5 12; 10 4; 10 12], [1 3 4; 1 2 4], [1 1]);
    Region4 = WeightedMotorSimplicialComplex([0 -5; 0 2; 8 -5; 8 2], [1 3 4; 1 2 4], [1 1]);
    Region5 = WeightedMotorSimplicialComplex([6 2; 6 3; 9 2; 9 3], [1 3 4; 1 2 4], [1 1]);
    RegionsToCombine = [Region1 Region2 Region3 Region4 Region5];
    [actPointA, actPointB, actPointC, actPointD, actPointE, actPointF, ...
        actPointG, actPointH, actOuterPointSequence, ...
        actUpperRight, actUpperLeft, actLowerRight, actLowerLeft, ...
        actCIndex, actEIndex, actGIndex, actLastIndex] = ...
        FindOuterPointSequence(RegionsToCombine);
    expPointA = [1; 14];
    expPointB = [7; 14];
    expPointC = [12; 10];
    expPointD = [12; 1];
    expPointE = [8; -5];
    expPointF = [0; -5];
    expPointG = [0; -5];
    expPointH = [0; 2];
    expOuterPointSequence = [1 7 10 12 12 8 0 0; 14 14 12 10 1 -5 -5 2];
    expUpperRight = [7 12 10 8 9; 14 10 12 2 3];
    expUpperLeft = [1 2 5 0 6; 14 10 12 2 3];
    expLowerRight = [7 12 10 8 9; 7 1 4 -5 2];
    expLowerLeft = [1 2 5 0 6; 7 1 4 -5 2];
    expCIndex = 4;
    expEIndex = 6;
    expGIndex = 7;
    expLastIndex = 8;
    verifyEqual(testCase, actPointA, expPointA, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointB, expPointB, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointC, expPointC, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointD, expPointD, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointE, expPointE, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointF, expPointF, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointG, expPointG, "AbsTol", 0.00001);
    verifyEqual(testCase, actPointH, expPointH, "AbsTol", 0.00001);
    verifyEqual(testCase, actOuterPointSequence, expOuterPointSequence, "AbsTol", 0.00001);
    verifyEqual(testCase, actUpperRight, expUpperRight, "AbsTol", 0.00001);
    verifyEqual(testCase, actUpperLeft, expUpperLeft, "AbsTol", 0.00001);
    verifyEqual(testCase, actLowerRight, expLowerRight, "AbsTol", 0.00001);
    verifyEqual(testCase, actLowerLeft, expLowerLeft, "AbsTol", 0.00001);
    verifyEqual(testCase, actCIndex, expCIndex, "AbsTol", 0.00001);
    verifyEqual(testCase, actEIndex, expEIndex, "AbsTol", 0.00001);
    verifyEqual(testCase, actGIndex, expGIndex, "AbsTol", 0.00001);
    verifyEqual(testCase, actLastIndex, expLastIndex, "AbsTol", 0.00001);
end
