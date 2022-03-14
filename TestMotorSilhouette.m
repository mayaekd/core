%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function tests = TestMotorSilhouette
    tests = functiontests(localfunctions);
end

function TestCreateObject(testCase)
    TestSilhouette = MotorSilhouette({ ...
        testCase.TestData.Region9; testCase.TestData.Region8; ...
        testCase.TestData.Region7; testCase.TestData.Region6; ...
        testCase.TestData.Region5; testCase.TestData.Region4; ...
        testCase.TestData.Region3; testCase.TestData.Region2; ...
        testCase.TestData.Region1});
    actCenter1 = TestSilhouette.Regions{1,1}.Center.Coordinates;
    actCenter2 = TestSilhouette.Regions{3,1}.Center.Coordinates;
    actCenter3 = TestSilhouette.Regions{5,1}.Center.Coordinates;
    actRadius1 = TestSilhouette.Regions{2,1}.Radius;
    actRadius2 = TestSilhouette.Regions{4,1}.Radius;
    actRadius3 = TestSilhouette.Regions{8,1}.Radius;
    expCenter1 = [-10; 70];
    expCenter2 = [0; 50];
    expCenter3 = [10; 30];
    expRadius1 = 6;
    expRadius2 = 5;
    expRadius3 = 4;
    verifyEqual(testCase, actCenter1, expCenter1);
    verifyEqual(testCase, actCenter2, expCenter2);
    verifyEqual(testCase, actCenter3, expCenter3);
    verifyEqual(testCase, actRadius1, expRadius1);
    verifyEqual(testCase, actRadius2, expRadius2);
    verifyEqual(testCase, actRadius3, expRadius3);
end

function TestDropoffScalar(testCase)
    actMultiplier1 = ...
        testCase.TestData.Silhouette1.DropoffScalar(0, 1, 1);
    actMultiplier2 = ...
        testCase.TestData.Silhouette1.DropoffScalar(0, 1, 2);
    actMultiplier3 = ...
        testCase.TestData.Silhouette1.DropoffScalar(0, 4, 1);
    actMultiplier4 = ...
        testCase.TestData.Silhouette1.DropoffScalar(0, 4, 2);
    actMultiplier5 = ...
        testCase.TestData.Silhouette1.DropoffScalar(1, 1, 1);
    actMultiplier6 = ...
        testCase.TestData.Silhouette1.DropoffScalar(1, 1, 2);
    actMultiplier7 = ...
        testCase.TestData.Silhouette1.DropoffScalar(1, 4, 1);
    actMultiplier8 = ...
        testCase.TestData.Silhouette1.DropoffScalar(1, 4, 2);
    actMultiplier9 = ...
        testCase.TestData.Silhouette1.DropoffScalar(3, 1, 1);
    actMultiplier10 = ...
        testCase.TestData.Silhouette1.DropoffScalar(3, 1, 2);
    actMultiplier11 = ...
        testCase.TestData.Silhouette1.DropoffScalar(3, 4, 1);
    actMultiplier12 = ...
        testCase.TestData.Silhouette1.DropoffScalar(3, 4, 2);
    actMultiplier13 = ...
        testCase.TestData.Silhouette1.DropoffScalar(-1, 1, 1);
    actMultiplier14 = ...
        testCase.TestData.Silhouette1.DropoffScalar(-1, 1, 2);
    actMultiplier15 = ...
        testCase.TestData.Silhouette1.DropoffScalar(-1, 4, 1);
    actMultiplier16 = ...
        testCase.TestData.Silhouette1.DropoffScalar(-1, 4, 2);
    expMultiplier1 = 1;
    expMultiplier2 = 1;
    expMultiplier3 = 1;
    expMultiplier4 = 1;
    expMultiplier5 = 0;
    expMultiplier6 = 0;
    expMultiplier7 = 0.5625;
    expMultiplier8 = 0.5625;
    expMultiplier9 = 0;
    expMultiplier10 = 0;
    expMultiplier11 = 0.0625;
    expMultiplier12 = 0.0625;
    expMultiplier13 = 0;
    expMultiplier14 = 0.25;
    expMultiplier15 = 0;
    expMultiplier16 = 0.25;
    verifyEqual(testCase, actMultiplier1, expMultiplier1, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier2, expMultiplier2, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier3, expMultiplier3, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier4, expMultiplier4, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier5, expMultiplier5, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier6, expMultiplier6, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier7, expMultiplier7, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier8, expMultiplier8, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier9, expMultiplier9, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier10, expMultiplier10, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier11, expMultiplier11, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier12, expMultiplier12, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier13, expMultiplier13, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier14, expMultiplier14, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier15, expMultiplier15, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier16, expMultiplier16, "AbsTol", 0.000000001);
end

function TestDropoffScalarConcave(testCase)
    actMultiplier1 = ...
        testCase.TestData.Silhouette1.DropoffScalarConcave(0, 1, 1, 1);
    actMultiplier2 = ...
        testCase.TestData.Silhouette1.DropoffScalarConcave(0, 1, 2, 2);
    actMultiplier3 = ...
        testCase.TestData.Silhouette1.DropoffScalarConcave(0, 4, 1, 1);
    actMultiplier4 = ...
        testCase.TestData.Silhouette1.DropoffScalarConcave(0, 4, 2, 2);
    actMultiplier5 = ...
        testCase.TestData.Silhouette1.DropoffScalarConcave(1, 1, 1, 1);
    actMultiplier6 = ...
        testCase.TestData.Silhouette1.DropoffScalarConcave(1, 1, 2, 2);
    actMultiplier7 = ...
        testCase.TestData.Silhouette1.DropoffScalarConcave(1, 4, 1, 1);
    actMultiplier8 = ...
        testCase.TestData.Silhouette1.DropoffScalarConcave(1, 4, 2, 2);
    actMultiplier9 = ...
        testCase.TestData.Silhouette1.DropoffScalarConcave(3, 1, 1, 1);
    actMultiplier10 = ...
        testCase.TestData.Silhouette1.DropoffScalarConcave(3, 1, 2, 2);
    actMultiplier11 = ...
        testCase.TestData.Silhouette1.DropoffScalarConcave(3, 4, 1, 1);
    actMultiplier12 = ...
        testCase.TestData.Silhouette1.DropoffScalarConcave(3, 4, 2, 2);
    actMultiplier13 = ...
        testCase.TestData.Silhouette1.DropoffScalarConcave(-1, 1, 1, 1);
    actMultiplier14 = ...
        testCase.TestData.Silhouette1.DropoffScalarConcave(-1, 1, 2, 2);
    actMultiplier15 = ...
        testCase.TestData.Silhouette1.DropoffScalarConcave(-1, 4, 1, 1);
    actMultiplier16 = ...
        testCase.TestData.Silhouette1.DropoffScalarConcave(-1, 4, 2, 2);
    expMultiplier1 = 1;
    expMultiplier2 = 1;
    expMultiplier3 = 1;
    expMultiplier4 = 1;
    expMultiplier5 = 0;
    expMultiplier6 = 0;
    expMultiplier7 = 0.75;
    expMultiplier8 = 0.5625;
    expMultiplier9 = 0;
    expMultiplier10 = 0;
    expMultiplier11 = 0.25;
    expMultiplier12 = 0.0625;
    expMultiplier13 = 0;
    expMultiplier14 = 0.25;
    expMultiplier15 = 0;
    expMultiplier16 = 0.25;
    verifyEqual(testCase, actMultiplier1, expMultiplier1, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier2, expMultiplier2, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier3, expMultiplier3, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier4, expMultiplier4, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier5, expMultiplier5, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier6, expMultiplier6, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier7, expMultiplier7, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier8, expMultiplier8, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier9, expMultiplier9, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier10, expMultiplier10, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier11, expMultiplier11, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier12, expMultiplier12, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier13, expMultiplier13, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier14, expMultiplier14, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier15, expMultiplier15, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier16, expMultiplier16, "AbsTol", 0.000000001);
end

function TestDropoffScalarLinearFalloff(testCase)
    actMultiplier1 = ...
        testCase.TestData.Silhouette1.DropoffScalarLinearFalloff(0, 1, 1);
    actMultiplier2 = ...
        testCase.TestData.Silhouette1.DropoffScalarLinearFalloff(0, 1, 2);
    actMultiplier3 = ...
        testCase.TestData.Silhouette1.DropoffScalarLinearFalloff(0, 4, 1);
    actMultiplier4 = ...
        testCase.TestData.Silhouette1.DropoffScalarLinearFalloff(0, 4, 2);
    actMultiplier5 = ...
        testCase.TestData.Silhouette1.DropoffScalarLinearFalloff(1, 1, 1);
    actMultiplier6 = ...
        testCase.TestData.Silhouette1.DropoffScalarLinearFalloff(1, 1, 2);
    actMultiplier7 = ...
        testCase.TestData.Silhouette1.DropoffScalarLinearFalloff(1, 4, 1);
    actMultiplier8 = ...
        testCase.TestData.Silhouette1.DropoffScalarLinearFalloff(1, 4, 2);
    actMultiplier9 = ...
        testCase.TestData.Silhouette1.DropoffScalarLinearFalloff(3, 1, 1);
    actMultiplier10 = ...
        testCase.TestData.Silhouette1.DropoffScalarLinearFalloff(3, 1, 2);
    actMultiplier11 = ...
        testCase.TestData.Silhouette1.DropoffScalarLinearFalloff(3, 4, 1);
    actMultiplier12 = ...
        testCase.TestData.Silhouette1.DropoffScalarLinearFalloff(3, 4, 2);
    actMultiplier13 = ...
        testCase.TestData.Silhouette1.DropoffScalarLinearFalloff(-1, 1, 1);
    actMultiplier14 = ...
        testCase.TestData.Silhouette1.DropoffScalarLinearFalloff(-1, 1, 2);
    actMultiplier15 = ...
        testCase.TestData.Silhouette1.DropoffScalarLinearFalloff(-1, 4, 1);
    actMultiplier16 = ...
        testCase.TestData.Silhouette1.DropoffScalarLinearFalloff(-1, 4, 2);
    expMultiplier1 = 1;
    expMultiplier2 = 1;
    expMultiplier3 = 1;
    expMultiplier4 = 1;
    expMultiplier5 = 0;
    expMultiplier6 = 0;
    expMultiplier7 = 0.75;
    expMultiplier8 = 0.75;
    expMultiplier9 = 0;
    expMultiplier10 = 0;
    expMultiplier11 = 0.25;
    expMultiplier12 = 0.25;
    expMultiplier13 = 0;
    expMultiplier14 = 0.5;
    expMultiplier15 = 0;
    expMultiplier16 = 0.5;
    verifyEqual(testCase, actMultiplier1, expMultiplier1, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier2, expMultiplier2, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier3, expMultiplier3, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier4, expMultiplier4, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier5, expMultiplier5, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier6, expMultiplier6, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier7, expMultiplier7, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier8, expMultiplier8, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier9, expMultiplier9, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier10, expMultiplier10, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier11, expMultiplier11, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier12, expMultiplier12, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier13, expMultiplier13, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier14, expMultiplier14, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier15, expMultiplier15, "AbsTol", 0.000000001);
    verifyEqual(testCase, actMultiplier16, expMultiplier16, "AbsTol", 0.000000001);
end

function TestTemporalActivationInfo(testCase)
    actActivationValues1 = testCase.TestData.Silhouette1.TemporalActivationInfo(3, 4);
    actActivationValues2 = testCase.TestData.Silhouette1.TemporalActivationInfo(1, 4);
    actActivationValues3 = testCase.TestData.Silhouette1.TemporalActivationInfo(3, 1);
    actActivationValues4 = testCase.TestData.Silhouette1.TemporalActivationInfo(1, 1);
    actActivationValues5 = testCase.TestData.Silhouette1.TemporalActivationInfo(5, 4);
    expActivationValues1 = {
        [1; 0.5625; 0.25; 0.0625; 0; 0; 0; 0; 0];
        [4/9; 1; 0.5625; 0.25; 0.0625; 0; 0; 0; 0];
        [1/9; 4/9; 1; 0.5625; 0.25; 0.0625; 0; 0; 0];
        [0; 1/9; 4/9; 1; 0.5625; 0.25; 0.0625; 0; 0];
        [0; 0; 1/9; 4/9; 1; 0.5625; 0.25; 0.0625; 0];
        [0; 0; 0; 1/9; 4/9; 1; 0.5625; 0.25; 0.0625];
        [0; 0; 0; 0; 1/9; 4/9; 1; 0.5625; 0.25];
        [0; 0; 0; 0; 0; 1/9; 4/9; 1; 0.5625];
        [0; 0; 0; 0; 0; 0; 1/9; 4/9; 1]};
    expActivationValues2 = {
        [1; 0.5625; 0.25; 0.0625; 0; 0; 0; 0; 0];
        [0; 1; 0.5625; 0.25; 0.0625; 0; 0; 0; 0];
        [0; 0; 1; 0.5625; 0.25; 0.0625; 0; 0; 0];
        [0; 0; 0; 1; 0.5625; 0.25; 0.0625; 0; 0];
        [0; 0; 0; 0; 1; 0.5625; 0.25; 0.0625; 0];
        [0; 0; 0; 0; 0; 1; 0.5625; 0.25; 0.0625];
        [0; 0; 0; 0; 0; 0; 1; 0.5625; 0.25];
        [0; 0; 0; 0; 0; 0; 0; 1; 0.5625];
        [0; 0; 0; 0; 0; 0; 0; 0; 1]};
    expActivationValues3 = {
        [1; 0; 0; 0; 0; 0; 0; 0; 0];
        [4/9; 1; 0; 0; 0; 0; 0; 0; 0];
        [1/9; 4/9; 1; 0; 0; 0; 0; 0; 0];
        [0; 1/9; 4/9; 1; 0; 0; 0; 0; 0];
        [0; 0; 1/9; 4/9; 1; 0; 0; 0; 0];
        [0; 0; 0; 1/9; 4/9; 1; 0; 0; 0];
        [0; 0; 0; 0; 1/9; 4/9; 1; 0; 0];
        [0; 0; 0; 0; 0; 1/9; 4/9; 1; 0];
        [0; 0; 0; 0; 0; 0; 1/9; 4/9; 1]};
    expActivationValues4 = {
        [1; 0; 0; 0; 0; 0; 0; 0; 0];
        [0; 1; 0; 0; 0; 0; 0; 0; 0];
        [0; 0; 1; 0; 0; 0; 0; 0; 0];
        [0; 0; 0; 1; 0; 0; 0; 0; 0];
        [0; 0; 0; 0; 1; 0; 0; 0; 0];
        [0; 0; 0; 0; 0; 1; 0; 0; 0];
        [0; 0; 0; 0; 0; 0; 1; 0; 0];
        [0; 0; 0; 0; 0; 0; 0; 1; 0];
        [0; 0; 0; 0; 0; 0; 0; 0; 1]};
    expActivationValues5 = {
        [1; 0.5625; 0.25; 0.0625; 0; 0; 0; 0; 0];
        [0.64; 1; 0.5625; 0.25; 0.0625; 0; 0; 0; 0];
        [0.36; 0.64; 1; 0.5625; 0.25; 0.0625; 0; 0; 0];
        [0.16; 0.36; 0.64; 1; 0.5625; 0.25; 0.0625; 0; 0];
        [0.04; 0.16; 0.36; 0.64; 1; 0.5625; 0.25; 0.0625; 0];
        [0; 0.04; 0.16; 0.36; 0.64; 1; 0.5625; 0.25; 0.0625];
        [0; 0; 0.04; 0.16; 0.36; 0.64; 1; 0.5625; 0.25];
        [0; 0; 0; 0.04; 0.16; 0.36; 0.64; 1; 0.5625];
        [0; 0; 0; 0; 0.04; 0.16; 0.36; 0.64; 1]};
    verifyEqual(testCase, actActivationValues1, expActivationValues1, "AbsTol", 0.00000001);
    verifyEqual(testCase, actActivationValues2, expActivationValues2, "AbsTol", 0.00000001);
    verifyEqual(testCase, actActivationValues3, expActivationValues3, "AbsTol", 0.00000001);
    verifyEqual(testCase, actActivationValues4, expActivationValues4, "AbsTol", 0.00000001);
    verifyEqual(testCase, actActivationValues5, expActivationValues5, "AbsTol", 0.00000001);
end

% function TestPlottingInfo(testCase)
%     verifyEqual(testCase, 0, 1);
% end

% function TestPlot(testCase)
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
    testCase.TestData.Region1 = MotorRegionTemp(MotorPoint([30; 70]), 4);
    testCase.TestData.Region2 = MotorRegionTemp(MotorPoint([25; 60]), 4);
    testCase.TestData.Region3 = MotorRegionTemp(MotorPoint([20; 50]), 4);
    testCase.TestData.Region4 = MotorRegionTemp(MotorPoint([15; 40]), 5);
    testCase.TestData.Region5 = MotorRegionTemp(MotorPoint([10; 30]), 5);
    testCase.TestData.Region6 = MotorRegionTemp(MotorPoint([5; 40]), 5);
    testCase.TestData.Region7 = MotorRegionTemp(MotorPoint([0; 50]), 6);
    testCase.TestData.Region8 = MotorRegionTemp(MotorPoint([-5; 60]), 6);
    testCase.TestData.Region9 = MotorRegionTemp(MotorPoint([-10; 70]), 6);
    testCase.TestData.Silhouette1 = MotorSilhouette({ ...
        testCase.TestData.Region1; testCase.TestData.Region2; ...
        testCase.TestData.Region3; testCase.TestData.Region4; ...
        testCase.TestData.Region5; testCase.TestData.Region6; ...
        testCase.TestData.Region7; testCase.TestData.Region8; ...
        testCase.TestData.Region9});
end

function teardownOnce(testCase)
    cd(testCase.TestData.origPath)
    rmdir(testCase.TestData.tmpFolder)
end
