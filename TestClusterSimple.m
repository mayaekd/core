%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS TESTED
%
%  Cluster
%  FindActivation
%  FindSilhouetteActivation
%  FindExemplarActivation
%  FindActivationWithWindow
%  DistanceToActivationMap
%  DistanceToActivationMapLinear
%  CombineActivation
%  Center
%  Center_AverageJunctureAll
%  MotorPlottingInfo
%  PerceptualPlottingInfo
%  PlotMotor
%  PlotPerceptual

%% TESTS

function tests = TestClusterSimple
    tests = functiontests(localfunctions);
end

function TestCreateObjectSimple(testCase)
    Cluster1 = Cluster([86 1 10; 4 2 12], [3 3 400; 40 4 25]);
    actMotorCoord = Cluster1.MotorCoordinateMatrix;
    actPerceptualCoord = Cluster1.PerceptualCoordinateMatrix;
    expMotorCoord = [86 1 10; 4 2 12];
    expPerceptualCoord = [3 3 400; 40 4 25];
    verifyEqual(testCase, actMotorCoord, expMotorCoord);
    verifyEqual(testCase, actPerceptualCoord, expPerceptualCoord);
end

function TestFindActivationSimple(testCase)
    st1 = testCase.TestData.spaceTransformation1;
    
    %% Clusters
    Cluster1 = st1.CreateCluster([0 1 0 1; 0 0 1 1]);
    Cluster2 = st1.CreateCluster([4 5 4 5; 0 0 1 1]);
    Cluster3 = st1.CreateCluster([7 8 7 8; 2 2 3 3]);

    %% Silhouette
    MotorVertexList1 = [0 0; 0 3; 4 3; 4 0];
    SimplexMatrix1 = [1 2 4; 2 3 4];
    Weights1 = [2 6];
    
    MotorVertexList2 = [0 0; 0 5; 5 5];
    SimplexMatrix2 = [1 2 3];
    Weights2 = 1;

    MotorVertexList3 = [5 0; 12 0; 6 12];
    SimplexMatrix3 = [1 2 3];
    Weights3 = 5;

    Region1 = WeightedMotorSimplicialComplex(MotorVertexList1, SimplexMatrix1, Weights1);
    Region2 = WeightedMotorSimplicialComplex(MotorVertexList2, SimplexMatrix2, Weights2);
    Region3 = WeightedMotorSimplicialComplex(MotorVertexList3, SimplexMatrix3, Weights3);
    
    Silhouette1 = MotorSilhouette([Region1; Region2; Region3]);

    %% Trajectory
    Trajectory = PerceptualTrajectory([3 0 1 8; 0 1 4 3]);

    %% Activations
    actActivation11 = Cluster1.FindActivation(Silhouette1, 1, Trajectory, 1, 0.1, 1, 0.1);
    actActivation12 = Cluster1.FindActivation(Silhouette1, 2, Trajectory, 1, 0.1, 1, 0.1);
    actActivation13 = Cluster1.FindActivation(Silhouette1, 3, Trajectory, 1, 0.1, 1, 0.1);
    actActivation21 = Cluster2.FindActivation(Silhouette1, 1, Trajectory, 1, 0.1, 1, 0.1);
    actActivation22 = Cluster2.FindActivation(Silhouette1, 2, Trajectory, 1, 0.1, 1, 0.1);
    actActivation23 = Cluster2.FindActivation(Silhouette1, 3, Trajectory, 1, 0.1, 1, 0.1);
    actActivation31 = Cluster3.FindActivation(Silhouette1, 1, Trajectory, 1, 0.1, 1, 0.1);
    actActivation32 = Cluster3.FindActivation(Silhouette1, 2, Trajectory, 1, 0.1, 1, 0.1);
    actActivation33 = Cluster3.FindActivation(Silhouette1, 3, Trajectory, 1, 0.1, 1, 0.1);
    
    expActivation11 = 0.739249723889701;
    expActivation12 = 0.784396164688319;
    expActivation13 = 0.585131085202092;
    expActivation21 = 0.759396866150702;
    expActivation22 = 0.662454107351842;
    expActivation23 = 0.760814928966457;
    expActivation31 = 0.555557131832453;
    expActivation32 = 0.562335328939553;
    expActivation33 = 0.700354336783294;
    
    %% Testing
    verifyEqual(testCase, actActivation11, expActivation11, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation12, expActivation12, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation13, expActivation13, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation21, expActivation21, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation22, expActivation22, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation23, expActivation23, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation31, expActivation31, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation32, expActivation32, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation33, expActivation33, "AbsTol", 0.000000001);
end

function TestFindSilhouetteActivationSimple(testCase)
    st1 = testCase.TestData.spaceTransformation1;
    
    %% Clusters
    Cluster1 = st1.CreateCluster([0 1 0 1; 0 0 1 1]);
    Cluster2 = st1.CreateCluster([4 5 4 5; 0 0 1 1]);
    Cluster3 = st1.CreateCluster([7 8 7 8; 2 2 3 3]);

    %% Silhouette
    MotorVertexList1 = [0 0; 0 3; 4 3; 4 0];
    SimplexMatrix1 = [1 2 4; 2 3 4];
    Weights1 = [2 6];
    
    MotorVertexList2 = [0 0; 0 5; 5 5];
    SimplexMatrix2 = [1 2 3];
    Weights2 = 1;

    MotorVertexList3 = [5 0; 12 0; 6 12];
    SimplexMatrix3 = [1 2 3];
    Weights3 = 5;

    Region1 = WeightedMotorSimplicialComplex(MotorVertexList1, SimplexMatrix1, Weights1);
    Region2 = WeightedMotorSimplicialComplex(MotorVertexList2, SimplexMatrix2, Weights2);
    Region3 = WeightedMotorSimplicialComplex(MotorVertexList3, SimplexMatrix3, Weights3);
    
    Silhouette1 = MotorSilhouette([Region1; Region2; Region3]);

    actActivation11 = Cluster1.FindSilhouetteActivation(Silhouette1, 1, 1, 0.1);
    actActivation12 = Cluster1.FindSilhouetteActivation(Silhouette1, 2, 1, 0.1);
    actActivation13 = Cluster1.FindSilhouetteActivation(Silhouette1, 3, 1, 0.1);
    actActivation21 = Cluster2.FindSilhouetteActivation(Silhouette1, 1, 1, 0.1);
    actActivation22 = Cluster2.FindSilhouetteActivation(Silhouette1, 2, 1, 0.1);
    actActivation23 = Cluster2.FindSilhouetteActivation(Silhouette1, 3, 1, 0.1);
    actActivation31 = Cluster3.FindSilhouetteActivation(Silhouette1, 1, 1, 0.1);
    actActivation32 = Cluster3.FindSilhouetteActivation(Silhouette1, 2, 1, 0.1);
    actActivation33 = Cluster3.FindSilhouetteActivation(Silhouette1, 3, 1, 0.1);
    
    expActivation11 = 0.8725;
    expActivation12 = 0.982322330470336;
    expActivation13 = 0.546624930402216;
    expActivation21 = 0.942411165235169;
    expActivation22 = 0.717157287525381;
    expActivation23 = 0.945934082051192;
    expActivation31 = 0.629247950515108;
    expActivation32 = 0.644696175168445;
    expActivation33 = 1;
    
    verifyEqual(testCase, actActivation11, expActivation11, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation12, expActivation12, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation13, expActivation13, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation21, expActivation21, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation22, expActivation22, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation23, expActivation23, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation31, expActivation31, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation32, expActivation32, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation33, expActivation33, "AbsTol", 0.000000001);
end

function TestFindExemplarActivationSimple(testCase)
    st1 = testCase.TestData.spaceTransformation1;
    
    %% Clusters
    Cluster1 = st1.CreateCluster([0 1 0 1; 0 0 1 1]);
    Cluster2 = st1.CreateCluster([4 5 4 5; 0 0 1 1]);
    Cluster3 = st1.CreateCluster([7 8 7 8; 2 2 3 3]);

    Trajectory = PerceptualTrajectory([3 0 1 8; 0 1 4 3]);

    actActivation1 = Cluster1.FindExemplarActivation(Trajectory, 1, 0.1);
    actActivation2 = Cluster2.FindExemplarActivation(Trajectory, 1, 0.1);
    actActivation3 = Cluster3.FindExemplarActivation(Trajectory, 1, 0.1);
    
    expActivation1 = 0.626349747015472;
    expActivation2 = 0.611923565417014;
    expActivation3 = 0.490496197051167;
    
    verifyEqual(testCase, actActivation1, expActivation1, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation2, expActivation2, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation3, expActivation3, "AbsTol", 0.000000001);
end

function TestFindActivationWithWindowSimple(testCase)
    st1 = testCase.TestData.spaceTransformation1;
    
    %% Clusters
    Cluster1 = st1.CreateCluster([0 1 0 1; 0 0 1 1]);
    Cluster2 = st1.CreateCluster([4 5 4 5; 0 0 1 1]);
    Cluster3 = st1.CreateCluster([7 8 7 8; 2 2 3 3]);

    %% Silhouette
    MotorVertexList1 = [0 0; 0 3; 4 3; 4 0];
    SimplexMatrix1 = [1 2 4; 2 3 4];
    Weights1 = [2 6];
    
    MotorVertexList2 = [0 0; 0 5; 5 5];
    SimplexMatrix2 = [1 2 3];
    Weights2 = 1;

    MotorVertexList3 = [5 0; 12 0; 6 12];
    SimplexMatrix3 = [1 2 3];
    Weights3 = 5;

    Region1 = WeightedMotorSimplicialComplex(MotorVertexList1, SimplexMatrix1, Weights1);
    Region2 = WeightedMotorSimplicialComplex(MotorVertexList2, SimplexMatrix2, Weights2);
    Region3 = WeightedMotorSimplicialComplex(MotorVertexList3, SimplexMatrix3, Weights3);
    
    Silhouette1 = MotorSilhouette([Region1; Region2; Region3]);

    %% Trajectory
    Trajectory = PerceptualTrajectory([3 0 1 8; 0 1 4 3]);

    %% Activations
    LookAheadWindow = 1;
    LookBackWindow = 0;
    actActivation11 = Cluster1.FindActivationWithWindow(Silhouette1, ...
        Trajectory, 1, LookBackWindow, LookAheadWindow, 1, 0.1, 1, 0.1);
    actActivation12 = Cluster1.FindActivationWithWindow(Silhouette1, ...
        Trajectory, 2, LookBackWindow, LookAheadWindow, 1, 0.1, 1, 0.1);
    actActivation13 = Cluster1.FindActivationWithWindow(Silhouette1, ...
        Trajectory, 3, LookBackWindow, LookAheadWindow, 1, 0.1, 1, 0.1);
    actActivation21 = Cluster2.FindActivationWithWindow(Silhouette1, ...
        Trajectory, 1, LookBackWindow, LookAheadWindow, 1, 0.1, 1, 0.1);
    actActivation22 = Cluster2.FindActivationWithWindow(Silhouette1, ...
        Trajectory, 2, LookBackWindow, LookAheadWindow, 1, 0.1, 1, 0.1);
    actActivation23 = Cluster2.FindActivationWithWindow(Silhouette1, ...
        Trajectory, 3, LookBackWindow, LookAheadWindow, 1, 0.1, 1, 0.1);
    actActivation31 = Cluster3.FindActivationWithWindow(Silhouette1, ...
        Trajectory, 1, LookBackWindow, LookAheadWindow, 1, 0.1, 1, 0.1);
    actActivation32 = Cluster3.FindActivationWithWindow(Silhouette1, ...
        Trajectory, 2, LookBackWindow, LookAheadWindow, 1, 0.1, 1, 0.1);
    actActivation33 = Cluster3.FindActivationWithWindow(Silhouette1, ...
        Trajectory, 3, LookBackWindow, LookAheadWindow, 1, 0.1, 1, 0.1);
    
    expActivation11 = 0.74827901204942;
    expActivation12 = 0.744543148791074;
    expActivation13 = 0.585131085202092;
    expActivation21 = 0.74000831439093;
    expActivation22 = 0.682126271674765;
    expActivation23 = 0.760814928966457;
    expActivation31 = 0.556912771253873;
    expActivation32 = 0.589939130508301;
    expActivation33 = 0.700354336783294;
    
    %% Testing
    verifyEqual(testCase, actActivation11, expActivation11, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation12, expActivation12, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation13, expActivation13, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation21, expActivation21, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation22, expActivation22, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation23, expActivation23, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation31, expActivation31, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation32, expActivation32, "AbsTol", 0.000000001);
    verifyEqual(testCase, actActivation33, expActivation33, "AbsTol", 0.000000001);
end

function TestDistanceToActivationMapSimple(testCase)
    st1 = testCase.TestData.spaceTransformation1;
    
    %% Clusters
    Cluster1 = st1.CreateCluster([0 1 0 1; 0 0 1 1]);
    Cluster2 = st1.CreateCluster([4 5 4 5; 0 0 1 1]);
    Cluster3 = st1.CreateCluster([7 8 7 8; 2 2 3 3]);

    %% Distances
    DistanceA = 0;
    DistanceB = 5;
    DistanceC = 8;
    DistanceD = 10;
    DistanceE = 15;

    %% Actual activations
    actActivation1A = Cluster1.DistanceToActivationMap(DistanceA);
    actActivation2A = Cluster2.DistanceToActivationMap(DistanceA);
    actActivation3A = Cluster3.DistanceToActivationMap(DistanceA);

    actActivation1B = Cluster1.DistanceToActivationMap(DistanceB);
    actActivation2B = Cluster2.DistanceToActivationMap(DistanceB);
    actActivation3B = Cluster3.DistanceToActivationMap(DistanceB);

    actActivation1C = Cluster1.DistanceToActivationMap(DistanceC);
    actActivation2C = Cluster2.DistanceToActivationMap(DistanceC);
    actActivation3C = Cluster3.DistanceToActivationMap(DistanceC);

    actActivation1D = Cluster1.DistanceToActivationMap(DistanceD);
    actActivation2D = Cluster2.DistanceToActivationMap(DistanceD);
    actActivation3D = Cluster3.DistanceToActivationMap(DistanceD);

    actActivation1E = Cluster1.DistanceToActivationMap(DistanceE);
    actActivation2E = Cluster2.DistanceToActivationMap(DistanceE);
    actActivation3E = Cluster3.DistanceToActivationMap(DistanceE);

    %% Expected activations
    expActivationA = 1;
    expActivationB = 0.5;
    expActivationC = 0.2;
    expActivationD = 0;
    expActivationE = 0;

    %% Testing
    verifyEqual(testCase, actActivation1A, expActivationA, "AbsTol",  0.00000001);
    verifyEqual(testCase, actActivation2A, expActivationA, "AbsTol",  0.00000001);
    verifyEqual(testCase, actActivation3A, expActivationA, "AbsTol",  0.00000001);

    verifyEqual(testCase, actActivation1B, expActivationB, "AbsTol",  0.00000001);
    verifyEqual(testCase, actActivation2B, expActivationB, "AbsTol",  0.00000001);
    verifyEqual(testCase, actActivation3B, expActivationB, "AbsTol",  0.00000001);

    verifyEqual(testCase, actActivation1C, expActivationC, "AbsTol",  0.00000001);
    verifyEqual(testCase, actActivation2C, expActivationC, "AbsTol",  0.00000001);
    verifyEqual(testCase, actActivation3C, expActivationC, "AbsTol",  0.00000001);

    verifyEqual(testCase, actActivation1D, expActivationD, "AbsTol",  0.00000001);
    verifyEqual(testCase, actActivation2D, expActivationD, "AbsTol",  0.00000001);
    verifyEqual(testCase, actActivation3D, expActivationD, "AbsTol",  0.00000001);

    verifyEqual(testCase, actActivation1E, expActivationE, "AbsTol",  0.00000001);
    verifyEqual(testCase, actActivation2E, expActivationE, "AbsTol",  0.00000001);
    verifyEqual(testCase, actActivation3E, expActivationE, "AbsTol",  0.00000001);
end

function TestDistanceToActivationMapLinearSimple(testCase)
    st1 = testCase.TestData.spaceTransformation1;
    
    %% Clusters
    Cluster1 = st1.CreateCluster([0 1 0 1; 0 0 1 1]);

    actActivation1 = Cluster1.DistanceToActivationMapLinear( ...
        3, 1, 0.1);
    actActivation2 = Cluster1.DistanceToActivationMapLinear( ...
        20, 1, 0.1);
    actActivation3 = Cluster1.DistanceToActivationMapLinear( ...
        2, 0.5, 0.2);
    actActivation4 = Cluster1.DistanceToActivationMapLinear( ...
        45, 100, 1);
    expActivation1 = 0.7;
    expActivation2 = 0;
    expActivation3 = 0.1;
    expActivation4 = 55;
    verifyEqual(testCase, actActivation1, expActivation1, "AbsTol", 0.0000001);
    verifyEqual(testCase, actActivation2, expActivation2, "AbsTol", 0.0000001);
    verifyEqual(testCase, actActivation3, expActivation3, "AbsTol", 0.0000001);
    verifyEqual(testCase, actActivation4, expActivation4, "AbsTol", 0.0000001);
end

function TestCombineActivationSimple(testCase)
    st1 = testCase.TestData.spaceTransformation1;
    
    %% Clusters
    Cluster1 = st1.CreateCluster([0 1 0 1; 0 0 1 1]);

    actActivation1 = Cluster1.CombineActivation(0.8, 0.2);
    actActivation2 = Cluster1.CombineActivation(1, 0.36);
    actActivation3 = Cluster1.CombineActivation(6.05, 0.2);
    actActivation4 = Cluster1.CombineActivation(0, 0.5);
    expActivation1 = 0.4;
    expActivation2 = 0.6;
    expActivation3 = 1.1;
    expActivation4 = 0;
    verifyEqual(testCase, actActivation1, expActivation1, "AbsTol", 0.0000001);
    verifyEqual(testCase, actActivation2, expActivation2, "AbsTol", 0.0000001);
    verifyEqual(testCase, actActivation3, expActivation3, "AbsTol", 0.0000001);
    verifyEqual(testCase, actActivation4, expActivation4, "AbsTol", 0.0000001);
end

function TestCenterSimple(testCase)
    st2 = testCase.TestData.spaceTransformation2;
    
    %% Clusters
    Cluster1 = st2.CreateCluster([0 1 0 1; 0 0 1 1]); % Perceptual: [0 1 0 1; 0 0 1 1]
    Cluster2 = st2.CreateCluster([0 1 0 1; 3 3 4 4]); % Perceptual: [0 1 6 7; 3 3 4 4]
    Cluster3 = st2.CreateCluster([8 9 8 9; 3 3 4 4]); % Perceptual: [8 9 4 5; 3 3 4 4]
    
    actCentroid1_M = Cluster1.Center().MotorPoint.Coordinates;
    actCentroid2_M = Cluster2.Center().MotorPoint.Coordinates;
    actCentroid3_M = Cluster3.Center().MotorPoint.Coordinates;

    expCentroid1_M = [0.5; 0.5];
    expCentroid2_M = [0.5; 3.5];
    expCentroid3_M = [8.5; 3.5];

    actCentroid1_P = Cluster1.Center().PerceptualPoint.Coordinates;
    actCentroid2_P = Cluster2.Center().PerceptualPoint.Coordinates;
    actCentroid3_P = Cluster3.Center().PerceptualPoint.Coordinates;
    
    expCentroid1_P = [0.5; 0.5];
    expCentroid2_P = [3.5; 3.5];
    expCentroid3_P = [6.5; 3.5];
    
    verifyEqual(testCase, actCentroid1_M, expCentroid1_M);
    verifyEqual(testCase, actCentroid2_M, expCentroid2_M);
    verifyEqual(testCase, actCentroid3_M, expCentroid3_M);
    verifyEqual(testCase, actCentroid1_P, expCentroid1_P);
    verifyEqual(testCase, actCentroid2_P, expCentroid2_P);
    verifyEqual(testCase, actCentroid3_P, expCentroid3_P);
end

function TestCenter_AverageJunctureAllSimple(testCase)
    st2 = testCase.TestData.spaceTransformation2;
    
    %% Clusters
    Cluster1 = st2.CreateCluster([0 1 0 1; 0 0 1 1]); % Perceptual: [0 1 0 1; 0 0 1 1]
    Cluster2 = st2.CreateCluster([0 1 0 1; 3 3 4 4]); % Perceptual: [0 1 6 7; 3 3 4 4]
    Cluster3 = st2.CreateCluster([8 9 8 9; 3 3 4 4]); % Perceptual: [8 9 4 5; 3 3 4 4]
    
    actCentroid1_M = Cluster1.Center_AverageJunctureAll().MotorPoint.Coordinates;
    actCentroid2_M = Cluster2.Center_AverageJunctureAll().MotorPoint.Coordinates;
    actCentroid3_M = Cluster3.Center_AverageJunctureAll().MotorPoint.Coordinates;

    expCentroid1_M = [0.5; 0.5];
    expCentroid2_M = [0.5; 3.5];
    expCentroid3_M = [8.5; 3.5];

    actCentroid1_P = Cluster1.Center_AverageJunctureAll().PerceptualPoint.Coordinates;
    actCentroid2_P = Cluster2.Center_AverageJunctureAll().PerceptualPoint.Coordinates;
    actCentroid3_P = Cluster3.Center_AverageJunctureAll().PerceptualPoint.Coordinates;
    
    expCentroid1_P = [0.5; 0.5];
    expCentroid2_P = [3.5; 3.5];
    expCentroid3_P = [6.5; 3.5];
    
    verifyEqual(testCase, actCentroid1_M, expCentroid1_M);
    verifyEqual(testCase, actCentroid2_M, expCentroid2_M);
    verifyEqual(testCase, actCentroid3_M, expCentroid3_M);
    verifyEqual(testCase, actCentroid1_P, expCentroid1_P);
    verifyEqual(testCase, actCentroid2_P, expCentroid2_P);
    verifyEqual(testCase, actCentroid3_P, expCentroid3_P);
end

function TestMotorPlottingInfoSimple(testCase)
    st2 = testCase.TestData.spaceTransformation2;
    
    %% Clusters
    Cluster1 = st2.CreateCluster([0 1 0 1; 0 0 1 1]); % Perceptual: [0 1 0 1; 0 0 1 1]
    Cluster2 = st2.CreateCluster([0 1 0 1; 3 3 4 4]); % Perceptual: [0 1 6 7; 3 3 4 4]
    Cluster3 = st2.CreateCluster([8 9 8 9; 3 3 4 4]); % Perceptual: [8 9 4 5; 3 3 4 4]
    
    color = [1 0 0.8];

    %% Actual values
    [actXValues1, actYValues1, actColorValues1] = ...
        Cluster1.MotorPlottingInfo(color);
    [actXValues2, actYValues2, actColorValues2] = ...
        Cluster2.MotorPlottingInfo(color);
    [actXValues3, actYValues3, actColorValues3] = ...
        Cluster3.MotorPlottingInfo(color);

    %% Expected values
    expXValues1 = [0 1 0 1];
    expYValues1 = [0 0 1 1];
    expColorValues1 = [1 0 0.8; 1 0 0.8; 1 0 0.8; 1 0 0.8];

    expXValues2 = [0 1 0 1];
    expYValues2 = [3 3 4 4];
    expColorValues2 = [1 0 0.8; 1 0 0.8; 1 0 0.8; 1 0 0.8];

    expXValues3 = [8 9 8 9];
    expYValues3 = [3 3 4 4];
    expColorValues3 = [1 0 0.8; 1 0 0.8; 1 0 0.8; 1 0 0.8];

    %% Testing
    verifyEqual(testCase, actXValues1, expXValues1);
    verifyEqual(testCase, actYValues1, expYValues1);
    verifyEqual(testCase, actColorValues1, expColorValues1);
    verifyEqual(testCase, actXValues2, expXValues2);
    verifyEqual(testCase, actYValues2, expYValues2);
    verifyEqual(testCase, actColorValues2, expColorValues2);
    verifyEqual(testCase, actXValues3, expXValues3);
    verifyEqual(testCase, actYValues3, expYValues3);
    verifyEqual(testCase, actColorValues3, expColorValues3);
end

function TestPerceptualPlottingInfoSimple(testCase)
    st2 = testCase.TestData.spaceTransformation2;
    
    %% Clusters
    Cluster1 = st2.CreateCluster([0 1 0 1; 0 0 1 1]); % Perceptual: [0 1 0 1; 0 0 1 1]
    Cluster2 = st2.CreateCluster([0 1 0 1; 3 3 4 4]); % Perceptual: [0 1 6 7; 3 3 4 4]
    Cluster3 = st2.CreateCluster([8 9 8 9; 3 3 4 4]); % Perceptual: [8 9 4 5; 3 3 4 4]
    
    color = [1 0 0.8];

    %% Actual values
    [actXValues1, actYValues1, actColorValues1] = ...
        Cluster1.PerceptualPlottingInfo(color);
    [actXValues2, actYValues2, actColorValues2] = ...
        Cluster2.PerceptualPlottingInfo(color);
    [actXValues3, actYValues3, actColorValues3] = ...
        Cluster3.PerceptualPlottingInfo(color);

    %% Expected values
    expXValues1 = [0 1 0 1];
    expYValues1 = [0 0 1 1];
    expColorValues1 = [1 0 0.8; 1 0 0.8; 1 0 0.8; 1 0 0.8];

    expXValues2 = [0 1 6 7];
    expYValues2 = [3 3 4 4];
    expColorValues2 = [1 0 0.8; 1 0 0.8; 1 0 0.8; 1 0 0.8];

    expXValues3 = [8 9 4 5];
    expYValues3 = [3 3 4 4];
    expColorValues3 = [1 0 0.8; 1 0 0.8; 1 0 0.8; 1 0 0.8];

    %% Testing
    verifyEqual(testCase, actXValues1, expXValues1);
    verifyEqual(testCase, actYValues1, expYValues1);
    verifyEqual(testCase, actColorValues1, expColorValues1);
    verifyEqual(testCase, actXValues2, expXValues2);
    verifyEqual(testCase, actYValues2, expYValues2);
    verifyEqual(testCase, actColorValues2, expColorValues2);
    verifyEqual(testCase, actXValues3, expXValues3);
    verifyEqual(testCase, actYValues3, expYValues3);
    verifyEqual(testCase, actColorValues3, expColorValues3);
end

%% SET UP & TEAR DOWN
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
    if MY < 4
        PX = MX;
        PY = MY;
    else
        if MX < 4
            PX = MX + 6;
            PY = MY;
        else
            PX = MX - 4;
            PY = MY;
        end
    end
    PerceptualCoordinates = [PX; PY];
end
