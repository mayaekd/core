%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS TESTED
%
% 

%% TESTS

function tests = TestCombineRectangularRegionsSimple()
    tests = functiontests(localfunctions);
end

function TestFunctionOneRegionSimple(testCase)
    Region1 = WeightedMotorSimplicialComplex([1 7; 1 14; 7 7; 7 14], [1 3 4; 1 2 4], [1 1]);
    RegionsToCombine = [Region1];
    CombinedRegion = CombineRectangularRegions(RegionsToCombine);
    actMotorVertexList = CombinedRegion.MotorVertexList;
    actSimplexMatrix = CombinedRegion.SimplexMatrix;
    actWeights = CombinedRegion.Weights;
    expMotorVertexList = [1 7; 1 14; 7 7; 7 14];
    expSimplexMatrix = [1 3 4; 2 1 4];
    expWeights = [1 1];
    verifyEqual(testCase, actMotorVertexList, expMotorVertexList, "AbsTol", 0.00001);
    verifyEqual(testCase, actSimplexMatrix, expSimplexMatrix, "AbsTol", 0.00001);
    verifyEqual(testCase, actWeights, expWeights, "AbsTol", 0.00001);
end

function TestFunctionDoubleRegionSimple(testCase)
    Region1 = WeightedMotorSimplicialComplex([5 4; 5 12; 10 4; 10 12], [1 3 4; 1 2 4], [1 1]);
    Region2 = WeightedMotorSimplicialComplex([5 4; 5 12; 10 4; 10 12], [1 3 4; 1 2 4], [1 1]);
    RegionsToCombine = [Region1 Region2];
    CombinedRegion = CombineRectangularRegions(RegionsToCombine);
    actMotorVertexList = CombinedRegion.MotorVertexList;
    actSimplexMatrix = CombinedRegion.SimplexMatrix;
    actWeights = CombinedRegion.Weights;
    expMotorVertexList = [5 4; 5 12; 10 4; 10 12];
    expSimplexMatrix = [1 3 4; 2 1 4];
    expWeights = [2 2];
    verifyEqual(testCase, actMotorVertexList, expMotorVertexList, "AbsTol", 0.00001);
    verifyEqual(testCase, actSimplexMatrix, expSimplexMatrix, "AbsTol", 0.00001);
    verifyEqual(testCase, actWeights, expWeights, "AbsTol", 0.00001);
end

function TestFunctionSimple(testCase)
    Region1 = WeightedMotorSimplicialComplex([1 7; 1 14; 7 7; 7 14], [1 3 4; 1 2 4], [1 1]);
    Region2 = WeightedMotorSimplicialComplex([2 1; 2 10; 12 1; 12 10], [1 3 4; 1 2 4], [1 1]);
    Region3 = WeightedMotorSimplicialComplex([5 4; 5 12; 10 4; 10 12], [1 3 4; 1 2 4], [1 1]);
    RegionsToCombine = [Region1 Region2 Region3];
    CombinedRegion = CombineRectangularRegions(RegionsToCombine);
    actMotorVertexList = CombinedRegion.MotorVertexList;
    actSimplexMatrix = CombinedRegion.SimplexMatrix;
    actWeights = CombinedRegion.Weights;
    expMotorVertexList = [1 7; 1 10; 1 12; 1 14; 1.5 4; 1.5 7; 1.5 10; 1.5 12; 1.5 14; 2 1; 2 4; 2 7; 2 10; 2 12; 2 14; 5 1; 5 4; 5 7; 5 10; 5 12; 5 14; 7 1; 7 4; 7 7; 7 10; 7 12; 7 14; 10 1; 10 4; 10 7; 10 10; 10 12; 12 1; 12 4; 12 7; 12 10];
    expSimplexMatrix = [1 5 6; 1 6 7; 2 1 7; 2 7 8; 3 2 8; 3 8 9; 4 3 9; 
        5 10 11; 5 11 12; 6 5 12; 6 12 13; 7 6 13; 7 13 14; 8 7 14; 8 14 15; 9 8 15;
        10 16 17; 11 10 17; 11 17 18; 12 11 18; 12 18 19; 13 12 19; 13 19 20; 14 13 20; 14 20 21; 15 14 21;
        16 22 23; 17 16 23; 17 23 24; 18 17 24; 18 24 25; 19 18 25; 19 25 26; 20 19 26; 20 26 27; 21 20 27; 
        22 28 29; 23 22 29; 23 29 30; 24 23 30; 24 30 31; 25 24 31; 25 31 32; 26 25 32; 27 26 32;
        28 33 34; 29 28 34; 29 34 35; 30 29 35; 30 35 36; 31 30 36; 32 31 36];
    expWeights = [1 1 1 1 1 1 1 ...
        1 1 1 1 1 1 1 1 1 ...
        1 1 1 1 2 2 1 1 1 1 ...
        1 1 2 2 3 3 2 2 1 1 ...
        1 1 2 2 2 2 1 1 1 ...
        1 1 1 1 1 1 1];
    verifyEqual(testCase, actMotorVertexList, expMotorVertexList, "AbsTol", 0.00001);
    verifyEqual(testCase, actSimplexMatrix, expSimplexMatrix, "AbsTol", 0.00001);
    verifyEqual(testCase, actWeights, expWeights, "AbsTol", 0.00001);
end
