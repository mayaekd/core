%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function tests = TestComputeDistanceFromCenter
    tests = functiontests(localfunctions);
end

function TestMain(testCase)
    actDistance1 = ComputeDistanceFromCenter( ...
        testCase.TestData.Trajectory1, testCase.TestData.PseudoCenter1);
    actDistance2 = ComputeDistanceFromCenter( ...
        testCase.TestData.Trajectory1, testCase.TestData.PseudoCenter2);
    actDistance3 = ComputeDistanceFromCenter( ...
        testCase.TestData.Trajectory2, testCase.TestData.PseudoCenter1);
    actDistance4 = ComputeDistanceFromCenter( ...
        testCase.TestData.Trajectory2, testCase.TestData.PseudoCenter2);

    expDistance1 = 51.34;
    expDistance2 = 48.23;
    expDistance3 = 51.34;
    expDistance4 = 48.23;

    verifyEqual(testCase, actDistance1, expDistance1, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance2, expDistance2, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance3, expDistance3, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance4, expDistance4, "AbsTol", 0.01);
end



function setupOnce(testCase)
    % Create and change to temporary folder
    testCase.TestData.origPath = pwd;
    testCase.TestData.tmpFolder = "tmpFolder" + ...
        string(datetime('now','Format',"yyyyMMdd'T'HHmmss"));
    mkdir(testCase.TestData.tmpFolder)
    cd(testCase.TestData.tmpFolder)
    % Make variables
    testCase.TestData.PseudoCenter1 = [4; 6];
    testCase.TestData.PseudoCenter2 = [8; 2];
    testCase.TestData.Trajectory1 = ...
        MotorTrajectory({MotorPoint([8; 1]); ...
        MotorPoint([7; 1]); MotorPoint([6; 1]); ...
        MotorPoint([5; 1]); MotorPoint([4; 1]); ...
        MotorPoint([3; 1]); MotorPoint([2; 1]); ...
        MotorPoint([2; 2]); MotorPoint([2; 3]); ...
        MotorPoint([2; 4]); MotorPoint([2; 5])});
    testCase.TestData.Trajectory2 = ...
        PerceptualTrajectory({PerceptualPoint([8; 1]); ...
        PerceptualPoint([7; 1]); PerceptualPoint([6; 1]); ...
        PerceptualPoint([5; 1]); PerceptualPoint([4; 1]); ...
        PerceptualPoint([3; 1]); PerceptualPoint([2; 1]); ...
        PerceptualPoint([2; 2]); PerceptualPoint([2; 3]); ...
        PerceptualPoint([2; 4]); PerceptualPoint([2; 5])});
end

function teardownOnce(testCase)
    cd(testCase.TestData.origPath)
    rmdir(testCase.TestData.tmpFolder)
end
