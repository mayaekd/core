%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% FUNCTIONS TESTED
%
%  DistancePointToSimplex

%% TESTS

function tests = TestDistancePointToSimplexSimple
    tests = functiontests(localfunctions);
end

function Test2Simplex2DSimple(testCase)
    SimplexVertices = [-4 5; 8 5; 0 10];
    Point1 = [0 0];
    Point2 = [3 0];
    Point3 = [-2.4 0];
    Point4 = [-4 3];
    Point5 = [6 -8];
    Point6 = [5 9.1];
    Point7 = [11 1];
    Point8 = [0 12];

    actDistance1 = DistancePointToSimplex(Point1, SimplexVertices);
    actDistance2 = DistancePointToSimplex(Point2, SimplexVertices);    
    actDistance3 = DistancePointToSimplex(Point3, SimplexVertices);
    actDistance4 = DistancePointToSimplex(Point4, SimplexVertices);
    actDistance5 = DistancePointToSimplex(Point5, SimplexVertices);
    actDistance6 = DistancePointToSimplex(Point6, SimplexVertices);    
    actDistance7 = DistancePointToSimplex(Point7, SimplexVertices);
    actDistance8 = DistancePointToSimplex(Point8, SimplexVertices);

    expDistance1 = 5;
    expDistance2 = 5;
    expDistance3 = 5;
    expDistance4 = 2;
    expDistance5 = 13;
    expDistance6 = sqrt(3.56);
    expDistance7 = 5;
    expDistance8 = 2;

    verifyEqual(testCase, actDistance1, expDistance1);
    verifyEqual(testCase, actDistance2, expDistance2);
    verifyEqual(testCase, actDistance3, expDistance3);
    verifyEqual(testCase, actDistance4, expDistance4);
    verifyEqual(testCase, actDistance5, expDistance5);
    verifyEqual(testCase, actDistance6, expDistance6, "AbsTol", 0.00001);
    verifyEqual(testCase, actDistance7, expDistance7);
    verifyEqual(testCase, actDistance8, expDistance8);
end
