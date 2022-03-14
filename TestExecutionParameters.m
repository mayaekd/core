%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function tests = TestExecutionParameters
    tests = functiontests(localfunctions);
end

function TestCreateObject(testCase)
    Parameters1 = ExecutionParameters(4, 5, "none");
    Parameters2 = ExecutionParameters(4, 3, "motor");
    actLookBack1 = Parameters1.LookBackAmount;
    actLookAhead1 = Parameters1.LookAheadAmount;
    actSpread1 = Parameters1.Spread;
    actLookBack2 = Parameters2.LookBackAmount;
    actLookAhead2 = Parameters2.LookAheadAmount;
    actSpread2 = Parameters2.Spread;
    expLookBack1 = 4;
    expLookAhead1 = 5;
    expSpread1 = "none";
    expLookBack2 = 4;
    expLookAhead2 = 3;
    expSpread2 = "motor";
    verifyEqual(testCase, actLookBack1, expLookBack1);
    verifyEqual(testCase, actLookAhead1, expLookAhead1);
    verifyEqual(testCase, actSpread1, expSpread1);
    verifyEqual(testCase, actLookBack2, expLookBack2);
    verifyEqual(testCase, actLookAhead2, expLookAhead2);
    verifyEqual(testCase, actSpread2, expSpread2);
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

