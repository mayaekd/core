%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS TESTED
%
%  MotorSilhouette
%  DropoffScalar
%  DropoffScalarConcave
%  ExpandSilhouette
%  TemporalActivationInfo
%  PlottingInfo3D
%  PlottingInfo
%  Plot

%% TESTS

function tests = TestMotorSilhouetteSimple
    tests = functiontests(localfunctions);
end

function TestCreateObjectSimple(testCase)
    %% Creating silhouette
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

    actRegion1Vertices = Silhouette1.Regions(1).MotorVertexList;
    actRegion2Vertices = Silhouette1.Regions(2).MotorVertexList;
    actRegion3Vertices = Silhouette1.Regions(3).MotorVertexList;

    expRegion1Vertices = [0 0; 0 3; 4 3; 4 0];
    expRegion2Vertices = [0 0; 0 5; 5 5];
    expRegion3Vertices = [5 0; 12 0; 6 12];

    verifyEqual(testCase, actRegion1Vertices, expRegion1Vertices);
    verifyEqual(testCase, actRegion2Vertices, expRegion2Vertices);
    verifyEqual(testCase, actRegion3Vertices, expRegion3Vertices);
end

function TestDropoffScalarSimple(testCase)
    %% Creating silhouette
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
    
    Silhouette1 = MotorSilhouette({Region1; Region2; Region3});

    LookAheadA = 0;
    LookAheadB = 1;
    LookAheadC = 3;

    LookBack_a = 0;
    LookBack_b = 3;
    LookBack_c = 7;

    TimeDistance0 = 0;
    TimeDistance1 = -1;
    TimeDistance2 = 2;
    TimeDistance3 = -3;

    %% Actual values
    actScalarAa0 = Silhouette1.DropoffScalar(TimeDistance0, LookAheadA, LookBack_a);
    actScalarAa1 = Silhouette1.DropoffScalar(TimeDistance1, LookAheadA, LookBack_a);
    actScalarAa2 = Silhouette1.DropoffScalar(TimeDistance2, LookAheadA, LookBack_a);
    actScalarAa3 = Silhouette1.DropoffScalar(TimeDistance3, LookAheadA, LookBack_a);

    actScalarAb0 = Silhouette1.DropoffScalar(TimeDistance0, LookAheadA, LookBack_b);
    actScalarAb1 = Silhouette1.DropoffScalar(TimeDistance1, LookAheadA, LookBack_b);
    actScalarAb2 = Silhouette1.DropoffScalar(TimeDistance2, LookAheadA, LookBack_b);
    actScalarAb3 = Silhouette1.DropoffScalar(TimeDistance3, LookAheadA, LookBack_b);

    actScalarAc0 = Silhouette1.DropoffScalar(TimeDistance0, LookAheadA, LookBack_c);
    actScalarAc1 = Silhouette1.DropoffScalar(TimeDistance1, LookAheadA, LookBack_c);
    actScalarAc2 = Silhouette1.DropoffScalar(TimeDistance2, LookAheadA, LookBack_c);
    actScalarAc3 = Silhouette1.DropoffScalar(TimeDistance3, LookAheadA, LookBack_c);

    actScalarBa0 = Silhouette1.DropoffScalar(TimeDistance0, LookAheadB, LookBack_a);
    actScalarBa1 = Silhouette1.DropoffScalar(TimeDistance1, LookAheadB, LookBack_a);
    actScalarBa2 = Silhouette1.DropoffScalar(TimeDistance2, LookAheadB, LookBack_a);
    actScalarBa3 = Silhouette1.DropoffScalar(TimeDistance3, LookAheadB, LookBack_a);

    actScalarBb0 = Silhouette1.DropoffScalar(TimeDistance0, LookAheadB, LookBack_b);
    actScalarBb1 = Silhouette1.DropoffScalar(TimeDistance1, LookAheadB, LookBack_b);
    actScalarBb2 = Silhouette1.DropoffScalar(TimeDistance2, LookAheadB, LookBack_b);
    actScalarBb3 = Silhouette1.DropoffScalar(TimeDistance3, LookAheadB, LookBack_b);

    actScalarBc0 = Silhouette1.DropoffScalar(TimeDistance0, LookAheadB, LookBack_c);
    actScalarBc1 = Silhouette1.DropoffScalar(TimeDistance1, LookAheadB, LookBack_c);
    actScalarBc2 = Silhouette1.DropoffScalar(TimeDistance2, LookAheadB, LookBack_c);
    actScalarBc3 = Silhouette1.DropoffScalar(TimeDistance3, LookAheadB, LookBack_c);

    actScalarCa0 = Silhouette1.DropoffScalar(TimeDistance0, LookAheadC, LookBack_a);
    actScalarCa1 = Silhouette1.DropoffScalar(TimeDistance1, LookAheadC, LookBack_a);
    actScalarCa2 = Silhouette1.DropoffScalar(TimeDistance2, LookAheadC, LookBack_a);
    actScalarCa3 = Silhouette1.DropoffScalar(TimeDistance3, LookAheadC, LookBack_a);

    actScalarCb0 = Silhouette1.DropoffScalar(TimeDistance0, LookAheadC, LookBack_b);
    actScalarCb1 = Silhouette1.DropoffScalar(TimeDistance1, LookAheadC, LookBack_b);
    actScalarCb2 = Silhouette1.DropoffScalar(TimeDistance2, LookAheadC, LookBack_b);
    actScalarCb3 = Silhouette1.DropoffScalar(TimeDistance3, LookAheadC, LookBack_b);

    actScalarCc0 = Silhouette1.DropoffScalar(TimeDistance0, LookAheadC, LookBack_c);
    actScalarCc1 = Silhouette1.DropoffScalar(TimeDistance1, LookAheadC, LookBack_c);
    actScalarCc2 = Silhouette1.DropoffScalar(TimeDistance2, LookAheadC, LookBack_c);
    actScalarCc3 = Silhouette1.DropoffScalar(TimeDistance3, LookAheadC, LookBack_c);

    %% Expected values
    expScalarAa0 = 1;
    expScalarAa1 = 0;
    expScalarAa2 = 0;
    expScalarAa3 = 0;

    expScalarAb0 = 1;
    expScalarAb1 = 0.5625;
    expScalarAb2 = 0;
    expScalarAb3 = 0.0625;

    expScalarAc0 = 1;
    expScalarAc1 = 0.765625;
    expScalarAc2 = 0;
    expScalarAc3 = 0.390625;

    expScalarBa0 = 1;
    expScalarBa1 = 0;
    expScalarBa2 = 0;
    expScalarBa3 = 0;

    expScalarBb0 = 1;
    expScalarBb1 = 0.5625;
    expScalarBb2 = 0;
    expScalarBb3 = 0.0625;

    expScalarBc0 = 1;
    expScalarBc1 = 0.765625;
    expScalarBc2 = 0;
    expScalarBc3 = 0.390625;

    expScalarCa0 = 1;
    expScalarCa1 = 0;
    expScalarCa2 = 0.25;
    expScalarCa3 = 0;

    expScalarCb0 = 1;
    expScalarCb1 = 0.5625;
    expScalarCb2 = 0.25;
    expScalarCb3 = 0.0625;

    expScalarCc0 = 1;
    expScalarCc1 = 0.765625;
    expScalarCc2 = 0.25;
    expScalarCc3 = 0.390625;

    %% Testing
    verifyEqual(testCase, actScalarAa0, expScalarAa0, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAa1, expScalarAa1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAa2, expScalarAa2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAa3, expScalarAa3, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarAb0, expScalarAb0, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAb1, expScalarAb1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAb2, expScalarAb2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAb3, expScalarAb3, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarAc0, expScalarAc0, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAc1, expScalarAc1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAc2, expScalarAc2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAc3, expScalarAc3, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarBa0, expScalarBa0, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBa1, expScalarBa1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBa2, expScalarBa2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBa3, expScalarBa3, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarBb0, expScalarBb0, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBb1, expScalarBb1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBb2, expScalarBb2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBb3, expScalarBb3, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarBc0, expScalarBc0, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBc1, expScalarBc1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBc2, expScalarBc2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBc3, expScalarBc3, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarCa0, expScalarCa0, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCa1, expScalarCa1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCa2, expScalarCa2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCa3, expScalarCa3, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarCb0, expScalarCb0, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCb1, expScalarCb1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCb2, expScalarCb2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCb3, expScalarCb3, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarCc0, expScalarCc0, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCc1, expScalarCc1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCc2, expScalarCc2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCc3, expScalarCc3, "AbsTol", 0.00000001);
end

function TestDropoffScalarConcaveSimple(testCase)
    %% Creating silhouette
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
    
    Silhouette1 = MotorSilhouette({Region1; Region2; Region3});

    LookAheadA = 0;
    LookAheadB = 1;
    LookAheadC = 3;

    LookBack_a = 0;
    LookBack_b = 3;
    LookBack_c = 7;

    TimeDistance0 = 0;
    TimeDistance1 = -1;
    TimeDistance2 = 2;
    TimeDistance3 = -3;

    %% Actual values
    actScalarAa0_1 = Silhouette1.DropoffScalarConcave(TimeDistance0, LookAheadA, LookBack_a, 1);
    actScalarAa1_1 = Silhouette1.DropoffScalarConcave(TimeDistance1, LookAheadA, LookBack_a, 1);
    actScalarAa2_1 = Silhouette1.DropoffScalarConcave(TimeDistance2, LookAheadA, LookBack_a, 1);
    actScalarAa3_1 = Silhouette1.DropoffScalarConcave(TimeDistance3, LookAheadA, LookBack_a, 1);

    actScalarAb0_1 = Silhouette1.DropoffScalarConcave(TimeDistance0, LookAheadA, LookBack_b, 1);
    actScalarAb1_1 = Silhouette1.DropoffScalarConcave(TimeDistance1, LookAheadA, LookBack_b, 1);
    actScalarAb2_1 = Silhouette1.DropoffScalarConcave(TimeDistance2, LookAheadA, LookBack_b, 1);
    actScalarAb3_1 = Silhouette1.DropoffScalarConcave(TimeDistance3, LookAheadA, LookBack_b, 1);

    actScalarAc0_1 = Silhouette1.DropoffScalarConcave(TimeDistance0, LookAheadA, LookBack_c, 1);
    actScalarAc1_1 = Silhouette1.DropoffScalarConcave(TimeDistance1, LookAheadA, LookBack_c, 1);
    actScalarAc2_1 = Silhouette1.DropoffScalarConcave(TimeDistance2, LookAheadA, LookBack_c, 1);
    actScalarAc3_1 = Silhouette1.DropoffScalarConcave(TimeDistance3, LookAheadA, LookBack_c, 1);

    actScalarBa0_1 = Silhouette1.DropoffScalarConcave(TimeDistance0, LookAheadB, LookBack_a, 1);
    actScalarBa1_1 = Silhouette1.DropoffScalarConcave(TimeDistance1, LookAheadB, LookBack_a, 1);
    actScalarBa2_1 = Silhouette1.DropoffScalarConcave(TimeDistance2, LookAheadB, LookBack_a, 1);
    actScalarBa3_1 = Silhouette1.DropoffScalarConcave(TimeDistance3, LookAheadB, LookBack_a, 1);

    actScalarBb0_1 = Silhouette1.DropoffScalarConcave(TimeDistance0, LookAheadB, LookBack_b, 1);
    actScalarBb1_1 = Silhouette1.DropoffScalarConcave(TimeDistance1, LookAheadB, LookBack_b, 1);
    actScalarBb2_1 = Silhouette1.DropoffScalarConcave(TimeDistance2, LookAheadB, LookBack_b, 1);
    actScalarBb3_1 = Silhouette1.DropoffScalarConcave(TimeDistance3, LookAheadB, LookBack_b, 1);

    actScalarBc0_1 = Silhouette1.DropoffScalarConcave(TimeDistance0, LookAheadB, LookBack_c, 1);
    actScalarBc1_1 = Silhouette1.DropoffScalarConcave(TimeDistance1, LookAheadB, LookBack_c, 1);
    actScalarBc2_1 = Silhouette1.DropoffScalarConcave(TimeDistance2, LookAheadB, LookBack_c, 1);
    actScalarBc3_1 = Silhouette1.DropoffScalarConcave(TimeDistance3, LookAheadB, LookBack_c, 1);

    actScalarCa0_1 = Silhouette1.DropoffScalarConcave(TimeDistance0, LookAheadC, LookBack_a, 1);
    actScalarCa1_1 = Silhouette1.DropoffScalarConcave(TimeDistance1, LookAheadC, LookBack_a, 1);
    actScalarCa2_1 = Silhouette1.DropoffScalarConcave(TimeDistance2, LookAheadC, LookBack_a, 1);
    actScalarCa3_1 = Silhouette1.DropoffScalarConcave(TimeDistance3, LookAheadC, LookBack_a, 1);

    actScalarCb0_1 = Silhouette1.DropoffScalarConcave(TimeDistance0, LookAheadC, LookBack_b, 1);
    actScalarCb1_1 = Silhouette1.DropoffScalarConcave(TimeDistance1, LookAheadC, LookBack_b, 1);
    actScalarCb2_1 = Silhouette1.DropoffScalarConcave(TimeDistance2, LookAheadC, LookBack_b, 1);
    actScalarCb3_1 = Silhouette1.DropoffScalarConcave(TimeDistance3, LookAheadC, LookBack_b, 1);

    actScalarCc0_1 = Silhouette1.DropoffScalarConcave(TimeDistance0, LookAheadC, LookBack_c, 1);
    actScalarCc1_1 = Silhouette1.DropoffScalarConcave(TimeDistance1, LookAheadC, LookBack_c, 1);
    actScalarCc2_1 = Silhouette1.DropoffScalarConcave(TimeDistance2, LookAheadC, LookBack_c, 1);
    actScalarCc3_1 = Silhouette1.DropoffScalarConcave(TimeDistance3, LookAheadC, LookBack_c, 1);

    actScalarAa0_2 = Silhouette1.DropoffScalarConcave(TimeDistance0, LookAheadA, LookBack_a, 2);
    actScalarAa1_2 = Silhouette1.DropoffScalarConcave(TimeDistance1, LookAheadA, LookBack_a, 2);
    actScalarAa2_2 = Silhouette1.DropoffScalarConcave(TimeDistance2, LookAheadA, LookBack_a, 2);
    actScalarAa3_2 = Silhouette1.DropoffScalarConcave(TimeDistance3, LookAheadA, LookBack_a, 2);

    actScalarAb0_2 = Silhouette1.DropoffScalarConcave(TimeDistance0, LookAheadA, LookBack_b, 2);
    actScalarAb1_2 = Silhouette1.DropoffScalarConcave(TimeDistance1, LookAheadA, LookBack_b, 2);
    actScalarAb2_2 = Silhouette1.DropoffScalarConcave(TimeDistance2, LookAheadA, LookBack_b, 2);
    actScalarAb3_2 = Silhouette1.DropoffScalarConcave(TimeDistance3, LookAheadA, LookBack_b, 2);

    actScalarAc0_2 = Silhouette1.DropoffScalarConcave(TimeDistance0, LookAheadA, LookBack_c, 2);
    actScalarAc1_2 = Silhouette1.DropoffScalarConcave(TimeDistance1, LookAheadA, LookBack_c, 2);
    actScalarAc2_2 = Silhouette1.DropoffScalarConcave(TimeDistance2, LookAheadA, LookBack_c, 2);
    actScalarAc3_2 = Silhouette1.DropoffScalarConcave(TimeDistance3, LookAheadA, LookBack_c, 2);

    actScalarBa0_2 = Silhouette1.DropoffScalarConcave(TimeDistance0, LookAheadB, LookBack_a, 2);
    actScalarBa1_2 = Silhouette1.DropoffScalarConcave(TimeDistance1, LookAheadB, LookBack_a, 2);
    actScalarBa2_2 = Silhouette1.DropoffScalarConcave(TimeDistance2, LookAheadB, LookBack_a, 2);
    actScalarBa3_2 = Silhouette1.DropoffScalarConcave(TimeDistance3, LookAheadB, LookBack_a, 2);

    actScalarBb0_2 = Silhouette1.DropoffScalarConcave(TimeDistance0, LookAheadB, LookBack_b, 2);
    actScalarBb1_2 = Silhouette1.DropoffScalarConcave(TimeDistance1, LookAheadB, LookBack_b, 2);
    actScalarBb2_2 = Silhouette1.DropoffScalarConcave(TimeDistance2, LookAheadB, LookBack_b, 2);
    actScalarBb3_2 = Silhouette1.DropoffScalarConcave(TimeDistance3, LookAheadB, LookBack_b, 2);

    actScalarBc0_2 = Silhouette1.DropoffScalarConcave(TimeDistance0, LookAheadB, LookBack_c, 2);
    actScalarBc1_2 = Silhouette1.DropoffScalarConcave(TimeDistance1, LookAheadB, LookBack_c, 2);
    actScalarBc2_2 = Silhouette1.DropoffScalarConcave(TimeDistance2, LookAheadB, LookBack_c, 2);
    actScalarBc3_2 = Silhouette1.DropoffScalarConcave(TimeDistance3, LookAheadB, LookBack_c, 2);

    actScalarCa0_2 = Silhouette1.DropoffScalarConcave(TimeDistance0, LookAheadC, LookBack_a, 2);
    actScalarCa1_2 = Silhouette1.DropoffScalarConcave(TimeDistance1, LookAheadC, LookBack_a, 2);
    actScalarCa2_2 = Silhouette1.DropoffScalarConcave(TimeDistance2, LookAheadC, LookBack_a, 2);
    actScalarCa3_2 = Silhouette1.DropoffScalarConcave(TimeDistance3, LookAheadC, LookBack_a, 2);

    actScalarCb0_2 = Silhouette1.DropoffScalarConcave(TimeDistance0, LookAheadC, LookBack_b, 2);
    actScalarCb1_2 = Silhouette1.DropoffScalarConcave(TimeDistance1, LookAheadC, LookBack_b, 2);
    actScalarCb2_2 = Silhouette1.DropoffScalarConcave(TimeDistance2, LookAheadC, LookBack_b, 2);
    actScalarCb3_2 = Silhouette1.DropoffScalarConcave(TimeDistance3, LookAheadC, LookBack_b, 2);

    actScalarCc0_2 = Silhouette1.DropoffScalarConcave(TimeDistance0, LookAheadC, LookBack_c, 2);
    actScalarCc1_2 = Silhouette1.DropoffScalarConcave(TimeDistance1, LookAheadC, LookBack_c, 2);
    actScalarCc2_2 = Silhouette1.DropoffScalarConcave(TimeDistance2, LookAheadC, LookBack_c, 2);
    actScalarCc3_2 = Silhouette1.DropoffScalarConcave(TimeDistance3, LookAheadC, LookBack_c, 2);

    %% Expected values
    expScalarAa0_1 = 1;
    expScalarAa1_1 = 0;
    expScalarAa2_1 = 0;
    expScalarAa3_1 = 0;

    expScalarAb0_1 = 1;
    expScalarAb1_1 = 0.75;
    expScalarAb2_1 = 0;
    expScalarAb3_1 = 0.25;

    expScalarAc0_1 = 1;
    expScalarAc1_1 = 0.875;
    expScalarAc2_1 = 0;
    expScalarAc3_1 = 0.625;

    expScalarBa0_1 = 1;
    expScalarBa1_1 = 0;
    expScalarBa2_1 = 0;
    expScalarBa3_1 = 0;

    expScalarBb0_1 = 1;
    expScalarBb1_1 = 0.75;
    expScalarBb2_1 = 0;
    expScalarBb3_1 = 0.25;

    expScalarBc0_1 = 1;
    expScalarBc1_1 = 0.875;
    expScalarBc2_1 = 0;
    expScalarBc3_1 = 0.625;

    expScalarCa0_1 = 1;
    expScalarCa1_1 = 0;
    expScalarCa2_1 = 0.5;
    expScalarCa3_1 = 0;

    expScalarCb0_1 = 1;
    expScalarCb1_1 = 0.75;
    expScalarCb2_1 = 0.5;
    expScalarCb3_1 = 0.25;

    expScalarCc0_1 = 1;
    expScalarCc1_1 = 0.875;
    expScalarCc2_1 = 0.5;
    expScalarCc3_1 = 0.625;

    expScalarAa0_2 = 1;
    expScalarAa1_2 = 0;
    expScalarAa2_2 = 0;
    expScalarAa3_2 = 0;

    expScalarAb0_2 = 1;
    expScalarAb1_2 = 0.5625;
    expScalarAb2_2 = 0;
    expScalarAb3_2 = 0.0625;

    expScalarAc0_2 = 1;
    expScalarAc1_2 = 0.765625;
    expScalarAc2_2 = 0;
    expScalarAc3_2 = 0.390625;

    expScalarBa0_2 = 1;
    expScalarBa1_2 = 0;
    expScalarBa2_2 = 0;
    expScalarBa3_2 = 0;

    expScalarBb0_2 = 1;
    expScalarBb1_2 = 0.5625;
    expScalarBb2_2 = 0;
    expScalarBb3_2 = 0.0625;

    expScalarBc0_2 = 1;
    expScalarBc1_2 = 0.765625;
    expScalarBc2_2 = 0;
    expScalarBc3_2 = 0.390625;

    expScalarCa0_2 = 1;
    expScalarCa1_2 = 0;
    expScalarCa2_2 = 0.25;
    expScalarCa3_2 = 0;

    expScalarCb0_2 = 1;
    expScalarCb1_2 = 0.5625;
    expScalarCb2_2 = 0.25;
    expScalarCb3_2 = 0.0625;

    expScalarCc0_2 = 1;
    expScalarCc1_2 = 0.765625;
    expScalarCc2_2 = 0.25;
    expScalarCc3_2 = 0.390625;

    %% Testing
    verifyEqual(testCase, actScalarAa0_1, expScalarAa0_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAa1_1, expScalarAa1_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAa2_1, expScalarAa2_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAa3_1, expScalarAa3_1, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarAb0_1, expScalarAb0_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAb1_1, expScalarAb1_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAb2_1, expScalarAb2_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAb3_1, expScalarAb3_1, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarAc0_1, expScalarAc0_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAc1_1, expScalarAc1_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAc2_1, expScalarAc2_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAc3_1, expScalarAc3_1, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarBa0_1, expScalarBa0_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBa1_1, expScalarBa1_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBa2_1, expScalarBa2_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBa3_1, expScalarBa3_1, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarBb0_1, expScalarBb0_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBb1_1, expScalarBb1_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBb2_1, expScalarBb2_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBb3_1, expScalarBb3_1, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarBc0_1, expScalarBc0_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBc1_1, expScalarBc1_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBc2_1, expScalarBc2_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBc3_1, expScalarBc3_1, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarCa0_1, expScalarCa0_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCa1_1, expScalarCa1_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCa2_1, expScalarCa2_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCa3_1, expScalarCa3_1, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarCb0_1, expScalarCb0_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCb1_1, expScalarCb1_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCb2_1, expScalarCb2_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCb3_1, expScalarCb3_1, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarCc0_1, expScalarCc0_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCc1_1, expScalarCc1_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCc2_1, expScalarCc2_1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCc3_1, expScalarCc3_1, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarAa0_2, expScalarAa0_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAa1_2, expScalarAa1_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAa2_2, expScalarAa2_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAa3_2, expScalarAa3_2, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarAb0_2, expScalarAb0_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAb1_2, expScalarAb1_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAb2_2, expScalarAb2_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAb3_2, expScalarAb3_2, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarAc0_2, expScalarAc0_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAc1_2, expScalarAc1_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAc2_2, expScalarAc2_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarAc3_2, expScalarAc3_2, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarBa0_2, expScalarBa0_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBa1_2, expScalarBa1_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBa2_2, expScalarBa2_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBa3_2, expScalarBa3_2, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarBb0_2, expScalarBb0_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBb1_2, expScalarBb1_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBb2_2, expScalarBb2_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBb3_2, expScalarBb3_2, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarBc0_2, expScalarBc0_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBc1_2, expScalarBc1_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBc2_2, expScalarBc2_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarBc3_2, expScalarBc3_2, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarCa0_2, expScalarCa0_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCa1_2, expScalarCa1_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCa2_2, expScalarCa2_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCa3_2, expScalarCa3_2, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarCb0_2, expScalarCb0_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCb1_2, expScalarCb1_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCb2_2, expScalarCb2_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCb3_2, expScalarCb3_2, "AbsTol", 0.00000001);

    verifyEqual(testCase, actScalarCc0_2, expScalarCc0_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCc1_2, expScalarCc1_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCc2_2, expScalarCc2_2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actScalarCc3_2, expScalarCc3_2, "AbsTol", 0.00000001);
end

function TestExpandSilhouetteSimple(testCase)
    %% Creating silhouette
    MotorVertexList1 = [0 0; 0 3; 4 3; 4 0];
    SimplexMatrix1 = [1 2 3; 1 3 4];
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

    MotorTrajectoryA = MotorTrajectory([5 1 12; 5 2 12]);

    MotorTrajectoryB = MotorTrajectory([1 8 5; 2 2 0]);

    %% Actual values
    actExpandedA = Silhouette1.ExpandSilhouette(MotorTrajectoryA);
    actExpandedB = Silhouette1.ExpandSilhouette(MotorTrajectoryB);

    actMotorVertexListA1 = actExpandedA.Regions(1).MotorVertexList;
    actSimplexMatrixA1 = actExpandedA.Regions(1).SimplexMatrix;
    actWeightsA1 = actExpandedA.Regions(1).Weights;

    actMotorVertexListA2 = actExpandedA.Regions(2).MotorVertexList;
    actSimplexMatrixA2 = actExpandedA.Regions(2).SimplexMatrix;
    actWeightsA2 = actExpandedA.Regions(2).Weights;

    actMotorVertexListA3 = actExpandedA.Regions(3).MotorVertexList;
    actSimplexMatrixA3 = actExpandedA.Regions(3).SimplexMatrix;
    actWeightsA3 = actExpandedA.Regions(3).Weights;

    actMotorVertexListB1 = actExpandedB.Regions(1).MotorVertexList;
    actSimplexMatrixB1 = actExpandedB.Regions(1).SimplexMatrix;
    actWeightsB1 = actExpandedB.Regions(1).Weights;

    actMotorVertexListB2 = actExpandedB.Regions(2).MotorVertexList;
    actSimplexMatrixB2 = actExpandedB.Regions(2).SimplexMatrix;
    actWeightsB2 = actExpandedB.Regions(2).Weights;

    actMotorVertexListB3 = actExpandedB.Regions(3).MotorVertexList;
    actSimplexMatrixB3 = actExpandedB.Regions(3).SimplexMatrix;
    actWeightsB3 = actExpandedB.Regions(3).Weights;

    %% Expected values

    expMotorVertexListA1 = [0 0; 0 3; 4 3; 4 0; 5 5];
    expSimplexMatrixA1 = [1 2 3; 1 3 4; 2 3 5; 3 4 5];
    expWeightsA1 = [2 6 1 1];

    expMotorVertexListA2 = [0 0; 0 5; 5 5];
    expSimplexMatrixA2 = [1 2 3];
    expWeightsA2 = 2;

    expMotorVertexListA3 = [5 0; 12 0; 6 12; 12 12];
    expSimplexMatrixA3 = [1 2 3; 2 3 4];
    expWeightsA3 = [5 1];

    expMotorVertexListB1 = [0 0; 0 3; 4 3; 4 0];
    expSimplexMatrixB1 = [1 2 3; 1 3 4];
    expWeightsB1 = [3 6];

    expMotorVertexListB2 = [0 0; 0 5; 5 5; 8 2];
    expSimplexMatrixB2 = [1 2 3; 1 3 4];
    expWeightsB2 = [1 1];

    expMotorVertexListB3 = [5 0; 12 0; 6 12];
    expSimplexMatrixB3 = [1 2 3];
    expWeightsB3 = 6;
    
    %% Testing

    verifyEqual(testCase, actMotorVertexListA1, expMotorVertexListA1);
    verifyEqual(testCase, actSimplexMatrixA1, expSimplexMatrixA1);
    verifyEqual(testCase, actWeightsA1, expWeightsA1);

    verifyEqual(testCase, actMotorVertexListA2, expMotorVertexListA2);
    verifyEqual(testCase, actSimplexMatrixA2, expSimplexMatrixA2);
    verifyEqual(testCase, actWeightsA2, expWeightsA2);

    verifyEqual(testCase, actMotorVertexListA3, expMotorVertexListA3);
    verifyEqual(testCase, actSimplexMatrixA3, expSimplexMatrixA3);
    verifyEqual(testCase, actWeightsA3, expWeightsA3);

    verifyEqual(testCase, actMotorVertexListB1, expMotorVertexListB1);
    verifyEqual(testCase, actSimplexMatrixB1, expSimplexMatrixB1);
    verifyEqual(testCase, actWeightsB1, expWeightsB1);

    verifyEqual(testCase, actMotorVertexListB2, expMotorVertexListB2);
    verifyEqual(testCase, actSimplexMatrixB2, expSimplexMatrixB2);
    verifyEqual(testCase, actWeightsB2, expWeightsB2);

    verifyEqual(testCase, actMotorVertexListB3, expMotorVertexListB3);
    verifyEqual(testCase, actSimplexMatrixB3, expSimplexMatrixB3);
    verifyEqual(testCase, actWeightsB3, expWeightsB3);
end

function TestTemporalActivationInfoSimple(testCase)
    %% Creating silhouette
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

    actTemporalVector11 = Silhouette1.TemporalActivationInfo(0, 0);
    actTemporalVector12 = Silhouette1.TemporalActivationInfo(0, 1);
    actTemporalVector14 = Silhouette1.TemporalActivationInfo(0, 3);
    
    actTemporalVector21 = Silhouette1.TemporalActivationInfo(1, 0);
    actTemporalVector22 = Silhouette1.TemporalActivationInfo(1, 1);
    actTemporalVector24 = Silhouette1.TemporalActivationInfo(1, 3);
    
    actTemporalVector41 = Silhouette1.TemporalActivationInfo(3, 0);
    actTemporalVector42 = Silhouette1.TemporalActivationInfo(3, 1);
    actTemporalVector44 = Silhouette1.TemporalActivationInfo(3, 3);

    expTemporalVector11 = [1 0 0; 0 1 0; 0 0 1];
    expTemporalVector12 = [1 0.25 0; 0 1 0.25; 0 0 1];
    expTemporalVector14 = [1 0.5625 0.25; 0 1 0.5625; 0 0 1];

    expTemporalVector21 = [1 0 0; 0.25 1 0; 0 0.25 1];
    expTemporalVector22 = [1 0.25 0; 0.25 1 0.25; 0 0.25 1];
    expTemporalVector24 = [1 0.5625 0.25; 0.25 1 0.5625; 0 0.25 1];

    expTemporalVector41 = [1 0 0; 0.5625 1 0; 0.25 0.5625 1];
    expTemporalVector42 = [1 0.25 0; 0.5625 1 0.25; 0.25 0.5625 1];
    expTemporalVector44 = [1 0.5625 0.25; 0.5625 1 0.5625; 0.25 0.5625 1];

    verifyEqual(testCase, actTemporalVector11, expTemporalVector11);
    verifyEqual(testCase, actTemporalVector12, expTemporalVector12);
    verifyEqual(testCase, actTemporalVector14, expTemporalVector14);

    verifyEqual(testCase, actTemporalVector21, expTemporalVector21);
    verifyEqual(testCase, actTemporalVector22, expTemporalVector22);
    verifyEqual(testCase, actTemporalVector24, expTemporalVector24);

    verifyEqual(testCase, actTemporalVector41, expTemporalVector41);
    verifyEqual(testCase, actTemporalVector42, expTemporalVector42);
    verifyEqual(testCase, actTemporalVector44, expTemporalVector44);
end

function TestPlottingInfo3DSimple(testCase)
    %% Creating silhouette
    MotorVertexList1 = [0 1 0; 1 0 1; -1 0 1; 0 1 1; 0 1 2];
    SimplexMatrix1 = [1 2 3 4; 2 3 4 5];
    Weights1 = [2 6];
    
    MotorVertexList2 = [0 1 10; 1 0 11; -1 0 11; 0 1 11; 0 1 12];
    SimplexMatrix2 = [1 2 3 4; 2 3 4 5];
    Weights2 = [1 1];

    MotorVertexList3 = [0 1 20; 1 0 21; -1 0 21; 0 1 21; 0 1 22];
    SimplexMatrix3 = [1 2 3 4; 2 3 4 5];
    Weights3 = [1 2];

    Region1 = WeightedMotorSimplicialComplex(MotorVertexList1, SimplexMatrix1, Weights1);
    Region2 = WeightedMotorSimplicialComplex(MotorVertexList2, SimplexMatrix2, Weights2);
    Region3 = WeightedMotorSimplicialComplex(MotorVertexList3, SimplexMatrix3, Weights3);
    
    Silhouette1 = MotorSilhouette([Region1; Region2; Region3]);
    
    [actVertexData, actFaceData, actAlphaData] = Silhouette1.PlottingInfo3D(0.5, 1);

    expVertexData = [0 1 0; 1 0 1; -1 0 1; 0 1 1; 0 1 2; ...
        0 1 10; 1 0 11; -1 0 11; 0 1 11; 0 1 12; ...
        0 1 20; 1 0 21; -1 0 21; 0 1 21; 0 1 22];
    expFaceData = [1 2 3 4 nan; 2 3 4 5 nan; 6 7 8 9 nan; ...
        7 8 9 10 nan; 11 12 13 14 nan; 12 13 14 15 nan];
    expAlphaData = [0.5; 1; 1; 1; 0.5; 1];

    verifyEqual(testCase, actVertexData, expVertexData);
    verifyEqual(testCase, actFaceData, expFaceData);
    verifyEqual(testCase, actAlphaData, expAlphaData);
end

function TestPlottingInfoSimple(testCase)
    %% Creating silhouette
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

    [actVertexData, actFaceData, actAlphaData] = Silhouette1.PlottingInfo(0, 1);
    expVertexData = [0 0; 0 3; 4 3; 4 0; 0 0; 0 5; 5 5; 5 0; 12 0; 6 12];
    expFaceData = [1 2 4 nan; 2 3 4 nan; 5 6 7 nan; 8 9 10 nan];
    expAlphaData = [0; 1; 1; 1];

    verifyEqual(testCase, actVertexData, expVertexData);
    verifyEqual(testCase, actFaceData, expFaceData);
    verifyEqual(testCase, actAlphaData, expAlphaData);
end

%% SET UP & TAKE DOWN

function setupOnce(testCase)
    % Create and change to temporary folder
    testCase.TestData.origPath = pwd;
    testCase.TestData.tmpFolder = "tmpFolder" + ...
        string(datetime('now','Format',"yyyyMMdd'T'HHmmss"));
    mkdir(testCase.TestData.tmpFolder)
    cd(testCase.TestData.tmpFolder)
end

function teardownOnce(testCase)
    cd(testCase.TestData.origPath)
    rmdir(testCase.TestData.tmpFolder)
end
