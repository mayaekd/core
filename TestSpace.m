%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% METHODS LIST
%  Space
% % %  ActivationFromPerceptualPoint
% % %  JustGreatestActivationFromTraj
% % %  Activations_SumFromTraj
% % %  CorrectionActivation
% % %  CorrectionActivationProportional
% % %  CorrectionActivationMultiplier
% % %  CorrectionActivationRaw
% % %  CorrectionActivationCutAtZero
% % %  CorrectionActivationShiftedToPositive
% % %  QuantizeJunctureActivationPattern


function tests = TestSpace
    tests = functiontests(localfunctions);
end

function TestCreateObject(testCase)

    % The motor coordinate matrices of the different spaces
    actMotor11 = testCase.TestData.Space1.Clusters{1,1}.MotorCoordinateMatrix;
    actMotor12 = testCase.TestData.Space1.Clusters{2,1}.MotorCoordinateMatrix;
    actMotor13 = testCase.TestData.Space1.Clusters{3,1}.MotorCoordinateMatrix;
    actMotor14 = testCase.TestData.Space1.Clusters{4,1}.MotorCoordinateMatrix;
    actMotor15 = testCase.TestData.Space1.Clusters{5,1}.MotorCoordinateMatrix;
    actMotor16 = testCase.TestData.Space1.Clusters{6,1}.MotorCoordinateMatrix;

    actMotor21 = testCase.TestData.Space2.Clusters{1,1}.MotorCoordinateMatrix;
    actMotor22 = testCase.TestData.Space2.Clusters{2,1}.MotorCoordinateMatrix;
    actMotor23 = testCase.TestData.Space2.Clusters{3,1}.MotorCoordinateMatrix;
    actMotor24 = testCase.TestData.Space2.Clusters{4,1}.MotorCoordinateMatrix;
    actMotor25 = testCase.TestData.Space2.Clusters{5,1}.MotorCoordinateMatrix;
    actMotor26 = testCase.TestData.Space2.Clusters{6,1}.MotorCoordinateMatrix;

    % The perceptual coordinate matrices of the different spaces
    actPerceptual21 = testCase.TestData.Space2.Clusters{1,1}.PerceptualCoordinateMatrix;
    actPerceptual22 = testCase.TestData.Space2.Clusters{2,1}.PerceptualCoordinateMatrix;
    actPerceptual23 = testCase.TestData.Space2.Clusters{3,1}.PerceptualCoordinateMatrix;
    actPerceptual24 = testCase.TestData.Space2.Clusters{4,1}.PerceptualCoordinateMatrix;
    actPerceptual25 = testCase.TestData.Space2.Clusters{5,1}.PerceptualCoordinateMatrix;
    actPerceptual26 = testCase.TestData.Space2.Clusters{6,1}.PerceptualCoordinateMatrix;

    actPerceptual31 = testCase.TestData.Space3.Clusters{1,1}.PerceptualCoordinateMatrix;
    actPerceptual32 = testCase.TestData.Space3.Clusters{2,1}.PerceptualCoordinateMatrix;
    actPerceptual33 = testCase.TestData.Space3.Clusters{3,1}.PerceptualCoordinateMatrix;
    actPerceptual34 = testCase.TestData.Space3.Clusters{4,1}.PerceptualCoordinateMatrix;
    actPerceptual35 = testCase.TestData.Space3.Clusters{5,1}.PerceptualCoordinateMatrix;
    actPerceptual36 = testCase.TestData.Space3.Clusters{6,1}.PerceptualCoordinateMatrix;

    % The cluster sizes
    actClusterSizes1 = testCase.TestData.Space1.ClusterSizes;
    actClusterSizes2 = testCase.TestData.Space2.ClusterSizes;
    actClusterSizes3 = testCase.TestData.Space3.ClusterSizes;

    % The canonical juncture order
    JunctureList1 = testCase.TestData.Space1.CanonicalJunctureOrder;
    JunctureList2 = testCase.TestData.Space2.CanonicalJunctureOrder;
    JunctureList3 = testCase.TestData.Space3.CanonicalJunctureOrder;

    actCanonicalOrderSize1 = size(JunctureList1);
    actCanonicalOrderSize2 = size(JunctureList2);
    actCanonicalOrderSize3 = size(JunctureList3);

    actMotorCoordinates3InOrder1 = JunctureList1{3,1}.MotorPoint.Coordinates;
    actMotorCoordinates4InOrder1 = JunctureList1{4,1}.MotorPoint.Coordinates;
    actMotorCoordinates18InOrder1 = JunctureList1{18,1}.MotorPoint.Coordinates;
    actMotorCoordinates24InOrder1 = JunctureList1{24,1}.MotorPoint.Coordinates;
    actMotorCoordinates33InOrder1 = JunctureList1{33,1}.MotorPoint.Coordinates;
    actMotorCoordinates34InOrder1 = JunctureList1{34,1}.MotorPoint.Coordinates;
    actMotorCoordinates43InOrder1 = JunctureList1{43,1}.MotorPoint.Coordinates;
    actMotorCoordinates48InOrder1 = JunctureList1{48,1}.MotorPoint.Coordinates;
    actMotorCoordinates52InOrder1 = JunctureList1{52,1}.MotorPoint.Coordinates;
    actMotorCoordinates64InOrder1 = JunctureList1{64,1}.MotorPoint.Coordinates;
    actMotorCoordinates68InOrder1 = JunctureList1{68,1}.MotorPoint.Coordinates;
    actMotorCoordinates72InOrder1 = JunctureList1{72,1}.MotorPoint.Coordinates;

    actMotorCoordinates3InOrder2 = JunctureList2{3,1}.MotorPoint.Coordinates;
    actMotorCoordinates4InOrder2 = JunctureList2{4,1}.MotorPoint.Coordinates;
    actMotorCoordinates18InOrder2 = JunctureList2{18,1}.MotorPoint.Coordinates;
    actMotorCoordinates24InOrder2 = JunctureList2{24,1}.MotorPoint.Coordinates;
    actMotorCoordinates33InOrder2 = JunctureList2{33,1}.MotorPoint.Coordinates;
    actMotorCoordinates34InOrder2 = JunctureList2{34,1}.MotorPoint.Coordinates;
    actMotorCoordinates43InOrder2 = JunctureList2{43,1}.MotorPoint.Coordinates;
    actMotorCoordinates48InOrder2 = JunctureList2{48,1}.MotorPoint.Coordinates;
    actMotorCoordinates52InOrder2 = JunctureList2{52,1}.MotorPoint.Coordinates;
    actMotorCoordinates64InOrder2 = JunctureList2{64,1}.MotorPoint.Coordinates;
    actMotorCoordinates68InOrder2 = JunctureList2{68,1}.MotorPoint.Coordinates;
    actMotorCoordinates72InOrder2 = JunctureList2{72,1}.MotorPoint.Coordinates;

    actMotorCoordinates3InOrder3 = JunctureList3{3,1}.MotorPoint.Coordinates;
    actMotorCoordinates4InOrder3 = JunctureList3{4,1}.MotorPoint.Coordinates;
    actMotorCoordinates18InOrder3 = JunctureList3{18,1}.MotorPoint.Coordinates;
    actMotorCoordinates24InOrder3 = JunctureList3{24,1}.MotorPoint.Coordinates;
    actMotorCoordinates33InOrder3 = JunctureList3{33,1}.MotorPoint.Coordinates;
    actMotorCoordinates34InOrder3 = JunctureList3{34,1}.MotorPoint.Coordinates;
    actMotorCoordinates43InOrder3 = JunctureList3{43,1}.MotorPoint.Coordinates;
    actMotorCoordinates48InOrder3 = JunctureList3{48,1}.MotorPoint.Coordinates;
    actMotorCoordinates52InOrder3 = JunctureList3{52,1}.MotorPoint.Coordinates;
    actMotorCoordinates64InOrder3 = JunctureList3{64,1}.MotorPoint.Coordinates;
    actMotorCoordinates68InOrder3 = JunctureList3{68,1}.MotorPoint.Coordinates;
    actMotorCoordinates72InOrder3 = JunctureList3{72,1}.MotorPoint.Coordinates;

    actPerceptualCoordinates3InOrder1 = JunctureList1{3,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates4InOrder1 = JunctureList1{4,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates18InOrder1 = JunctureList1{18,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates24InOrder1 = JunctureList1{24,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates33InOrder1 = JunctureList1{33,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates34InOrder1 = JunctureList1{34,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates43InOrder1 = JunctureList1{43,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates48InOrder1 = JunctureList1{48,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates52InOrder1 = JunctureList1{52,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates64InOrder1 = JunctureList1{64,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates68InOrder1 = JunctureList1{68,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates72InOrder1 = JunctureList1{72,1}.PerceptualPoint.Coordinates;

    actPerceptualCoordinates3InOrder2 = JunctureList2{3,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates4InOrder2 = JunctureList2{4,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates18InOrder2 = JunctureList2{18,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates24InOrder2 = JunctureList2{24,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates33InOrder2 = JunctureList2{33,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates34InOrder2 = JunctureList2{34,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates43InOrder2 = JunctureList2{43,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates48InOrder2 = JunctureList2{48,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates52InOrder2 = JunctureList2{52,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates64InOrder2 = JunctureList2{64,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates68InOrder2 = JunctureList2{68,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates72InOrder2 = JunctureList2{72,1}.PerceptualPoint.Coordinates;

    actPerceptualCoordinates3InOrder3 = JunctureList3{3,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates4InOrder3 = JunctureList3{4,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates18InOrder3 = JunctureList3{18,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates24InOrder3 = JunctureList3{24,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates33InOrder3 = JunctureList3{33,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates34InOrder3 = JunctureList3{34,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates43InOrder3 = JunctureList3{43,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates48InOrder3 = JunctureList3{48,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates52InOrder3 = JunctureList3{52,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates64InOrder3 = JunctureList3{64,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates68InOrder3 = JunctureList3{68,1}.PerceptualPoint.Coordinates;
    actPerceptualCoordinates72InOrder3 = JunctureList3{72,1}.PerceptualPoint.Coordinates;

    % The space transformations
    Transformation1 = testCase.TestData.Space1.SpaceTransformation.TransformationFunction;
    Transformation2 = testCase.TestData.Space2.SpaceTransformation.TransformationFunction;
    Transformation3 = testCase.TestData.Space3.SpaceTransformation.TransformationFunction;

    actTransform1_3_4 = Transformation1([3; 4]);
    actTransform1_24_34 = Transformation1([24; 34]);
    actTransform1_12_34 = Transformation1([12; 34]);

    actTransform2_3_4 = Transformation2([3; 4]);
    actTransform2_24_34 = Transformation2([24; 34]);
    actTransform2_12_34 = Transformation2([12; 34]);

    actTransform3_3_4 = Transformation3([3; 4]);
    actTransform3_24_34 = Transformation3([24; 34]);
    actTransform3_12_34 = Transformation3([12; 34]);

    % The motor bounds
    actMotorBounds1 = testCase.TestData.Space1.MotorBounds;
    actMotorBounds2 = testCase.TestData.Space2.MotorBounds;
    actMotorBounds3 = testCase.TestData.Space3.MotorBounds;

    % The maximum distance with activation
    actMaxDist1 = testCase.TestData.Space1.MaxDistanceWithActivation;
    actMaxDist2 = testCase.TestData.Space2.MaxDistanceWithActivation;
    actMaxDist3 = testCase.TestData.Space3.MaxDistanceWithActivation;

    % The motor coordinate matrices of the different spaces
    expMotorAll1 = [0 0 0 2 2 2 4 4 4 6 6 6; 0 5 10 0 5 10 0 5 10 0 5 10];
    expMotorAll2 = [10 10 10 12 12 12 14 14 14 16 16 16; 
        0 5 10 0 5 10 0 5 10 0 5 10];
    expMotorAll3 = [20 20 20 22 22 22 24 24 24 26 26 26; 
        0 5 10 0 5 10 0 5 10 0 5 10];
    expMotorAll4 = [0 0 0 2 2 2 4 4 4 6 6 6; 
        12 17 22 12 17 22 12 17 22 12 17 22];
    expMotorAll5 = [10 10 10 12 12 12 14 14 14 16 16 16; 
        12 17 22 12 17 22 12 17 22 12 17 22];
    expMotorAll6 = [20 20 20 22 22 22 24 24 24 26 26 26; 
        12 17 22 12 17 22 12 17 22 12 17 22];

    % The perceptual coordinate matrices of the different spaces
    expPerceptual21 = [10 10 10 8 8 8 6 6 6 4 4 4; 
        10 5 0 10 5 0 10 5 0 10 5 0];
    expPerceptual22 = [0 0 0 -2 -2 -2 -4 -4 -4 -6 -6 -6; 
        10 5 0 10 5 0 10 5 0 10 5 0];
    expPerceptual23 = [-10 -10 -10 -12 -12 -12 -14 -14 -14 -16 -16 -16; 
        10 5 0 10 5 0 10 5 0 10 5 0];
    expPerceptual24 = [10 10 10 8 8 8 6 6 6 4 4 4; 
        -2 -7 -12 -2 -7 -12 -2 -7 -12 -2 -7 -12];
    expPerceptual25 = [0 0 0 -2 -2 -2 -4 -4 -4 -6 -6 -6; 
        -2 -7 -12 -2 -7 -12 -2 -7 -12 -2 -7 -12];
    expPerceptual26 = [-10 -10 -10 -12 -12 -12 -14 -14 -14 -16 -16 -16; 
        -2 -7 -12 -2 -7 -12 -2 -7 -12 -2 -7 -12];

    expPerceptual31 = [0 0 0 2 2 2 4 4 4 6 6 6; 0 5 10 0 5 10 0 5 10 0 5 10];
    expPerceptual32 = [10 10 10 12 12 12 14 14 14 16 16 16; 
        0 5 10 0 5 10 0 5 10 0 5 10];
    expPerceptual33 = [20 20 20 22 22 22 24 24 24 26 26 26; 
        0 5 10 0 5 10 0 5 10 0 5 10];
    expPerceptual34 = [10 10 10 12 12 12 14 14 14 16 16 16; 
        12 17 22 12 17 22 12 17 22 12 17 22];
    expPerceptual35 = [20 20 20 22 22 22 24 24 24 26 26 26; 
        12 17 22 12 17 22 12 17 22 12 17 22];
    expPerceptual36 = [0 0 0 2 2 2 4 4 4 6 6 6; 
        12 17 22 12 17 22 12 17 22 12 17 22];

    % The cluster sizes
    expClusterSizes1 = [12; 12; 12; 12; 12; 12];
    expClusterSizes2 = [12; 12; 12; 12; 12; 12];
    expClusterSizes3 = [12; 12; 12; 12; 12; 12];

    % The canonical juncture order
    expCanonicalOrderSize1 = [72 1];
    expCanonicalOrderSize2 = [72 1];
    expCanonicalOrderSize3 = [72 1];

    expMotorCoordinates3InOrderAll = [0; 10];
    expMotorCoordinates4InOrderAll = [2; 0];
    expMotorCoordinates18InOrderAll = [12; 10];
    expMotorCoordinates24InOrderAll = [16; 10];
    expMotorCoordinates33InOrderAll = [24; 10];
    expMotorCoordinates34InOrderAll = [26; 0];
    expMotorCoordinates43InOrderAll = [4; 12];
    expMotorCoordinates48InOrderAll = [6; 22];
    expMotorCoordinates52InOrderAll = [12; 12];
    expMotorCoordinates64InOrderAll = [22; 12];
    expMotorCoordinates68InOrderAll = [24; 17];
    expMotorCoordinates72InOrderAll = [26; 22];

    expPerceptualCoordinates3InOrder1 = [0; 10];
    expPerceptualCoordinates4InOrder1 = [2; 0];
    expPerceptualCoordinates18InOrder1 = [12; 10];
    expPerceptualCoordinates24InOrder1 = [16; 10];
    expPerceptualCoordinates33InOrder1 = [24; 10];
    expPerceptualCoordinates34InOrder1 = [26; 0];
    expPerceptualCoordinates43InOrder1 = [4; 12];
    expPerceptualCoordinates48InOrder1 = [6; 22];
    expPerceptualCoordinates52InOrder1 = [12; 12];
    expPerceptualCoordinates64InOrder1 = [22; 12];
    expPerceptualCoordinates68InOrder1 = [24; 17];
    expPerceptualCoordinates72InOrder1 = [26; 22];

    expPerceptualCoordinates3InOrder2 = [10; 0];
    expPerceptualCoordinates4InOrder2 = [8; 10];
    expPerceptualCoordinates18InOrder2 = [-2; 0];
    expPerceptualCoordinates24InOrder2 = [-6; 0];
    expPerceptualCoordinates33InOrder2 = [-14; 0];
    expPerceptualCoordinates34InOrder2 = [-16; 10];
    expPerceptualCoordinates43InOrder2 = [6; -2];
    expPerceptualCoordinates48InOrder2 = [4; -12];
    expPerceptualCoordinates52InOrder2 = [-2; -2];
    expPerceptualCoordinates64InOrder2 = [-12; -2];
    expPerceptualCoordinates68InOrder2 = [-14; -7];
    expPerceptualCoordinates72InOrder2 = [-16; -12];

    expPerceptualCoordinates3InOrder3 = [0; 10];
    expPerceptualCoordinates4InOrder3 = [2; 0];
    expPerceptualCoordinates18InOrder3 = [12; 10];
    expPerceptualCoordinates24InOrder3 = [16; 10];
    expPerceptualCoordinates33InOrder3 = [24; 10];
    expPerceptualCoordinates34InOrder3 = [26; 0];
    expPerceptualCoordinates43InOrder3 = [14; 12];
    expPerceptualCoordinates48InOrder3 = [16; 22];
    expPerceptualCoordinates52InOrder3 = [22; 12];
    expPerceptualCoordinates64InOrder3 = [2; 12];
    expPerceptualCoordinates68InOrder3 = [4; 17];
    expPerceptualCoordinates72InOrder3 = [6; 22];

    % The space transformations
    expTransform1_3_4 = [3; 4];
    expTransform1_24_34 = [24; 34];
    expTransform1_12_34 = [12; 34];

    expTransform2_3_4 = [7; 6];
    expTransform2_24_34 = [-14; -24];
    expTransform2_12_34 = [-2; -24];

    expTransform3_3_4 = [3; 4];
    expTransform3_24_34 = [4; 34];
    expTransform3_12_34 = [22; 34];

    % The motor bounds
    expMotorBounds1 = [0 0];
    expMotorBounds2 = [0 0];
    expMotorBounds3 = [0 0];

    % The maximum distance with activation
    expMaxDist1 = 10;
    expMaxDist2 = 10;
    expMaxDist3 = 10;

    % The motor coordinate matrices of the different spaces
    verifyEqual(testCase, actMotor11, expMotorAll1);
    verifyEqual(testCase, actMotor12, expMotorAll2);
    verifyEqual(testCase, actMotor13, expMotorAll3);
    verifyEqual(testCase, actMotor14, expMotorAll4);
    verifyEqual(testCase, actMotor15, expMotorAll5);
    verifyEqual(testCase, actMotor16, expMotorAll6);

    verifyEqual(testCase, actMotor21, expMotorAll1);
    verifyEqual(testCase, actMotor22, expMotorAll2);
    verifyEqual(testCase, actMotor23, expMotorAll3);
    verifyEqual(testCase, actMotor24, expMotorAll4);
    verifyEqual(testCase, actMotor25, expMotorAll5);
    verifyEqual(testCase, actMotor26, expMotorAll6);

    % The perceptual coordinate matrices of the different spaces
    verifyEqual(testCase, actPerceptual21, expPerceptual21);
    verifyEqual(testCase, actPerceptual22, expPerceptual22);
    verifyEqual(testCase, actPerceptual23, expPerceptual23);
    verifyEqual(testCase, actPerceptual24, expPerceptual24);
    verifyEqual(testCase, actPerceptual25, expPerceptual25);
    verifyEqual(testCase, actPerceptual26, expPerceptual26);

    verifyEqual(testCase, actPerceptual31, expPerceptual31);
    verifyEqual(testCase, actPerceptual32, expPerceptual32);
    verifyEqual(testCase, actPerceptual33, expPerceptual33);
    verifyEqual(testCase, actPerceptual34, expPerceptual34);
    verifyEqual(testCase, actPerceptual35, expPerceptual35);
    verifyEqual(testCase, actPerceptual36, expPerceptual36);

    % The cluster sizes
    verifyEqual(testCase, actClusterSizes1, expClusterSizes1);
    verifyEqual(testCase, actClusterSizes2, expClusterSizes2);
    verifyEqual(testCase, actClusterSizes3, expClusterSizes3);

    % The canonical juncture order
    verifyEqual(testCase, actCanonicalOrderSize1, expCanonicalOrderSize1);
    verifyEqual(testCase, actCanonicalOrderSize2, expCanonicalOrderSize2);
    verifyEqual(testCase, actCanonicalOrderSize3, expCanonicalOrderSize3);

    verifyEqual(testCase, actMotorCoordinates3InOrder1, expMotorCoordinates3InOrderAll);
    verifyEqual(testCase, actMotorCoordinates4InOrder1, expMotorCoordinates4InOrderAll);
    verifyEqual(testCase, actMotorCoordinates18InOrder1, expMotorCoordinates18InOrderAll);
    verifyEqual(testCase, actMotorCoordinates24InOrder1, expMotorCoordinates24InOrderAll);
    verifyEqual(testCase, actMotorCoordinates33InOrder1, expMotorCoordinates33InOrderAll);
    verifyEqual(testCase, actMotorCoordinates34InOrder1, expMotorCoordinates34InOrderAll);
    verifyEqual(testCase, actMotorCoordinates43InOrder1, expMotorCoordinates43InOrderAll);
    verifyEqual(testCase, actMotorCoordinates48InOrder1, expMotorCoordinates48InOrderAll);
    verifyEqual(testCase, actMotorCoordinates52InOrder1, expMotorCoordinates52InOrderAll);
    verifyEqual(testCase, actMotorCoordinates64InOrder1, expMotorCoordinates64InOrderAll);
    verifyEqual(testCase, actMotorCoordinates68InOrder1, expMotorCoordinates68InOrderAll);
    verifyEqual(testCase, actMotorCoordinates72InOrder1, expMotorCoordinates72InOrderAll);

    verifyEqual(testCase, actMotorCoordinates3InOrder2, expMotorCoordinates3InOrderAll);
    verifyEqual(testCase, actMotorCoordinates4InOrder2, expMotorCoordinates4InOrderAll);
    verifyEqual(testCase, actMotorCoordinates18InOrder2, expMotorCoordinates18InOrderAll);
    verifyEqual(testCase, actMotorCoordinates24InOrder2, expMotorCoordinates24InOrderAll);
    verifyEqual(testCase, actMotorCoordinates33InOrder2, expMotorCoordinates33InOrderAll);
    verifyEqual(testCase, actMotorCoordinates34InOrder2, expMotorCoordinates34InOrderAll);
    verifyEqual(testCase, actMotorCoordinates43InOrder2, expMotorCoordinates43InOrderAll);
    verifyEqual(testCase, actMotorCoordinates48InOrder2, expMotorCoordinates48InOrderAll);
    verifyEqual(testCase, actMotorCoordinates52InOrder2, expMotorCoordinates52InOrderAll);
    verifyEqual(testCase, actMotorCoordinates64InOrder2, expMotorCoordinates64InOrderAll);
    verifyEqual(testCase, actMotorCoordinates68InOrder2, expMotorCoordinates68InOrderAll);
    verifyEqual(testCase, actMotorCoordinates72InOrder2, expMotorCoordinates72InOrderAll);

    verifyEqual(testCase, actMotorCoordinates3InOrder3, expMotorCoordinates3InOrderAll);
    verifyEqual(testCase, actMotorCoordinates4InOrder3, expMotorCoordinates4InOrderAll);
    verifyEqual(testCase, actMotorCoordinates18InOrder3, expMotorCoordinates18InOrderAll);
    verifyEqual(testCase, actMotorCoordinates24InOrder3, expMotorCoordinates24InOrderAll);
    verifyEqual(testCase, actMotorCoordinates33InOrder3, expMotorCoordinates33InOrderAll);
    verifyEqual(testCase, actMotorCoordinates34InOrder3, expMotorCoordinates34InOrderAll);
    verifyEqual(testCase, actMotorCoordinates43InOrder3, expMotorCoordinates43InOrderAll);
    verifyEqual(testCase, actMotorCoordinates48InOrder3, expMotorCoordinates48InOrderAll);
    verifyEqual(testCase, actMotorCoordinates52InOrder3, expMotorCoordinates52InOrderAll);
    verifyEqual(testCase, actMotorCoordinates64InOrder3, expMotorCoordinates64InOrderAll);
    verifyEqual(testCase, actMotorCoordinates68InOrder3, expMotorCoordinates68InOrderAll);
    verifyEqual(testCase, actMotorCoordinates72InOrder3, expMotorCoordinates72InOrderAll);

    verifyEqual(testCase, actPerceptualCoordinates3InOrder1, expPerceptualCoordinates3InOrder1);
    verifyEqual(testCase, actPerceptualCoordinates4InOrder1, expPerceptualCoordinates4InOrder1);
    verifyEqual(testCase, actPerceptualCoordinates18InOrder1, expPerceptualCoordinates18InOrder1);
    verifyEqual(testCase, actPerceptualCoordinates24InOrder1, expPerceptualCoordinates24InOrder1);
    verifyEqual(testCase, actPerceptualCoordinates33InOrder1, expPerceptualCoordinates33InOrder1);
    verifyEqual(testCase, actPerceptualCoordinates34InOrder1, expPerceptualCoordinates34InOrder1);
    verifyEqual(testCase, actPerceptualCoordinates43InOrder1, expPerceptualCoordinates43InOrder1);
    verifyEqual(testCase, actPerceptualCoordinates48InOrder1, expPerceptualCoordinates48InOrder1);
    verifyEqual(testCase, actPerceptualCoordinates52InOrder1, expPerceptualCoordinates52InOrder1);
    verifyEqual(testCase, actPerceptualCoordinates64InOrder1, expPerceptualCoordinates64InOrder1);
    verifyEqual(testCase, actPerceptualCoordinates68InOrder1, expPerceptualCoordinates68InOrder1);
    verifyEqual(testCase, actPerceptualCoordinates72InOrder1, expPerceptualCoordinates72InOrder1);

    verifyEqual(testCase, actPerceptualCoordinates3InOrder2, expPerceptualCoordinates3InOrder2);
    verifyEqual(testCase, actPerceptualCoordinates4InOrder2, expPerceptualCoordinates4InOrder2);
    verifyEqual(testCase, actPerceptualCoordinates18InOrder2, expPerceptualCoordinates18InOrder2);
    verifyEqual(testCase, actPerceptualCoordinates24InOrder2, expPerceptualCoordinates24InOrder2);
    verifyEqual(testCase, actPerceptualCoordinates33InOrder2, expPerceptualCoordinates33InOrder2);
    verifyEqual(testCase, actPerceptualCoordinates34InOrder2, expPerceptualCoordinates34InOrder2);
    verifyEqual(testCase, actPerceptualCoordinates43InOrder2, expPerceptualCoordinates43InOrder2);
    verifyEqual(testCase, actPerceptualCoordinates48InOrder2, expPerceptualCoordinates48InOrder2);
    verifyEqual(testCase, actPerceptualCoordinates52InOrder2, expPerceptualCoordinates52InOrder2);
    verifyEqual(testCase, actPerceptualCoordinates64InOrder2, expPerceptualCoordinates64InOrder2);
    verifyEqual(testCase, actPerceptualCoordinates68InOrder2, expPerceptualCoordinates68InOrder2);
    verifyEqual(testCase, actPerceptualCoordinates72InOrder2, expPerceptualCoordinates72InOrder2);

    verifyEqual(testCase, actPerceptualCoordinates3InOrder3, expPerceptualCoordinates3InOrder3);
    verifyEqual(testCase, actPerceptualCoordinates4InOrder3, expPerceptualCoordinates4InOrder3);
    verifyEqual(testCase, actPerceptualCoordinates18InOrder3, expPerceptualCoordinates18InOrder3);
    verifyEqual(testCase, actPerceptualCoordinates24InOrder3, expPerceptualCoordinates24InOrder3);
    verifyEqual(testCase, actPerceptualCoordinates33InOrder3, expPerceptualCoordinates33InOrder3);
    verifyEqual(testCase, actPerceptualCoordinates34InOrder3, expPerceptualCoordinates34InOrder3);
    verifyEqual(testCase, actPerceptualCoordinates43InOrder3, expPerceptualCoordinates43InOrder3);
    verifyEqual(testCase, actPerceptualCoordinates48InOrder3, expPerceptualCoordinates48InOrder3);
    verifyEqual(testCase, actPerceptualCoordinates52InOrder3, expPerceptualCoordinates52InOrder3);
    verifyEqual(testCase, actPerceptualCoordinates64InOrder3, expPerceptualCoordinates64InOrder3);
    verifyEqual(testCase, actPerceptualCoordinates68InOrder3, expPerceptualCoordinates68InOrder3);
    verifyEqual(testCase, actPerceptualCoordinates72InOrder3, expPerceptualCoordinates72InOrder3);
    
    % The space transformations
    verifyEqual(testCase, actTransform1_3_4, expTransform1_3_4);
    verifyEqual(testCase, actTransform1_24_34, expTransform1_24_34);
    verifyEqual(testCase, actTransform1_12_34, expTransform1_12_34);

    verifyEqual(testCase, actTransform2_3_4, expTransform2_3_4);
    verifyEqual(testCase, actTransform2_24_34, expTransform2_24_34);
    verifyEqual(testCase, actTransform2_12_34, expTransform2_12_34);

    verifyEqual(testCase, actTransform3_3_4, expTransform3_3_4);
    verifyEqual(testCase, actTransform3_24_34, expTransform3_24_34);
    verifyEqual(testCase, actTransform3_12_34, expTransform3_12_34);

    % The motor bounds
    verifyEqual(testCase, actMotorBounds1, expMotorBounds1);
    verifyEqual(testCase, actMotorBounds2, expMotorBounds2);
    verifyEqual(testCase, actMotorBounds3, expMotorBounds3);

    % The maximum distance with activation
    verifyEqual(testCase, actMaxDist1, expMaxDist1);
    verifyEqual(testCase, actMaxDist2, expMaxDist2);
    verifyEqual(testCase, actMaxDist3, expMaxDist3);
end

%% NOT IN USE

% function TestActivationFromPerceptualPoint(testCase)
%     verifyEqual(testCase, 0, 1);
% end
% 
% function TestJustGreatestActivationFromTraj(testCase)
%     verifyEqual(testCase, 0, 1);
% end
% 
% function TestActivations_SumFromTraj(testCase)
%     verifyEqual(testCase, 0, 1);
% end
% 
% function TestCorrectionActivation(testCase)
%     verifyEqual(testCase, 0, 1);
% end
% 
% function TestCorrectionActivationProportional(testCase)
%     verifyEqual(testCase, 0, 1);
% end
% 
% function TestCorrectionActivationMultiplier(testCase)
%     verifyEqual(testCase, 0, 1);
% end
% 
% function TestCorrectionActivationRaw(testCase)
%     verifyEqual(testCase, 0, 1);
% end
% 
% function TestCorrectionActivationCutAtZero(testCase)
%     verifyEqual(testCase, 0, 1);
% end
% 
% function TestCorrectionActivationShiftedToPositive(testCase)
%     verifyEqual(testCase, 0, 1);
% end
% 
% function TestQuantizeJunctureActivationPattern(testCase)
%     verifyEqual(testCase, 0, 1);
% end
%% 

function TestThresholdJunctureActivationPattern(testCase)
    ActivationPatternA = [0; 2; 8; 3; 6; -4];
    ActivationPatternB = [0.2; 0.4; 0.6; 0.75; 0.1; 0.33];
    ActivationPatternC = [-34; -0.3; 0; 0; 0];
    ActivationPatternD = [0.8; 0.4];
    Threshold_a = 3;
    Threshold_b = 0.8;
    Threshold_c = -5;
    Threshold_d = 0.6;

    actNewActivationPattern1Aa = ...
        testCase.TestData.Space1.ThresholdJunctureActivationPattern( ...
        ActivationPatternA, Threshold_a);
    actNewActivationPattern2Aa = ...
        testCase.TestData.Space2.ThresholdJunctureActivationPattern( ...
        ActivationPatternA, Threshold_a);
    actNewActivationPattern3Aa = ...
        testCase.TestData.Space3.ThresholdJunctureActivationPattern( ...
        ActivationPatternA, Threshold_a);
    actNewActivationPattern1Ab = ...
        testCase.TestData.Space1.ThresholdJunctureActivationPattern( ...
        ActivationPatternA, Threshold_b);
    actNewActivationPattern2Ab = ...
        testCase.TestData.Space2.ThresholdJunctureActivationPattern( ...
        ActivationPatternA, Threshold_b);
    actNewActivationPattern3Ab = ...
        testCase.TestData.Space3.ThresholdJunctureActivationPattern( ...
        ActivationPatternA, Threshold_b);
    actNewActivationPattern1Ac = ...
        testCase.TestData.Space1.ThresholdJunctureActivationPattern( ...
        ActivationPatternA, Threshold_c);
    actNewActivationPattern2Ac = ...
        testCase.TestData.Space2.ThresholdJunctureActivationPattern( ...
        ActivationPatternA, Threshold_c);
    actNewActivationPattern3Ac = ...
        testCase.TestData.Space3.ThresholdJunctureActivationPattern( ...
        ActivationPatternA, Threshold_c);
    actNewActivationPattern1Ad = ...
        testCase.TestData.Space1.ThresholdJunctureActivationPattern( ...
        ActivationPatternA, Threshold_d);
    actNewActivationPattern2Ad = ...
        testCase.TestData.Space2.ThresholdJunctureActivationPattern( ...
        ActivationPatternA, Threshold_d);
    actNewActivationPattern3Ad = ...
        testCase.TestData.Space3.ThresholdJunctureActivationPattern( ...
        ActivationPatternA, Threshold_d);

    actNewActivationPattern1Ba = ...
        testCase.TestData.Space1.ThresholdJunctureActivationPattern( ...
        ActivationPatternB, Threshold_a);
    actNewActivationPattern2Ba = ...
        testCase.TestData.Space2.ThresholdJunctureActivationPattern( ...
        ActivationPatternB, Threshold_a);
    actNewActivationPattern3Ba = ...
        testCase.TestData.Space3.ThresholdJunctureActivationPattern( ...
        ActivationPatternB, Threshold_a);
    actNewActivationPattern1Bb = ...
        testCase.TestData.Space1.ThresholdJunctureActivationPattern( ...
        ActivationPatternB, Threshold_b);
    actNewActivationPattern2Bb = ...
        testCase.TestData.Space2.ThresholdJunctureActivationPattern( ...
        ActivationPatternB, Threshold_b);
    actNewActivationPattern3Bb = ...
        testCase.TestData.Space3.ThresholdJunctureActivationPattern( ...
        ActivationPatternB, Threshold_b);
    actNewActivationPattern1Bc = ...
        testCase.TestData.Space1.ThresholdJunctureActivationPattern( ...
        ActivationPatternB, Threshold_c);
    actNewActivationPattern2Bc = ...
        testCase.TestData.Space2.ThresholdJunctureActivationPattern( ...
        ActivationPatternB, Threshold_c);
    actNewActivationPattern3Bc = ...
        testCase.TestData.Space3.ThresholdJunctureActivationPattern( ...
        ActivationPatternB, Threshold_c);
    actNewActivationPattern1Bd = ...
        testCase.TestData.Space1.ThresholdJunctureActivationPattern( ...
        ActivationPatternB, Threshold_d);
    actNewActivationPattern2Bd = ...
        testCase.TestData.Space2.ThresholdJunctureActivationPattern( ...
        ActivationPatternB, Threshold_d);
    actNewActivationPattern3Bd = ...
        testCase.TestData.Space3.ThresholdJunctureActivationPattern( ...
        ActivationPatternB, Threshold_d);

    actNewActivationPattern1Ca = ...
        testCase.TestData.Space1.ThresholdJunctureActivationPattern( ...
        ActivationPatternC, Threshold_a);
    actNewActivationPattern2Ca = ...
        testCase.TestData.Space2.ThresholdJunctureActivationPattern( ...
        ActivationPatternC, Threshold_a);
    actNewActivationPattern3Ca = ...
        testCase.TestData.Space3.ThresholdJunctureActivationPattern( ...
        ActivationPatternC, Threshold_a);
    actNewActivationPattern1Cb = ...
        testCase.TestData.Space1.ThresholdJunctureActivationPattern( ...
        ActivationPatternC, Threshold_b);
    actNewActivationPattern2Cb = ...
        testCase.TestData.Space2.ThresholdJunctureActivationPattern( ...
        ActivationPatternC, Threshold_b);
    actNewActivationPattern3Cb = ...
        testCase.TestData.Space3.ThresholdJunctureActivationPattern( ...
        ActivationPatternC, Threshold_b);
    actNewActivationPattern1Cc = ...
        testCase.TestData.Space1.ThresholdJunctureActivationPattern( ...
        ActivationPatternC, Threshold_c);
    actNewActivationPattern2Cc = ...
        testCase.TestData.Space2.ThresholdJunctureActivationPattern( ...
        ActivationPatternC, Threshold_c);
    actNewActivationPattern3Cc = ...
        testCase.TestData.Space3.ThresholdJunctureActivationPattern( ...
        ActivationPatternC, Threshold_c);
    actNewActivationPattern1Cd = ...
        testCase.TestData.Space1.ThresholdJunctureActivationPattern( ...
        ActivationPatternC, Threshold_d);
    actNewActivationPattern2Cd = ...
        testCase.TestData.Space2.ThresholdJunctureActivationPattern( ...
        ActivationPatternC, Threshold_d);
    actNewActivationPattern3Cd = ...
        testCase.TestData.Space3.ThresholdJunctureActivationPattern( ...
        ActivationPatternC, Threshold_d);

    actNewActivationPattern1Da = ...
        testCase.TestData.Space1.ThresholdJunctureActivationPattern( ...
        ActivationPatternD, Threshold_a);
    actNewActivationPattern2Da = ...
        testCase.TestData.Space2.ThresholdJunctureActivationPattern( ...
        ActivationPatternD, Threshold_a);
    actNewActivationPattern3Da = ...
        testCase.TestData.Space3.ThresholdJunctureActivationPattern( ...
        ActivationPatternD, Threshold_a);
    actNewActivationPattern1Db = ...
        testCase.TestData.Space1.ThresholdJunctureActivationPattern( ...
        ActivationPatternD, Threshold_b);
    actNewActivationPattern2Db = ...
        testCase.TestData.Space2.ThresholdJunctureActivationPattern( ...
        ActivationPatternD, Threshold_b);
    actNewActivationPattern3Db = ...
        testCase.TestData.Space3.ThresholdJunctureActivationPattern( ...
        ActivationPatternD, Threshold_b);
    actNewActivationPattern1Dc = ...
        testCase.TestData.Space1.ThresholdJunctureActivationPattern( ...
        ActivationPatternD, Threshold_c);
    actNewActivationPattern2Dc = ...
        testCase.TestData.Space2.ThresholdJunctureActivationPattern( ...
        ActivationPatternD, Threshold_c);
    actNewActivationPattern3Dc = ...
        testCase.TestData.Space3.ThresholdJunctureActivationPattern( ...
        ActivationPatternD, Threshold_c);
    actNewActivationPattern1Dd = ...
        testCase.TestData.Space1.ThresholdJunctureActivationPattern( ...
        ActivationPatternD, Threshold_d);
    actNewActivationPattern2Dd = ...
        testCase.TestData.Space2.ThresholdJunctureActivationPattern( ...
        ActivationPatternD, Threshold_d);
    actNewActivationPattern3Dd = ...
        testCase.TestData.Space3.ThresholdJunctureActivationPattern( ...
        ActivationPatternD, Threshold_d);

    expNewActivationPatternAa = [0; 2; 1; 1; 1; -4];
    expNewActivationPatternAb = [0; 1; 1; 1; 1; -4];
    expNewActivationPatternAc = [1; 1; 1; 1; 1; 1];
    expNewActivationPatternAd = [0; 1; 1; 1; 1; -4];
    expNewActivationPatternBa = [0.2; 0.4; 0.6; 0.75; 0.1; 0.33];
    expNewActivationPatternBb = [0.2; 0.4; 0.6; 0.75; 0.1; 0.33];
    expNewActivationPatternBc = [1; 1; 1; 1; 1; 1];
    expNewActivationPatternBd = [0.2; 0.4; 1; 1; 0.1; 0.33];
    expNewActivationPatternCa = [-34; -0.3; 0; 0; 0];
    expNewActivationPatternCb = [-34; -0.3; 0; 0; 0];
    expNewActivationPatternCc = [-34; 1; 1; 1; 1];
    expNewActivationPatternCd = [-34; -0.3; 0; 0; 0];
    expNewActivationPatternDa = [0.8; 0.4];
    expNewActivationPatternDb = [1; 0.4];
    expNewActivationPatternDc = [1; 1];
    expNewActivationPatternDd = [1; 0.4];

    verifyEqual(testCase, actNewActivationPattern1Aa, expNewActivationPatternAa);
    verifyEqual(testCase, actNewActivationPattern2Aa, expNewActivationPatternAa);
    verifyEqual(testCase, actNewActivationPattern3Aa, expNewActivationPatternAa);
    verifyEqual(testCase, actNewActivationPattern1Ab, expNewActivationPatternAb);
    verifyEqual(testCase, actNewActivationPattern2Ab, expNewActivationPatternAb);
    verifyEqual(testCase, actNewActivationPattern3Ab, expNewActivationPatternAb);
    verifyEqual(testCase, actNewActivationPattern1Ac, expNewActivationPatternAc);
    verifyEqual(testCase, actNewActivationPattern2Ac, expNewActivationPatternAc);
    verifyEqual(testCase, actNewActivationPattern3Ac, expNewActivationPatternAc);
    verifyEqual(testCase, actNewActivationPattern1Ad, expNewActivationPatternAd);
    verifyEqual(testCase, actNewActivationPattern2Ad, expNewActivationPatternAd);
    verifyEqual(testCase, actNewActivationPattern3Ad, expNewActivationPatternAd);

    verifyEqual(testCase, actNewActivationPattern1Ba, expNewActivationPatternBa);
    verifyEqual(testCase, actNewActivationPattern2Ba, expNewActivationPatternBa);
    verifyEqual(testCase, actNewActivationPattern3Ba, expNewActivationPatternBa);
    verifyEqual(testCase, actNewActivationPattern1Bb, expNewActivationPatternBb);
    verifyEqual(testCase, actNewActivationPattern2Bb, expNewActivationPatternBb);
    verifyEqual(testCase, actNewActivationPattern3Bb, expNewActivationPatternBb);
    verifyEqual(testCase, actNewActivationPattern1Bc, expNewActivationPatternBc);
    verifyEqual(testCase, actNewActivationPattern2Bc, expNewActivationPatternBc);
    verifyEqual(testCase, actNewActivationPattern3Bc, expNewActivationPatternBc);
    verifyEqual(testCase, actNewActivationPattern1Bd, expNewActivationPatternBd);
    verifyEqual(testCase, actNewActivationPattern2Bd, expNewActivationPatternBd);
    verifyEqual(testCase, actNewActivationPattern3Bd, expNewActivationPatternBd);

    verifyEqual(testCase, actNewActivationPattern1Ca, expNewActivationPatternCa);
    verifyEqual(testCase, actNewActivationPattern2Ca, expNewActivationPatternCa);
    verifyEqual(testCase, actNewActivationPattern3Ca, expNewActivationPatternCa);
    verifyEqual(testCase, actNewActivationPattern1Cb, expNewActivationPatternCb);
    verifyEqual(testCase, actNewActivationPattern2Cb, expNewActivationPatternCb);
    verifyEqual(testCase, actNewActivationPattern3Cb, expNewActivationPatternCb);
    verifyEqual(testCase, actNewActivationPattern1Cc, expNewActivationPatternCc);
    verifyEqual(testCase, actNewActivationPattern2Cc, expNewActivationPatternCc);
    verifyEqual(testCase, actNewActivationPattern3Cc, expNewActivationPatternCc);
    verifyEqual(testCase, actNewActivationPattern1Cd, expNewActivationPatternCd);
    verifyEqual(testCase, actNewActivationPattern2Cd, expNewActivationPatternCd);
    verifyEqual(testCase, actNewActivationPattern3Cd, expNewActivationPatternCd);

    verifyEqual(testCase, actNewActivationPattern1Da, expNewActivationPatternDa);
    verifyEqual(testCase, actNewActivationPattern2Da, expNewActivationPatternDa);
    verifyEqual(testCase, actNewActivationPattern3Da, expNewActivationPatternDa);
    verifyEqual(testCase, actNewActivationPattern1Db, expNewActivationPatternDb);
    verifyEqual(testCase, actNewActivationPattern2Db, expNewActivationPatternDb);
    verifyEqual(testCase, actNewActivationPattern3Db, expNewActivationPatternDb);
    verifyEqual(testCase, actNewActivationPattern1Dc, expNewActivationPatternDc);
    verifyEqual(testCase, actNewActivationPattern2Dc, expNewActivationPatternDc);
    verifyEqual(testCase, actNewActivationPattern3Dc, expNewActivationPatternDc);
    verifyEqual(testCase, actNewActivationPattern1Dd, expNewActivationPatternDd);
    verifyEqual(testCase, actNewActivationPattern2Dd, expNewActivationPatternDd);
    verifyEqual(testCase, actNewActivationPattern3Dd, expNewActivationPatternDd);
end

function TestClusterToJunctureActivations(testCase)
    s1 = testCase.TestData.Space1;
    s2 = testCase.TestData.Space2;
    s3 = testCase.TestData.Space3;
    s4 = testCase.TestData.Space4;

    ClusterActivations1 = [5; 8; 3; 4; 5; 6];
    ClusterActivations2 = [0; 0; 1; 0; 2; 3];
    ClusterActivations3 = [10; 20; 15; -34; 34; 43];
    ClusterActivations4 = [33; 44];

    actActivations1 = s1.ClusterToJunctureActivations(ClusterActivations1);
    actActivations2 = s2.ClusterToJunctureActivations(ClusterActivations2);
    actActivations3 = s3.ClusterToJunctureActivations(ClusterActivations3);
    actActivations4 = s4.ClusterToJunctureActivations(ClusterActivations4);

    expActivations1 = [5; 5; 5; 5; 5; 5; 5; 5; 5; 5; 5; 5; ...
        8; 8; 8; 8; 8; 8; 8; 8; 8; 8; 8; 8; ...
        3; 3; 3; 3; 3; 3; 3; 3; 3; 3; 3; 3; ...
        4; 4; 4; 4; 4; 4; 4; 4; 4; 4; 4; 4; ...
        5; 5; 5; 5; 5; 5; 5; 5; 5; 5; 5; 5; ...
        6; 6; 6; 6; 6; 6; 6; 6; 6; 6; 6; 6];
    expActivations2 = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; ...
        0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        2; 2; 2; 2; 2; 2; 2; 2; 2; 2; 2; 2; ...
        3; 3; 3; 3; 3; 3; 3; 3; 3; 3; 3; 3];
    expActivations3 = [10; 10; 10; 10; 10; 10; 10; 10; 10; 10; 10; 10; ...
        20; 20; 20; 20; 20; 20; 20; 20; 20; 20; 20; 20; ...
        15; 15; 15; 15; 15; 15; 15; 15; 15; 15; 15; 15; ...
        -34; -34; -34; -34; -34; -34; -34; -34; -34; -34; -34; -34; ...
        34; 34; 34; 34; 34; 34; 34; 34; 34; 34; 34; 34; ...
        43; 43; 43; 43; 43; 43; 43; 43; 43; 43; 43; 43];
    expActivations4 = [33; 33; 33; 33; 33; 33; 33; 33; ...
        44; 44; 44; 44; 44; 44; 44; 44];

    verifyEqual(testCase, actActivations1, expActivations1);
    verifyEqual(testCase, actActivations2, expActivations2);
    verifyEqual(testCase, actActivations3, expActivations3);
    verifyEqual(testCase, actActivations4, expActivations4);
end

function TestAverageJuncture(testCase)
    s1 = testCase.TestData.Space1;
    s2 = testCase.TestData.Space2;
    s3 = testCase.TestData.Space3;
    s4 = testCase.TestData.Space4;

    JunctureActivationsA = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; ...
        0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];

    JunctureActivationsB = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        0; 0; 0; 0; 0; 0; 0; 0; 0; 1; 0; 0; ...
        1; 0; 1; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        0; 0; 1; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];

    JunctureActivationsC = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        0.6; 0.6; 0.6; 0.6; 0.6; 0.6; 0.6; 0.6; 0.6; 0.6; 0.6; 0.6; ...
        0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; ...
        0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; ...
        0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];

    JunctureActivationsD = [0.3; 0.1; 0.1; 0.1; ...
        0.6; 0.2; 0.2; 0.2; ...
        0.6; 0.2; 0.2; 0.2; ...
        0.3; 0.1; 0.1; 0.1];

    JunctureActivationsE = [12; 2; 1; 2; ...
        8; 1; 4; 6; ...
        4; 8; 5; 2; ...
        12; 1; 2; 2];

    actAverage1A = s1.AverageJuncture(JunctureActivationsA);
    actAverage2A = s2.AverageJuncture(JunctureActivationsA);
    actAverage3A = s3.AverageJuncture(JunctureActivationsA);

    actAverage1B = s1.AverageJuncture(JunctureActivationsB);
    actAverage2B = s2.AverageJuncture(JunctureActivationsB);
    actAverage3B = s3.AverageJuncture(JunctureActivationsB);

    actAverage1C = s1.AverageJuncture(JunctureActivationsC);
    actAverage2C = s2.AverageJuncture(JunctureActivationsC);
    actAverage3C = s3.AverageJuncture(JunctureActivationsC);

    actAverage4D = s4.AverageJuncture(JunctureActivationsD);
    actAverage4E = s4.AverageJuncture(JunctureActivationsE);

    expAverage1AMotor = [3; 17];
    expAverage1APerceptual = [3; 17];
    expAverage2AMotor = [3; 17];
    expAverage2APerceptual = [7; -7];
    expAverage3AMotor = [3; 17];
    expAverage3APerceptual = [13; 17];

    expAverage1BMotor = [9; 14];
    expAverage1BPerceptual = [9; 14];
    expAverage2BMotor = [9; 14];
    expAverage2BPerceptual = [1; -4];
    expAverage3BMotor = [9; 14];
    expAverage3BPerceptual = [19; 14];

    expAverage1CMotor = [16.75; 6.5];
    expAverage1CPerceptual = [16.75; 6.5];
    expAverage2CMotor = [16.75; 6.5];
    expAverage2CPerceptual = [-6.75; 3.5];
    expAverage3CMotor = [16.75; 6.5];
    expAverage3CPerceptual = [16.75; 6.5];

    expAverage4DMotor = [2.5; 2];
    expAverage4DPerceptual = [2.5; 2];

    expAverage4EMotor = [2.5; 2];
    expAverage4EPerceptual = [2.5; 2];

    verifyEqual(testCase, actAverage1A.MotorPoint.Coordinates, expAverage1AMotor, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage1A.PerceptualPoint.Coordinates, expAverage1APerceptual, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage2A.MotorPoint.Coordinates, expAverage2AMotor, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage2A.PerceptualPoint.Coordinates, expAverage2APerceptual, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage3A.MotorPoint.Coordinates, expAverage3AMotor, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage3A.PerceptualPoint.Coordinates, expAverage3APerceptual, "AbsTol", 0.001);

    verifyEqual(testCase, actAverage1B.MotorPoint.Coordinates, expAverage1BMotor, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage1B.PerceptualPoint.Coordinates, expAverage1BPerceptual, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage2B.MotorPoint.Coordinates, expAverage2BMotor, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage2B.PerceptualPoint.Coordinates, expAverage2BPerceptual, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage3B.MotorPoint.Coordinates, expAverage3BMotor, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage3B.PerceptualPoint.Coordinates, expAverage3BPerceptual, "AbsTol", 0.001);

    verifyEqual(testCase, actAverage1C.MotorPoint.Coordinates, expAverage1CMotor, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage1C.PerceptualPoint.Coordinates, expAverage1CPerceptual, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage2C.MotorPoint.Coordinates, expAverage2CMotor, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage2C.PerceptualPoint.Coordinates, expAverage2CPerceptual, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage3C.MotorPoint.Coordinates, expAverage3CMotor, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage3C.PerceptualPoint.Coordinates, expAverage3CPerceptual, "AbsTol", 0.001);

    verifyEqual(testCase, actAverage4D.MotorPoint.Coordinates, expAverage4DMotor, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage4D.PerceptualPoint.Coordinates, expAverage4DPerceptual, "AbsTol", 0.001);

    verifyEqual(testCase, actAverage4E.MotorPoint.Coordinates, expAverage4EMotor, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage4E.PerceptualPoint.Coordinates, expAverage4EPerceptual, "AbsTol", 0.001);
end

% function TestActivationWeightedAverageJuncture(testCase)
%     verifyEqual(testCase, 0, 1);
% end

function TestPositiveActivationWeightedAverageJuncture(testCase)
    s1 = testCase.TestData.Space1;
    s2 = testCase.TestData.Space2;
    s3 = testCase.TestData.Space3;
    s4 = testCase.TestData.Space4;

    JunctureActivationsA = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; ...
        0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];

    JunctureActivationsB = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        0; 0; 0; 0; 0; 0; 0; 0; 0; 1; 0; 0; ...
        1; 0; 1; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        0; 0; 1; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];

    JunctureActivationsC = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        0.6; 0.6; 0.6; 0.6; 0.6; 0.6; 0.6; 0.6; 0.6; 0.6; 0.6; 0.6; ...
        0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; ...
        0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; ...
        0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; ...
        0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];

    JunctureActivationsD = [0.3; 0.1; 0.1; 0.1; ...
        0.6; 0.2; 0.2; 0.2; ...
        0.6; 0.2; 0.2; 0.2; ...
        0.3; 0.1; 0.1; 0.1];

    JunctureActivationsE = [12; 2; 1; 2; ...
        8; 1; 4; 6; ...
        4; 8; 5; 2; ...
        12; 1; 2; 2];

    actAverage1A = s1.PositiveActivationWeightedAverageJuncture(JunctureActivationsA);
    actAverage2A = s2.PositiveActivationWeightedAverageJuncture(JunctureActivationsA);
    actAverage3A = s3.PositiveActivationWeightedAverageJuncture(JunctureActivationsA);

    actAverage1B = s1.PositiveActivationWeightedAverageJuncture(JunctureActivationsB);
    actAverage2B = s2.PositiveActivationWeightedAverageJuncture(JunctureActivationsB);
    actAverage3B = s3.PositiveActivationWeightedAverageJuncture(JunctureActivationsB);

    actAverage1C = s1.PositiveActivationWeightedAverageJuncture(JunctureActivationsC);
    actAverage2C = s2.PositiveActivationWeightedAverageJuncture(JunctureActivationsC);
    actAverage3C = s3.PositiveActivationWeightedAverageJuncture(JunctureActivationsC);

    actAverage4D = s4.PositiveActivationWeightedAverageJuncture(JunctureActivationsD);
    actAverage4E = s4.PositiveActivationWeightedAverageJuncture(JunctureActivationsE);

    expAverage1AMotor = [3; 17];
    expAverage1APerceptual = [3; 17];
    expAverage2AMotor = [3; 17];
    expAverage2APerceptual = [7; -7];
    expAverage3AMotor = [3; 17];
    expAverage3APerceptual = [13; 17];

    expAverage1BMotor = [9; 14];
    expAverage1BPerceptual = [9; 14];
    expAverage2BMotor = [9; 14];
    expAverage2BPerceptual = [1; -4];
    expAverage3BMotor = [9; 14];
    expAverage3BPerceptual = [19; 14];

    expAverage1CMotor = [16.75; 6.5];
    expAverage1CPerceptual = [16.75; 6.5];
    expAverage2CMotor = [16.75; 6.5];
    expAverage2CPerceptual = [-6.75; 3.5];
    expAverage3CMotor = [16.75; 6.5];
    expAverage3CPerceptual = [16.75; 6.5];

    expAverage4DMotor = [2.5; 2];
    expAverage4DPerceptual = [2.5; 2];

    expAverage4EMotor = [2.5; 2];
    expAverage4EPerceptual = [2.5; 2];

    verifyEqual(testCase, actAverage1A.MotorPoint.Coordinates, expAverage1AMotor, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage1A.PerceptualPoint.Coordinates, expAverage1APerceptual, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage2A.MotorPoint.Coordinates, expAverage2AMotor, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage2A.PerceptualPoint.Coordinates, expAverage2APerceptual, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage3A.MotorPoint.Coordinates, expAverage3AMotor, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage3A.PerceptualPoint.Coordinates, expAverage3APerceptual, "AbsTol", 0.001);

    verifyEqual(testCase, actAverage1B.MotorPoint.Coordinates, expAverage1BMotor, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage1B.PerceptualPoint.Coordinates, expAverage1BPerceptual, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage2B.MotorPoint.Coordinates, expAverage2BMotor, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage2B.PerceptualPoint.Coordinates, expAverage2BPerceptual, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage3B.MotorPoint.Coordinates, expAverage3BMotor, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage3B.PerceptualPoint.Coordinates, expAverage3BPerceptual, "AbsTol", 0.001);

    verifyEqual(testCase, actAverage1C.MotorPoint.Coordinates, expAverage1CMotor, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage1C.PerceptualPoint.Coordinates, expAverage1CPerceptual, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage2C.MotorPoint.Coordinates, expAverage2CMotor, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage2C.PerceptualPoint.Coordinates, expAverage2CPerceptual, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage3C.MotorPoint.Coordinates, expAverage3CMotor, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage3C.PerceptualPoint.Coordinates, expAverage3CPerceptual, "AbsTol", 0.001);

    verifyEqual(testCase, actAverage4D.MotorPoint.Coordinates, expAverage4DMotor, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage4D.PerceptualPoint.Coordinates, expAverage4DPerceptual, "AbsTol", 0.001);

    verifyEqual(testCase, actAverage4E.MotorPoint.Coordinates, expAverage4EMotor, "AbsTol", 0.001);
    verifyEqual(testCase, actAverage4E.PerceptualPoint.Coordinates, expAverage4EPerceptual, "AbsTol", 0.001);

end

function TestMotorClusterPlottingInfo(testCase)
    s1 = testCase.TestData.Space1;
    s2 = testCase.TestData.Space2;
    s3 = testCase.TestData.Space3;
    s4 = testCase.TestData.Space4;
    ColorArrayA = [0 0.8 0; 0.4 0.4 1; 0 0 1; 0.4 0 1; 0.7 0 1; 1 0 1];
    ColorArrayB = [1 1 0; 1 0.8 0; 1 0.6 0; 1 0.4 0; 1 0.2 0; 1 0 0];
    ColorArrayC = [0 0 0.6; 1 0 0.3];
    AlphaClusterValues6 = [1; 0.9; 0.8; 0.8; 0.9; 1];
    AlphaClusterValues2 = [0.3; 0.4];

    [actXValues1A, actYValues1A, actColorValues1A, actAlphaValues1A] = ...
        s1.MotorClusterPlottingInfo(ColorArrayA, AlphaClusterValues6);
    [actXValues1B, actYValues1B, actColorValues1B, actAlphaValues1B] = ...
        s1.MotorClusterPlottingInfo(ColorArrayB, AlphaClusterValues6);
    [actXValues2A, actYValues2A, actColorValues2A, actAlphaValues2A] = ...
        s2.MotorClusterPlottingInfo(ColorArrayA, AlphaClusterValues6);
    [actXValues2B, actYValues2B, actColorValues2B, actAlphaValues2B] = ...
        s2.MotorClusterPlottingInfo(ColorArrayB, AlphaClusterValues6);
    [actXValues3A, actYValues3A, actColorValues3A, actAlphaValues3A] = ...
        s3.MotorClusterPlottingInfo(ColorArrayA, AlphaClusterValues6);
    [actXValues3B, actYValues3B, actColorValues3B, actAlphaValues3B] = ...
        s3.MotorClusterPlottingInfo(ColorArrayB, AlphaClusterValues6);
    [actXValues4C, actYValues4C, actColorValues4C, actAlphaValues4C] = ...
        s4.MotorClusterPlottingInfo(ColorArrayC, AlphaClusterValues2);

    expXValues123 = [0; 0; 0; 2; 2; 2; 4; 4; 4; 6; 6; 6; ...
        10; 10; 10; 12; 12; 12; 14; 14; 14; 16; 16; 16; ...
        20; 20; 20; 22; 22; 22; 24; 24; 24; 26; 26; 26; ...
        0; 0; 0; 2; 2; 2; 4; 4; 4; 6; 6; 6; ...
        10; 10; 10; 12; 12; 12; 14; 14; 14; 16; 16; 16; ...
        20; 20; 20; 22; 22; 22; 24; 24; 24; 26; 26; 26];
    expYValues123 = [0; 5; 10; 0; 5; 10; 0; 5; 10; 0; 5; 10; ...
        0; 5; 10; 0; 5; 10; 0; 5; 10; 0; 5; 10; ...
        0; 5; 10; 0; 5; 10; 0; 5; 10; 0; 5; 10; ...
        12; 17; 22; 12; 17; 22; 12; 17; 22; 12; 17; 22; ...
        12; 17; 22; 12; 17; 22; 12; 17; 22; 12; 17; 22; ...
        12; 17; 22; 12; 17; 22; 12; 17; 22; 12; 17; 22];
    expAlphaValues123 = [1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; ...
        0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; ...
        0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; ...
        0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; ...
        0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; ...
        1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1]; 
    expColorValuesA = [...
        0 0.8 0; 0 0.8 0; 0 0.8 0; 0 0.8 0; 0 0.8 0; 0 0.8 0; ...
        0 0.8 0; 0 0.8 0; 0 0.8 0; 0 0.8 0; 0 0.8 0; 0 0.8 0; ...
        0.4 0.4 1; 0.4 0.4 1; 0.4 0.4 1; 0.4 0.4 1; 0.4 0.4 1; 0.4 0.4 1; ...
        0.4 0.4 1; 0.4 0.4 1; 0.4 0.4 1; 0.4 0.4 1; 0.4 0.4 1; 0.4 0.4 1; ...
        0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 1; ...
        0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 1; ...
        0.4 0 1; 0.4 0 1; 0.4 0 1; 0.4 0 1; 0.4 0 1; 0.4 0 1; ...
        0.4 0 1; 0.4 0 1; 0.4 0 1; 0.4 0 1; 0.4 0 1; 0.4 0 1; ...
        0.7 0 1; 0.7 0 1; 0.7 0 1; 0.7 0 1; 0.7 0 1; 0.7 0 1; ...
        0.7 0 1; 0.7 0 1; 0.7 0 1; 0.7 0 1; 0.7 0 1; 0.7 0 1; ...
        1 0 1; 1 0 1; 1 0 1; 1 0 1; 1 0 1; 1 0 1; ...
        1 0 1; 1 0 1; 1 0 1; 1 0 1; 1 0 1; 1 0 1];
    expColorValuesB = [...
        1 1 0; 1 1 0; 1 1 0; 1 1 0; 1 1 0; 1 1 0; ...
        1 1 0; 1 1 0; 1 1 0; 1 1 0; 1 1 0; 1 1 0; ...
        1 0.8 0; 1 0.8 0; 1 0.8 0; 1 0.8 0; 1 0.8 0; 1 0.8 0; ...
        1 0.8 0; 1 0.8 0; 1 0.8 0; 1 0.8 0; 1 0.8 0; 1 0.8 0; ...
        1 0.6 0; 1 0.6 0; 1 0.6 0; 1 0.6 0; 1 0.6 0; 1 0.6 0; ...
        1 0.6 0; 1 0.6 0; 1 0.6 0; 1 0.6 0; 1 0.6 0; 1 0.6 0; ...
        1 0.4 0; 1 0.4 0; 1 0.4 0; 1 0.4 0; 1 0.4 0; 1 0.4 0; ...
        1 0.4 0; 1 0.4 0; 1 0.4 0; 1 0.4 0; 1 0.4 0; 1 0.4 0; ...
        1 0.2 0; 1 0.2 0; 1 0.2 0; 1 0.2 0; 1 0.2 0; 1 0.2 0; ...
        1 0.2 0; 1 0.2 0; 1 0.2 0; 1 0.2 0; 1 0.2 0; 1 0.2 0; ...
        1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0; ...
        1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0];
    expXValues4 = [0; 0; 0; 0; 1; 1; 1; 1; 4; 4; 4; 4; 5; 5; 5; 5];
    expYValues4 = [0; 2; 4; 6; 0; 2; 4; 6; 0; 2; 4; 6; 0; 2; 4; 6];
    expColorValuesC = [...
        0 0 0.6; 0 0 0.6; 0 0 0.6; 0 0 0.6; ...
        0 0 0.6; 0 0 0.6; 0 0 0.6; 0 0 0.6; ...
        1 0 0.3; 1 0 0.3; 1 0 0.3; 1 0 0.3; ...
        1 0 0.3; 1 0 0.3; 1 0 0.3; 1 0 0.3];
    expAlphaValues4 = [0.3; 0.3; 0.3; 0.3; 0.3; 0.3; 0.3; 0.3; ...
        0.4; 0.4; 0.4; 0.4; 0.4; 0.4; 0.4; 0.4];

    verifyEqual(testCase, actXValues1A, expXValues123);
    verifyEqual(testCase, actYValues1A, expYValues123);
    verifyEqual(testCase, actColorValues1A, expColorValuesA);
    verifyEqual(testCase, actAlphaValues1A, expAlphaValues123);
    verifyEqual(testCase, actXValues1B, expXValues123);
    verifyEqual(testCase, actYValues1B, expYValues123);
    verifyEqual(testCase, actColorValues1B, expColorValuesB);
    verifyEqual(testCase, actAlphaValues1B, expAlphaValues123);
    verifyEqual(testCase, actXValues2A, expXValues123);
    verifyEqual(testCase, actYValues2A, expYValues123);
    verifyEqual(testCase, actColorValues2A, expColorValuesA);
    verifyEqual(testCase, actAlphaValues2A, expAlphaValues123);
    verifyEqual(testCase, actXValues2B, expXValues123);
    verifyEqual(testCase, actYValues2B, expYValues123);
    verifyEqual(testCase, actColorValues2B, expColorValuesB);
    verifyEqual(testCase, actAlphaValues2B, expAlphaValues123);
    verifyEqual(testCase, actXValues3A, expXValues123);
    verifyEqual(testCase, actYValues3A, expYValues123);
    verifyEqual(testCase, actColorValues3A, expColorValuesA);
    verifyEqual(testCase, actAlphaValues3A, expAlphaValues123);
    verifyEqual(testCase, actXValues3B, expXValues123);
    verifyEqual(testCase, actYValues3B, expYValues123);
    verifyEqual(testCase, actColorValues3B, expColorValuesB);
    verifyEqual(testCase, actAlphaValues3B, expAlphaValues123);
    verifyEqual(testCase, actXValues4C, expXValues4);
    verifyEqual(testCase, actYValues4C, expYValues4);
    verifyEqual(testCase, actColorValues4C, expColorValuesC);
    verifyEqual(testCase, actAlphaValues4C, expAlphaValues4);
end

function TestPerceptualClusterPlottingInfo(testCase)
    s1 = testCase.TestData.Space1;
    s2 = testCase.TestData.Space2;
    s3 = testCase.TestData.Space3;
    s4 = testCase.TestData.Space4;
    ColorArrayA = [0 0.8 0; 0.4 0.4 1; 0 0 1; 0.4 0 1; 0.7 0 1; 1 0 1];
    ColorArrayB = [1 1 0; 1 0.8 0; 1 0.6 0; 1 0.4 0; 1 0.2 0; 1 0 0];
    ColorArrayC = [0 0 0.6; 1 0 0.3];
    AlphaClusterValues6 = [1; 0.9; 0.8; 0.8; 0.9; 1];
    AlphaClusterValues2 = [0.3; 0.4];

    [actXValues1A, actYValues1A, actColorValues1A, actAlphaValues1A] = ...
        s1.PerceptualClusterPlottingInfo(ColorArrayA, AlphaClusterValues6);
    [actXValues1B, actYValues1B, actColorValues1B, actAlphaValues1B] = ...
        s1.PerceptualClusterPlottingInfo(ColorArrayB, AlphaClusterValues6);
    [actXValues2A, actYValues2A, actColorValues2A, actAlphaValues2A] = ...
        s2.PerceptualClusterPlottingInfo(ColorArrayA, AlphaClusterValues6);
    [actXValues2B, actYValues2B, actColorValues2B, actAlphaValues2B] = ...
        s2.PerceptualClusterPlottingInfo(ColorArrayB, AlphaClusterValues6);
    [actXValues3A, actYValues3A, actColorValues3A, actAlphaValues3A] = ...
        s3.PerceptualClusterPlottingInfo(ColorArrayA, AlphaClusterValues6);
    [actXValues3B, actYValues3B, actColorValues3B, actAlphaValues3B] = ...
        s3.PerceptualClusterPlottingInfo(ColorArrayB, AlphaClusterValues6);
    [actXValues4C, actYValues4C, actColorValues4C, actAlphaValues4C] = ...
        s4.PerceptualClusterPlottingInfo(ColorArrayC, AlphaClusterValues2);

    expXValues1 = [0; 0; 0; 2; 2; 2; 4; 4; 4; 6; 6; 6; ...
        10; 10; 10; 12; 12; 12; 14; 14; 14; 16; 16; 16; ...
        20; 20; 20; 22; 22; 22; 24; 24; 24; 26; 26; 26; ...
        0; 0; 0; 2; 2; 2; 4; 4; 4; 6; 6; 6; ...
        10; 10; 10; 12; 12; 12; 14; 14; 14; 16; 16; 16; ...
        20; 20; 20; 22; 22; 22; 24; 24; 24; 26; 26; 26];
    expYValues1 = [0; 5; 10; 0; 5; 10; 0; 5; 10; 0; 5; 10; ...
        0; 5; 10; 0; 5; 10; 0; 5; 10; 0; 5; 10; ...
        0; 5; 10; 0; 5; 10; 0; 5; 10; 0; 5; 10; ...
        12; 17; 22; 12; 17; 22; 12; 17; 22; 12; 17; 22; ...
        12; 17; 22; 12; 17; 22; 12; 17; 22; 12; 17; 22; ...
        12; 17; 22; 12; 17; 22; 12; 17; 22; 12; 17; 22];

    expXValues2 = [10; 10; 10; 8; 8; 8; 6; 6; 6; 4; 4; 4; ...
        0; 0; 0; -2; -2; -2; -4; -4; -4; -6; -6; -6; ...
        -10; -10; -10; -12; -12; -12; -14; -14; -14; -16; -16; -16; ...
        10; 10; 10; 8; 8; 8; 6; 6; 6; 4; 4; 4; ...
        0; 0; 0; -2; -2; -2; -4; -4; -4; -6; -6; -6; ...
        -10; -10; -10; -12; -12; -12; -14; -14; -14; -16; -16; -16];
    expYValues2 = [10; 5; 0; 10; 5; 0; 10; 5; 0; 10; 5; 0; ...
        10; 5; 0; 10; 5; 0; 10; 5; 0; 10; 5; 0; ...
        10; 5; 0; 10; 5; 0; 10; 5; 0; 10; 5; 0; ...
        -2; -7; -12; -2; -7; -12; -2; -7; -12; -2; -7; -12; ...
        -2; -7; -12; -2; -7; -12; -2; -7; -12; -2; -7; -12; ...
        -2; -7; -12; -2; -7; -12; -2; -7; -12; -2; -7; -12];

    expXValues3 = [0; 0; 0; 2; 2; 2; 4; 4; 4; 6; 6; 6; ...
        10; 10; 10; 12; 12; 12; 14; 14; 14; 16; 16; 16; ...
        20; 20; 20; 22; 22; 22; 24; 24; 24; 26; 26; 26; ...
        10; 10; 10; 12; 12; 12; 14; 14; 14; 16; 16; 16; ...
        20; 20; 20; 22; 22; 22; 24; 24; 24; 26; 26; 26; ...
        0; 0; 0; 2; 2; 2; 4; 4; 4; 6; 6; 6];
    expYValues3 = [0; 5; 10; 0; 5; 10; 0; 5; 10; 0; 5; 10; ...
        0; 5; 10; 0; 5; 10; 0; 5; 10; 0; 5; 10; ...
        0; 5; 10; 0; 5; 10; 0; 5; 10; 0; 5; 10; ...
        12; 17; 22; 12; 17; 22; 12; 17; 22; 12; 17; 22; ...
        12; 17; 22; 12; 17; 22; 12; 17; 22; 12; 17; 22; ...
        12; 17; 22; 12; 17; 22; 12; 17; 22; 12; 17; 22];

    expAlphaValues123 = [1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; ...
        0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; ...
        0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; ...
        0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; 0.8; ...
        0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; ...
        1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1]; 
    expColorValuesA = [...
        0 0.8 0; 0 0.8 0; 0 0.8 0; 0 0.8 0; 0 0.8 0; 0 0.8 0; ...
        0 0.8 0; 0 0.8 0; 0 0.8 0; 0 0.8 0; 0 0.8 0; 0 0.8 0; ...
        0.4 0.4 1; 0.4 0.4 1; 0.4 0.4 1; 0.4 0.4 1; 0.4 0.4 1; 0.4 0.4 1; ...
        0.4 0.4 1; 0.4 0.4 1; 0.4 0.4 1; 0.4 0.4 1; 0.4 0.4 1; 0.4 0.4 1; ...
        0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 1; ...
        0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 1; ...
        0.4 0 1; 0.4 0 1; 0.4 0 1; 0.4 0 1; 0.4 0 1; 0.4 0 1; ...
        0.4 0 1; 0.4 0 1; 0.4 0 1; 0.4 0 1; 0.4 0 1; 0.4 0 1; ...
        0.7 0 1; 0.7 0 1; 0.7 0 1; 0.7 0 1; 0.7 0 1; 0.7 0 1; ...
        0.7 0 1; 0.7 0 1; 0.7 0 1; 0.7 0 1; 0.7 0 1; 0.7 0 1; ...
        1 0 1; 1 0 1; 1 0 1; 1 0 1; 1 0 1; 1 0 1; ...
        1 0 1; 1 0 1; 1 0 1; 1 0 1; 1 0 1; 1 0 1];
    expColorValuesB = [...
        1 1 0; 1 1 0; 1 1 0; 1 1 0; 1 1 0; 1 1 0; ...
        1 1 0; 1 1 0; 1 1 0; 1 1 0; 1 1 0; 1 1 0; ...
        1 0.8 0; 1 0.8 0; 1 0.8 0; 1 0.8 0; 1 0.8 0; 1 0.8 0; ...
        1 0.8 0; 1 0.8 0; 1 0.8 0; 1 0.8 0; 1 0.8 0; 1 0.8 0; ...
        1 0.6 0; 1 0.6 0; 1 0.6 0; 1 0.6 0; 1 0.6 0; 1 0.6 0; ...
        1 0.6 0; 1 0.6 0; 1 0.6 0; 1 0.6 0; 1 0.6 0; 1 0.6 0; ...
        1 0.4 0; 1 0.4 0; 1 0.4 0; 1 0.4 0; 1 0.4 0; 1 0.4 0; ...
        1 0.4 0; 1 0.4 0; 1 0.4 0; 1 0.4 0; 1 0.4 0; 1 0.4 0; ...
        1 0.2 0; 1 0.2 0; 1 0.2 0; 1 0.2 0; 1 0.2 0; 1 0.2 0; ...
        1 0.2 0; 1 0.2 0; 1 0.2 0; 1 0.2 0; 1 0.2 0; 1 0.2 0; ...
        1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0; ...
        1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0];
    expXValues4 = [0; 0; 0; 0; 1; 1; 1; 1; 4; 4; 4; 4; 5; 5; 5; 5];
    expYValues4 = [0; 2; 4; 6; 0; 2; 4; 6; 0; 2; 4; 6; 0; 2; 4; 6];
    expColorValuesC = [...
        0 0 0.6; 0 0 0.6; 0 0 0.6; 0 0 0.6; ...
        0 0 0.6; 0 0 0.6; 0 0 0.6; 0 0 0.6; ...
        1 0 0.3; 1 0 0.3; 1 0 0.3; 1 0 0.3; ...
        1 0 0.3; 1 0 0.3; 1 0 0.3; 1 0 0.3];
    expAlphaValues4 = [0.3; 0.3; 0.3; 0.3; 0.3; 0.3; 0.3; 0.3; ...
        0.4; 0.4; 0.4; 0.4; 0.4; 0.4; 0.4; 0.4];

    verifyEqual(testCase, actXValues1A, expXValues1);
    verifyEqual(testCase, actYValues1A, expYValues1);
    verifyEqual(testCase, actColorValues1A, expColorValuesA);
    verifyEqual(testCase, actAlphaValues1A, expAlphaValues123);
    verifyEqual(testCase, actXValues1B, expXValues1);
    verifyEqual(testCase, actYValues1B, expYValues1);
    verifyEqual(testCase, actColorValues1B, expColorValuesB);
    verifyEqual(testCase, actAlphaValues1B, expAlphaValues123);
    verifyEqual(testCase, actXValues2A, expXValues2);
    verifyEqual(testCase, actYValues2A, expYValues2);
    verifyEqual(testCase, actColorValues2A, expColorValuesA);
    verifyEqual(testCase, actAlphaValues2A, expAlphaValues123);
    verifyEqual(testCase, actXValues2B, expXValues2);
    verifyEqual(testCase, actYValues2B, expYValues2);
    verifyEqual(testCase, actColorValues2B, expColorValuesB);
    verifyEqual(testCase, actAlphaValues2B, expAlphaValues123);
    verifyEqual(testCase, actXValues3A, expXValues3);
    verifyEqual(testCase, actYValues3A, expYValues3);
    verifyEqual(testCase, actColorValues3A, expColorValuesA);
    verifyEqual(testCase, actAlphaValues3A, expAlphaValues123);
    verifyEqual(testCase, actXValues3B, expXValues3);
    verifyEqual(testCase, actYValues3B, expYValues3);
    verifyEqual(testCase, actColorValues3B, expColorValuesB);
    verifyEqual(testCase, actAlphaValues3B, expAlphaValues123);
    verifyEqual(testCase, actXValues4C, expXValues4);
    verifyEqual(testCase, actYValues4C, expYValues4);
    verifyEqual(testCase, actColorValues4C, expColorValuesC);
    verifyEqual(testCase, actAlphaValues4C, expAlphaValues4);
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

    % SPACE TRANSFORMATIONS
    testCase.TestData.spaceTransformation1 = SpaceTransformation(@transformationFunction1);
    testCase.TestData.spaceTransformation2 = SpaceTransformation(@transformationFunction2);
    testCase.TestData.spaceTransformation3 = SpaceTransformation(@transformationFunction3);
    
    % CLUSTER LISTS
    testCase.TestData.Clusters1 = MakeManySquareClusters( ...
        0, 2, 6, 4, 3, 0, 5, 10, 2, 2, testCase.TestData.spaceTransformation1);
    testCase.TestData.Clusters2 = MakeManySquareClusters( ...
        0, 2, 6, 4, 3, 0, 5, 10, 2, 2, testCase.TestData.spaceTransformation2);
    testCase.TestData.Clusters3 = MakeManySquareClusters( ...
        0, 2, 6, 4, 3, 0, 5, 10, 2, 2, testCase.TestData.spaceTransformation3);
    testCase.TestData.Clusters4 = MakeManySquareClusters( ...
        0, 1, 1, 3, 2, 0, 2, 6, 1, 1, testCase.TestData.spaceTransformation1);
    
    % SPACES
    testCase.TestData.Space1 = Space(testCase.TestData.Clusters1, ...
        testCase.TestData.spaceTransformation1, [0 0], 10);
    testCase.TestData.Space2 = Space(testCase.TestData.Clusters2, ...
        testCase.TestData.spaceTransformation2, [0 0], 10);
    testCase.TestData.Space3 = Space(testCase.TestData.Clusters3, ...
        testCase.TestData.spaceTransformation3, [0 0], 10);
    testCase.TestData.Space4 = Space(testCase.TestData.Clusters4, ...
        testCase.TestData.spaceTransformation1, [0 0], 10);
    
    % MOTOR REGIONS
    testCase.TestData.Region1 = MotorRegionTemp(MotorPoint([8; 2]), 3);
    testCase.TestData.Region2 = MotorRegionTemp(MotorPoint([6; 2]), 3);
    testCase.TestData.Region3 = MotorRegionTemp(MotorPoint([4; 2]), 3);
    testCase.TestData.Region4 = MotorRegionTemp(MotorPoint([2; 2]), 3);
    testCase.TestData.Region5 = MotorRegionTemp(MotorPoint([2; 4]), 3);
    testCase.TestData.Region6 = MotorRegionTemp(MotorPoint([2; 6]), 3);
    
    % SILHOUETTE
    testCase.TestData.Silhouette1 = MotorSilhouette({ ...
        testCase.TestData.Region1; testCase.TestData.Region2; ...
        testCase.TestData.Region3; testCase.TestData.Region4; ...
        testCase.TestData.Region5; testCase.TestData.Region6});
    
    % TRAJECTORY
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
    PX = 10 - MX;
    PY = 10 - MY;
    PerceptualCoordinates = [PX; PY];
end

function PerceptualCoordinates = transformationFunction3(MotorCoordinates)
    MX = MotorCoordinates(1,1);
    MY = MotorCoordinates(2,1);
    if MY < 11
        PX = MX;
        PY = MY;
    else
        if MX < 18
            PX = MX + 10;
            PY = MY;
        else
            PX = MX - 20;
            PY = MY;
        end
    end
    PerceptualCoordinates = [PX; PY];
end
