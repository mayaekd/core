%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function tests = TestMakeManySquareClusters
    tests = functiontests(localfunctions);
end

function TestOneCluster(testCase)
    xStartA = 0;
    yStartA = 3;
    StepSizeA = 2;
    SideLengthA = 10;
    DistanceBetweenClustersA = 2;
    NumClustersPerSideA = 1;

    xStartB = 0;
    yStartB = 0;
    StepSizeB = 6;
    SideLengthB = 12;
    DistanceBetweenClustersB = 3;
    NumClustersPerSideB = 1;

    xStartC = 2;
    yStartC = 2;
    StepSizeC = 2;
    SideLengthC = 6;
    DistanceBetweenClustersC = 4;
    NumClustersPerSideC = 1;

    ClusterList1A = MakeManySquareClusters(xStartA, yStartA, StepSizeA, ...
        SideLengthA, DistanceBetweenClustersA, NumClustersPerSideA, ...
        testCase.TestData.spaceTransformation1);
    ClusterList2A = MakeManySquareClusters(xStartA, yStartA, StepSizeA, ...
        SideLengthA, DistanceBetweenClustersA, NumClustersPerSideA, ...
        testCase.TestData.spaceTransformation2);
    ClusterList3A = MakeManySquareClusters(xStartA, yStartA, StepSizeA, ...
        SideLengthA, DistanceBetweenClustersA, NumClustersPerSideA, ...
        testCase.TestData.spaceTransformation3);

    ClusterList1B = MakeManySquareClusters(xStartB, yStartB, StepSizeB, ...
        SideLengthB, DistanceBetweenClustersB, NumClustersPerSideB, ...
        testCase.TestData.spaceTransformation1);
    ClusterList2B = MakeManySquareClusters(xStartB, yStartB, StepSizeB, ...
        SideLengthB, DistanceBetweenClustersB, NumClustersPerSideB, ...
        testCase.TestData.spaceTransformation2);
    ClusterList3B = MakeManySquareClusters(xStartB, yStartB, StepSizeB, ...
        SideLengthB, DistanceBetweenClustersB, NumClustersPerSideB, ...
        testCase.TestData.spaceTransformation3);

    ClusterList1C = MakeManySquareClusters(xStartC, yStartC, StepSizeC, ...
        SideLengthC, DistanceBetweenClustersC, NumClustersPerSideC, ...
        testCase.TestData.spaceTransformation1);
    ClusterList2C = MakeManySquareClusters(xStartC, yStartC, StepSizeC, ...
        SideLengthC, DistanceBetweenClustersC, NumClustersPerSideC, ...
        testCase.TestData.spaceTransformation2);
    ClusterList3C = MakeManySquareClusters(xStartC, yStartC, StepSizeC, ...
        SideLengthC, DistanceBetweenClustersC, NumClustersPerSideC, ...
        testCase.TestData.spaceTransformation3);

    % Making sure all the cluster lists only have one cluster
    verifyEqual(testCase, length(ClusterList1A), 1);
    verifyEqual(testCase, length(ClusterList2A), 1);
    verifyEqual(testCase, length(ClusterList3A), 1);
    verifyEqual(testCase, length(ClusterList1B), 1);
    verifyEqual(testCase, length(ClusterList2B), 1);
    verifyEqual(testCase, length(ClusterList3B), 1);
    verifyEqual(testCase, length(ClusterList1C), 1);
    verifyEqual(testCase, length(ClusterList2C), 1);
    verifyEqual(testCase, length(ClusterList3C), 1);

    expMotor1A = [0 0 0 0 0 0 ...
        2 2 2 2 2 2 ...
        4 4 4 4 4 4 ...
        6 6 6 6 6 6 ...
        8 8 8 8 8 8 ...
        10 10 10 10 10 10; ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13];
    expPerceptual1A = [0 0 0 0 0 0 ...
        2 2 2 2 2 2 ...
        4 4 4 4 4 4 ...
        6 6 6 6 6 6 ...
        8 8 8 8 8 8 ...
        10 10 10 10 10 10; ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13];
    expMotor2A = [0 0 0 0 0 0 ...
        2 2 2 2 2 2 ...
        4 4 4 4 4 4 ...
        6 6 6 6 6 6 ...
        8 8 8 8 8 8 ...
        10 10 10 10 10 10; ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13];
    expPerceptual2A = [10 10 10 10 10 10 ...
        8 8 8 8 8 8 ...
        6 6 6 6 6 6 ...
        4 4 4 4 4 4 ...
        2 2 2 2 2 2 ...
        0 0 0 0 0 0; ...
        7 5 3 1 -1 -3 ...
        7 5 3 1 -1 -3 ...
        7 5 3 1 -1 -3 ...
        7 5 3 1 -1 -3 ...
        7 5 3 1 -1 -3 ...
        7 5 3 1 -1 -3];
    expMotor3A = [0 0 0 0 0 0 ...
        2 2 2 2 2 2 ...
        4 4 4 4 4 4 ...
        6 6 6 6 6 6 ...
        8 8 8 8 8 8 ...
        10 10 10 10 10 10; ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13];
    expPerceptual3A = [0 6 6 6 6 6 ...
        2 8 8 8 8 8 ...
        4 0 0 0 0 0 ...
        6 2 2 2 2 2 ...
        8 4 4 4 4 4 ...
        10 6 6 6 6 6; ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13 ...
        3 5 7 9 11 13];
    expMotor1B = [0 0 0 6 6 6 12 12 12; 0 6 12 0 6 12 0 6 12];
    expPerceptual1B = [0 0 0 6 6 6 12 12 12; 0 6 12 0 6 12 0 6 12];
    expMotor2B = [0 0 0 6 6 6 12 12 12; 0 6 12 0 6 12 0 6 12];
    expPerceptual2B = [10 10 10 4 4 4 -2 -2 -2; 10 4 -2 10 4 -2 10 4 -2];
    expMotor3B = [0 0 0 6 6 6 12 12 12; 0 6 12 0 6 12 0 6 12];
    expPerceptual3B = [0 6 6 6 2 2 12 8 8; 0 6 12 0 6 12 0 6 12];
    expMotor1C = [2 2 2 2 4 4 4 4 6 6 6 6 8 8 8 8; 2 4 6 8 2 4 6 8 2 4 6 8 2 4 6 8];
    expPerceptual1C = [2 2 2 2 4 4 4 4 6 6 6 6 8 8 8 8; 2 4 6 8 2 4 6 8 2 4 6 8 2 4 6 8];
    expMotor2C = [2 2 2 2 4 4 4 4 6 6 6 6 8 8 8 8; 2 4 6 8 2 4 6 8 2 4 6 8 2 4 6 8];
    expPerceptual2C = [8 8 8 8 6 6 6 6 4 4 4 4 2 2 2 2; 8 6 4 2 8 6 4 2 8 6 4 2 8 6 4 2];
    expMotor3C = [2 2 2 2 4 4 4 4 6 6 6 6 8 8 8 8; 2 4 6 8 2 4 6 8 2 4 6 8 2 4 6 8];
    expPerceptual3C = [2 8 8 8 4 0 0 0 6 2 2 2 8 4 4 4; 2 4 6 8 2 4 6 8 2 4 6 8 2 4 6 8];

    verifyEqual(testCase, ClusterList1A{1,1}.MotorCoordinateMatrix, expMotor1A);
    verifyEqual(testCase, ClusterList1A{1,1}.PerceptualCoordinateMatrix, expPerceptual1A);
    verifyEqual(testCase, ClusterList1B{1,1}.MotorCoordinateMatrix, expMotor1B);
    verifyEqual(testCase, ClusterList1B{1,1}.PerceptualCoordinateMatrix, expPerceptual1B);
    verifyEqual(testCase, ClusterList1C{1,1}.MotorCoordinateMatrix, expMotor1C);
    verifyEqual(testCase, ClusterList1C{1,1}.PerceptualCoordinateMatrix, expPerceptual1C);
    verifyEqual(testCase, ClusterList2A{1,1}.MotorCoordinateMatrix, expMotor2A);
    verifyEqual(testCase, ClusterList2A{1,1}.PerceptualCoordinateMatrix, expPerceptual2A);
    verifyEqual(testCase, ClusterList2B{1,1}.MotorCoordinateMatrix, expMotor2B);
    verifyEqual(testCase, ClusterList2B{1,1}.PerceptualCoordinateMatrix, expPerceptual2B);
    verifyEqual(testCase, ClusterList2C{1,1}.MotorCoordinateMatrix, expMotor2C);
    verifyEqual(testCase, ClusterList2C{1,1}.PerceptualCoordinateMatrix, expPerceptual2C);
    verifyEqual(testCase, ClusterList3A{1,1}.MotorCoordinateMatrix, expMotor3A);
    verifyEqual(testCase, ClusterList3A{1,1}.PerceptualCoordinateMatrix, expPerceptual3A);
    verifyEqual(testCase, ClusterList3B{1,1}.MotorCoordinateMatrix, expMotor3B);
    verifyEqual(testCase, ClusterList3B{1,1}.PerceptualCoordinateMatrix, expPerceptual3B);
    verifyEqual(testCase, ClusterList3C{1,1}.MotorCoordinateMatrix, expMotor3C);
    verifyEqual(testCase, ClusterList3C{1,1}.PerceptualCoordinateMatrix, expPerceptual3C);
end

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
    testCase.TestData.spaceTransformation3 = SpaceTransformation(@transformationFunction3);
end

function teardownOnce(testCase)
    cd(testCase.TestData.origPath)
    rmdir(testCase.TestData.tmpFolder)
end

% Identity
function PerceptualCoordinates = transformationFunction1(MotorCoordinates)
    PerceptualCoordinates = MotorCoordinates;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MOTOR
% 14 % o0 o1 o2 o3 o4 o5 o6 o7 o8 o9 O0 O1 O2 O3 O4 O5 O6 O7 O8 O9
% 13 % n0 n1 n2 n3 n4 n5 n6 n7 n8 n9 N0 N1 N2 N3 N4 N5 N6 N7 N8 N9
% 12 % m0 m1 m2 m3 m4 m5 m6 m7 m8 m9 M0 M1 M2 M3 M4 M5 M6 M7 M8 M9
% 11 % l0 l1 l2 l3 l4 l5 l6 l7 l8 l9 L0 L1 L2 L3 L4 L5 L6 L7 L8 L9
% 10 % k0 k1 k2 k3 k4 k5 k6 k7 k8 k9 K0 K1 K2 K3 K4 K5 K6 K7 K8 K9
% 09 % j0 j1 j2 j3 j4 j5 j6 j7 j8 j9 J0 J1 J2 J3 J4 J5 J6 J7 J8 J9
% 08 % i0 i1 i2 i3 i4 i5 i6 i7 i8 i9 I0 I1 I2 I3 I4 I5 I6 I7 I8 I9
% 07 % h0 h1 h2 h3 h4 h5 h6 h7 h8 h9 H0 H1 H2 H3 H4 H5 H6 H7 H8 H9
% 06 % g0 g1 g2 g3 g4 g5 g6 g7 g8 g9 A0 G1 G2 G3 G4 G5 G6 G7 G8 G9 
% 05 % f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 F0 F1 F2 F3 F4 F5 F6 F7 F8 F9 
% 04 % e0 e1 e2 e3 e4 e5 e6 e7 e8 e9 E0 E1 E2 E3 E4 E5 E6 E7 E8 E9 
% 03 % d0 d1 d2 d3 d4 d5 d6 d7 d8 d9 D0 D1 D2 D3 D4 D5 D6 D7 D8 D9 
% 02 % c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 C0 C1 C2 C3 C4 C5 C6 C7 C8 C9 
% 01 % b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 B0 B1 B2 B3 B4 B5 B6 B7 B8 B9 
% 00 % a0 a1 a2 a3 a4 a5 a6 a7 a8 a9 A0 A1 A2 A3 A4 A5 A6 A7 A8 A9
%    % 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19

% PERCEPTUAL
% 10 % A9 A8 A7 A6 A5 A4 A3 A2 A1 A0 a9 a8 a7 a6 a5 a4 a3 a2 a1 a0
% 09 % B9 B8 B7 B6 B5 B4 B3 B2 B1 B0 b9 b8 b7 b6 b5 b4 b3 b2 b1 b0
% 08 % C9 C8 C7 C6 C5 C4 C3 C2 C1 C0 c9 c8 c7 c6 c5 c4 c3 c2 c1 c0
% 07 % D9 D8 D7 D6 D5 D4 D3 D2 D1 D0 d9 d8 d7 d6 d5 d4 d3 d2 d1 d0
% 06 % E9 E8 E7 E6 E5 E4 E3 E2 E1 E0 e9 d8 d7 d6 d5 d4 d3 d2 d1 d0
% 05 % F9 F8 F7 F6 F5 F4 F3 F2 F1 F0 f9 f8 f7 f6 f5 f4 f3 f2 f1 f0
% 04 % G9 G8 G7 G6 G5 G4 G3 G2 G1 G0 g9 g8 g7 g6 g5 g4 g3 g2 g1 g0
% 03 % H9 H8 H7 H6 H5 H4 H3 H2 H1 H0 h9 h8 h7 h6 h5 h4 h3 h2 h1 h0
% 02 % I9 I8 I7 I6 I5 I4 I3 I2 I1 I0 i9 i8 i7 i6 i5 i4 i3 i2 i1 i0
% 01 % J9 J8 J7 J6 J5 J4 J3 J2 J1 J0 j9 j8 j7 j6 j5 j4 j3 j2 j1 j0
% 00 % K9 K8 K7 K6 K5 K4 K3 K2 K1 K0 k9 k8 k7 k6 k5 k4 k3 k2 k1 k0
% -1 % L9 L8 L7 L6 L5 L4 L3 L2 L1 L0 l9 l8 l7 l6 l5 l4 l3 l2 l1 l0
% -2 % M9 M8 M7 M6 M5 M4 M3 M2 M1 M0 m9 m8 m7 m6 m5 m4 m3 m2 m1 m0
% -3 % N9 N8 N7 N6 N5 N4 N3 N2 N1 N0 n9 n8 n7 n6 n5 n4 n3 n2 n1 n0
% -4 % O9 O8 O7 O6 O5 O4 O3 O2 O1 O0 o9 o8 o7 o6 o5 o4 o3 o2 o1 o0
%    % -9 -8 -7 -6 -5 -4 -3 -2 -1 00 01 02 03 04 05 06 07 08 09 10
function PerceptualCoordinates = transformationFunction2(MotorCoordinates)
    PerceptualCoordinates = [10; 10] - MotorCoordinates;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MOTOR
% 10 % k0 k1 k2 k3 k4 k5 k6 k7 k8 k9 K0 K1 K2 K3 K4 K5
% 09 % j0 j1 j2 j3 j4 j5 j6 j7 j8 j9 J0 J1 J2 J3 J4 J5
% 08 % i0 i1 i2 i3 i4 i5 i6 i7 i8 i9 I0 I1 I2 I3 I4 I5
% 07 % h0 h1 h2 h3 h4 h5 h6 h7 h8 h9 H0 H1 H2 H3 H4 H5
% 06 % g0 g1 g2 g3 g4 g5 g6 g7 g8 g9 A0 G1 G2 G3 G4 G5
% 05 % f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 F0 F1 F2 F3 F4 F5
% 04 % e0 e1 e2 e3 e4 e5 e6 e7 e8 e9 E0 E1 E2 E3 E4 E5
% 03 % d0 d1 d2 d3 d4 d5 d6 d7 d8 d9 D0 D1 D2 D3 D4 D5
% 02 % c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 C0 C1 C2 C3 C4 C5
% 01 % b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 B0 B1 B2 B3 B4 B5
% 00 % a0 a1 a2 a3 a4 a5 a6 a7 a8 a9 A0 A1 A2 A3 A4 A5
%    % 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15

% PERCEPTUAL
% 10 % k6 k7 k8 k9 k0 k1 k2 k3 k4 k5 k6 k7 k8 k9 K0 K1 K2 K3 K4 K5 K6 K7 K8 K9
% 09 % j6 j7 j8 j9 j0 j1 j2 j3 j4 j5 j6 j7 j8 j9 J0 J1 J2 J3 J4 J5 J6 J7 J8 J9
% 08 % i6 i7 i8 i9 i0 i1 i2 i3 i4 i5 i6 i7 i8 i9 I0 I1 I2 I3 I4 I5 I6 I7 I8 I9
% 07 % h6 h7 h8 h9 h0 h1 h2 h3 h4 h5 h6 h7 h8 h9 H0 H1 H2 H3 H4 H5 H6 H7 H8 H9
% 06 % g6 g7 g8 g9 g0 g1 g2 g3 g4 g5 g6 g7 g8 g9 A0 G1 G2 G3 G4 G5 G6 G7 G8 G9 
% 05 % f6 f7 f8 f9 f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 F0 F1 F2 F3 F4 F5 F6 F7 F8 F9 
% 04 % e6 e7 e8 e9 e0 e1 e2 e3 e4 e5 e6 e7 e8 e9 E0 E1 E2 E3 E4 E5 E6 E7 E8 E9 
% 03 % d0 d1 d2 d3 d4 d5 d6 d7 d8 d9 D0 D1 D2 D3 D4 D5 D6 D7 D8 D9 
% 02 % c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 C0 C1 C2 C3 C4 C5 C6 C7 C8 C9 
% 01 % b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 B0 B1 B2 B3 B4 B5 B6 B7 B8 B9 
% 00 % a0 a1 a2 a3 a4 a5 a6 a7 a8 a9 A0 A1 A2 A3 A4 A5 A6 A7 A8 A9
%    % 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23
function PerceptualCoordinates = transformationFunction3(MotorCoordinates)
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%