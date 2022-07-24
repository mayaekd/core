%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS TESTED
%
%  ExecutionParameters

function tests = TestExecutionParametersSimple
    tests = functiontests(localfunctions);
end

function TestCreateObjectSimple(testCase)
    Parameters1 = ExecutionParameters(4, 5);
    Parameters2 = ExecutionParameters(4, 3);
    actLookBack1 = Parameters1.LookBackAmount;
    actLookAhead1 = Parameters1.LookAheadAmount;
    actLookBack2 = Parameters2.LookBackAmount;
    actLookAhead2 = Parameters2.LookAheadAmount;
    expLookBack1 = 4;
    expLookAhead1 = 5;
    expLookBack2 = 4;
    expLookAhead2 = 3;
    verifyEqual(testCase, actLookBack1, expLookBack1);
    verifyEqual(testCase, actLookAhead1, expLookAhead1);
    verifyEqual(testCase, actLookBack2, expLookBack2);
    verifyEqual(testCase, actLookAhead2, expLookAhead2);
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

