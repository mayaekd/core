%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS TESTED
%  WeightedMotorSimplicialComplex
%  Contains
%  DistancesToCoordinates
%  ActivationOfMotorMatrix
%  DistanceToActivationFunction
%  Expand
%  AddPointToSimplicialComplex
%  PlottingInfo

%% TESTS

function tests = TestWeightedMotorSimplicialComplexSimple
    tests = functiontests(localfunctions);
end

function TestCreateObjectSimple(testCase)
    MotorVertexList = [0 0; 0 3; 4 3; 4 0];
    SimplexMatrix = [1 2 3; 1 3 4];
    Weights = [1 2];
    wmsc = WeightedMotorSimplicialComplex(MotorVertexList, SimplexMatrix, Weights);
    actMotorVertexList = wmsc.MotorVertexList;
    actSimplexMatrix = wmsc.SimplexMatrix;
    actWeights = wmsc.Weights;
    actNumSimplices = wmsc.NumSimplices;
    actSimplexDimension = wmsc.SimplexDimension;
    actSpaceDimension = wmsc.SpaceDimension;
    actFull = wmsc.Full;
    actBoundaryFaceList = wmsc.BoundaryFaceList;
    
    expMotorVertexList = [0 0; 0 3; 4 3; 4 0];
    expSimplexMatrix = [1 2 3; 1 3 4];
    expWeights = [1 2];
    expNumSimplices = 2;
    expSimplexDimension = 2;
    expSpaceDimension = 2;
    expFull = true;
    expBoundaryFaceList = [1 2; 1 4; 2 3; 3 4];

    verifyEqual(testCase, actMotorVertexList, expMotorVertexList);
    verifyEqual(testCase, actSimplexMatrix, expSimplexMatrix);
    verifyEqual(testCase, actWeights, expWeights);
    verifyEqual(testCase, actNumSimplices, expNumSimplices);
    verifyEqual(testCase, actSimplexDimension, expSimplexDimension);
    verifyEqual(testCase, actSpaceDimension, expSpaceDimension);
    verifyEqual(testCase, actFull, expFull);
    verifyEqual(testCase, actBoundaryFaceList, expBoundaryFaceList);
end

function TestContainsSimple(testCase)
    MotorVertexList = [0 0; 0 3; 4 3; 4 0];
    SimplexMatrix = [1 2 3; 1 3 4];
    Weights = [1 2];
    wmsc = WeightedMotorSimplicialComplex(MotorVertexList, SimplexMatrix, Weights);
    Coord1 = [0; 0];
    Coord2 = [0; 3];
    Coord3 = [4; 3];
    Coord4 = [4; 0];
    Coord5 = [10; 3];
    Coord6 = [0; 2];
    Coord7 = [1; 1];
    Coord8 = [2; 1.5];
    Coord9 = [3; 1];
    Coord10 = [3; 2.5];

    actContains1 = wmsc.Contains(Coord1);
    actContains2 = wmsc.Contains(Coord2);
    actContains3 = wmsc.Contains(Coord3);
    actContains4 = wmsc.Contains(Coord4);
    actContains5 = wmsc.Contains(Coord5);
    actContains6 = wmsc.Contains(Coord6);
    actContains7 = wmsc.Contains(Coord7);
    actContains8 = wmsc.Contains(Coord8);
    actContains9 = wmsc.Contains(Coord9);
    actContains10 = wmsc.Contains(Coord10);

    expContains1 = [1 2];
    expContains2 = 1;
    expContains3 = [1 2];
    expContains4 = 2;
    expContains5 = zeros(1,0);
    expContains6 = 1;
    expContains7 = 1;
    expContains8 = [1 2];
    expContains9 = 2;
    expContains10 = 1;

    verifyEqual(testCase, actContains1, expContains1);
    verifyEqual(testCase, actContains2, expContains2);
    verifyEqual(testCase, actContains3, expContains3);
    verifyEqual(testCase, actContains4, expContains4);
    verifyEqual(testCase, actContains5, expContains5);
    verifyEqual(testCase, actContains6, expContains6);
    verifyEqual(testCase, actContains7, expContains7);
    verifyEqual(testCase, actContains8, expContains8);
    verifyEqual(testCase, actContains9, expContains9);
    verifyEqual(testCase, actContains10, expContains10);
end

function TestDistancesToCoordinatesSimple(testCase)
    MotorVertexList = [0 0; 0 3; 4 3; 4 0];
    SimplexMatrix = [1 2 3; 1 3 4];
    Weights = [1 2];
    wmsc = WeightedMotorSimplicialComplex(MotorVertexList, SimplexMatrix, Weights);
    Coordinate1 = [-3; -4];
    Coordinate2 = [-6; 2];
    Coordinate3 = [-6; 11];
    Coordinate4 = [1; 20];
    Coordinate5 = [14; 27];
    Coordinate6 = [25; 1];
    Coordinate7 = [6; -1.5];
    Coordinate8 = [3.4; -8];
    Coordinate9 = [3; 2];
    Coordinate10 = [4; 3];

    actDistance1 = wmsc.DistancesToCoordinates(Coordinate1);
    actDistance2 = wmsc.DistancesToCoordinates(Coordinate2);
    actDistance3 = wmsc.DistancesToCoordinates(Coordinate3);
    actDistance4 = wmsc.DistancesToCoordinates(Coordinate4);
    actDistance5 = wmsc.DistancesToCoordinates(Coordinate5);
    actDistance6 = wmsc.DistancesToCoordinates(Coordinate6);
    actDistance7 = wmsc.DistancesToCoordinates(Coordinate7);
    actDistance8 = wmsc.DistancesToCoordinates(Coordinate8);
    actDistance9 = wmsc.DistancesToCoordinates(Coordinate9);
    actDistance10 = wmsc.DistancesToCoordinates(Coordinate10);

    expDistance1 = [5 5];
    expDistance2 = [6 sqrt(40)];
    expDistance3 = [10 12.4];
    expDistance4 = [17 sqrt(298)];
    expDistance5 = [26 26];
    expDistance6 = [sqrt(445) 21];
    expDistance7 = [4.8 2.5];
    expDistance8 = [sqrt(75.56) 8];
    expDistance9 = [0.2 0];
    expDistance10 = [0 0];

    verifyEqual(testCase, actDistance1, expDistance1, "AbsTol", 0.00001);
    verifyEqual(testCase, actDistance2, expDistance2, "AbsTol", 0.00001);
    verifyEqual(testCase, actDistance3, expDistance3, "AbsTol", 0.00001);
    verifyEqual(testCase, actDistance4, expDistance4, "AbsTol", 0.00001);
    verifyEqual(testCase, actDistance5, expDistance5, "AbsTol", 0.00001);
    verifyEqual(testCase, actDistance6, expDistance6, "AbsTol", 0.00001);
    verifyEqual(testCase, actDistance7, expDistance7, "AbsTol", 0.00001);
    verifyEqual(testCase, actDistance8, expDistance8, "AbsTol", 0.00001);
    verifyEqual(testCase, actDistance9, expDistance9, "AbsTol", 0.00001);
    verifyEqual(testCase, actDistance10, expDistance10, "AbsTol", 0.00001);
end

function TestActivationOfMotorMatrixSimple(testCase)
    MotorVertexList = [0 0; 0 3; 4 3; 4 0];
    SimplexMatrix = [1 2 3; 1 3 4];
    Weights = [1 2];
    wmsc = WeightedMotorSimplicialComplex(MotorVertexList, SimplexMatrix, Weights);
    Cluster1 = Cluster([0 0 24; 0 3 5], [90 -3 90; 100 -4 100]);
    HighestActivation = 1;
    DropoffSlopeA = 0.1;
    DropoffSlopeB = 0.2;

    actActivationA = wmsc.ActivationOfMotorMatrix(Cluster1.MotorCoordinateMatrix, HighestActivation, DropoffSlopeA);
    actActivationB = wmsc.ActivationOfMotorMatrix(Cluster1.MotorCoordinateMatrix, HighestActivation, DropoffSlopeB);

    expActivationA = 1.84/3;
    expActivationB = 0.56;

    verifyEqual(testCase, actActivationA, expActivationA, "AbsTol", 0.000001);
    verifyEqual(testCase, actActivationB, expActivationB, "AbsTol", 0.000001);
end

function TestDistanceToActivationFunctionSimple(testCase)
    Distance1 = 5;
    Distance2 = 10;
    HighestActivationA = 1;
    HighestActivationB = 8;
    DropoffSlopeC = 0.1;
    DropoffSlopeD = 0.4;

    % Making object (irrelevant)
    MotorVertexList = [0 0; 0 3; 4 3; 4 0];
    SimplexMatrix = [1 2 3; 1 3 4];
    Weights = [1 2];
    wmsc = WeightedMotorSimplicialComplex(MotorVertexList, SimplexMatrix, Weights);
    
    actActivation1AC = wmsc.DistanceToActivationFunction(Distance1, ...
        HighestActivationA, DropoffSlopeC);
    actActivation1AD = wmsc.DistanceToActivationFunction(Distance1, ...
        HighestActivationA, DropoffSlopeD);
    actActivation1BC = wmsc.DistanceToActivationFunction(Distance1, ...
        HighestActivationB, DropoffSlopeC);
    actActivation1BD = wmsc.DistanceToActivationFunction(Distance1, ...
        HighestActivationB, DropoffSlopeD);
    actActivation2AC = wmsc.DistanceToActivationFunction(Distance2, ...
        HighestActivationA, DropoffSlopeC);
    actActivation2AD = wmsc.DistanceToActivationFunction(Distance2, ...
        HighestActivationA, DropoffSlopeD);
    actActivation2BC = wmsc.DistanceToActivationFunction(Distance2, ...
        HighestActivationB, DropoffSlopeC);
    actActivation2BD = wmsc.DistanceToActivationFunction(Distance2, ...
        HighestActivationB, DropoffSlopeD);

    expActivation1AC = 0.5;
    expActivation1AD = 0;
    expActivation1BC = 7.5;
    expActivation1BD = 6;
    expActivation2AC = 0;
    expActivation2AD = 0;
    expActivation2BC = 7;
    expActivation2BD = 4;
    
    verifyEqual(testCase, actActivation1AC, expActivation1AC);
    verifyEqual(testCase, actActivation1AD, expActivation1AD);
    verifyEqual(testCase, actActivation1BC, expActivation1BC);
    verifyEqual(testCase, actActivation1BD, expActivation1BD);
    verifyEqual(testCase, actActivation2AC, expActivation2AC);
    verifyEqual(testCase, actActivation2AD, expActivation2AD);
    verifyEqual(testCase, actActivation2BC, expActivation2BC);
    verifyEqual(testCase, actActivation2BD, expActivation2BD);
end

function TestExpandSimple(testCase)
    MotorVertexList = [0 0; 0 3; 4 3; 4 0];
    SimplexMatrix = [1 2 3; 1 3 4];
    Weights = [1 2];
    wmsc = WeightedMotorSimplicialComplex(MotorVertexList, SimplexMatrix, Weights);
    
    Coordinate1 = [4; 3]; % In both simplices
    Coordinate2 = [1; 2]; % In the first simplex
    Coordinate3 = [6; 0]; % Creates new simplex to the right
    Coordinate4 = [6; 5]; % Creates two new simplices to the upper right
    Coordinate5 = [4; 10]; % Creates new simplex above

    NewSimplicialComplex1 = wmsc.Expand(Coordinate1);
    NewSimplicialComplex2 = wmsc.Expand(Coordinate2);
    NewSimplicialComplex3 = wmsc.Expand(Coordinate3);
    NewSimplicialComplex4 = wmsc.Expand(Coordinate4);
    NewSimplicialComplex5 = wmsc.Expand(Coordinate5);

    %% Actual Values
    actMotorVertexList1 = NewSimplicialComplex1.MotorVertexList;
    actMotorVertexList2 = NewSimplicialComplex2.MotorVertexList;
    actMotorVertexList3 = NewSimplicialComplex3.MotorVertexList;
    actMotorVertexList4 = NewSimplicialComplex4.MotorVertexList;
    actMotorVertexList5 = NewSimplicialComplex5.MotorVertexList;

    actSimplexMatrix1 = NewSimplicialComplex1.SimplexMatrix;
    actSimplexMatrix2 = NewSimplicialComplex2.SimplexMatrix;
    actSimplexMatrix3 = NewSimplicialComplex3.SimplexMatrix;
    actSimplexMatrix4 = NewSimplicialComplex4.SimplexMatrix;
    actSimplexMatrix5 = NewSimplicialComplex5.SimplexMatrix;

    actBoundaryFaceList1 = NewSimplicialComplex1.BoundaryFaceList;
    actBoundaryFaceList2 = NewSimplicialComplex2.BoundaryFaceList;
    actBoundaryFaceList3 = NewSimplicialComplex3.BoundaryFaceList;
    actBoundaryFaceList4 = NewSimplicialComplex4.BoundaryFaceList;
    actBoundaryFaceList5 = NewSimplicialComplex5.BoundaryFaceList;

    actWeights1 = NewSimplicialComplex1.Weights;
    actWeights2 = NewSimplicialComplex2.Weights;
    actWeights3 = NewSimplicialComplex3.Weights;
    actWeights4 = NewSimplicialComplex4.Weights;
    actWeights5 = NewSimplicialComplex5.Weights;

    actNumSimplices1 = NewSimplicialComplex1.NumSimplices;
    actNumSimplices2 = NewSimplicialComplex2.NumSimplices;
    actNumSimplices3 = NewSimplicialComplex3.NumSimplices;
    actNumSimplices4 = NewSimplicialComplex4.NumSimplices;
    actNumSimplices5 = NewSimplicialComplex5.NumSimplices;

    actSpaceDimension1 = NewSimplicialComplex1.SpaceDimension;
    actSpaceDimension2 = NewSimplicialComplex2.SpaceDimension;
    actSpaceDimension3 = NewSimplicialComplex3.SpaceDimension;
    actSpaceDimension4 = NewSimplicialComplex4.SpaceDimension;
    actSpaceDimension5 = NewSimplicialComplex5.SpaceDimension;

    actSimplexDimension1 = NewSimplicialComplex1.SimplexDimension;
    actSimplexDimension2 = NewSimplicialComplex2.SimplexDimension;
    actSimplexDimension3 = NewSimplicialComplex3.SimplexDimension;
    actSimplexDimension4 = NewSimplicialComplex4.SimplexDimension;
    actSimplexDimension5 = NewSimplicialComplex5.SimplexDimension;

    actFull1 = NewSimplicialComplex1.Full;
    actFull2 = NewSimplicialComplex2.Full;
    actFull3 = NewSimplicialComplex3.Full;
    actFull4 = NewSimplicialComplex4.Full;
    actFull5 = NewSimplicialComplex5.Full;

    %% Expected values
    expMotorVertexList1 = [0 0; 0 3; 4 3; 4 0];
    expMotorVertexList2 = [0 0; 0 3; 4 3; 4 0];
    expMotorVertexList3 = [0 0; 0 3; 4 3; 4 0; 6 0];
    expMotorVertexList4 = [0 0; 0 3; 4 3; 4 0; 6 5];
    expMotorVertexList5 = [0 0; 0 3; 4 3; 4 0; 4 10];

    expSimplexMatrix1 = [1 2 3; 1 3 4];
    expSimplexMatrix2 = [1 2 3; 1 3 4];
    expSimplexMatrix3 = [1 2 3; 1 3 4; 3 4 5];
    expSimplexMatrix4 = [1 2 3; 1 3 4; 2 3 5; 3 4 5];
    expSimplexMatrix5 = [1 2 3; 1 3 4; 2 3 5];

    expBoundaryFaceList1 = [1 2; 1 4; 2 3; 3 4];
    expBoundaryFaceList2 = [1 2; 1 4; 2 3; 3 4];
    expBoundaryFaceList3 = [1 2; 1 4; 2 3; 3 5; 4 5];
    expBoundaryFaceList4 = [1 2; 1 4; 2 5; 4 5];
    expBoundaryFaceList5 = [1 2; 1 4; 2 5; 3 4; 3 5];

    expWeights1 = [2 3];
    expWeights2 = [2 2];
    expWeights3 = [1 2 1];
    expWeights4 = [1 2 1 1];
    expWeights5 = [1 2 1];

    expNumSimplices1 = 2;
    expNumSimplices2 = 2;
    expNumSimplices3 = 3;
    expNumSimplices4 = 4;
    expNumSimplices5 = 3;

    expSpaceDimension1 = 2;
    expSpaceDimension2 = 2;
    expSpaceDimension3 = 2;
    expSpaceDimension4 = 2;
    expSpaceDimension5 = 2;

    expSimplexDimension1 = 2;
    expSimplexDimension2 = 2;
    expSimplexDimension3 = 2;
    expSimplexDimension4 = 2;
    expSimplexDimension5 = 2;

    expFull1 = true;
    expFull2 = true;
    expFull3 = true;
    expFull4 = true;
    expFull5 = true;

    %% Testing
    verifyEqual(testCase, actMotorVertexList1, expMotorVertexList1);
    verifyEqual(testCase, actMotorVertexList2, expMotorVertexList2);
    verifyEqual(testCase, actMotorVertexList3, expMotorVertexList3);
    verifyEqual(testCase, actMotorVertexList4, expMotorVertexList4);
    verifyEqual(testCase, actMotorVertexList5, expMotorVertexList5);

    verifyEqual(testCase, actSimplexMatrix1, expSimplexMatrix1);
    verifyEqual(testCase, actSimplexMatrix2, expSimplexMatrix2);
    verifyEqual(testCase, actSimplexMatrix3, expSimplexMatrix3);
    verifyEqual(testCase, actSimplexMatrix4, expSimplexMatrix4);
    verifyEqual(testCase, actSimplexMatrix5, expSimplexMatrix5);

    verifyEqual(testCase, actBoundaryFaceList1, expBoundaryFaceList1);
    verifyEqual(testCase, actBoundaryFaceList2, expBoundaryFaceList2);
    verifyEqual(testCase, actBoundaryFaceList3, expBoundaryFaceList3);
    verifyEqual(testCase, actBoundaryFaceList4, expBoundaryFaceList4);
    verifyEqual(testCase, actBoundaryFaceList5, expBoundaryFaceList5);

    verifyEqual(testCase, actWeights1, expWeights1);
    verifyEqual(testCase, actWeights2, expWeights2);
    verifyEqual(testCase, actWeights3, expWeights3);
    verifyEqual(testCase, actWeights4, expWeights4);
    verifyEqual(testCase, actWeights5, expWeights5);

    verifyEqual(testCase, actNumSimplices1, expNumSimplices1);
    verifyEqual(testCase, actNumSimplices2, expNumSimplices2);
    verifyEqual(testCase, actNumSimplices3, expNumSimplices3);
    verifyEqual(testCase, actNumSimplices4, expNumSimplices4);
    verifyEqual(testCase, actNumSimplices5, expNumSimplices5);

    verifyEqual(testCase, actSpaceDimension1, expSpaceDimension1);
    verifyEqual(testCase, actSpaceDimension2, expSpaceDimension2);
    verifyEqual(testCase, actSpaceDimension3, expSpaceDimension3);
    verifyEqual(testCase, actSpaceDimension4, expSpaceDimension4);
    verifyEqual(testCase, actSpaceDimension5, expSpaceDimension5);

    verifyEqual(testCase, actSimplexDimension1, expSimplexDimension1);
    verifyEqual(testCase, actSimplexDimension2, expSimplexDimension2);
    verifyEqual(testCase, actSimplexDimension3, expSimplexDimension3);
    verifyEqual(testCase, actSimplexDimension4, expSimplexDimension4);
    verifyEqual(testCase, actSimplexDimension5, expSimplexDimension5);

    verifyEqual(testCase, actFull1, expFull1);
    verifyEqual(testCase, actFull2, expFull2);
    verifyEqual(testCase, actFull3, expFull3);
    verifyEqual(testCase, actFull4, expFull4);
    verifyEqual(testCase, actFull5, expFull5);
    
end

function TestAddPointToSimplicialComplexSimple(testCase)
    MotorVertexList = [0 0; 0 3; 4 3; 4 0];
    SimplexMatrix = [1 2 3; 1 3 4];
    Weights = [1 2];
    wmsc = WeightedMotorSimplicialComplex(MotorVertexList, SimplexMatrix, Weights);
    
    Coordinate1 = [-4 -3]; % Creates new simplex to the lower left
    Coordinate2 = [-2 0]; % Creates new simplex to the left
    Coordinate3 = [6 0]; % Creates new simplex to the right
    Coordinate4 = [6 5]; % Creates two new simplices to the upper right
    Coordinate5 = [4 10]; % Creates new simplex above

    %% Actual values
    [actSimplexVertices1, actSimplexMatrix1, actWeights1] = ...
        wmsc.AddPointToSimplicialComplex(Coordinate1);
    [actSimplexVertices2, actSimplexMatrix2, actWeights2] = ...
        wmsc.AddPointToSimplicialComplex(Coordinate2);
    [actSimplexVertices3, actSimplexMatrix3, actWeights3] = ...
        wmsc.AddPointToSimplicialComplex(Coordinate3);
    [actSimplexVertices4, actSimplexMatrix4, actWeights4] = ...
        wmsc.AddPointToSimplicialComplex(Coordinate4);
    [actSimplexVertices5, actSimplexMatrix5, actWeights5] = ...
        wmsc.AddPointToSimplicialComplex(Coordinate5);

    %% Expected values
    expSimplexVertices1 = [0 0; 0 3; 4 3; 4 0; -4 -3];
    expSimplexVertices2 = [0 0; 0 3; 4 3; 4 0; -2 0];
    expSimplexVertices3 = [0 0; 0 3; 4 3; 4 0; 6 0];
    expSimplexVertices4 = [0 0; 0 3; 4 3; 4 0; 6 5];
    expSimplexVertices5 = [0 0; 0 3; 4 3; 4 0; 4 10];

    expSimplexMatrix1 = [1 2 3; 1 3 4; 1 2 5; 1 4 5];
    expSimplexMatrix2 = [1 2 3; 1 3 4; 1 2 5];
    expSimplexMatrix3 = [1 2 3; 1 3 4; 3 4 5];
    expSimplexMatrix4 = [1 2 3; 1 3 4; 2 3 5; 3 4 5];
    expSimplexMatrix5 = [1 2 3; 1 3 4; 2 3 5];

    expWeights1 = [1 2 1 1];
    expWeights2 = [1 2 1];
    expWeights3 = [1 2 1];
    expWeights4 = [1 2 1 1];
    expWeights5 = [1 2 1];

    %% Testing

    verifyEqual(testCase, actSimplexVertices1, expSimplexVertices1);
    verifyEqual(testCase, actSimplexVertices2, expSimplexVertices2);
    verifyEqual(testCase, actSimplexVertices3, expSimplexVertices3);
    verifyEqual(testCase, actSimplexVertices4, expSimplexVertices4);
    verifyEqual(testCase, actSimplexVertices5, expSimplexVertices5);

    verifyEqual(testCase, actSimplexMatrix1, expSimplexMatrix1);
    verifyEqual(testCase, actSimplexMatrix2, expSimplexMatrix2);
    verifyEqual(testCase, actSimplexMatrix3, expSimplexMatrix3);
    verifyEqual(testCase, actSimplexMatrix4, expSimplexMatrix4);
    verifyEqual(testCase, actSimplexMatrix5, expSimplexMatrix5);

    verifyEqual(testCase, actWeights1, expWeights1);
    verifyEqual(testCase, actWeights2, expWeights2);
    verifyEqual(testCase, actWeights3, expWeights3);
    verifyEqual(testCase, actWeights4, expWeights4);
    verifyEqual(testCase, actWeights5, expWeights5);
end

function TestPlottingInfoSimple(testCase)
    MotorVertexList = [0 0; 0 3; 4 3; 4 0];
    SimplexMatrix = [1 2 3; 1 3 4];
    Weights = [2 6];
    wmsc = WeightedMotorSimplicialComplex(MotorVertexList, SimplexMatrix, Weights);
    [actFaceData, actVertexData, actAlphaData] = wmsc.PlottingInfo("AlphaMin", 0.2, "AlphaMax", 0.8);
    expFaceData = [1 2 3; 1 3 4];
    expVertexData = [0 0; 0 3; 4 3; 4 0];
    expAlphaData = [0.2; 0.8];

    verifyEqual(testCase, actFaceData, expFaceData, "AbsTol", 0.000001);
    verifyEqual(testCase, actVertexData, expVertexData, "AbsTol", 0.000001);
    verifyEqual(testCase, actAlphaData, expAlphaData, "AbsTol", 0.000001);
end
