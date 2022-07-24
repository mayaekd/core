%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS TESTED
%  MakeManyHyperCubeClusters

%% TESTS

function tests = TestMakeManyHyperCubeClustersSimple
    tests = functiontests(localfunctions);
end
% 
% function TestFunction1D(testCase)
%     st1 = testCase.TestData.spaceTransformation1;
%     st2 = testCase.TestData.spaceTransformation2;
%     
%     StartingValues1 = 2;
%     StepSizes1 = 1;
%     SideLengths1 = 3;
%     DistancesBetweenClusters1 = 4;
%     NumClustersPerSides1 = 4;
% 
%     StartingValues2 = 1;
%     StepSizes2 = 3;
%     SideLengths2 = 6;
%     DistancesBetweenClusters2 = 5;
%     NumClustersPerSides2 = 4;
% 
%     Clusters1 = MakeManyHyperCubeClusters(StartingValues1, StepSizes1, ...
%         SideLengths1, DistancesBetweenClusters1, NumClustersPerSides1, ...
%         st1);
% 
%     Clusters2 = MakeManyHyperCubeClusters(StartingValues2, StepSizes2, ...
%         SideLengths2, DistancesBetweenClusters2, NumClustersPerSides2, ...
%         st2);
% 
%     actCluster1AMotor = Clusters1(1).MotorCoordinateMatrix;
%     actCluster1BMotor = Clusters1(2).MotorCoordinateMatrix;
%     actCluster1CMotor = Clusters1(3).MotorCoordinateMatrix;
%     actCluster1DMotor = Clusters1(4).MotorCoordinateMatrix;
% 
%     actCluster1APerceptual = Clusters1(1).PerceptualCoordinateMatrix;
%     actCluster1BPerceptual = Clusters1(2).PerceptualCoordinateMatrix;
%     actCluster1CPerceptual = Clusters1(3).PerceptualCoordinateMatrix;
%     actCluster1DPerceptual = Clusters1(4).PerceptualCoordinateMatrix;
% 
%     actCluster2AMotor = Clusters2(1).MotorCoordinateMatrix;
%     actCluster2BMotor = Clusters2(2).MotorCoordinateMatrix;
%     actCluster2CMotor = Clusters2(3).MotorCoordinateMatrix;
%     actCluster2DMotor = Clusters2(4).MotorCoordinateMatrix;
% 
%     actCluster2APerceptual = Clusters2(1).PerceptualCoordinateMatrix;
%     actCluster2BPerceptual = Clusters2(2).PerceptualCoordinateMatrix;
%     actCluster2CPerceptual = Clusters2(3).PerceptualCoordinateMatrix;
%     actCluster2DPerceptual = Clusters2(4).PerceptualCoordinateMatrix;
% 
%     expCluster1A = [2 3 4 5];
%     expCluster1B = [9 10 11 12];
%     expCluster1C = [16 17 18 19];
%     expCluster1D = [23 24 25 26];
% 
%     expCluster2AMotor = [1 4 7];
%     expCluster2BMotor = [12 15 18];
%     expCluster2CMotor = [23 26 29];
%     expCluster2DMotor = [34 37 40];
% 
%     expCluster2APerceptual = [9 6 3];
%     expCluster2BPerceptual = [-2 -5 -8];
%     expCluster2CPerceptual = [-13 -16 -19];
%     expCluster2DPerceptual = [-24 -27 -30];
% 
%     verifyEqual(testCase, actCluster1AMotor, expCluster1A);
%     verifyEqual(testCase, actCluster1BMotor, expCluster1B);
%     verifyEqual(testCase, actCluster1CMotor, expCluster1C);
%     verifyEqual(testCase, actCluster1DMotor, expCluster1D);
% 
%     verifyEqual(testCase, actCluster1APerceptual, expCluster1A);
%     verifyEqual(testCase, actCluster1BPerceptual, expCluster1B);
%     verifyEqual(testCase, actCluster1CPerceptual, expCluster1C);
%     verifyEqual(testCase, actCluster1DPerceptual, expCluster1D);
% 
%     verifyEqual(testCase, actCluster2AMotor, expCluster2AMotor);
%     verifyEqual(testCase, actCluster2BMotor, expCluster2BMotor);
%     verifyEqual(testCase, actCluster2CMotor, expCluster2CMotor);
%     verifyEqual(testCase, actCluster2DMotor, expCluster2DMotor);
% 
%     verifyEqual(testCase, actCluster2APerceptual, expCluster2APerceptual);
%     verifyEqual(testCase, actCluster2BPerceptual, expCluster2BPerceptual);
%     verifyEqual(testCase, actCluster2CPerceptual, expCluster2CPerceptual);
%     verifyEqual(testCase, actCluster2DPerceptual, expCluster2DPerceptual);
% end


function TestFunction2DSimple(testCase)
    st1 = testCase.TestData.spaceTransformation1;
    st3 = testCase.TestData.spaceTransformation3;
    StartingValues1 = [2 4];
    StepSizes1 = [1 10];
    SideLengths1 = [3 20];
    DistancesBetweenClusters1 = [4 4];
    NumClustersPerSides1 = [2 2];

    StartingValues2 = [1 10];
    StepSizes2 = [5 8];
    SideLengths2 = [50 16];
    DistancesBetweenClusters2 = [500 10];
    NumClustersPerSides2 = [1 3];

    Clusters1 = MakeManyHyperCubeClusters(StartingValues1, StepSizes1, ...
        SideLengths1, DistancesBetweenClusters1, NumClustersPerSides1, ...
        st1);

    Clusters2 = MakeManyHyperCubeClusters(StartingValues2, StepSizes2, ...
        SideLengths2, DistancesBetweenClusters2, NumClustersPerSides2, ...
        st3);

    actCluster1AMotor = Clusters1(1).MotorCoordinateMatrix;
    actCluster1BMotor = Clusters1(2).MotorCoordinateMatrix;
    actCluster1CMotor = Clusters1(3).MotorCoordinateMatrix;
    actCluster1DMotor = Clusters1(4).MotorCoordinateMatrix;

    actCluster1APerceptual = Clusters1(1).PerceptualCoordinateMatrix;
    actCluster1BPerceptual = Clusters1(2).PerceptualCoordinateMatrix;
    actCluster1CPerceptual = Clusters1(3).PerceptualCoordinateMatrix;
    actCluster1DPerceptual = Clusters1(4).PerceptualCoordinateMatrix;

    actCluster2AMotor = Clusters2(1).MotorCoordinateMatrix;
    actCluster2BMotor = Clusters2(2).MotorCoordinateMatrix;
    actCluster2CMotor = Clusters2(3).MotorCoordinateMatrix;

    actCluster2APerceptual = Clusters2(1).PerceptualCoordinateMatrix;
    actCluster2BPerceptual = Clusters2(2).PerceptualCoordinateMatrix;
    actCluster2CPerceptual = Clusters2(3).PerceptualCoordinateMatrix;

    expCluster1A = [2 3 4 5 2 3 4 5 2 3 4 5; 4 4 4 4 14 14 14 14 24 24 24 24];
    expCluster1B = [9 10 11 12 9 10 11 12 9 10 11 12; 4 4 4 4 14 14 14 14 24 24 24 24];
    expCluster1C = [2 3 4 5 2 3 4 5 2 3 4 5; 28 28 28 28 38 38 38 38 48 48 48 48];
    expCluster1D = [9 10 11 12 9 10 11 12 9 10 11 12; 28 28 28 28 38 38 38 38 48 48 48 48];

    expCluster2AMotor = [ ...
        1 6 11 16 21 26 31 36 41 46 51 ...
        1 6 11 16 21 26 31 36 41 46 51 ...
        1 6 11 16 21 26 31 36 41 46 51; ...
        10 10 10 10 10 10 10 10 10 10 10 ...
        18 18 18 18 18 18 18 18 18 18 18 ...
        26 26 26 26 26 26 26 26 26 26 26];
    expCluster2BMotor = [ ...
        1 6 11 16 21 26 31 36 41 46 51 ...
        1 6 11 16 21 26 31 36 41 46 51 ...
        1 6 11 16 21 26 31 36 41 46 51; ...
        36 36 36 36 36 36 36 36 36 36 36 ...
        44 44 44 44 44 44 44 44 44 44 44 ...
        52 52 52 52 52 52 52 52 52 52 52];
    expCluster2CMotor = [ ...
        1 6 11 16 21 26 31 36 41 46 51 ...
        1 6 11 16 21 26 31 36 41 46 51 ...
        1 6 11 16 21 26 31 36 41 46 51; ...
        62 62 62 62 62 62 62 62 62 62 62 ...
        70 70 70 70 70 70 70 70 70 70 70 ...
        78 78 78 78 78 78 78 78 78 78 78];

    expCluster2APerceptual = [ ...
        99 94 89 84 79 74 69 64 59 54 49 ...
        99 94 89 84 79 74 69 64 59 54 49 ...
        99 94 89 84 79 74 69 64 59 54 49; ...
        90 90 90 90 90 90 90 90 90 90 90 ...
        82 82 82 82 82 82 82 82 82 82 82 ...
        74 74 74 74 74 74 74 74 74 74 74];
    expCluster2BPerceptual = [ ...
        99 94 89 84 79 74 69 64 59 54 49 ...
        99 94 89 84 79 74 69 64 59 54 49 ...
        99 94 89 84 79 74 69 64 59 54 49; ...
        64 64 64 64 64 64 64 64 64 64 64 ...
        56 56 56 56 56 56 56 56 56 56 56 ...
        48 48 48 48 48 48 48 48 48 48 48];
    expCluster2CPerceptual = [ ...
        99 94 89 84 79 74 69 64 59 54 49 ...
        99 94 89 84 79 74 69 64 59 54 49 ...
        99 94 89 84 79 74 69 64 59 54 49; ...
        38 38 38 38 38 38 38 38 38 38 38 ...
        30 30 30 30 30 30 30 30 30 30 30 ...
        22 22 22 22 22 22 22 22 22 22 22];

    verifyEqual(testCase, actCluster1AMotor, expCluster1A);
    verifyEqual(testCase, actCluster1BMotor, expCluster1B);
    verifyEqual(testCase, actCluster1CMotor, expCluster1C);
    verifyEqual(testCase, actCluster1DMotor, expCluster1D);

    verifyEqual(testCase, actCluster1APerceptual, expCluster1A);
    verifyEqual(testCase, actCluster1BPerceptual, expCluster1B);
    verifyEqual(testCase, actCluster1CPerceptual, expCluster1C);
    verifyEqual(testCase, actCluster1DPerceptual, expCluster1D);

    verifyEqual(testCase, actCluster2AMotor, expCluster2AMotor);
    verifyEqual(testCase, actCluster2BMotor, expCluster2BMotor);
    verifyEqual(testCase, actCluster2CMotor, expCluster2CMotor);

    verifyEqual(testCase, actCluster2APerceptual, expCluster2APerceptual);
    verifyEqual(testCase, actCluster2BPerceptual, expCluster2BPerceptual);
    verifyEqual(testCase, actCluster2CPerceptual, expCluster2CPerceptual);
end

function TestFunction3DSimple(testCase)
    st1 = testCase.TestData.spaceTransformation1;
    st3 = testCase.TestData.spaceTransformation3;
    StartingValues1 = [2 4 8];
    StepSizes1 = [1 1 2];
    SideLengths1 = [2 1 2];
    DistancesBetweenClusters1 = [3 4 4];
    NumClustersPerSides1 = [2 2 2];

    StartingValues2 = [10 20 30];
    StepSizes2 = [3 4 7];
    SideLengths2 = [3 4 14];
    DistancesBetweenClusters2 = [10 10 10];
    NumClustersPerSides2 = [1 3 1];

    Clusters1 = MakeManyHyperCubeClusters(StartingValues1, StepSizes1, ...
        SideLengths1, DistancesBetweenClusters1, NumClustersPerSides1, ...
        st1);

    Clusters2 = MakeManyHyperCubeClusters(StartingValues2, StepSizes2, ...
        SideLengths2, DistancesBetweenClusters2, NumClustersPerSides2, ...
        st3);

    actCluster1AMotor = Clusters1(1).MotorCoordinateMatrix;
    actCluster1BMotor = Clusters1(2).MotorCoordinateMatrix;
    actCluster1CMotor = Clusters1(3).MotorCoordinateMatrix;
    actCluster1DMotor = Clusters1(4).MotorCoordinateMatrix;
    actCluster1EMotor = Clusters1(5).MotorCoordinateMatrix;
    actCluster1FMotor = Clusters1(6).MotorCoordinateMatrix;
    actCluster1GMotor = Clusters1(7).MotorCoordinateMatrix;
    actCluster1HMotor = Clusters1(8).MotorCoordinateMatrix;

    actCluster1APerceptual = Clusters1(1).PerceptualCoordinateMatrix;
    actCluster1BPerceptual = Clusters1(2).PerceptualCoordinateMatrix;
    actCluster1CPerceptual = Clusters1(3).PerceptualCoordinateMatrix;
    actCluster1DPerceptual = Clusters1(4).PerceptualCoordinateMatrix;
    actCluster1EPerceptual = Clusters1(5).PerceptualCoordinateMatrix;
    actCluster1FPerceptual = Clusters1(6).PerceptualCoordinateMatrix;
    actCluster1GPerceptual = Clusters1(7).PerceptualCoordinateMatrix;
    actCluster1HPerceptual = Clusters1(8).PerceptualCoordinateMatrix;

    actCluster2AMotor = Clusters2(1).MotorCoordinateMatrix;
    actCluster2BMotor = Clusters2(2).MotorCoordinateMatrix;
    actCluster2CMotor = Clusters2(3).MotorCoordinateMatrix;

    actCluster2APerceptual = Clusters2(1).PerceptualCoordinateMatrix;
    actCluster2BPerceptual = Clusters2(2).PerceptualCoordinateMatrix;
    actCluster2CPerceptual = Clusters2(3).PerceptualCoordinateMatrix;

    expCluster1A = [ ...
        2 3 4 2 3 4 2 3 4 2 3 4; ...
        4 4 4 5 5 5 4 4 4 5 5 5; ...
        8 8 8 8 8 8 10 10 10 10 10 10];
    expCluster1B = [ ...
        7 8 9 7 8 9 7 8 9 7 8 9; ...
        4 4 4 5 5 5 4 4 4 5 5 5; ...
        8 8 8 8 8 8 10 10 10 10 10 10];
    expCluster1C = [ ...
        2 3 4 2 3 4 2 3 4 2 3 4; ...
        9 9 9 10 10 10 9 9 9 10 10 10; ...
        8 8 8 8 8 8 10 10 10 10 10 10];
    expCluster1D = [ ...
        7 8 9 7 8 9 7 8 9 7 8 9; ...
        9 9 9 10 10 10 9 9 9 10 10 10; ...
        8 8 8 8 8 8 10 10 10 10 10 10];
    expCluster1E = [ ...
        2 3 4 2 3 4 2 3 4 2 3 4; ...
        4 4 4 5 5 5 4 4 4 5 5 5; ...
        14 14 14 14 14 14 16 16 16 16 16 16];
    expCluster1F = [ ...
        7 8 9 7 8 9 7 8 9 7 8 9; ...
        4 4 4 5 5 5 4 4 4 5 5 5; ...
        14 14 14 14 14 14 16 16 16 16 16 16];
    expCluster1G = [ ...
        2 3 4 2 3 4 2 3 4 2 3 4; ...
        9 9 9 10 10 10 9 9 9 10 10 10; ...
        14 14 14 14 14 14 16 16 16 16 16 16];
    expCluster1H = [ ...
        7 8 9 7 8 9 7 8 9 7 8 9; ...
        9 9 9 10 10 10 9 9 9 10 10 10; ...
        14 14 14 14 14 14 16 16 16 16 16 16];

    expCluster2AMotor = [ ...
        10 13 10 13 10 13 10 13 10 13 10 13; ...
        20 20 24 24 20 20 24 24 20 20 24 24; ...
        30 30 30 30 37 37 37 37 44 44 44 44
        ];
    expCluster2BMotor = [ ...
        10 13 10 13 10 13 10 13 10 13 10 13; ...
        34 34 38 38 34 34 38 38 34 34 38 38; ...
        30 30 30 30 37 37 37 37 44 44 44 44
        ];
    expCluster2CMotor = [ ...
        10 13 10 13 10 13 10 13 10 13 10 13; ...
        48 48 52 52 48 48 52 52 48 48 52 52; ...
        30 30 30 30 37 37 37 37 44 44 44 44
        ];

    expCluster2APerceptual = [ ...
        90 87 90 87 90 87 90 87 90 87 90 87; ...
        80 80 76 76 80 80 76 76 80 80 76 76; ...
        70 70 70 70 63 63 63 63 56 56 56 56
        ];
    expCluster2BPerceptual = [ ...
        90 87 90 87 90 87 90 87 90 87 90 87; ...
        66 66 62 62 66 66 62 62 66 66 62 62; ...
        70 70 70 70 63 63 63 63 56 56 56 56
        ];
    expCluster2CPerceptual = [ ...
        90 87 90 87 90 87 90 87 90 87 90 87; ...
        52 52 48 48 52 52 48 48 52 52 48 48; ...
        70 70 70 70 63 63 63 63 56 56 56 56
        ];

    verifyEqual(testCase, actCluster1AMotor, expCluster1A);
    verifyEqual(testCase, actCluster1BMotor, expCluster1B);
    verifyEqual(testCase, actCluster1CMotor, expCluster1C);
    verifyEqual(testCase, actCluster1DMotor, expCluster1D);
    verifyEqual(testCase, actCluster1EMotor, expCluster1E);
    verifyEqual(testCase, actCluster1FMotor, expCluster1F);
    verifyEqual(testCase, actCluster1GMotor, expCluster1G);
    verifyEqual(testCase, actCluster1HMotor, expCluster1H);

    verifyEqual(testCase, actCluster1APerceptual, expCluster1A);
    verifyEqual(testCase, actCluster1BPerceptual, expCluster1B);
    verifyEqual(testCase, actCluster1CPerceptual, expCluster1C);
    verifyEqual(testCase, actCluster1DPerceptual, expCluster1D);
    verifyEqual(testCase, actCluster1EPerceptual, expCluster1E);
    verifyEqual(testCase, actCluster1FPerceptual, expCluster1F);
    verifyEqual(testCase, actCluster1GPerceptual, expCluster1G);
    verifyEqual(testCase, actCluster1HPerceptual, expCluster1H);

    verifyEqual(testCase, actCluster2AMotor, expCluster2AMotor);
    verifyEqual(testCase, actCluster2BMotor, expCluster2BMotor);
    verifyEqual(testCase, actCluster2CMotor, expCluster2CMotor);

    verifyEqual(testCase, actCluster2APerceptual, expCluster2APerceptual);
    verifyEqual(testCase, actCluster2BPerceptual, expCluster2BPerceptual);
    verifyEqual(testCase, actCluster2CPerceptual, expCluster2CPerceptual);
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

function PerceptualCoordinates = transformationFunction1(MotorCoordinates)
    PerceptualCoordinates = MotorCoordinates;
end

function PerceptualCoordinates = transformationFunction2(MotorCoordinates)
    PerceptualCoordinates = 10 - MotorCoordinates;
end

function PerceptualCoordinates = transformationFunction3(MotorCoordinates)
    PerceptualCoordinates = 100 - MotorCoordinates;
end