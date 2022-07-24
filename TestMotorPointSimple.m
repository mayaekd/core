%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS TESTED
%  MotorPoint
%  Distance
%  FindPerceptualPoint
%  MakeJuncture

%% TESTS

function tests = TestMotorPointSimple
    tests = functiontests(localfunctions);
end

function TestCreateObjectSimple(testCase)
    MotorPoint1 = MotorPoint([43; 89]);
    MotorPoint2 = MotorPoint([2; 3; 4], "zRowIndex", 3);
    MotorPoint3 = MotorPoint([32; 33; 34; 35; 36], "zRowIndex", 3);

    actX1 = MotorPoint1.x;
    actY1 = MotorPoint1.y;
    actZ1 = MotorPoint1.z;
    actCoordinates1 = MotorPoint1.Coordinates;

    actX2 = MotorPoint2.x;
    actY2 = MotorPoint2.y;
    actZ2 = MotorPoint2.z;
    actCoordinates2 = MotorPoint2.Coordinates;

    actX3 = MotorPoint3.x;
    actY3 = MotorPoint3.y;
    actZ3 = MotorPoint3.z;
    actCoordinates3 = MotorPoint3.Coordinates;
    
    expX1 = 43;
    expY1 = 89;
    expZ1 = NaN;
    expCoordinates1 = [43; 89];

    expX2 = 2;
    expY2 = 3;
    expZ2 = 4;
    expCoordinates2 = [2; 3; 4];

    expX3 = 32;
    expY3 = 33;
    expZ3 = 34;
    expCoordinates3 = [32; 33; 34; 35; 36];

    verifyEqual(testCase, actX1, expX1);
    verifyEqual(testCase, actY1, expY1);
    verifyEqual(testCase, actZ1, expZ1);
    verifyEqual(testCase, actCoordinates1, expCoordinates1);

    verifyEqual(testCase, actX2, expX2);
    verifyEqual(testCase, actY2, expY2);
    verifyEqual(testCase, actZ2, expZ2);
    verifyEqual(testCase, actCoordinates2, expCoordinates2);

    verifyEqual(testCase, actX3, expX3);
    verifyEqual(testCase, actY3, expY3);
    verifyEqual(testCase, actZ3, expZ3);
    verifyEqual(testCase, actCoordinates3, expCoordinates3);
end

function TestDistanceSimple(testCase)
    MotorPoint1 = MotorPoint([43; 89]);
    MotorPoint2 = MotorPoint([47; 92]);
    MotorPoint3 = MotorPoint([43; 95]);

    MotorPoint4 = MotorPoint([10; 8; 9; 5]);
    MotorPoint5 = MotorPoint([14; 10; 11; 6]);
    MotorPoint6 = MotorPoint([14; 12; 14; 12]);

    actDistance1 = MotorPoint1.Distance(MotorPoint1);
    actDistance2 = MotorPoint1.Distance(MotorPoint2);
    actDistance3 = MotorPoint1.Distance(MotorPoint3);
    actDistance4 = MotorPoint2.Distance(MotorPoint1);
    actDistance5 = MotorPoint2.Distance(MotorPoint2);
    actDistance6 = MotorPoint2.Distance(MotorPoint3);
    actDistance7 = MotorPoint3.Distance(MotorPoint1);
    actDistance8 = MotorPoint3.Distance(MotorPoint2);
    actDistance9 = MotorPoint3.Distance(MotorPoint3);

    actDistance10 = MotorPoint4.Distance(MotorPoint5);
    actDistance11 = MotorPoint5.Distance(MotorPoint6);

    expDistance1 = 0;
    expDistance2 = 5;
    expDistance3 = 6;
    expDistance4 = 5;
    expDistance5 = 0;
    expDistance6 = 5;
    expDistance7 = 6;
    expDistance8 = 5;
    expDistance9 = 0;

    expDistance10 = 5;
    expDistance11 = 7;

    verifyEqual(testCase, actDistance1, expDistance1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actDistance2, expDistance2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actDistance3, expDistance3, "AbsTol", 0.00000001);
    verifyEqual(testCase, actDistance4, expDistance4, "AbsTol", 0.00000001);
    verifyEqual(testCase, actDistance5, expDistance5, "AbsTol", 0.00000001);
    verifyEqual(testCase, actDistance6, expDistance6, "AbsTol", 0.00000001);
    verifyEqual(testCase, actDistance7, expDistance7, "AbsTol", 0.00000001);
    verifyEqual(testCase, actDistance8, expDistance8, "AbsTol", 0.00000001);
    verifyEqual(testCase, actDistance9, expDistance9, "AbsTol", 0.00000001);
    verifyEqual(testCase, actDistance10, expDistance10, "AbsTol", 0.00000001);
    verifyEqual(testCase, actDistance11, expDistance11, "AbsTol", 0.00000001);
end

function TestFindPerceptualPointSimple(testCase)
    MotorPoint1 = MotorPoint([43; 89]);
    MotorPoint2 = MotorPoint([47; 92]);
    MotorPoint3 = MotorPoint([43; 95]);
    MotorPoint4 = MotorPoint([32; 33; 34; 35; 36]);
    MotorPoint5 = MotorPoint([10; 8; 9; 5]);

    PerceptualPoint1 = MotorPoint1.FindPerceptualPoint(testCase.TestData.spaceTransformation1);
    PerceptualPoint2 = MotorPoint1.FindPerceptualPoint(testCase.TestData.spaceTransformation2);
    PerceptualPoint3 = MotorPoint1.FindPerceptualPoint(testCase.TestData.spaceTransformation3);
    PerceptualPoint4 = MotorPoint1.FindPerceptualPoint(testCase.TestData.spaceTransformation4);
    PerceptualPoint5 = MotorPoint2.FindPerceptualPoint(testCase.TestData.spaceTransformation1);
    PerceptualPoint6 = MotorPoint2.FindPerceptualPoint(testCase.TestData.spaceTransformation2);
    PerceptualPoint7 = MotorPoint2.FindPerceptualPoint(testCase.TestData.spaceTransformation3);
    PerceptualPoint8 = MotorPoint2.FindPerceptualPoint(testCase.TestData.spaceTransformation4);
    PerceptualPoint9 = MotorPoint3.FindPerceptualPoint(testCase.TestData.spaceTransformation1);
    PerceptualPoint10 = MotorPoint3.FindPerceptualPoint(testCase.TestData.spaceTransformation2);
    PerceptualPoint11 = MotorPoint3.FindPerceptualPoint(testCase.TestData.spaceTransformation3);
    PerceptualPoint12 = MotorPoint3.FindPerceptualPoint(testCase.TestData.spaceTransformation4);
    PerceptualPoint13 = MotorPoint4.FindPerceptualPoint(testCase.TestData.spaceTransformation1);
    PerceptualPoint14 = MotorPoint5.FindPerceptualPoint(testCase.TestData.spaceTransformation1);
    PerceptualPoint15 = MotorPoint4.FindPerceptualPoint(testCase.TestData.spaceTransformation5);
    PerceptualPoint16 = MotorPoint5.FindPerceptualPoint(testCase.TestData.spaceTransformation5);

    actCoordinates1 = PerceptualPoint1.Coordinates;
    actCoordinates2 = PerceptualPoint2.Coordinates;
    actCoordinates3 = PerceptualPoint3.Coordinates;
    actCoordinates4 = PerceptualPoint4.Coordinates;
    actCoordinates5 = PerceptualPoint5.Coordinates;
    actCoordinates6 = PerceptualPoint6.Coordinates;
    actCoordinates7 = PerceptualPoint7.Coordinates;
    actCoordinates8 = PerceptualPoint8.Coordinates;
    actCoordinates9 = PerceptualPoint9.Coordinates;
    actCoordinates10 = PerceptualPoint10.Coordinates;
    actCoordinates11 = PerceptualPoint11.Coordinates;
    actCoordinates12 = PerceptualPoint12.Coordinates;
    actCoordinates13 = PerceptualPoint13.Coordinates;
    actCoordinates14 = PerceptualPoint14.Coordinates;
    actCoordinates15 = PerceptualPoint15.Coordinates;
    actCoordinates16 = PerceptualPoint16.Coordinates;

    expCoordinates1 = [43; 89];
    expCoordinates2 = [143; 489];
    expCoordinates3 = [1; 2];
    expCoordinates4 = [43; 89];
    expCoordinates5 = [47; 92];
    expCoordinates6 = [147; 492];
    expCoordinates7 = [1; 2];
    expCoordinates8 = [3; 92];
    expCoordinates9 = [43; 95];
    expCoordinates10 = [143; 495];
    expCoordinates11 = [1; 2];
    expCoordinates12 = [7; 95];
    expCoordinates13 = [32; 33; 34; 35; 36];
    expCoordinates14 = [10; 8; 9; 5];
    expCoordinates15 = [42; 43; 44; 45; 46];
    expCoordinates16 = [20; 18; 19; 15];

    verifyEqual(testCase, actCoordinates1, expCoordinates1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates2, expCoordinates2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates3, expCoordinates3, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates4, expCoordinates4, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates5, expCoordinates5, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates6, expCoordinates6, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates7, expCoordinates7, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates8, expCoordinates8, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates9, expCoordinates9, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates10, expCoordinates10, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates11, expCoordinates11, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates12, expCoordinates12, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates13, expCoordinates13, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates14, expCoordinates14, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates15, expCoordinates15, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates16, expCoordinates16, "AbsTol", 0.00000001);
end

function TestMakeJunctureSimple(testCase)
    MotorPoint1 = MotorPoint([43; 89]);
    MotorPoint2 = MotorPoint([47; 92]);
    MotorPoint3 = MotorPoint([43; 95]);
    MotorPoint4 = MotorPoint([32; 33; 34; 35; 36]);
    MotorPoint5 = MotorPoint([10; 8; 9; 5]);

    Juncture1 = MotorPoint1.MakeJuncture(testCase.TestData.spaceTransformation1);
    Juncture2 = MotorPoint1.MakeJuncture(testCase.TestData.spaceTransformation2);
    Juncture3 = MotorPoint1.MakeJuncture(testCase.TestData.spaceTransformation3);
    Juncture4 = MotorPoint1.MakeJuncture(testCase.TestData.spaceTransformation4);
    Juncture5 = MotorPoint2.MakeJuncture(testCase.TestData.spaceTransformation1);
    Juncture6 = MotorPoint2.MakeJuncture(testCase.TestData.spaceTransformation2);
    Juncture7 = MotorPoint2.MakeJuncture(testCase.TestData.spaceTransformation3);
    Juncture8 = MotorPoint2.MakeJuncture(testCase.TestData.spaceTransformation4);
    Juncture9 = MotorPoint3.MakeJuncture(testCase.TestData.spaceTransformation1);
    Juncture10 = MotorPoint3.MakeJuncture(testCase.TestData.spaceTransformation2);
    Juncture11 = MotorPoint3.MakeJuncture(testCase.TestData.spaceTransformation3);
    Juncture12 = MotorPoint3.MakeJuncture(testCase.TestData.spaceTransformation4);
    Juncture13 = MotorPoint4.MakeJuncture(testCase.TestData.spaceTransformation1);
    Juncture14 = MotorPoint5.MakeJuncture(testCase.TestData.spaceTransformation1);
    Juncture15 = MotorPoint4.MakeJuncture(testCase.TestData.spaceTransformation5);
    Juncture16 = MotorPoint5.MakeJuncture(testCase.TestData.spaceTransformation5);
    
    actCoordinates1_M = Juncture1.MotorPoint.Coordinates;
    actCoordinates2_M = Juncture2.MotorPoint.Coordinates;
    actCoordinates3_M = Juncture3.MotorPoint.Coordinates;
    actCoordinates4_M = Juncture4.MotorPoint.Coordinates;
    actCoordinates5_M = Juncture5.MotorPoint.Coordinates;
    actCoordinates6_M = Juncture6.MotorPoint.Coordinates;
    actCoordinates7_M = Juncture7.MotorPoint.Coordinates;
    actCoordinates8_M = Juncture8.MotorPoint.Coordinates;
    actCoordinates9_M = Juncture9.MotorPoint.Coordinates;
    actCoordinates10_M = Juncture10.MotorPoint.Coordinates;
    actCoordinates11_M = Juncture11.MotorPoint.Coordinates;
    actCoordinates12_M = Juncture12.MotorPoint.Coordinates;
    actCoordinates13_M = Juncture13.MotorPoint.Coordinates;
    actCoordinates14_M = Juncture14.MotorPoint.Coordinates;
    actCoordinates15_M = Juncture15.MotorPoint.Coordinates;
    actCoordinates16_M = Juncture16.MotorPoint.Coordinates;

    actCoordinates1_P = Juncture1.PerceptualPoint.Coordinates;
    actCoordinates2_P = Juncture2.PerceptualPoint.Coordinates;
    actCoordinates3_P = Juncture3.PerceptualPoint.Coordinates;
    actCoordinates4_P = Juncture4.PerceptualPoint.Coordinates;
    actCoordinates5_P = Juncture5.PerceptualPoint.Coordinates;
    actCoordinates6_P = Juncture6.PerceptualPoint.Coordinates;
    actCoordinates7_P = Juncture7.PerceptualPoint.Coordinates;
    actCoordinates8_P = Juncture8.PerceptualPoint.Coordinates;
    actCoordinates9_P = Juncture9.PerceptualPoint.Coordinates;
    actCoordinates10_P = Juncture10.PerceptualPoint.Coordinates;
    actCoordinates11_P = Juncture11.PerceptualPoint.Coordinates;
    actCoordinates12_P = Juncture12.PerceptualPoint.Coordinates;
    actCoordinates13_P = Juncture13.PerceptualPoint.Coordinates;
    actCoordinates14_P = Juncture14.PerceptualPoint.Coordinates;
    actCoordinates15_P = Juncture15.PerceptualPoint.Coordinates;
    actCoordinates16_P = Juncture16.PerceptualPoint.Coordinates;
    
    expCoordinates1_M = [43; 89];
    expCoordinates2_M = [43; 89];
    expCoordinates3_M = [43; 89];
    expCoordinates4_M = [43; 89];
    expCoordinates5_M = [47; 92];
    expCoordinates6_M = [47; 92];
    expCoordinates7_M = [47; 92];
    expCoordinates8_M = [47; 92];
    expCoordinates9_M = [43; 95];
    expCoordinates10_M = [43; 95];
    expCoordinates11_M = [43; 95];
    expCoordinates12_M = [43; 95];
    expCoordinates13_M = [32; 33; 34; 35; 36];
    expCoordinates14_M = [10; 8; 9; 5];
    expCoordinates15_M = [32; 33; 34; 35; 36];
    expCoordinates16_M = [10; 8; 9; 5];

    expCoordinates1_P = [43; 89];
    expCoordinates2_P = [143; 489];
    expCoordinates3_P = [1; 2];
    expCoordinates4_P = [43; 89];
    expCoordinates5_P = [47; 92];
    expCoordinates6_P = [147; 492];
    expCoordinates7_P = [1; 2];
    expCoordinates8_P = [3; 92];
    expCoordinates9_P = [43; 95];
    expCoordinates10_P = [143; 495];
    expCoordinates11_P = [1; 2];
    expCoordinates12_P = [7; 95];
    expCoordinates13_P = [32; 33; 34; 35; 36];
    expCoordinates14_P = [10; 8; 9; 5];
    expCoordinates15_P = [42; 43; 44; 45; 46];
    expCoordinates16_P = [20; 18; 19; 15];

    verifyEqual(testCase, actCoordinates1_M, expCoordinates1_M, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates2_M, expCoordinates2_M, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates3_M, expCoordinates3_M, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates4_M, expCoordinates4_M, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates5_M, expCoordinates5_M, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates6_M, expCoordinates6_M, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates7_M, expCoordinates7_M, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates8_M, expCoordinates8_M, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates9_M, expCoordinates9_M, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates10_M, expCoordinates10_M, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates11_M, expCoordinates11_M, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates12_M, expCoordinates12_M, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates13_M, expCoordinates13_M, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates14_M, expCoordinates14_M, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates15_M, expCoordinates15_M, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates16_M, expCoordinates16_M, "AbsTol", 0.00000001);
    
    verifyEqual(testCase, actCoordinates1_P, expCoordinates1_P, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates2_P, expCoordinates2_P, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates3_P, expCoordinates3_P, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates4_P, expCoordinates4_P, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates5_P, expCoordinates5_P, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates6_P, expCoordinates6_P, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates7_P, expCoordinates7_P, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates8_P, expCoordinates8_P, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates9_P, expCoordinates9_P, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates10_P, expCoordinates10_P, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates11_P, expCoordinates11_P, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates12_P, expCoordinates12_P, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates13_P, expCoordinates13_P, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates14_P, expCoordinates14_P, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates15_P, expCoordinates15_P, "AbsTol", 0.00000001);
    verifyEqual(testCase, actCoordinates16_P, expCoordinates16_P, "AbsTol", 0.00000001);
end

function setupOnce(testCase)
    % Create and change to temporary folder
    testCase.TestData.origPath = pwd;
    testCase.TestData.tmpFolder = "tmpFolder" + ...
        string(datetime('now','Format',"yyyyMMdd'T'HHmmss"));
    mkdir(testCase.TestData.tmpFolder)
    cd(testCase.TestData.tmpFolder)
    % Make and save variables
    testCase.TestData.spaceTransformation1 = SpaceTransformation(@transformationFunction1);
    testCase.TestData.spaceTransformation2 = SpaceTransformation(@transformationFunction2);
    testCase.TestData.spaceTransformation3 = SpaceTransformation(@transformationFunction3);
    testCase.TestData.spaceTransformation4 = SpaceTransformation(@transformationFunction4);
    testCase.TestData.spaceTransformation5 = SpaceTransformation(@transformationFunction5);
end

function teardownOnce(testCase)
    cd(testCase.TestData.origPath)
    rmdir(testCase.TestData.tmpFolder)
end

function PerceptualCoordinates = transformationFunction1(MotorCoordinates)
    PerceptualCoordinates = MotorCoordinates;
end

function PerceptualCoordinates = transformationFunction2(MotorCoordinates)
    PerceptualCoordinates = MotorCoordinates + [100; 400];
end

function PerceptualCoordinates = transformationFunction3(MotorCoordinates)
    PerceptualCoordinates = 0 * MotorCoordinates + [1; 2];
end

function PerceptualCoordinates = transformationFunction4(MotorCoordinates)
    MX = MotorCoordinates(1,1);
    MY = MotorCoordinates(2,1);
    if MY < 90
        PX = MX;
        PY = MY;
    else
        PX = 50 - MX;
        PY = MY;
    end
    PerceptualCoordinates = [PX; PY];
end

function PerceptualCoordinates = transformationFunction5(MotorCoordinates)
    PerceptualCoordinates = MotorCoordinates + 10;
end

