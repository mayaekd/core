%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [GoalsOverTime, ActivationsOverTime, ...
    MResultsOverTime, PResultsOverTime] = LearnNewExemplarWithNoise( ...
    StartingSpace, StartingSilhouette, Exemplar, ...
    NumberOfIterations, LookBackWindow, LookAheadWindow, Noise)

    CurrentExecutionParameters = ExecutionParameters(LookBackWindow, ...
        LookAheadWindow);
    
    GoalsOverTime = Goal.empty(NumberOfIterations + 1,0);
    ActivationsOverTime = cell(NumberOfIterations + 1,0);
    MResultsOverTime = MotorTrajectory.empty(NumberOfIterations + 1,0);
    PResultsOverTime = PerceptualTrajectory.empty(NumberOfIterations + 1,0);

    CurrentSpace = StartingSpace;
    CurrentSilhouette = StartingSilhouette;
    CurrentExemplar = Exemplar;
    
    for n = 1:NumberOfIterations + 1
        fprintf("Done with iteration%d\n", n);
        % Making the current goal from already in-place parameters;
        % then finding the results of that
        CurrentGoal = Goal(CurrentSpace, CurrentSilhouette, ...
            CurrentExemplar);
        [AverageJunctureEstimates, CurrentActivations] = ...
            CurrentGoal.SimpleMacroEstimates( ...
            CurrentExecutionParameters);
        % NOISE!
        JostledMotor = nan(length( ...
            AverageJunctureEstimates(1).MotorPoint.Coordinates), ...
            length(AverageJunctureEstimates));
        for j = 1:size(JostledMotor, 2)
            CurrentMotorCoordinates = AverageJunctureEstimates(j).MotorPoint.Coordinates;
            MotorCoordinatesPlusNoise = CurrentMotorCoordinates + ...
                Noise * 2 * (rand(size(CurrentMotorCoordinates)) - 0.5);
            JostledMotor(:, j) = MotorCoordinatesPlusNoise;
        end

        if size(JostledMotor, 1) >= 3
            MTrajectory = MotorTrajectory(JostledMotor, "zRowIndex", 3);
            PTrajectory = MTrajectory.FindPerceptualTrajectory(StartingSpace.SpaceTransformation, "zRowIndex", 3);
        else
            MTrajectory = MotorTrajectory(JostledMotor);
            PTrajectory = MTrajectory.FindPerceptualTrajectory( ...
                StartingSpace.SpaceTransformation);
        end
        
        % Storing these results in appropriate places
        GoalsOverTime(n) = CurrentGoal;
        ActivationsOverTime{n} = CurrentActivations;
        MResultsOverTime(n) = MTrajectory;
        PResultsOverTime(n) = PTrajectory;

        % Updating the silhouette for next time (the exemplar and space
        % stay the same)
        CurrentSilhouette = CurrentSilhouette.ExpandSilhouette(MTrajectory);
    end
end