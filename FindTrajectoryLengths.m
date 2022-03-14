%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function LengthMatrix = FindTrajectoryLengths(FiveDimMatrix)
    A = size(FiveDimMatrix, 1);
    B = size(FiveDimMatrix, 2);
    C = size(FiveDimMatrix, 3);
    D = size(FiveDimMatrix, 4);
    E = size(FiveDimMatrix, 5);
    LengthMatrix = zeros(A,B,C,D,E);
    for a = 1:A
        for b = 1:B
            for c = 1:C
                for d = 1:D
                    for e = 1:E
                        CurrentTrajectory = FiveDimMatrix{a,b,c,d,e};
                        CurrentLength = ComputeTrajectoryLength(CurrentTrajectory);
                        LengthMatrix(a,b,c,d,e) = CurrentLength;
                    end
                end
            end
        end
    end
end