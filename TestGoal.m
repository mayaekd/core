%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function tests = TestGoal
    tests = functiontests(localfunctions);
end

function TestCreateObject(testCase)
    verifyEqual(testCase, 0, 1);
end

function TestAtoA_Default(testCase)
    verifyEqual(testCase, 0, 1);
end

function TestAtoA_CappedAtOne(testCase)
    verifyEqual(testCase, 0, 1);
end

function TestAtoA_FractionOfMax(testCase)
    verifyEqual(testCase, 0, 1);
end

function TestAtoA_RootFractionOfMax(testCase)
    verifyEqual(testCase, 0, 1);
end

function TestActivations_DefaultFromTraj(testCase)
    verifyEqual(testCase, 0, 1);
end

function TestTempActivations(testCase)
    verifyEqual(testCase, 0, 1);
end

function TestActivationVector(testCase)
    verifyEqual(testCase, 0, 1);
end

function TestActivations_SumFromTraj(testCase)
    verifyEqual(testCase, 0, 1);
end

function TestSpreadActivationsInMotorSpace(testCase)
    verifyEqual(testCase, 0, 1);
end

function TestSpreadActivationsInPerceptualSpace(testCase)
    verifyEqual(testCase, 0, 1);
end

function TestMotorDistanceSpreadToActivation(testCase)
    verifyEqual(testCase, 0, 1);
end

function TestPerceptualDistanceSpreadToActivation(testCase)
    verifyEqual(testCase, 0, 1);
end

function TestSimpleMacroEstimates(testCase)
    verifyEqual(testCase, 0, 1);
end

function TestSimpleMacroEstimatesWithAdjustments(testCase)
    verifyEqual(testCase, 0, 1);
end

% function TestPauseFunction(testCase)
%     verifyEqual(testCase, 0, 1);
% end

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
    testCase.TestData.Juncture1aTransf1 = MotorPoint([0; 0]).MakeJuncture(testCase.TestData.spaceTransformation1);
    testCase.TestData.Juncture1bTransf1 = MotorPoint([2; 0]).MakeJuncture(testCase.TestData.spaceTransformation1);
    testCase.TestData.Juncture1cTransf1 = MotorPoint([0; 2]).MakeJuncture(testCase.TestData.spaceTransformation1);
    testCase.TestData.Juncture1dTransf1 = MotorPoint([2; 2]).MakeJuncture(testCase.TestData.spaceTransformation1);
    testCase.TestData.Juncture2aTransf1 = MotorPoint([0; 6]).MakeJuncture(testCase.TestData.spaceTransformation1);
    testCase.TestData.Juncture2bTransf1 = MotorPoint([2; 6]).MakeJuncture(testCase.TestData.spaceTransformation1);
    testCase.TestData.Juncture2cTransf1 = MotorPoint([0; 8]).MakeJuncture(testCase.TestData.spaceTransformation1);
    testCase.TestData.Juncture2dTransf1 = MotorPoint([2; 8]).MakeJuncture(testCase.TestData.spaceTransformation1);
    testCase.TestData.Juncture3aTransf1 = MotorPoint([6; 0]).MakeJuncture(testCase.TestData.spaceTransformation1);
    testCase.TestData.Juncture3bTransf1 = MotorPoint([8; 0]).MakeJuncture(testCase.TestData.spaceTransformation1);
    testCase.TestData.Juncture3cTransf1 = MotorPoint([6; 2]).MakeJuncture(testCase.TestData.spaceTransformation1);
    testCase.TestData.Juncture3dTransf1 = MotorPoint([8; 2]).MakeJuncture(testCase.TestData.spaceTransformation1);
    testCase.TestData.Juncture1aTransf2 = MotorPoint([0; 0]).MakeJuncture(testCase.TestData.spaceTransformation2);
    testCase.TestData.Juncture1bTransf2 = MotorPoint([2; 0]).MakeJuncture(testCase.TestData.spaceTransformation2);
    testCase.TestData.Juncture1cTransf2 = MotorPoint([0; 2]).MakeJuncture(testCase.TestData.spaceTransformation2);
    testCase.TestData.Juncture1dTransf2 = MotorPoint([2; 2]).MakeJuncture(testCase.TestData.spaceTransformation2);
    testCase.TestData.Juncture2aTransf2 = MotorPoint([0; 6]).MakeJuncture(testCase.TestData.spaceTransformation2);
    testCase.TestData.Juncture2bTransf2 = MotorPoint([2; 6]).MakeJuncture(testCase.TestData.spaceTransformation2);
    testCase.TestData.Juncture2cTransf2 = MotorPoint([0; 8]).MakeJuncture(testCase.TestData.spaceTransformation2);
    testCase.TestData.Juncture2dTransf2 = MotorPoint([2; 8]).MakeJuncture(testCase.TestData.spaceTransformation2);
    testCase.TestData.Juncture3aTransf2 = MotorPoint([6; 0]).MakeJuncture(testCase.TestData.spaceTransformation2);
    testCase.TestData.Juncture3bTransf2 = MotorPoint([8; 0]).MakeJuncture(testCase.TestData.spaceTransformation2);
    testCase.TestData.Juncture3cTransf2 = MotorPoint([6; 2]).MakeJuncture(testCase.TestData.spaceTransformation2);
    testCase.TestData.Juncture3dTransf2 = MotorPoint([8; 2]).MakeJuncture(testCase.TestData.spaceTransformation2);
    testCase.TestData.Cluster1Transf1 = Cluster({testCase.TestData.Juncture1aTransf1; testCase.TestData.Juncture1bTransf1; 
        testCase.TestData.Juncture1cTransf1; testCase.TestData.Juncture1dTransf1});
    testCase.TestData.Cluster2Transf1 = Cluster({testCase.TestData.Juncture2aTransf1; testCase.TestData.Juncture2bTransf1; 
        testCase.TestData.Juncture2cTransf1; testCase.TestData.Juncture2dTransf1});
    testCase.TestData.Cluster3Transf1 = Cluster({testCase.TestData.Juncture3aTransf1; testCase.TestData.Juncture3bTransf1; 
        testCase.TestData.Juncture3cTransf1; testCase.TestData.Juncture3dTransf1});
    testCase.TestData.Cluster1Transf2 = Cluster({testCase.TestData.Juncture1aTransf2; testCase.TestData.Juncture1bTransf2; 
        testCase.TestData.Juncture1cTransf2; testCase.TestData.Juncture1dTransf2});
    testCase.TestData.Cluster2Transf2 = Cluster({testCase.TestData.Juncture2aTransf2; testCase.TestData.Juncture2bTransf2; 
        testCase.TestData.Juncture2cTransf2; testCase.TestData.Juncture2dTransf2});
    testCase.TestData.Cluster3Transf2 = Cluster({testCase.TestData.Juncture3aTransf2; testCase.TestData.Juncture3bTransf2; 
        testCase.TestData.Juncture3cTransf2; testCase.TestData.Juncture3dTransf2});
    testCase.TestData.Region1 = MotorRegionTemp(MotorPoint([8; 2]), 3);
    testCase.TestData.Region2 = MotorRegionTemp(MotorPoint([6; 2]), 3);
    testCase.TestData.Region3 = MotorRegionTemp(MotorPoint([4; 2]), 3);
    testCase.TestData.Region4 = MotorRegionTemp(MotorPoint([2; 2]), 3);
    testCase.TestData.Region5 = MotorRegionTemp(MotorPoint([2; 4]), 3);
    testCase.TestData.Region6 = MotorRegionTemp(MotorPoint([2; 6]), 3);
    testCase.TestData.Silhouette1 = MotorSilhouette({ ...
        testCase.TestData.Region1; testCase.TestData.Region2; ...
        testCase.TestData.Region3; testCase.TestData.Region4; ...
        testCase.TestData.Region5; testCase.TestData.Region6});
    testCase.TestData.Trajectory1 = ...
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
