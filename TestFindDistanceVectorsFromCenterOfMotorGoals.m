%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function tests = TestFindDistanceVectorsFromCenterOfMotorGoals
    tests = functiontests(localfunctions);
end

function Test1(testCase)
    GoalList = {testCase.TestData.Goal1 testCase.TestData.Goal2};
    MotorTrajectoryList = {testCase.TestData.MotorTrajectory1 ...
        testCase.TestData.MotorTrajectory2};
    actMatrix = FindDistanceVectorsFromCenterOfMotorGoals(GoalList, MotorTrajectoryList);
%     Center of middle of goals: [4;2] [4;2] [2;4] [2;4] [4;2] [4;2] [2;4] [2;4]
%     MotorTrajectory1: [0; 0] [1; 1] [2; 2] [3; 3] [4; 4] [5; 5] [6; 6] [7; 7] [8; 8]
%     MotorTrajectory2: [0; 0] [1; 1] [2; 2] [3; 3]
%     MotorTrajectory3: [0; 5] [1; 6] [2; 8] [3; 7] [4; 5]
%     MotorTrajectory4: [10; 5] [10; 5] [10; 4] [10; 3] [10; 2]
    expMatrix = [4.47 4.47;
        3.16 3.16;
        2.00 2.00;
        1.41 1.41;
        2.00 0;
        3.16 0;
        4.47 0;
        5.83 0;
        7.21 0];
    verifyEqual(testCase, actMatrix, expMatrix, "AbsTol", 0.01);
end

function Test2(testCase)
    GoalList = {testCase.TestData.Goal6 ...
        testCase.TestData.Goal7 ...
        testCase.TestData.Goal8};
    MotorTrajectoryList = {testCase.TestData.MotorTrajectory3 ...
        testCase.TestData.MotorTrajectory3 ...
        testCase.TestData.MotorTrajectory4};
    actMatrix = FindDistanceVectorsFromCenterOfMotorGoals(GoalList, MotorTrajectoryList);
    expMatrix = [5.00 2.24 8.06;
        5.00 2.24 8.06;
        6.32 4.00 8.00;
        5.10 3.16 8.06;
        3.00 2.24 8.25];
    verifyEqual(testCase, actMatrix, expMatrix, "AbsTol", 0.01);
end

function Test3(testCase)
    GoalList = {testCase.TestData.Goal3 ...
        testCase.TestData.Goal4 ...
        testCase.TestData.Goal5 ...
        testCase.TestData.Goal6};
    MotorTrajectoryList = {testCase.TestData.MotorTrajectory1 ...
        testCase.TestData.MotorTrajectory2 ...
        testCase.TestData.MotorTrajectory3 ...
        testCase.TestData.MotorTrajectory4};
    actMatrix = FindDistanceVectorsFromCenterOfMotorGoals(GoalList, MotorTrajectoryList);
    expMatrix = [4.47 4.47 5.00 6.71;
        3.16 3.16 5.00 6.71;
        2.00 2.00 6.32 6.32;
        1.41 1.41 5.10 6.08;
        2.00 0 3.00	6.00;
        3.16 0 0 0;
        4.47 0 0 0;
        5.83 0 0 0;
        7.21 0 0 0];
    verifyEqual(testCase, actMatrix, expMatrix, "AbsTol", 0.01);
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
    testCase.TestData.ClusterList1 = MakeManySquareClusters(0, 0, 1, 3, 2, 2, testCase.TestData.spaceTransformation1);
    testCase.TestData.ClusterList2 = MakeManySquareClusters(0, 0, 1, 2, 2, 3, testCase.TestData.spaceTransformation2);
    testCase.TestData.space1 = Space(testCase.TestData.ClusterList1, testCase.TestData.spaceTransformation1, [0 10; 0 10], 10);
    testCase.TestData.space2 = Space(testCase.TestData.ClusterList2, testCase.TestData.spaceTransformation2, [0 10; 0 10], 10);
    testCase.TestData.Region1 = MotorRegionTemp(MotorPoint([8; 2]), 3);
    testCase.TestData.Region2 = MotorRegionTemp(MotorPoint([6; 2]), 3);
    testCase.TestData.Region3 = MotorRegionTemp(MotorPoint([4; 2]), 3);
    testCase.TestData.Region4 = MotorRegionTemp(MotorPoint([2; 2]), 3);
    testCase.TestData.Region5 = MotorRegionTemp(MotorPoint([2; 4]), 3);
    testCase.TestData.Region6 = MotorRegionTemp(MotorPoint([2; 6]), 3);
    testCase.TestData.Silhouette1 = MotorSilhouette({ ...
        testCase.TestData.Region1; testCase.TestData.Region2; ...
        testCase.TestData.Region3; testCase.TestData.Region4; ...
        testCase.TestData.Region5});
    testCase.TestData.Silhouette2 = MotorSilhouette({ ...
        testCase.TestData.Region4; ...
        testCase.TestData.Region5; ...
        testCase.TestData.Region6});
    testCase.TestData.Trajectory1 = ...
        PerceptualTrajectory({PerceptualPoint([8; 1]); ...
        PerceptualPoint([7; 1]); PerceptualPoint([6; 1]); ...
        PerceptualPoint([5; 1]); PerceptualPoint([4; 1]); ...
        PerceptualPoint([3; 1]); PerceptualPoint([2; 1]); ...
        PerceptualPoint([2; 2]); PerceptualPoint([2; 3]); ...
        PerceptualPoint([2; 4]); PerceptualPoint([2; 5])});
    testCase.TestData.Trajectory2 = ...
        PerceptualTrajectory({PerceptualPoint([8; 1]); ...
        PerceptualPoint([7; 1]); PerceptualPoint([6; 1]); ...
        PerceptualPoint([5; 1]); PerceptualPoint([4; 1]); ...
        PerceptualPoint([3; 1]); PerceptualPoint([2; 1]); ...
        PerceptualPoint([2; 2]); PerceptualPoint([2; 3]); ...
        PerceptualPoint([2; 4]); PerceptualPoint([2; 5])});
    testCase.TestData.Goal1 = Goal(testCase.TestData.space1, ...
        testCase.TestData.Silhouette1, testCase.TestData.Trajectory1);
    testCase.TestData.Goal2 = Goal(testCase.TestData.space1, ...
        testCase.TestData.Silhouette1, testCase.TestData.Trajectory2);
    testCase.TestData.Goal3 = Goal(testCase.TestData.space1, ...
        testCase.TestData.Silhouette2, testCase.TestData.Trajectory1);
    testCase.TestData.Goal4 = Goal(testCase.TestData.space1, ...
        testCase.TestData.Silhouette2, testCase.TestData.Trajectory2);
    testCase.TestData.Goal5 = Goal(testCase.TestData.space2, ...
        testCase.TestData.Silhouette1, testCase.TestData.Trajectory1);
    testCase.TestData.Goal6 = Goal(testCase.TestData.space2, ...
        testCase.TestData.Silhouette1, testCase.TestData.Trajectory2);
    testCase.TestData.Goal7 = Goal(testCase.TestData.space2, ...
        testCase.TestData.Silhouette2, testCase.TestData.Trajectory1);
    testCase.TestData.Goal8 = Goal(testCase.TestData.space2, ...
        testCase.TestData.Silhouette2, testCase.TestData.Trajectory2);
    testCase.TestData.MotorTrajectory1 = MotorTrajectory({MotorPoint([0; 0]); ...
        MotorPoint([1; 1]); MotorPoint([2; 2]); MotorPoint([3; 3]); MotorPoint([4; 4]); ...
        MotorPoint([5; 5]); MotorPoint([6; 6]); MotorPoint([7; 7]); MotorPoint([8; 8])});
    testCase.TestData.MotorTrajectory2 = MotorTrajectory({MotorPoint([0; 0]); ...
        MotorPoint([1; 1]); MotorPoint([2; 2]); MotorPoint([3; 3])});
    testCase.TestData.MotorTrajectory3 = MotorTrajectory({MotorPoint([0; 5]); ...
        MotorPoint([1; 6]); MotorPoint([2; 8]); MotorPoint([3; 7]); MotorPoint([4; 5])});
    testCase.TestData.MotorTrajectory4 = MotorTrajectory({MotorPoint([10; 5]); ...
        MotorPoint([10; 5]); MotorPoint([10; 4]); MotorPoint([10; 3]); MotorPoint([10; 2])});
end

function teardownOnce(testCase)
    cd(testCase.TestData.origPath)
    rmdir(testCase.TestData.tmpFolder)
end

function PerceptualCoordinates = transformationFunction1(MotorCoordinates)
    PerceptualCoordinates = MotorCoordinates;
end

function PerceptualCoordinates = transformationFunction2(MotorCoordinates)
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
