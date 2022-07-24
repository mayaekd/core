%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS TESTED
%  PerceptualPoint
%  Distance

%% TESTS

function tests = TestPerceptualPointSimple
    tests = functiontests(localfunctions);
end

function TestCreateObjectSimple(testCase)
    PerceptualPoint1 = PerceptualPoint([43; 89]);
    PerceptualPoint2 = PerceptualPoint([43; 89; 121; 145; 200], "zRowIndex", 3);

    actX1 = PerceptualPoint1.x;
    actY1 = PerceptualPoint1.y;
    actZ1 = PerceptualPoint1.z;
    actCoordinates1 = PerceptualPoint1.Coordinates;

    actX2 = PerceptualPoint2.x;
    actY2 = PerceptualPoint2.y;
    actZ2 = PerceptualPoint2.z;
    actCoordinates2 = PerceptualPoint2.Coordinates;

    expX1 = 43;
    expY1 = 89;
    expZ1 = NaN;
    expCoordinates1 = [43; 89];

    expX2 = 43;
    expY2 = 89;
    expZ2 = 121;
    expCoordinates2 = [43; 89; 121; 145; 200];

    verifyEqual(testCase, actX1, expX1);
    verifyEqual(testCase, actY1, expY1);
    verifyEqual(testCase, actZ1, expZ1);
    verifyEqual(testCase, actCoordinates1, expCoordinates1);

    verifyEqual(testCase, actX2, expX2);
    verifyEqual(testCase, actY2, expY2);
    verifyEqual(testCase, actZ2, expZ2);
    verifyEqual(testCase, actCoordinates2, expCoordinates2);
end

function TestDistanceSimple(testCase)
    PerceptualPoint1 = PerceptualPoint([43; 89]);
    PerceptualPoint2 = PerceptualPoint([47; 92]);
    PerceptualPoint3 = PerceptualPoint([43; 95]);
    PerceptualPoint4 = PerceptualPoint([100; 101; 102; 103; 104]);
    PerceptualPoint5 = PerceptualPoint([101; 103; 110; 109; 108]);

    actDistance1 = PerceptualPoint1.Distance(PerceptualPoint1);
    actDistance2 = PerceptualPoint1.Distance(PerceptualPoint2);
    actDistance3 = PerceptualPoint1.Distance(PerceptualPoint3);
    actDistance4 = PerceptualPoint2.Distance(PerceptualPoint1);
    actDistance5 = PerceptualPoint2.Distance(PerceptualPoint2);
    actDistance6 = PerceptualPoint2.Distance(PerceptualPoint3);
    actDistance7 = PerceptualPoint3.Distance(PerceptualPoint1);
    actDistance8 = PerceptualPoint3.Distance(PerceptualPoint2);
    actDistance9 = PerceptualPoint3.Distance(PerceptualPoint3);
    actDistance10 = PerceptualPoint4.Distance(PerceptualPoint5);

    expDistance1 = 0;
    expDistance2 = 5;
    expDistance3 = 6;
    expDistance4 = 5;
    expDistance5 = 0;
    expDistance6 = 5;
    expDistance7 = 6;
    expDistance8 = 5;
    expDistance9 = 0;
    expDistance10 = 11;

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

