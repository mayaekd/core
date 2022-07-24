%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS TESTED
%
%  Goal
%  ActivationsFromExemplar
%  TempActivations
%  SimpleMacroEstimates

%% TESTS

function tests = TestGoalSimple
    tests = functiontests(localfunctions);
end

function TestCreateObjectSimple(testCase)
    %% SETTING UP OBJECTS
    st1 = testCase.TestData.spaceTransformation1;
    st2 = testCase.TestData.spaceTransformation2;

    % CLUSTER LISTS
    Clusters1 = MakeManyHyperCubeClusters([0 0], [2 5], [6 10], [4 2], [3 2], st1);
    Clusters2 = MakeManyHyperCubeClusters([0 0], [2 5], [6 10], [4 2], [3 2], st2);
    
    % SPACES
    Space1 = Space(Clusters1, st1);
    Space2 = Space(Clusters2, st1);

    % SILHOUETTE
    Region1 = WeightedMotorSimplicialComplex([8 2; 8 6; 12 2], [1 2 3], 1);
    Region2 = WeightedMotorSimplicialComplex([6 2; 6 6; 10 2], [1 2 3], 1);
    Region3 = WeightedMotorSimplicialComplex([4 2; 4 6; 8 2], [1 2 3], 1);
    Region4 = WeightedMotorSimplicialComplex([2 2; 2 6; 6 2], [1 2 3], 1);
    Region5 = WeightedMotorSimplicialComplex([2 4; 2 10; 6 4], [1 2 3], 1);
    Region6 = WeightedMotorSimplicialComplex([2 6; 2 12; 6 6], [1 2 3], 1);

    silhouette = MotorSilhouette( ...
        [Region1 Region2 Region3 Region4 Region5 Region6]);
    
    % TRAJECTORY
    trajectory = PerceptualTrajectory([8 7 6 5 4 3 2 2 2 2 2; ...
        1 1 1 1 1 1 1 2 3 4 5]);

    % GOALS
    Goal1 = Goal(Space1, silhouette, trajectory);
    Goal2 = Goal(Space2, silhouette, trajectory);

    %% ACTUAL VALUES
    % CLUSTER MOTOR COORDINATES
    actMotorCoordinates11 = Goal1.Space.Clusters(1).MotorCoordinateMatrix;
    actMotorCoordinates12 = Goal1.Space.Clusters(2).MotorCoordinateMatrix;
    actMotorCoordinates13 = Goal1.Space.Clusters(3).MotorCoordinateMatrix;
    actMotorCoordinates14 = Goal1.Space.Clusters(4).MotorCoordinateMatrix;
    actMotorCoordinates15 = Goal1.Space.Clusters(5).MotorCoordinateMatrix;
    actMotorCoordinates16 = Goal1.Space.Clusters(6).MotorCoordinateMatrix;

    actMotorCoordinates21 = Goal2.Space.Clusters(1).MotorCoordinateMatrix;
    actMotorCoordinates22 = Goal2.Space.Clusters(2).MotorCoordinateMatrix;
    actMotorCoordinates23 = Goal2.Space.Clusters(3).MotorCoordinateMatrix;
    actMotorCoordinates24 = Goal2.Space.Clusters(4).MotorCoordinateMatrix;
    actMotorCoordinates25 = Goal2.Space.Clusters(5).MotorCoordinateMatrix;
    actMotorCoordinates26 = Goal2.Space.Clusters(6).MotorCoordinateMatrix;

    % CLUSTER PERCEPTUAL COORDINATES
    actPerceptualCoordinates11 = Goal1.Space.Clusters(1).PerceptualCoordinateMatrix;
    actPerceptualCoordinates12 = Goal1.Space.Clusters(2).PerceptualCoordinateMatrix;
    actPerceptualCoordinates13 = Goal1.Space.Clusters(3).PerceptualCoordinateMatrix;
    actPerceptualCoordinates14 = Goal1.Space.Clusters(4).PerceptualCoordinateMatrix;
    actPerceptualCoordinates15 = Goal1.Space.Clusters(5).PerceptualCoordinateMatrix;
    actPerceptualCoordinates16 = Goal1.Space.Clusters(6).PerceptualCoordinateMatrix;

    actPerceptualCoordinates21 = Goal2.Space.Clusters(1).PerceptualCoordinateMatrix;
    actPerceptualCoordinates22 = Goal2.Space.Clusters(2).PerceptualCoordinateMatrix;
    actPerceptualCoordinates23 = Goal2.Space.Clusters(3).PerceptualCoordinateMatrix;
    actPerceptualCoordinates24 = Goal2.Space.Clusters(4).PerceptualCoordinateMatrix;
    actPerceptualCoordinates25 = Goal2.Space.Clusters(5).PerceptualCoordinateMatrix;
    actPerceptualCoordinates26 = Goal2.Space.Clusters(6).PerceptualCoordinateMatrix;

    % SILHOUETTES

    actSilhouetteMVL1_1 = Goal1.Silhouette.Regions(1).MotorVertexList;
    actSilhouetteMVL1_2 = Goal1.Silhouette.Regions(2).MotorVertexList;
    actSilhouetteMVL1_3 = Goal1.Silhouette.Regions(3).MotorVertexList;
    actSilhouetteMVL1_4 = Goal1.Silhouette.Regions(4).MotorVertexList;
    actSilhouetteMVL1_5 = Goal1.Silhouette.Regions(5).MotorVertexList;
    actSilhouetteMVL1_6 = Goal1.Silhouette.Regions(6).MotorVertexList;

    actSilhouetteMVL2_1 = Goal2.Silhouette.Regions(1).MotorVertexList;
    actSilhouetteMVL2_2 = Goal2.Silhouette.Regions(2).MotorVertexList;
    actSilhouetteMVL2_3 = Goal2.Silhouette.Regions(3).MotorVertexList;
    actSilhouetteMVL2_4 = Goal2.Silhouette.Regions(4).MotorVertexList;
    actSilhouetteMVL2_5 = Goal2.Silhouette.Regions(5).MotorVertexList;
    actSilhouetteMVL2_6 = Goal2.Silhouette.Regions(6).MotorVertexList;

    actSilhouetteSM1_1 = Goal1.Silhouette.Regions(1).SimplexMatrix;
    actSilhouetteSM1_2 = Goal1.Silhouette.Regions(2).SimplexMatrix;
    actSilhouetteSM1_3 = Goal1.Silhouette.Regions(3).SimplexMatrix;
    actSilhouetteSM1_4 = Goal1.Silhouette.Regions(4).SimplexMatrix;
    actSilhouetteSM1_5 = Goal1.Silhouette.Regions(5).SimplexMatrix;
    actSilhouetteSM1_6 = Goal1.Silhouette.Regions(6).SimplexMatrix;

    actSilhouetteSM2_1 = Goal2.Silhouette.Regions(1).SimplexMatrix;
    actSilhouetteSM2_2 = Goal2.Silhouette.Regions(2).SimplexMatrix;
    actSilhouetteSM2_3 = Goal2.Silhouette.Regions(3).SimplexMatrix;
    actSilhouetteSM2_4 = Goal2.Silhouette.Regions(4).SimplexMatrix;
    actSilhouetteSM2_5 = Goal2.Silhouette.Regions(5).SimplexMatrix;
    actSilhouetteSM2_6 = Goal2.Silhouette.Regions(6).SimplexMatrix;

    actSilhouetteWeights1_1 = Goal1.Silhouette.Regions(1).Weights;
    actSilhouetteWeights1_2 = Goal1.Silhouette.Regions(2).Weights;
    actSilhouetteWeights1_3 = Goal1.Silhouette.Regions(3).Weights;
    actSilhouetteWeights1_4 = Goal1.Silhouette.Regions(4).Weights;
    actSilhouetteWeights1_5 = Goal1.Silhouette.Regions(5).Weights;
    actSilhouetteWeights1_6 = Goal1.Silhouette.Regions(6).Weights;

    actSilhouetteWeights2_1 = Goal2.Silhouette.Regions(1).Weights;
    actSilhouetteWeights2_2 = Goal2.Silhouette.Regions(2).Weights;
    actSilhouetteWeights2_3 = Goal2.Silhouette.Regions(3).Weights;
    actSilhouetteWeights2_4 = Goal2.Silhouette.Regions(4).Weights;
    actSilhouetteWeights2_5 = Goal2.Silhouette.Regions(5).Weights;
    actSilhouetteWeights2_6 = Goal2.Silhouette.Regions(6).Weights;

    % EXEMPLARS 

    actExemplarPoints1 = Goal1.Exemplar.CoordinateMatrix;
    actExemplarPoints2 = Goal2.Exemplar.CoordinateMatrix;
    

    %% EXEPECTED VALUES
    % CLUSTER MOTOR COORDINATES
    expMotorCoordinates11 = [0 2 4 6 0 2 4 6 0 2 4 6; 0 0 0 0 5 5 5 5 10 10 10 10];
    expMotorCoordinates12 = [10 12 14 16 10 12 14 16 10 12 14 16; 0 0 0 0 5 5 5 5 10 10 10 10];
    expMotorCoordinates13 = [20 22 24 26 20 22 24 26 20 22 24 26; 0 0 0 0 5 5 5 5 10 10 10 10];
    expMotorCoordinates14 = [0 2 4 6 0 2 4 6 0 2 4 6; 12 12 12 12 17 17 17 17 22 22 22 22];
    expMotorCoordinates15 = [10 12 14 16 10 12 14 16 10 12 14 16; 12 12 12 12 17 17 17 17 22 22 22 22];
    expMotorCoordinates16 = [20 22 24 26 20 22 24 26 20 22 24 26; 12 12 12 12 17 17 17 17 22 22 22 22];

    expMotorCoordinates21 = [0 2 4 6 0 2 4 6 0 2 4 6; 0 0 0 0 5 5 5 5 10 10 10 10];
    expMotorCoordinates22 = [10 12 14 16 10 12 14 16 10 12 14 16; 0 0 0 0 5 5 5 5 10 10 10 10];
    expMotorCoordinates23 = [20 22 24 26 20 22 24 26 20 22 24 26; 0 0 0 0 5 5 5 5 10 10 10 10];
    expMotorCoordinates24 = [0 2 4 6 0 2 4 6 0 2 4 6; 12 12 12 12 17 17 17 17 22 22 22 22];
    expMotorCoordinates25 = [10 12 14 16 10 12 14 16 10 12 14 16; 12 12 12 12 17 17 17 17 22 22 22 22];
    expMotorCoordinates26 = [20 22 24 26 20 22 24 26 20 22 24 26; 12 12 12 12 17 17 17 17 22 22 22 22];

    % CLUSTER PERCEPTUAL COORDINATES
    expPerceptualCoordinates11 = [0 2 4 6 0 2 4 6 0 2 4 6; 0 0 0 0 5 5 5 5 10 10 10 10];
    expPerceptualCoordinates12 = [10 12 14 16 10 12 14 16 10 12 14 16; 0 0 0 0 5 5 5 5 10 10 10 10];
    expPerceptualCoordinates13 = [20 22 24 26 20 22 24 26 20 22 24 26; 0 0 0 0 5 5 5 5 10 10 10 10];
    expPerceptualCoordinates14 = [0 2 4 6 0 2 4 6 0 2 4 6; 12 12 12 12 17 17 17 17 22 22 22 22];
    expPerceptualCoordinates15 = [10 12 14 16 10 12 14 16 10 12 14 16; 12 12 12 12 17 17 17 17 22 22 22 22];
    expPerceptualCoordinates16 = [20 22 24 26 20 22 24 26 20 22 24 26; 12 12 12 12 17 17 17 17 22 22 22 22];

    expPerceptualCoordinates21 = [10 8 6 4 10 8 6 4 10 8 6 4; 10 10 10 10 5 5 5 5 0 0 0 0];
    expPerceptualCoordinates22 = [0 -2 -4 -6 0 -2 -4 -6 0 -2 -4 -6; 10 10 10 10 5 5 5 5 0 0 0 0];
    expPerceptualCoordinates23 = [-10 -12 -14 -16 -10 -12 -14 -16 -10 -12 -14 -16; 10 10 10 10 5 5 5 5 0 0 0 0];
    expPerceptualCoordinates24 = [10 8 6 4 10 8 6 4 10 8 6 4; -2 -2 -2 -2 -7 -7 -7 -7 -12 -12 -12 -12];
    expPerceptualCoordinates25 = [0 -2 -4 -6 0 -2 -4 -6 0 -2 -4 -6; -2 -2 -2 -2 -7 -7 -7 -7 -12 -12 -12 -12];
    expPerceptualCoordinates26 = [-10 -12 -14 -16 -10 -12 -14 -16 -10 -12 -14 -16; -2 -2 -2 -2 -7 -7 -7 -7 -12 -12 -12 -12];

    % SILHOUETTES

    expSilhouetteMVL1_1 = [8 2; 8 6; 12 2];
    expSilhouetteMVL1_2 = [6 2; 6 6; 10 2];
    expSilhouetteMVL1_3 = [4 2; 4 6; 8 2];
    expSilhouetteMVL1_4 = [2 2; 2 6; 6 2];
    expSilhouetteMVL1_5 = [2 4; 2 10; 6 4];
    expSilhouetteMVL1_6 = [2 6; 2 12; 6 6];

    expSilhouetteMVL2_1 = [8 2; 8 6; 12 2];
    expSilhouetteMVL2_2 = [6 2; 6 6; 10 2];
    expSilhouetteMVL2_3 = [4 2; 4 6; 8 2];
    expSilhouetteMVL2_4 = [2 2; 2 6; 6 2];
    expSilhouetteMVL2_5 = [2 4; 2 10; 6 4];
    expSilhouetteMVL2_6 = [2 6; 2 12; 6 6];

    expSilhouetteSM1_1 = [1 2 3];
    expSilhouetteSM1_2 = [1 2 3];
    expSilhouetteSM1_3 = [1 2 3];
    expSilhouetteSM1_4 = [1 2 3];
    expSilhouetteSM1_5 = [1 2 3];
    expSilhouetteSM1_6 = [1 2 3];

    expSilhouetteSM2_1 = [1 2 3];
    expSilhouetteSM2_2 = [1 2 3];
    expSilhouetteSM2_3 = [1 2 3];
    expSilhouetteSM2_4 = [1 2 3];
    expSilhouetteSM2_5 = [1 2 3];
    expSilhouetteSM2_6 = [1 2 3];

    expSilhouetteWeights1_1 = 1;
    expSilhouetteWeights1_2 = 1;
    expSilhouetteWeights1_3 = 1;
    expSilhouetteWeights1_4 = 1;
    expSilhouetteWeights1_5 = 1;
    expSilhouetteWeights1_6 = 1;

    expSilhouetteWeights2_1 = 1;
    expSilhouetteWeights2_2 = 1;
    expSilhouetteWeights2_3 = 1;
    expSilhouetteWeights2_4 = 1;
    expSilhouetteWeights2_5 = 1;
    expSilhouetteWeights2_6 = 1;

    % EXEMPLARS 

    expExemplarPoints1 = [8 7 6 5 4 3 2 2 2 2 2; 1 1 1 1 1 1 1 2 3 4 5];
    expExemplarPoints2 = [8 7 6 5 4 3 2 2 2 2 2; 1 1 1 1 1 1 1 2 3 4 5];
    
    %% TESTING VALUES -- SPACE COORDINATES
    verifyEqual(testCase, actMotorCoordinates11, expMotorCoordinates11);
    verifyEqual(testCase, actMotorCoordinates12, expMotorCoordinates12);
    verifyEqual(testCase, actMotorCoordinates13, expMotorCoordinates13);
    verifyEqual(testCase, actMotorCoordinates14, expMotorCoordinates14);
    verifyEqual(testCase, actMotorCoordinates15, expMotorCoordinates15);
    verifyEqual(testCase, actMotorCoordinates16, expMotorCoordinates16);

    verifyEqual(testCase, actMotorCoordinates21, expMotorCoordinates21);
    verifyEqual(testCase, actMotorCoordinates22, expMotorCoordinates22);
    verifyEqual(testCase, actMotorCoordinates23, expMotorCoordinates23);
    verifyEqual(testCase, actMotorCoordinates24, expMotorCoordinates24);
    verifyEqual(testCase, actMotorCoordinates25, expMotorCoordinates25);
    verifyEqual(testCase, actMotorCoordinates26, expMotorCoordinates26);

    verifyEqual(testCase, actPerceptualCoordinates11, expPerceptualCoordinates11);
    verifyEqual(testCase, actPerceptualCoordinates12, expPerceptualCoordinates12);
    verifyEqual(testCase, actPerceptualCoordinates13, expPerceptualCoordinates13);
    verifyEqual(testCase, actPerceptualCoordinates14, expPerceptualCoordinates14);
    verifyEqual(testCase, actPerceptualCoordinates15, expPerceptualCoordinates15);
    verifyEqual(testCase, actPerceptualCoordinates16, expPerceptualCoordinates16);

    verifyEqual(testCase, actPerceptualCoordinates21, expPerceptualCoordinates21);
    verifyEqual(testCase, actPerceptualCoordinates22, expPerceptualCoordinates22);
    verifyEqual(testCase, actPerceptualCoordinates23, expPerceptualCoordinates23);
    verifyEqual(testCase, actPerceptualCoordinates24, expPerceptualCoordinates24);
    verifyEqual(testCase, actPerceptualCoordinates25, expPerceptualCoordinates25);
    verifyEqual(testCase, actPerceptualCoordinates26, expPerceptualCoordinates26);

    %% TESTING VALUES -- SILHOUETTES
    verifyEqual(testCase, actSilhouetteMVL1_1, expSilhouetteMVL1_1);
    verifyEqual(testCase, actSilhouetteMVL1_2, expSilhouetteMVL1_2);
    verifyEqual(testCase, actSilhouetteMVL1_3, expSilhouetteMVL1_3);
    verifyEqual(testCase, actSilhouetteMVL1_4, expSilhouetteMVL1_4);
    verifyEqual(testCase, actSilhouetteMVL1_5, expSilhouetteMVL1_5);
    verifyEqual(testCase, actSilhouetteMVL1_6, expSilhouetteMVL1_6);

    verifyEqual(testCase, actSilhouetteMVL2_1, expSilhouetteMVL2_1);
    verifyEqual(testCase, actSilhouetteMVL2_2, expSilhouetteMVL2_2);
    verifyEqual(testCase, actSilhouetteMVL2_3, expSilhouetteMVL2_3);
    verifyEqual(testCase, actSilhouetteMVL2_4, expSilhouetteMVL2_4);
    verifyEqual(testCase, actSilhouetteMVL2_5, expSilhouetteMVL2_5);
    verifyEqual(testCase, actSilhouetteMVL2_6, expSilhouetteMVL2_6);

    verifyEqual(testCase, actSilhouetteSM1_1, expSilhouetteSM1_1);
    verifyEqual(testCase, actSilhouetteSM1_2, expSilhouetteSM1_2);
    verifyEqual(testCase, actSilhouetteSM1_3, expSilhouetteSM1_3);
    verifyEqual(testCase, actSilhouetteSM1_4, expSilhouetteSM1_4);
    verifyEqual(testCase, actSilhouetteSM1_5, expSilhouetteSM1_5);
    verifyEqual(testCase, actSilhouetteSM1_6, expSilhouetteSM1_6);

    verifyEqual(testCase, actSilhouetteSM2_1, expSilhouetteSM2_1);
    verifyEqual(testCase, actSilhouetteSM2_2, expSilhouetteSM2_2);
    verifyEqual(testCase, actSilhouetteSM2_3, expSilhouetteSM2_3);
    verifyEqual(testCase, actSilhouetteSM2_4, expSilhouetteSM2_4);
    verifyEqual(testCase, actSilhouetteSM2_5, expSilhouetteSM2_5);
    verifyEqual(testCase, actSilhouetteSM2_6, expSilhouetteSM2_6);

    verifyEqual(testCase, actSilhouetteWeights1_1, expSilhouetteWeights1_1);
    verifyEqual(testCase, actSilhouetteWeights1_2, expSilhouetteWeights1_2);
    verifyEqual(testCase, actSilhouetteWeights1_3, expSilhouetteWeights1_3);
    verifyEqual(testCase, actSilhouetteWeights1_4, expSilhouetteWeights1_4);
    verifyEqual(testCase, actSilhouetteWeights1_5, expSilhouetteWeights1_5);
    verifyEqual(testCase, actSilhouetteWeights1_6, expSilhouetteWeights1_6);

    verifyEqual(testCase, actSilhouetteWeights2_1, expSilhouetteWeights2_1);
    verifyEqual(testCase, actSilhouetteWeights2_2, expSilhouetteWeights2_2);
    verifyEqual(testCase, actSilhouetteWeights2_3, expSilhouetteWeights2_3);
    verifyEqual(testCase, actSilhouetteWeights2_4, expSilhouetteWeights2_4);
    verifyEqual(testCase, actSilhouetteWeights2_5, expSilhouetteWeights2_5);
    verifyEqual(testCase, actSilhouetteWeights2_6, expSilhouetteWeights2_6);

    %% TESTING VALUES -- EXEMPLARS
    verifyEqual(testCase, actExemplarPoints1, expExemplarPoints1);
    verifyEqual(testCase, actExemplarPoints2, expExemplarPoints2);
end

function TestActivationsFromExemplarSimple(testCase)
    st1 = testCase.TestData.spaceTransformation1;

    % CLUSTER LISTS
    Clusters1 = MakeManyHyperCubeClusters( ...
        [0 0], [2 5], [6 10], [4 2], [3 2], st1);
    
    % SPACES
    Space1 = Space(Clusters1, st1);

    % SILHOUETTE
    Region1 = WeightedMotorSimplicialComplex([0 0; 30 0; 30 6; 0 6], [1 2 3; 1 3 4], [1 1]);
    Region2 = WeightedMotorSimplicialComplex([0 4; 30 4; 30 10; 0 10], [1 2 3; 1 3 4], [1 1]);
    Region3 = WeightedMotorSimplicialComplex([0 40; 30 40; 30 50; 0 50], [1 2 3; 1 3 4], [1 1]);
    Region4 = WeightedMotorSimplicialComplex([0 40; 30 40; 30 50; 0 50], [1 2 3; 1 3 4], [1 1]);
    Region5 = WeightedMotorSimplicialComplex([0 4; 30 4; 30 10; 0 10], [1 2 3; 1 3 4], [1 1]);
    Region6 = WeightedMotorSimplicialComplex([0 0; 30 0; 30 6; 0 6], [1 2 3; 1 3 4], [1 1]);

    silhouette = MotorSilhouette( ...
        [Region1 Region2 Region3 Region4 Region5 Region6]);
    
    % EXEMPLAR
    exemplar = PerceptualTrajectory([3 0 1 8; 0 1 4 3]);

    % GOALS
    Goal1 = Goal(Space1, silhouette, exemplar);

    actActivations1 = Goal1.ActivationsFromExemplar();

    expActivations1 = [0.41578247266573, 0.0962550647782358, 0, ...
        0.0142272861811245, 0.00194082862689794, 0];

    verifyEqual(testCase, actActivations1, expActivations1, ...
        "AbsTol", 0.000000001);
end

function TestTempActivationsSimple(testCase)
    ep = ExecutionParameters(0, 0);

    st1 = testCase.TestData.spaceTransformation1;

    % CLUSTER LISTS
    Clusters1 = MakeManyHyperCubeClusters( ...
        [0 0], [2 5], [6 10], [4 2], [3 2], st1);
    
    % SPACES
    Space1 = Space(Clusters1, st1);

    % SILHOUETTE
    MotorVertexList1 = [0 -30; 60 10; 0 10];
    SimplexMatrix1 = [1 2 3];
    Weights1 = 1;
    
    MotorVertexList2 = [0 -30; 120 18; 0 18];
    SimplexMatrix2 = [1 2 3];
    Weights2 = 1;

    MotorVertexList3 = [0 -30; 180 25; 0 25];
    SimplexMatrix3 = [1 2 3];
    Weights3 = 1;

    Region1 = WeightedMotorSimplicialComplex(MotorVertexList1, SimplexMatrix1, Weights1);
    Region2 = WeightedMotorSimplicialComplex(MotorVertexList2, SimplexMatrix2, Weights2);
    Region3 = WeightedMotorSimplicialComplex(MotorVertexList3, SimplexMatrix3, Weights3);
    
    silhouette = MotorSilhouette([Region1 Region2 Region3]);
    
    % EXEMPLAR
    exemplar = PerceptualTrajectory([3 0 1 8; 0 1 4 3]);

    % GOALS
    Goal1 = Goal(Space1, silhouette, exemplar);

    % ACTIVATIONS

    actActivations = Goal1.TempActivations(ep);
    
    expActivations = [...
        0.644811966906423 0.644811966906423 0.644811966906423;
        0.310250003671613 0.310250003671613 0.310250003671613;
        0 0 0;
        0.0722265297501248 0.11104195013736 0.119278188203563;
        0.0266765283197779 0.04101282088134 0.044054836589164;
        0 0 0];

    verifyEqual(testCase, actActivations, expActivations, ...
        "AbsTol", 0.000000001);
end

function TestSimpleMacroEstimatesSimple(testCase)
    ep = ExecutionParameters(0, 0);

    st1 = testCase.TestData.spaceTransformation1;

    % CLUSTER LISTS
    Clusters1 = MakeManyHyperCubeClusters( ...
        [0 0], [2 5], [6 10], [4 2], [3 2], st1);
    
    % SPACES
    Space1 = Space(Clusters1, st1);

    % SILHOUETTE
    MotorVertexList1 = [0 -30; 60 10; 0 10];
    SimplexMatrix1 = [1 2 3];
    Weights1 = 1;
    
    MotorVertexList2 = [0 -30; 120 18; 0 18];
    SimplexMatrix2 = [1 2 3];
    Weights2 = 1;

    MotorVertexList3 = [0 -30; 180 25; 0 25];
    SimplexMatrix3 = [1 2 3];
    Weights3 = 1;

    Region1 = WeightedMotorSimplicialComplex(MotorVertexList1, SimplexMatrix1, Weights1);
    Region2 = WeightedMotorSimplicialComplex(MotorVertexList2, SimplexMatrix2, Weights2);
    Region3 = WeightedMotorSimplicialComplex(MotorVertexList3, SimplexMatrix3, Weights3);
    
    silhouette = MotorSilhouette([Region1 Region2 Region3]);
    
    % EXEMPLAR
    exemplar = PerceptualTrajectory([3 0 1 8; 0 1 4 3]);

    % GOALS
    goal = Goal(Space1, silhouette, exemplar);

    [actAverageJunctureEstimates, actFinalJunctureActivationValues] = ...
                goal.SimpleMacroEstimates(ep);

    actAverageJunctureEstimates1Motor = actAverageJunctureEstimates(1).MotorPoint.Coordinates;
    actAverageJunctureEstimates2Motor = actAverageJunctureEstimates(2).MotorPoint.Coordinates;
    actAverageJunctureEstimates3Motor = actAverageJunctureEstimates(3).MotorPoint.Coordinates;

    actAverageJunctureEstimates1Perceptual = actAverageJunctureEstimates(1).PerceptualPoint.Coordinates;
    actAverageJunctureEstimates2Perceptual = actAverageJunctureEstimates(2).PerceptualPoint.Coordinates;
    actAverageJunctureEstimates3Perceptual = actAverageJunctureEstimates(3).PerceptualPoint.Coordinates;

    expAverageJunctureEstimates1Motor = [6.196752480711922; 6.126068384224615];
    expAverageJunctureEstimates2Motor = [6.172771319909273; 6.648116394295323];
    expAverageJunctureEstimates3Motor = [6.167975909471235; 6.752508108159908];

    expAverageJunctureEstimates1Perceptual = [6.196752480711922; 6.126068384224615];
    expAverageJunctureEstimates2Perceptual = [6.172771319909273; 6.648116394295323];
    expAverageJunctureEstimates3Perceptual = [6.167975909471235; 6.752508108159908];

    expFinalJunctureActivationValues = [...
        0.644811966906423 0.644811966906423 0.644811966906423;
        0.644811966906423 0.644811966906423 0.644811966906423;
        0.644811966906423 0.644811966906423 0.644811966906423;
        0.644811966906423 0.644811966906423 0.644811966906423;
        0.644811966906423 0.644811966906423 0.644811966906423;
        0.644811966906423 0.644811966906423 0.644811966906423;
        0.644811966906423 0.644811966906423 0.644811966906423;
        0.644811966906423 0.644811966906423 0.644811966906423;
        0.644811966906423 0.644811966906423 0.644811966906423;
        0.644811966906423 0.644811966906423 0.644811966906423;
        0.644811966906423 0.644811966906423 0.644811966906423;
        0.644811966906423 0.644811966906423 0.644811966906423;
        0.310250003671613 0.310250003671613 0.310250003671613;
        0.310250003671613 0.310250003671613 0.310250003671613;
        0.310250003671613 0.310250003671613 0.310250003671613;
        0.310250003671613 0.310250003671613 0.310250003671613;
        0.310250003671613 0.310250003671613 0.310250003671613;
        0.310250003671613 0.310250003671613 0.310250003671613;
        0.310250003671613 0.310250003671613 0.310250003671613;
        0.310250003671613 0.310250003671613 0.310250003671613;
        0.310250003671613 0.310250003671613 0.310250003671613;
        0.310250003671613 0.310250003671613 0.310250003671613;
        0.310250003671613 0.310250003671613 0.310250003671613;
        0.310250003671613 0.310250003671613 0.310250003671613;
        0 0 0;
        0 0 0;
        0 0 0;
        0 0 0;
        0 0 0;
        0 0 0;
        0 0 0;
        0 0 0;
        0 0 0;
        0 0 0;
        0 0 0;
        0 0 0;
        0.0722265297501248 0.11104195013736 0.119278188203563;
        0.0722265297501248 0.11104195013736 0.119278188203563;
        0.0722265297501248 0.11104195013736 0.119278188203563;
        0.0722265297501248 0.11104195013736 0.119278188203563;
        0.0722265297501248 0.11104195013736 0.119278188203563;
        0.0722265297501248 0.11104195013736 0.119278188203563;
        0.0722265297501248 0.11104195013736 0.119278188203563;
        0.0722265297501248 0.11104195013736 0.119278188203563;
        0.0722265297501248 0.11104195013736 0.119278188203563;
        0.0722265297501248 0.11104195013736 0.119278188203563;
        0.0722265297501248 0.11104195013736 0.119278188203563;
        0.0722265297501248 0.11104195013736 0.119278188203563;
        0.0266765283197779 0.04101282088134 0.044054836589164;
        0.0266765283197779 0.04101282088134 0.044054836589164;
        0.0266765283197779 0.04101282088134 0.044054836589164;
        0.0266765283197779 0.04101282088134 0.044054836589164;
        0.0266765283197779 0.04101282088134 0.044054836589164;
        0.0266765283197779 0.04101282088134 0.044054836589164;
        0.0266765283197779 0.04101282088134 0.044054836589164;
        0.0266765283197779 0.04101282088134 0.044054836589164;
        0.0266765283197779 0.04101282088134 0.044054836589164;
        0.0266765283197779 0.04101282088134 0.044054836589164;
        0.0266765283197779 0.04101282088134 0.044054836589164;
        0.0266765283197779 0.04101282088134 0.044054836589164;
        0 0 0;
        0 0 0;
        0 0 0;
        0 0 0;
        0 0 0;
        0 0 0;
        0 0 0;
        0 0 0;
        0 0 0;
        0 0 0;
        0 0 0;
        0 0 0];
    
    verifyEqual(testCase, actFinalJunctureActivationValues, ...
        expFinalJunctureActivationValues, ...
        "AbsTol", 0.000000001);

    verifyEqual(testCase, actAverageJunctureEstimates1Motor, ...
        expAverageJunctureEstimates1Motor, ...
        "AbsTol", 0.000000001);
    verifyEqual(testCase, actAverageJunctureEstimates2Motor, ...
        expAverageJunctureEstimates2Motor, ...
        "AbsTol", 0.000000001);
    verifyEqual(testCase, actAverageJunctureEstimates3Motor, ...
        expAverageJunctureEstimates3Motor, ...
        "AbsTol", 0.000000001);

    verifyEqual(testCase, actAverageJunctureEstimates1Perceptual, ...
        expAverageJunctureEstimates1Perceptual, ...
        "AbsTol", 0.000000001);
    verifyEqual(testCase, actAverageJunctureEstimates2Perceptual, ...
        expAverageJunctureEstimates2Perceptual, ...
        "AbsTol", 0.000000001);
    verifyEqual(testCase, actAverageJunctureEstimates3Perceptual, ...
        expAverageJunctureEstimates3Perceptual, ...
        "AbsTol", 0.000000001);
end

function setupOnce(testCase)
    % Create and change to temporary folder
    testCase.TestData.origPath = pwd;
    testCase.TestData.tmpFolder = "tmpFolder" + ...
        string(datetime('now','Format',"yyyyMMdd'T'HHmmss"));
    mkdir(testCase.TestData.tmpFolder)
    cd(testCase.TestData.tmpFolder)
    % Create and save variables

    % SPACE TRANSFORMATIONS
    testCase.TestData.spaceTransformation1 = SpaceTransformation(@transformationFunction1);
    testCase.TestData.spaceTransformation2 = SpaceTransformation(@transformationFunction2);
    testCase.TestData.spaceTransformation3 = SpaceTransformation(@transformationFunction3);
end

function teardownOnce(testCase)
    cd(testCase.TestData.origPath)
    rmdir(testCase.TestData.tmpFolder)
end

function PerceptualCoordinates = transformationFunction1(MotorCoordinates)
    PerceptualCoordinates = MotorCoordinates;
end

function PerceptualCoordinates = transformationFunction2(MotorCoordinates)
    MX = MotorCoordinates(1,1);
    MY = MotorCoordinates(2,1);
    PX = 10 - MX;
    PY = 10 - MY;
    PerceptualCoordinates = [PX; PY];
end

function PerceptualCoordinates = transformationFunction3(MotorCoordinates)
    MX = MotorCoordinates(1,1);
    MY = MotorCoordinates(2,1);
    if MY < 11
        PX = MX;
        PY = MY;
    else
        if MX < 18
            PX = MX + 10;
            PY = MY;
        else
            PX = MX - 20;
            PY = MY;
        end
    end
    PerceptualCoordinates = [PX; PY];
end