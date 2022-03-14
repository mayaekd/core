%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function tests = TestPerceptualPoint
    tests = functiontests(localfunctions);
end

function TestCreateObject(testCase)
    PerceptualPoint1 = PerceptualPoint([43; 89]);
    actX = PerceptualPoint1.x;
    actY = PerceptualPoint1.y;
    actZ = PerceptualPoint1.z;
    actCoordinates = PerceptualPoint1.Coordinates;
    expX = 43;
    expY = 89;
    expZ = 0;
    expCoordinates = [43; 89];
    verifyEqual(testCase, actX, expX);
    verifyEqual(testCase, actY, expY);
    verifyEqual(testCase, actZ, expZ);
    verifyEqual(testCase, actCoordinates, expCoordinates);
end

function TestDistance(testCase)
    PerceptualPoint1 = PerceptualPoint([43; 89]);
    PerceptualPoint2 = PerceptualPoint([47; 92]);
    PerceptualPoint3 = PerceptualPoint([43; 95]);
    actDistance1 = PerceptualPoint1.Distance(PerceptualPoint1);
    actDistance2 = PerceptualPoint1.Distance(PerceptualPoint2);
    actDistance3 = PerceptualPoint1.Distance(PerceptualPoint3);
    actDistance4 = PerceptualPoint2.Distance(PerceptualPoint1);
    actDistance5 = PerceptualPoint2.Distance(PerceptualPoint2);
    actDistance6 = PerceptualPoint2.Distance(PerceptualPoint3);
    actDistance7 = PerceptualPoint3.Distance(PerceptualPoint1);
    actDistance8 = PerceptualPoint3.Distance(PerceptualPoint2);
    actDistance9 = PerceptualPoint3.Distance(PerceptualPoint3);
    expDistance1 = 0;
    expDistance2 = 5;
    expDistance3 = 6;
    expDistance4 = 5;
    expDistance5 = 0;
    expDistance6 = 5;
    expDistance7 = 6;
    expDistance8 = 5;
    expDistance9 = 0;
    verifyEqual(testCase, actDistance1, expDistance1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actDistance2, expDistance2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actDistance3, expDistance3, "AbsTol", 0.00000001);
    verifyEqual(testCase, actDistance4, expDistance4, "AbsTol", 0.00000001);
    verifyEqual(testCase, actDistance5, expDistance5, "AbsTol", 0.00000001);
    verifyEqual(testCase, actDistance6, expDistance6, "AbsTol", 0.00000001);
    verifyEqual(testCase, actDistance7, expDistance7, "AbsTol", 0.00000001);
    verifyEqual(testCase, actDistance8, expDistance8, "AbsTol", 0.00000001);
    verifyEqual(testCase, actDistance9, expDistance9, "AbsTol", 0.00000001);
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

