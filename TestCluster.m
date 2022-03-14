%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function tests = TestCluster
    tests = functiontests(localfunctions);
end

function TestCreateObject(testCase)
    j1 = Juncture(MotorPoint([86; 4]), PerceptualPoint([3; 40]));
    j2 = Juncture(MotorPoint([1; 2]), PerceptualPoint([3; 4]));
    j3 = Juncture(MotorPoint([10; 12]), PerceptualPoint([400; 25]));
    Cluster1 = Cluster({j1; j2; j3});
    actCoord1 = Cluster1.Junctures{1,1}.MotorPoint.Coordinates;
    actCoord2 = Cluster1.Junctures{2,1}.PerceptualPoint.Coordinates;
    actCoord3= Cluster1.Junctures{3,1}.MotorPoint.Coordinates;
    expCoord1 = [86; 4];
    expCoord2 = [3; 4];
    expCoord3 = [10; 12];
    verifyEqual(testCase, actCoord1, expCoord1);
    verifyEqual(testCase, actCoord2, expCoord2);
    verifyEqual(testCase, actCoord3, expCoord3);
end

function TestFindActivation(testCase)
    actActivation1 = ...
        testCase.TestData.Cluster3Transf1.FindActivation( ...
        testCase.TestData.Silhouette1, 1, testCase.TestData.Trajectory1, ...
        1, 0.1);
    actActivation2 = ...
        testCase.TestData.Cluster3Transf1.FindActivation( ...
        testCase.TestData.Silhouette1, 2, testCase.TestData.Trajectory1, ...
        1, 0.1);
    actActivation3 = ...
        testCase.TestData.Cluster3Transf1.FindActivation( ...
        testCase.TestData.Silhouette1, 1, testCase.TestData.Trajectory1, ...
        0.8, 0.2);
    actActivation4 = ...
        testCase.TestData.Cluster1Transf1.FindActivation( ...
        testCase.TestData.Silhouette1, 4, testCase.TestData.Trajectory1, ...
        1, 0.5);
    actActivation5 = ...
        testCase.TestData.Cluster2Transf1.FindActivation( ...
        testCase.TestData.Silhouette1, 5, testCase.TestData.Trajectory1, ...
        1, 0.5);

    expActivation1 = 1;
    expActivation2 = 1;
    expActivation3 = 0.8944;
    expActivation4 = 0.5809;
    expActivation5 = 0;

    verifyEqual(testCase, actActivation1, expActivation1);
    verifyEqual(testCase, actActivation2, expActivation2);
    verifyEqual(testCase, actActivation3, expActivation3, "AbsTol", 0.01);
    verifyEqual(testCase, actActivation4, expActivation4, "AbsTol", 0.01);
    verifyEqual(testCase, actActivation5, expActivation5);

end

function TestFindSilhouetteActivation(testCase)
    actActivation1 = ...
        testCase.TestData.Cluster3Transf1.FindSilhouetteActivation( ...
        testCase.TestData.Silhouette1, 1, 1, 0.1);
    actActivation2 = ...
        testCase.TestData.Cluster3Transf1.FindSilhouetteActivation( ...
        testCase.TestData.Silhouette1, 2, 1, 0.1);
    actActivation3 = ...
        testCase.TestData.Cluster3Transf1.FindSilhouetteActivation( ...
        testCase.TestData.Silhouette1, 1, 0.8, 0.2);
    actActivation4 = ...
        testCase.TestData.Cluster1Transf1.FindSilhouetteActivation( ...
        testCase.TestData.Silhouette1, 4, 1, 0.5);
    actActivation5 = ...
        testCase.TestData.Cluster2Transf1.FindSilhouetteActivation( ...
        testCase.TestData.Silhouette1, 5, 1, 0.5);
    expActivation1 = 1;
    expActivation2 = 1;
    expActivation3 = 0.8;
    expActivation4 = 1;
    expActivation5 = 0.69;
    verifyEqual(testCase, actActivation1, expActivation1);
    verifyEqual(testCase, actActivation2, expActivation2);
    verifyEqual(testCase, actActivation3, expActivation3);
    verifyEqual(testCase, actActivation4, expActivation4);
    verifyEqual(testCase, actActivation5, expActivation5, "AbsTol", 0.01);
end

function TestFindTrajectoryActivationAverage(testCase)
    actActivation1 = ...
        testCase.TestData.Cluster1Transf1.FindTrajectoryActivationAverage( ...
        testCase.TestData.Trajectory1, 1, 0.1);
    actActivation2 = ...
        testCase.TestData.Cluster2Transf1.FindTrajectoryActivationAverage( ...
        testCase.TestData.Trajectory1, 1, 0.1);
    actActivation3 = ...
        testCase.TestData.Cluster3Transf1.FindTrajectoryActivationAverage( ...
        testCase.TestData.Trajectory1, 1, 0.1);
    actActivation4 = ...
        testCase.TestData.Cluster1Transf1.FindTrajectoryActivationAverage( ...
        testCase.TestData.Trajectory1, 1, 0.5);
    actActivation5 = ...
        testCase.TestData.Cluster2Transf1.FindTrajectoryActivationAverage( ...
        testCase.TestData.Trajectory1, 1, 0.5);
    actActivation6 = ...
        testCase.TestData.Cluster3Transf1.FindTrajectoryActivationAverage( ...
        testCase.TestData.Trajectory1, 1, 0.5);
    expActivation1 = 0.63;
    expActivation2 = 0.39;
    expActivation3 = 0.61;
    expActivation4 = 0.03;
    expActivation5 = 0;
    expActivation6 = 0.06;
    verifyEqual(testCase,actActivation1,expActivation1, "AbsTol", 0.01);
    verifyEqual(testCase,actActivation2,expActivation2, "AbsTol", 0.01);
    verifyEqual(testCase,actActivation3,expActivation3, "AbsTol", 0.01);
    verifyEqual(testCase,actActivation4,expActivation4, "AbsTol", 0.01);
    verifyEqual(testCase,actActivation5,expActivation5, "AbsTol", 0.01);
    verifyEqual(testCase,actActivation6,expActivation6, "AbsTol", 0.01);
end


function TestFindTrajectoryActivationSum(testCase)
    actActivation1 = ...
        testCase.TestData.Cluster1Transf1.FindTrajectoryActivationSum( ...
        testCase.TestData.Trajectory1, 1, 0.1);
    actActivation2 = ...
        testCase.TestData.Cluster2Transf1.FindTrajectoryActivationSum( ...
        testCase.TestData.Trajectory1, 1, 0.1);
    actActivation3 = ...
        testCase.TestData.Cluster3Transf1.FindTrajectoryActivationSum( ...
        testCase.TestData.Trajectory1, 1, 0.1);
    actActivation4 = ...
        testCase.TestData.Cluster1Transf1.FindTrajectoryActivationSum( ...
        testCase.TestData.Trajectory1, 1, 0.5);
    actActivation5 = ...
        testCase.TestData.Cluster2Transf1.FindTrajectoryActivationSum( ...
        testCase.TestData.Trajectory1, 1, 0.5);
    actActivation6 = ...
        testCase.TestData.Cluster3Transf1.FindTrajectoryActivationSum( ...
        testCase.TestData.Trajectory1, 1, 0.5);
    expActivation1 = 1;
    expActivation2 = 1;
    expActivation3 = 1;
    expActivation4 = 0.337;
    expActivation5 = 0;
    expActivation6 = 0.67;
    verifyEqual(testCase,actActivation1,expActivation1);
    verifyEqual(testCase,actActivation2,expActivation2);
    verifyEqual(testCase,actActivation3,expActivation3);
    verifyEqual(testCase,actActivation4,expActivation4, "AbsTol", 0.01);
    verifyEqual(testCase,actActivation5,expActivation5);
    verifyEqual(testCase,actActivation6,expActivation6, "AbsTol", 0.01);
end

function TestFindActivationWithWindow(testCase)
    actActivation1 = ...
        testCase.TestData.Cluster1Transf1.FindActivationWithWindow( ...
        testCase.TestData.Silhouette1, testCase.TestData.Trajectory1, ...
        1, 1, 1, 1, 0.1);
    actActivation2 = ...
        testCase.TestData.Cluster2Transf1.FindActivationWithWindow( ...
        testCase.TestData.Silhouette1, testCase.TestData.Trajectory1, ...
        2, 1, 3, 1, 0.1);
    actActivation3 = ...
        testCase.TestData.Cluster3Transf1.FindActivationWithWindow( ...
        testCase.TestData.Silhouette1, testCase.TestData.Trajectory1, ...
        3, 1, 4, 1, 0.1);
    actActivation4 = ...
        testCase.TestData.Cluster1Transf2.FindActivationWithWindow( ...
        testCase.TestData.Silhouette1, testCase.TestData.Trajectory1, ...
        4, 4, 2, 0.8, 0.3);
    actActivation5 = ...
        testCase.TestData.Cluster2Transf2.FindActivationWithWindow( ...
        testCase.TestData.Silhouette1, testCase.TestData.Trajectory1, ...
        5, 4, 1, 0.8, 0.3);
    actActivation6 = ...
        testCase.TestData.Cluster3Transf2.FindActivationWithWindow( ...
        testCase.TestData.Silhouette1, testCase.TestData.Trajectory1, ...
        6, 4, 1, 0.8, 0.3);
    expActivation1 = 0.77;
    expActivation2 = 1.24;
    expActivation3 = 1.72;
    expActivation4 = 1.43;
    expActivation5 = 0.00;
    expActivation6 = 0.14;
    verifyEqual(testCase, actActivation1, expActivation1, "AbsTol", 0.01);
    verifyEqual(testCase, actActivation2, expActivation2, "AbsTol", 0.01);
    verifyEqual(testCase, actActivation3, expActivation3, "AbsTol", 0.01);
    verifyEqual(testCase, actActivation4, expActivation4, "AbsTol", 0.01);
    verifyEqual(testCase, actActivation5, expActivation5, "AbsTol", 0.01);
    verifyEqual(testCase, actActivation6, expActivation6, "AbsTol", 0.01);
end

function TestDistanceToActivationMap(testCase)
    % Assumes that the function thats being referenced by
    % DistanceToActivationMap is DistanceToActivationMapLinear
    actActivation1 = ...
        testCase.TestData.Cluster3Transf2.DistanceToActivationMapLinear( ...
        3, 1, 0.1);
    actActivation2 = ...
        testCase.TestData.Cluster2Transf2.DistanceToActivationMapLinear( ...
        20, 1, 0.1);
    actActivation3 = ...
        testCase.TestData.Cluster3Transf2.DistanceToActivationMapLinear( ...
        2, 0.5, 0.2);
    actActivation4 = ...
        testCase.TestData.Cluster1Transf1.DistanceToActivationMapLinear( ...
        45, 100, 1);
    expActivation1 = 0.7;
    expActivation2 = 0;
    expActivation3 = 0.1;
    expActivation4 = 55;
    verifyEqual(testCase, actActivation1, expActivation1, "AbsTol", 0.0000001);
    verifyEqual(testCase, actActivation2, expActivation2, "AbsTol", 0.0000001);
    verifyEqual(testCase, actActivation3, expActivation3, "AbsTol", 0.0000001);
    verifyEqual(testCase, actActivation4, expActivation4, "AbsTol", 0.0000001);
end

function TestDistanceToActivationMapLinear(testCase)
    actActivation1 = ...
        testCase.TestData.Cluster3Transf2.DistanceToActivationMapLinear( ...
        3, 1, 0.1);
    actActivation2 = ...
        testCase.TestData.Cluster2Transf2.DistanceToActivationMapLinear( ...
        20, 1, 0.1);
    actActivation3 = ...
        testCase.TestData.Cluster3Transf2.DistanceToActivationMapLinear( ...
        2, 0.5, 0.2);
    actActivation4 = ...
        testCase.TestData.Cluster1Transf1.DistanceToActivationMapLinear( ...
        45, 100, 1);
    expActivation1 = 0.7;
    expActivation2 = 0;
    expActivation3 = 0.1;
    expActivation4 = 55;
    verifyEqual(testCase, actActivation1, expActivation1, "AbsTol", 0.0000001);
    verifyEqual(testCase, actActivation2, expActivation2, "AbsTol", 0.0000001);
    verifyEqual(testCase, actActivation3, expActivation3, "AbsTol", 0.0000001);
    verifyEqual(testCase, actActivation4, expActivation4, "AbsTol", 0.0000001);
end

function TestCombineActivation(testCase)
    actActivation1 = testCase.TestData.Cluster3Transf2.CombineActivation( ...
        0.8, 0.2);
    actActivation2 = testCase.TestData.Cluster2Transf2.CombineActivation( ...
        1, 0.36);
    actActivation3 = testCase.TestData.Cluster1Transf1.CombineActivation( ...
        6.05, 0.2);
    actActivation4 = testCase.TestData.Cluster3Transf1.CombineActivation( ...
        0, 0.5);
    expActivation1 = 0.4;
    expActivation2 = 0.6;
    expActivation3 = 1.1;
    expActivation4 = 0;
    verifyEqual(testCase, actActivation1, expActivation1, "AbsTol", 0.0000001);
    verifyEqual(testCase, actActivation2, expActivation2, "AbsTol", 0.0000001);
    verifyEqual(testCase, actActivation3, expActivation3, "AbsTol", 0.0000001);
    verifyEqual(testCase, actActivation4, expActivation4, "AbsTol", 0.0000001);
end

function TestAverageDistanceToTrajectory(testCase)
    actDistance1 = ...
        testCase.TestData.Cluster1Transf1.AverageDistanceToTrajectory( ...
        testCase.TestData.Trajectory1);
    actDistance2 = ...
        testCase.TestData.Cluster2Transf1.AverageDistanceToTrajectory( ...
        testCase.TestData.Trajectory1);
    actDistance3 = ...
        testCase.TestData.Cluster3Transf1.AverageDistanceToTrajectory( ...
        testCase.TestData.Trajectory1);
    actDistance4 = ...
        testCase.TestData.Cluster1Transf2.AverageDistanceToTrajectory( ...
        testCase.TestData.Trajectory1);
    actDistance5 = ...
        testCase.TestData.Cluster2Transf2.AverageDistanceToTrajectory( ...
        testCase.TestData.Trajectory1);
    actDistance6 = ...
        testCase.TestData.Cluster3Transf2.AverageDistanceToTrajectory( ...
        testCase.TestData.Trajectory1);
    expDistance1 = 3.75;
    expDistance2 = 6.14;
    expDistance3 = 3.86;
    expDistance4 = 3.75;
    expDistance5 = 6.52;
    expDistance6 = 3.86;
    verifyEqual(testCase, actDistance1, expDistance1, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance2, expDistance2, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance3, expDistance3, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance4, expDistance4, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance5, expDistance5, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance6, expDistance6, "AbsTol", 0.01);
end

function TestAverageDistanceToSilhouette(testCase)
    actDistance1 = ...
        testCase.TestData.Cluster1Transf1.AverageDistanceToSilhouette( ...
        testCase.TestData.Silhouette1, 1);
    actDistance2 = ...
        testCase.TestData.Cluster2Transf1.AverageDistanceToSilhouette( ...
        testCase.TestData.Silhouette1, 2);
    actDistance3 = ...
        testCase.TestData.Cluster3Transf1.AverageDistanceToSilhouette( ...
        testCase.TestData.Silhouette1, 3);
    actDistance4 = ...
        testCase.TestData.Cluster1Transf2.AverageDistanceToSilhouette( ...
        testCase.TestData.Silhouette1, 4);
    actDistance5 = ...
        testCase.TestData.Cluster2Transf2.AverageDistanceToSilhouette( ...
        testCase.TestData.Silhouette1, 5);
    actDistance6 = ...
        testCase.TestData.Cluster3Transf2.AverageDistanceToSilhouette( ...
        testCase.TestData.Silhouette1, 6);
    expDistance1 = 4.14;
    expDistance2 = 4.14;
    expDistance3 = 0.62;
    expDistance4 = 0;
    expDistance5 = 0.62;
    expDistance6 = 4.14;
    verifyEqual(testCase, actDistance1, expDistance1, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance2, expDistance2, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance3, expDistance3, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance4, expDistance4, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance5, expDistance5, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance6, expDistance6, "AbsTol", 0.01);
end

function TestAverageDistancesToTrajectoryVector(testCase)
    actDistance1 = ...
        testCase.TestData.Cluster1Transf1.AverageDistancesToTrajectoryVector( ...
        testCase.TestData.Trajectory1);
    actDistance2 = ...
        testCase.TestData.Cluster2Transf1.AverageDistancesToTrajectoryVector( ...
        testCase.TestData.Trajectory1);
    actDistance3 = ...
        testCase.TestData.Cluster3Transf1.AverageDistancesToTrajectoryVector( ...
        testCase.TestData.Trajectory1);
    actDistance4 = ...
        testCase.TestData.Cluster1Transf2.AverageDistancesToTrajectoryVector( ...
        testCase.TestData.Trajectory1);
    actDistance5 = ...
        testCase.TestData.Cluster2Transf2.AverageDistancesToTrajectoryVector( ...
        testCase.TestData.Trajectory1);
    actDistance6 = ...
        testCase.TestData.Cluster3Transf2.AverageDistancesToTrajectoryVector( ...
        testCase.TestData.Trajectory1);
    expDistance1 = [7.07 6.09 5.10 4.13 3.18 2.29 1.62 1.71 2.46 3.33 4.25];
    expDistance2 = [9.27 8.54 7.87 7.28 6.78 6.40 6.17 5.20 4.25 3.33 2.46];
    expDistance3 = [1.62 1.41 1.62 2.29 3.18 4.13 5.10 5.20 5.48 5.92 6.48];
    expDistance4 = [7.07 6.09 5.10 4.13 3.18 2.29 1.62 1.71 2.46 3.33 4.25];
    expDistance5 = [6.17 6.09 6.17 6.40 6.78 7.28 7.87 7.14 6.48 5.92 5.48];
    expDistance6 = [1.62 1.41 1.62 2.29 3.18 4.13 5.10 5.20 5.48 5.92 6.48];
    verifyEqual(testCase, actDistance1, expDistance1, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance2, expDistance2, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance3, expDistance3, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance4, expDistance4, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance5, expDistance5, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance6, expDistance6, "AbsTol", 0.01);
end

function TestAverageDistanceToPoint(testCase)
    actDistance1 = ...
        testCase.TestData.Cluster1Transf1.AverageDistanceToPoint( ...
        testCase.TestData.Trajectory1.Points{1,1});
    actDistance2 = ...
        testCase.TestData.Cluster2Transf1.AverageDistanceToPoint( ...
        testCase.TestData.Silhouette1.Regions{1,1}.Center);
    actDistance3 = ...
        testCase.TestData.Cluster3Transf1.AverageDistanceToPoint( ...
        testCase.TestData.Trajectory1.Points{3,1});
    actDistance4 = ...
        testCase.TestData.Cluster1Transf2.AverageDistanceToPoint( ...
        testCase.TestData.Silhouette1.Regions{6,1}.Center);
    actDistance5 = ...
        testCase.TestData.Cluster2Transf2.AverageDistanceToPoint( ...
        testCase.TestData.Trajectory1.Points{5,1});
    actDistance6 = ...
        testCase.TestData.Cluster3Transf2.AverageDistanceToPoint( ...
        testCase.TestData.Silhouette1.Regions{5,1}.Center);
    expDistance1 = 7.07;
    expDistance2 = 8.66;
    expDistance3 = 1.62;
    expDistance4 = 5.2;
    expDistance5 = 6.78;
    expDistance6 = 5.92;
    verifyEqual(testCase, actDistance1, expDistance1, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance2, expDistance2, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance3, expDistance3, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance4, expDistance4, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance5, expDistance5, "AbsTol", 0.01);
    verifyEqual(testCase, actDistance6, expDistance6, "AbsTol", 0.01);
end

function TestCenter(testCase)
    actCentroid1_M = testCase.TestData.Cluster1Transf1.Center_AverageJunctureAll().MotorPoint.Coordinates;
    actCentroid2_M = testCase.TestData.Cluster2Transf1.Center_AverageJunctureAll().MotorPoint.Coordinates;
    actCentroid3_M = testCase.TestData.Cluster3Transf1.Center_AverageJunctureAll().MotorPoint.Coordinates;
    actCentroid4_M = testCase.TestData.Cluster1Transf2.Center_AverageJunctureAll().MotorPoint.Coordinates;
    actCentroid5_M = testCase.TestData.Cluster2Transf2.Center_AverageJunctureAll().MotorPoint.Coordinates;
    actCentroid6_M = testCase.TestData.Cluster3Transf2.Center_AverageJunctureAll().MotorPoint.Coordinates;
    expCentroid1_M = [1; 1];
    expCentroid2_M = [1; 7];
    expCentroid3_M = [7; 1];
    expCentroid4_M = [1; 1];
    expCentroid5_M = [1; 7];
    expCentroid6_M = [7; 1];
    actCentroid1_P = testCase.TestData.Cluster1Transf1.Center_AverageJunctureAll().PerceptualPoint.Coordinates;
    actCentroid2_P = testCase.TestData.Cluster2Transf1.Center_AverageJunctureAll().PerceptualPoint.Coordinates;
    actCentroid3_P = testCase.TestData.Cluster3Transf1.Center_AverageJunctureAll().PerceptualPoint.Coordinates;
    actCentroid4_P = testCase.TestData.Cluster1Transf2.Center_AverageJunctureAll().PerceptualPoint.Coordinates;
    actCentroid5_P = testCase.TestData.Cluster2Transf2.Center_AverageJunctureAll().PerceptualPoint.Coordinates;
    actCentroid6_P = testCase.TestData.Cluster3Transf2.Center_AverageJunctureAll().PerceptualPoint.Coordinates;
    expCentroid1_P = [1; 1];
    expCentroid2_P = [1; 7];
    expCentroid3_P = [7; 1];
    expCentroid4_P = [1; 1];
    expCentroid5_P = [7; 7];
    expCentroid6_P = [7; 1];
    verifyEqual(testCase, actCentroid1_M, expCentroid1_M);
    verifyEqual(testCase, actCentroid2_M, expCentroid2_M);
    verifyEqual(testCase, actCentroid3_M, expCentroid3_M);
    verifyEqual(testCase, actCentroid4_M, expCentroid4_M);
    verifyEqual(testCase, actCentroid5_M, expCentroid5_M);
    verifyEqual(testCase, actCentroid6_M, expCentroid6_M);
    verifyEqual(testCase, actCentroid1_P, expCentroid1_P);
    verifyEqual(testCase, actCentroid2_P, expCentroid2_P);
    verifyEqual(testCase, actCentroid3_P, expCentroid3_P);
    verifyEqual(testCase, actCentroid4_P, expCentroid4_P);
    verifyEqual(testCase, actCentroid5_P, expCentroid5_P);
    verifyEqual(testCase, actCentroid6_P, expCentroid6_P);
end

function TestMotorPlottingInfo(testCase)
    [expX1, expY1, expColor1] = ...
        testCase.TestData.Cluster1Transf1.MotorPlottingInfo( ...
        [1 0 0]);
    [expX2, expY2, expColor2] = ...
        testCase.TestData.Cluster2Transf1.MotorPlottingInfo( ...
        [1 0 0.5]);
    [expX3, expY3, expColor3] = ...
        testCase.TestData.Cluster3Transf1.MotorPlottingInfo( ...
        [1 0 1]);
    [expX4, expY4, expColor4] = ...
        testCase.TestData.Cluster1Transf2.MotorPlottingInfo( ...
        [0.5 0 1]);
    [expX5, expY5, expColor5] = ...
        testCase.TestData.Cluster2Transf2.MotorPlottingInfo( ...
        [0 0 1]);
    [expX6, expY6, expColor6] = ...
        testCase.TestData.Cluster3Transf2.MotorPlottingInfo( ...
        [0 1 1]);
    actX1 = [0; 2; 0; 2];
    actY1 = [0; 0; 2; 2];
    actColor1 = [1 0 0; 1 0 0; 1 0 0; 1 0 0];
    actX2 = [0; 2; 0; 2];
    actY2 = [6; 6; 8; 8];
    actColor2 = [1 0 0.5; 1 0 0.5; 1 0 0.5; 1 0 0.5];
    actX3 = [6; 8; 6; 8];
    actY3 = [0; 0; 2; 2];
    actColor3 = [1 0 1; 1 0 1; 1 0 1; 1 0 1];
    actX4 = [0; 2; 0; 2];
    actY4 = [0; 0; 2; 2];
    actColor4 = [0.5 0 1; 0.5 0 1; 0.5 0 1; 0.5 0 1];
    actX5 = [0; 2; 0; 2];
    actY5 = [6; 6; 8; 8];
    actColor5 = [0 0 1; 0 0 1; 0 0 1; 0 0 1];
    actX6 = [6; 8; 6; 8];
    actY6 = [0; 0; 2; 2];
    actColor6 = [0 1 1; 0 1 1; 0 1 1; 0 1 1];
    verifyEqual(testCase, actX1, expX1, "AbsTol", 0.000001);
    verifyEqual(testCase, actY1, expY1, "AbsTol", 0.000001);
    verifyEqual(testCase, actColor1, expColor1, "AbsTol", 0.000001);
    verifyEqual(testCase, actX2, expX2, "AbsTol", 0.000001);
    verifyEqual(testCase, actY2, expY2, "AbsTol", 0.000001);
    verifyEqual(testCase, actColor2, expColor2, "AbsTol", 0.000001);
    verifyEqual(testCase, actX3, expX3, "AbsTol", 0.000001);
    verifyEqual(testCase, actY3, expY3, "AbsTol", 0.000001);
    verifyEqual(testCase, actColor3, expColor3, "AbsTol", 0.000001);
    verifyEqual(testCase, actX4, expX4, "AbsTol", 0.000001);
    verifyEqual(testCase, actY4, expY4, "AbsTol", 0.000001);
    verifyEqual(testCase, actColor4, expColor4, "AbsTol", 0.000001);
    verifyEqual(testCase, actX5, expX5, "AbsTol", 0.000001);
    verifyEqual(testCase, actY5, expY5, "AbsTol", 0.000001);
    verifyEqual(testCase, actColor5, expColor5, "AbsTol", 0.000001);
    verifyEqual(testCase, actX6, expX6, "AbsTol", 0.000001);
    verifyEqual(testCase, actY6, expY6, "AbsTol", 0.000001);
    verifyEqual(testCase, actColor6, expColor6, "AbsTol", 0.000001);
end

function TestPerceptualPlottingInfo(testCase)
    [expX1, expY1, expColor1] = ...
        testCase.TestData.Cluster1Transf1.PerceptualPlottingInfo( ...
        [1 0 0]);
    [expX2, expY2, expColor2] = ...
        testCase.TestData.Cluster2Transf1.PerceptualPlottingInfo( ...
        [1 0 0.5]);
    [expX3, expY3, expColor3] = ...
        testCase.TestData.Cluster3Transf1.PerceptualPlottingInfo( ...
        [1 0 1]);
    [expX4, expY4, expColor4] = ...
        testCase.TestData.Cluster1Transf2.PerceptualPlottingInfo( ...
        [0.5 0 1]);
    [expX5, expY5, expColor5] = ...
        testCase.TestData.Cluster2Transf2.PerceptualPlottingInfo( ...
        [0 0 1]);
    [expX6, expY6, expColor6] = ...
        testCase.TestData.Cluster3Transf2.PerceptualPlottingInfo( ...
        [0 1 1]);
    actX1 = [0; 2; 0; 2];
    actY1 = [0; 0; 2; 2];
    actColor1 = [1 0 0; 1 0 0; 1 0 0; 1 0 0];
    actX2 = [0; 2; 0; 2];
    actY2 = [6; 6; 8; 8];
    actColor2 = [1 0 0.5; 1 0 0.5; 1 0 0.5; 1 0 0.5];
    actX3 = [6; 8; 6; 8];
    actY3 = [0; 0; 2; 2];
    actColor3 = [1 0 1; 1 0 1; 1 0 1; 1 0 1];
    actX4 = [0; 2; 0; 2];
    actY4 = [0; 0; 2; 2];
    actColor4 = [0.5 0 1; 0.5 0 1; 0.5 0 1; 0.5 0 1];
    actX5 = [6; 8; 6; 8];
    actY5 = [6; 6; 8; 8];
    actColor5 = [0 0 1; 0 0 1; 0 0 1; 0 0 1];
    actX6 = [6; 8; 6; 8];
    actY6 = [0; 0; 2; 2];
    actColor6 = [0 1 1; 0 1 1; 0 1 1; 0 1 1];
    verifyEqual(testCase, actX1, expX1, "AbsTol", 0.000001);
    verifyEqual(testCase, actY1, expY1, "AbsTol", 0.000001);
    verifyEqual(testCase, actColor1, expColor1, "AbsTol", 0.000001);
    verifyEqual(testCase, actX2, expX2, "AbsTol", 0.000001);
    verifyEqual(testCase, actY2, expY2, "AbsTol", 0.000001);
    verifyEqual(testCase, actColor2, expColor2, "AbsTol", 0.000001);
    verifyEqual(testCase, actX3, expX3, "AbsTol", 0.000001);
    verifyEqual(testCase, actY3, expY3, "AbsTol", 0.000001);
    verifyEqual(testCase, actColor3, expColor3, "AbsTol", 0.000001);
    verifyEqual(testCase, actX4, expX4, "AbsTol", 0.000001);
    verifyEqual(testCase, actY4, expY4, "AbsTol", 0.000001);
    verifyEqual(testCase, actColor4, expColor4, "AbsTol", 0.000001);
    verifyEqual(testCase, actX5, expX5, "AbsTol", 0.000001);
    verifyEqual(testCase, actY5, expY5, "AbsTol", 0.000001);
    verifyEqual(testCase, actColor5, expColor5, "AbsTol", 0.000001);
    verifyEqual(testCase, actX6, expX6, "AbsTol", 0.000001);
    verifyEqual(testCase, actY6, expY6, "AbsTol", 0.000001);
    verifyEqual(testCase, actColor6, expColor6, "AbsTol", 0.000001);
end

% function TestPlotMotor(testCase)
%     verifyEqual(0,1);
% end
% 
% function TestPlotPerceptual(testCase)
%     verifyEqual(0,1);
% end

function TestCenter_AverageJunctureAll(testCase)
    actCentroid1_M = testCase.TestData.Cluster1Transf1.Center_AverageJunctureAll().MotorPoint.Coordinates;
    actCentroid2_M = testCase.TestData.Cluster2Transf1.Center_AverageJunctureAll().MotorPoint.Coordinates;
    actCentroid3_M = testCase.TestData.Cluster3Transf1.Center_AverageJunctureAll().MotorPoint.Coordinates;
    actCentroid4_M = testCase.TestData.Cluster1Transf2.Center_AverageJunctureAll().MotorPoint.Coordinates;
    actCentroid5_M = testCase.TestData.Cluster2Transf2.Center_AverageJunctureAll().MotorPoint.Coordinates;
    actCentroid6_M = testCase.TestData.Cluster3Transf2.Center_AverageJunctureAll().MotorPoint.Coordinates;
    expCentroid1_M = [1; 1];
    expCentroid2_M = [1; 7];
    expCentroid3_M = [7; 1];
    expCentroid4_M = [1; 1];
    expCentroid5_M = [1; 7];
    expCentroid6_M = [7; 1];
    actCentroid1_P = testCase.TestData.Cluster1Transf1.Center_AverageJunctureAll().PerceptualPoint.Coordinates;
    actCentroid2_P = testCase.TestData.Cluster2Transf1.Center_AverageJunctureAll().PerceptualPoint.Coordinates;
    actCentroid3_P = testCase.TestData.Cluster3Transf1.Center_AverageJunctureAll().PerceptualPoint.Coordinates;
    actCentroid4_P = testCase.TestData.Cluster1Transf2.Center_AverageJunctureAll().PerceptualPoint.Coordinates;
    actCentroid5_P = testCase.TestData.Cluster2Transf2.Center_AverageJunctureAll().PerceptualPoint.Coordinates;
    actCentroid6_P = testCase.TestData.Cluster3Transf2.Center_AverageJunctureAll().PerceptualPoint.Coordinates;
    expCentroid1_P = [1; 1];
    expCentroid2_P = [1; 7];
    expCentroid3_P = [7; 1];
    expCentroid4_P = [1; 1];
    expCentroid5_P = [7; 7];
    expCentroid6_P = [7; 1];
    verifyEqual(testCase, actCentroid1_M, expCentroid1_M);
    verifyEqual(testCase, actCentroid2_M, expCentroid2_M);
    verifyEqual(testCase, actCentroid3_M, expCentroid3_M);
    verifyEqual(testCase, actCentroid4_M, expCentroid4_M);
    verifyEqual(testCase, actCentroid5_M, expCentroid5_M);
    verifyEqual(testCase, actCentroid6_M, expCentroid6_M);
    verifyEqual(testCase, actCentroid1_P, expCentroid1_P);
    verifyEqual(testCase, actCentroid2_P, expCentroid2_P);
    verifyEqual(testCase, actCentroid3_P, expCentroid3_P);
    verifyEqual(testCase, actCentroid4_P, expCentroid4_P);
    verifyEqual(testCase, actCentroid5_P, expCentroid5_P);
    verifyEqual(testCase, actCentroid6_P, expCentroid6_P);
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
