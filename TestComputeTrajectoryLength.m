%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function tests = TestComputeTrajectoryLength
    tests = functiontests(localfunctions);
end

function TestFindActivation(testCase)
    actDistance1 = ComputeTrajectoryLength(testCase.TestData.Trajectory1);
    actDistance2 = ComputeTrajectoryLength(testCase.TestData.Trajectory2);
    actDistance3 = ComputeTrajectoryLength(testCase.TestData.Trajectory3);
    actDistance4 = ComputeTrajectoryLength(testCase.TestData.Trajectory4);

    expDistance1 = 10;
    expDistance2 = 10;
    expDistance3 = 35;
    expDistance4 = 35;

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
    testCase.TestData.Trajectory3 = ...
        MotorTrajectory({MotorPoint([40; 30]); ...
        MotorPoint([43; 34]); MotorPoint([43; 64])});
    testCase.TestData.Trajectory4 = ...
        PerceptualTrajectory({PerceptualPoint([40; 30]); ...
        PerceptualPoint([43; 34]); PerceptualPoint([43; 64])});
end

function teardownOnce(testCase)
    cd(testCase.TestData.origPath)
    rmdir(testCase.TestData.tmpFolder)
end
