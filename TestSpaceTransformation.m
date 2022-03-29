%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function tests = TestSpaceTransformation
    tests = functiontests(localfunctions);
end

function TestCreateObject(testCase)
    spaceTransformationA = SpaceTransformation(@transformationFunction1);
    spaceTransformationB = SpaceTransformation(@transformationFunction2);
    spaceTransformationC = SpaceTransformation(@transformationFunction3);
    MP1 = MotorPoint([0; 0]);
    MP2 = MotorPoint([0; 1]);
    MP3 = MotorPoint([1; 0]);
    MP4 = MotorPoint([1; 1]);
    MP5 = MotorPoint([3; 4]);
    MP6 = MotorPoint([3; 6]);
    MP7 = MotorPoint([5; 8]);
    MP8 = MotorPoint([6; 7]);
    Juncture1A = MP1.MakeJuncture(spaceTransformationA);
    Juncture2A = MP2.MakeJuncture(spaceTransformationA);
    Juncture3A = MP3.MakeJuncture(spaceTransformationA);
    Juncture4A = MP4.MakeJuncture(spaceTransformationA);
    Juncture5A = MP5.MakeJuncture(spaceTransformationA);
    Juncture6A = MP6.MakeJuncture(spaceTransformationA);
    Juncture7A = MP7.MakeJuncture(spaceTransformationA);
    Juncture8A = MP8.MakeJuncture(spaceTransformationA);

    Juncture1B = MP1.MakeJuncture(spaceTransformationB);
    Juncture2B = MP2.MakeJuncture(spaceTransformationB);
    Juncture3B = MP3.MakeJuncture(spaceTransformationB);
    Juncture4B = MP4.MakeJuncture(spaceTransformationB);
    Juncture5B = MP5.MakeJuncture(spaceTransformationB);
    Juncture6B = MP6.MakeJuncture(spaceTransformationB);
    Juncture7B = MP7.MakeJuncture(spaceTransformationB);
    Juncture8B = MP8.MakeJuncture(spaceTransformationB);

    Juncture1C = MP1.MakeJuncture(spaceTransformationC);
    Juncture2C = MP2.MakeJuncture(spaceTransformationC);
    Juncture3C = MP3.MakeJuncture(spaceTransformationC);
    Juncture4C = MP4.MakeJuncture(spaceTransformationC);
    Juncture5C = MP5.MakeJuncture(spaceTransformationC);
    Juncture6C = MP6.MakeJuncture(spaceTransformationC);
    Juncture7C = MP7.MakeJuncture(spaceTransformationC);
    Juncture8C = MP8.MakeJuncture(spaceTransformationC);

    actPP1A = Juncture1A.PerceptualPoint.Coordinates;
    actPP2A = Juncture2A.PerceptualPoint.Coordinates;
    actPP3A = Juncture3A.PerceptualPoint.Coordinates;
    actPP4A = Juncture4A.PerceptualPoint.Coordinates;
    actPP5A = Juncture5A.PerceptualPoint.Coordinates;
    actPP6A = Juncture6A.PerceptualPoint.Coordinates;
    actPP7A = Juncture7A.PerceptualPoint.Coordinates;
    actPP8A = Juncture8A.PerceptualPoint.Coordinates;

    actPP1B = Juncture1B.PerceptualPoint.Coordinates;
    actPP2B = Juncture2B.PerceptualPoint.Coordinates;
    actPP3B = Juncture3B.PerceptualPoint.Coordinates;
    actPP4B = Juncture4B.PerceptualPoint.Coordinates;
    actPP5B = Juncture5B.PerceptualPoint.Coordinates;
    actPP6B = Juncture6B.PerceptualPoint.Coordinates;
    actPP7B = Juncture7B.PerceptualPoint.Coordinates;
    actPP8B = Juncture8B.PerceptualPoint.Coordinates;

    actPP1C = Juncture1C.PerceptualPoint.Coordinates;
    actPP2C = Juncture2C.PerceptualPoint.Coordinates;
    actPP3C = Juncture3C.PerceptualPoint.Coordinates;
    actPP4C = Juncture4C.PerceptualPoint.Coordinates;
    actPP5C = Juncture5C.PerceptualPoint.Coordinates;
    actPP6C = Juncture6C.PerceptualPoint.Coordinates;
    actPP7C = Juncture7C.PerceptualPoint.Coordinates;
    actPP8C = Juncture8C.PerceptualPoint.Coordinates;

    expPP1A = [0; 0];
    expPP2A = [0; 1];
    expPP3A = [1; 0];
    expPP4A = [1; 1];
    expPP5A = [3; 4];
    expPP6A = [3; 6];
    expPP7A = [5; 8];
    expPP8A = [6; 7];    

    expPP1B = [10; 10];
    expPP2B = [10; 9];
    expPP3B = [9; 10];
    expPP4B = [9; 9];
    expPP5B = [7; 6];
    expPP6B = [7; 4];
    expPP7B = [5; 2];
    expPP8B = [4; 3];

    expPP1C = [0; 0];
    expPP2C = [0; 1];
    expPP3C = [1; 0];
    expPP4C = [1; 1];
    expPP5C = [9; 4];
    expPP6C = [9; 6];
    expPP7C = [1; 8];
    expPP8C = [2; 7];

    verifyEqual(testCase, actPP1A, expPP1A);
    verifyEqual(testCase, actPP2A, expPP2A);
    verifyEqual(testCase, actPP3A, expPP3A);
    verifyEqual(testCase, actPP4A, expPP4A);
    verifyEqual(testCase, actPP5A, expPP5A);
    verifyEqual(testCase, actPP6A, expPP6A);
    verifyEqual(testCase, actPP7A, expPP7A);
    verifyEqual(testCase, actPP8A, expPP8A);

    verifyEqual(testCase, actPP1B, expPP1B);
    verifyEqual(testCase, actPP2B, expPP2B);
    verifyEqual(testCase, actPP3B, expPP3B);
    verifyEqual(testCase, actPP4B, expPP4B);
    verifyEqual(testCase, actPP5B, expPP5B);
    verifyEqual(testCase, actPP6B, expPP6B);
    verifyEqual(testCase, actPP7B, expPP7B);
    verifyEqual(testCase, actPP8B, expPP8B);

    verifyEqual(testCase, actPP1C, expPP1C);
    verifyEqual(testCase, actPP2C, expPP2C);
    verifyEqual(testCase, actPP3C, expPP3C);
    verifyEqual(testCase, actPP4C, expPP4C);
    verifyEqual(testCase, actPP5C, expPP5C);
    verifyEqual(testCase, actPP6C, expPP6C);
    verifyEqual(testCase, actPP7C, expPP7C);
    verifyEqual(testCase, actPP8C, expPP8C);
end

function TestCreateSpace(testCase)
    spaceTransformationA = SpaceTransformation(@transformationFunction1);
    spaceTransformationB = SpaceTransformation(@transformationFunction2);
    spaceTransformationC = SpaceTransformation(@transformationFunction3);
    MP1 = MotorPoint([-5; -5]);
    MP2 = MotorPoint([-4; -4]);
    MP3 = MotorPoint([-3; -3]);
    MP4 = MotorPoint([-3; -4]);
    MP5 = MotorPoint([12; 15]);
    MP6 = MotorPoint([15; 16]);
    MP7 = MotorPoint([12; 14]);
    MP8 = MotorPoint([14; 16]);

    MotorPointListList = {{MP1; MP2; MP3; MP4}; {MP5; MP6; MP7; MP8}};

    spaceA = spaceTransformationA.CreateSpace(MotorPointListList, [0 50], 5);
    spaceB = spaceTransformationB.CreateSpace(MotorPointListList, [-20 50], 30);
    spaceC = spaceTransformationC.CreateSpace(MotorPointListList, [0 0], 4);

    actCluster1A_Motor = spaceA.Clusters{1,1}.MotorCoordinateMatrix;
    actCluster1A_Perceptual = spaceA.Clusters{1,1}.PerceptualCoordinateMatrix;
    actCluster2A_Motor = spaceA.Clusters{2,1}.MotorCoordinateMatrix;
    actCluster2A_Perceptual = spaceA.Clusters{2,1}.PerceptualCoordinateMatrix;

    actCluster1B_Motor = spaceB.Clusters{1,1}.MotorCoordinateMatrix;
    actCluster1B_Perceptual = spaceB.Clusters{1,1}.PerceptualCoordinateMatrix;
    actCluster2B_Motor = spaceB.Clusters{2,1}.MotorCoordinateMatrix;
    actCluster2B_Perceptual = spaceB.Clusters{2,1}.PerceptualCoordinateMatrix;

    actCluster1C_Motor = spaceC.Clusters{1,1}.MotorCoordinateMatrix;
    actCluster1C_Perceptual = spaceC.Clusters{1,1}.PerceptualCoordinateMatrix;
    actCluster2C_Motor = spaceC.Clusters{2,1}.MotorCoordinateMatrix;
    actCluster2C_Perceptual = spaceC.Clusters{2,1}.PerceptualCoordinateMatrix;

    expCluster1A_Motor = [-5 -4 -3 -3; -5 -4 -3 -4];
    expCluster1A_Perceptual = [-5 -4 -3 -3; -5 -4 -3 -4];
    expCluster2A_Motor = [12 15 12 14; 15 16 14 16];
    expCluster2A_Perceptual = [12 15 12 14; 15 16 14 16];

    expCluster1B_Motor = [-5 -4 -3 -3; -5 -4 -3 -4];
    expCluster1B_Perceptual = [15 14 13 13; 15 14 13 14];
    expCluster2B_Motor = [12 15 12 14; 15 16 14 16];
    expCluster2B_Perceptual = [-2 -5 -2 -4; -5 -6 -4 -6];

    expCluster1C_Motor = [-5 -4 -3 -3; -5 -4 -3 -4];
    expCluster1C_Perceptual = [-5 -4 -3 -3; -5 -4 -3 -4];
    expCluster2C_Motor = [12 15 12 14; 15 16 14 16];
    expCluster2C_Perceptual = [8 11 8 10; 15 16 14 16];

    verifyEqual(testCase, actCluster1A_Motor, expCluster1A_Motor);
    verifyEqual(testCase, actCluster1A_Perceptual, expCluster1A_Perceptual);
    verifyEqual(testCase, actCluster2A_Motor, expCluster2A_Motor);
    verifyEqual(testCase, actCluster2A_Perceptual, expCluster2A_Perceptual);

    verifyEqual(testCase, actCluster1B_Motor, expCluster1B_Motor);
    verifyEqual(testCase, actCluster1B_Perceptual, expCluster1B_Perceptual);
    verifyEqual(testCase, actCluster2B_Motor, expCluster2B_Motor);
    verifyEqual(testCase, actCluster2B_Perceptual, expCluster2B_Perceptual);

    verifyEqual(testCase, actCluster1C_Motor, expCluster1C_Motor);
    verifyEqual(testCase, actCluster1C_Perceptual, expCluster1C_Perceptual);
    verifyEqual(testCase, actCluster2C_Motor, expCluster2C_Motor);
    verifyEqual(testCase, actCluster2C_Perceptual, expCluster2C_Perceptual);
end

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

function PerceptualCoordinates = transformationFunction1(MotorCoordinates)
    PerceptualCoordinates = MotorCoordinates;
end

function PerceptualCoordinates = transformationFunction2(MotorCoordinates)
    PerceptualCoordinates = [10; 10] - MotorCoordinates;
end

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
