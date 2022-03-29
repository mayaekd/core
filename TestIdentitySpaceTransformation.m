%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function tests = TestIdentitySpaceTransformation
    tests = functiontests(localfunctions);
end

function TestCreateObject(testCase)
    MP1 = MotorPoint([0; 0]);
    MP2 = MotorPoint([0; 1]);
    MP3 = MotorPoint([1; 0]);
    MP4 = MotorPoint([1; 1]);
    MP5 = MotorPoint([3; 4]);
    MP6 = MotorPoint([3; 6]);
    MP7 = MotorPoint([5; 8]);
    MP8 = MotorPoint([6; 7]);

    MP11 = MotorPoint([-5; -5]);
    MP12 = MotorPoint([-4; -4]);
    MP13 = MotorPoint([-3; -3]);
    MP14 = MotorPoint([-3; -4]);
    MP15 = MotorPoint([12; 15]);
    MP16 = MotorPoint([15; 16]);
    MP17 = MotorPoint([12; 14]);
    MP18 = MotorPoint([14; 16]);

    Juncture1 = MP1.MakeJuncture(testCase.TestData.identitySpaceTransformation);
    Juncture2 = MP2.MakeJuncture(testCase.TestData.identitySpaceTransformation);
    Juncture3 = MP3.MakeJuncture(testCase.TestData.identitySpaceTransformation);
    Juncture4 = MP4.MakeJuncture(testCase.TestData.identitySpaceTransformation);
    Juncture5 = MP5.MakeJuncture(testCase.TestData.identitySpaceTransformation);
    Juncture6 = MP6.MakeJuncture(testCase.TestData.identitySpaceTransformation);
    Juncture7 = MP7.MakeJuncture(testCase.TestData.identitySpaceTransformation);
    Juncture8 = MP8.MakeJuncture(testCase.TestData.identitySpaceTransformation);

    MotorPointListList = {{MP11; MP12; MP13; MP14}; {MP15; MP16; MP17; MP18}};

    space = testCase.TestData.identitySpaceTransformation.CreateSpace(MotorPointListList, [0 50], 5);

    actPP1 = Juncture1.PerceptualPoint.Coordinates;
    actPP2 = Juncture2.PerceptualPoint.Coordinates;
    actPP3 = Juncture3.PerceptualPoint.Coordinates;
    actPP4 = Juncture4.PerceptualPoint.Coordinates;
    actPP5 = Juncture5.PerceptualPoint.Coordinates;
    actPP6 = Juncture6.PerceptualPoint.Coordinates;
    actPP7 = Juncture7.PerceptualPoint.Coordinates;
    actPP8 = Juncture8.PerceptualPoint.Coordinates;

    actCluster1_Motor = space.Clusters{1,1}.MotorCoordinateMatrix;
    actCluster1_Perceptual = space.Clusters{1,1}.PerceptualCoordinateMatrix;
    actCluster2_Motor = space.Clusters{2,1}.MotorCoordinateMatrix;
    actCluster2_Perceptual = space.Clusters{2,1}.PerceptualCoordinateMatrix;

    expPP1 = [0; 0];
    expPP2 = [0; 1];
    expPP3 = [1; 0];
    expPP4 = [1; 1];
    expPP5 = [3; 4];
    expPP6 = [3; 6];
    expPP7 = [5; 8];
    expPP8 = [6; 7];

    expCluster1_Motor = [-5 -4 -3 -3; -5 -4 -3 -4];
    expCluster1_Perceptual = [-5 -4 -3 -3; -5 -4 -3 -4];
    expCluster2_Motor = [12 15 12 14; 15 16 14 16];
    expCluster2_Perceptual = [12 15 12 14; 15 16 14 16];

    verifyEqual(testCase, actPP1, expPP1);
    verifyEqual(testCase, actPP2, expPP2);
    verifyEqual(testCase, actPP3, expPP3);
    verifyEqual(testCase, actPP4, expPP4);
    verifyEqual(testCase, actPP5, expPP5);
    verifyEqual(testCase, actPP6, expPP6);
    verifyEqual(testCase, actPP7, expPP7);
    verifyEqual(testCase, actPP8, expPP8);

    verifyEqual(testCase, actCluster1_Motor, expCluster1_Motor);
    verifyEqual(testCase, actCluster1_Perceptual, expCluster1_Perceptual);
    verifyEqual(testCase, actCluster2_Motor, expCluster2_Motor);
    verifyEqual(testCase, actCluster2_Perceptual, expCluster2_Perceptual);
end

function setupOnce(testCase)
    % Create and change to temporary folder
    testCase.TestData.origPath = pwd;
    testCase.TestData.tmpFolder = "tmpFolder" + ...
        string(datetime('now','Format',"yyyyMMdd'T'HHmmss"));
    mkdir(testCase.TestData.tmpFolder)
    cd(testCase.TestData.tmpFolder)
    IdentitySpaceTransformation;
    testCase.TestData.identitySpaceTransformation = identitySpaceTransformation;
end

function teardownOnce(testCase)
    cd(testCase.TestData.origPath)
    rmdir(testCase.TestData.tmpFolder)
end

