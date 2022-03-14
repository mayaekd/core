%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS LIST
%  MotorSilhouette
%  DropoffScalar
%  DropoffScalarLinearSymmetricFalloff
%  DropoffScalarConcave
%  DropoffScalarLinearFalloff
%  DropoffScalarNormalFalloff
%  TemporalActivationInfo
%  PlottingInfo
%  Plot

classdef MotorSilhouette
    % A motor silhouette consists of its timestamps & region at each time
    
    %% PROPERTIES
    properties
        Regions;
    end
    
    %% METHODS
    methods
        % Creating an object
        function obj = MotorSilhouette(MotorRegionCellArray)
            obj.Regions = MotorRegionCellArray;
        end
        
        %% DROPOFF FUNCTIONS FOR LOOKBACK & LOOKAHEAD WINDOWS
        % Takes a time distance as an input, and gives as an output a
        % scalar that represents the weight that should be given to the
        % part of the motor silhouette that is that time distance away from
        % the present.

        % Default dropoff function -- references one of the ones below
        function ScalarMultiplier = DropoffScalar(obj, TimeDistance, ...
                LookAheadWindow, LookBackWindow)
            ScalarMultiplier = obj.DropoffScalarConcave(TimeDistance, ...
                LookAheadWindow, LookBackWindow, 2);
        end
        
        % Drops off concavely, i.e. faster at first and then slower.  The
        % higher Power is, the closer the dropoff is to just a step 
        % function that goes from 1 to 0.  If Power = 1, then it just drops
        % off linearly.
        function ScalarMultiplier = DropoffScalarConcave(~, ...
                TimeDistance, LookAheadWindow, LookBackWindow, Power)
            % TimeDistance is positive if we're looking forward in time and
            % negative if we're looking backward in time
            if TimeDistance > -LookBackWindow
                if TimeDistance > 0
                    if TimeDistance < LookAheadWindow
                        % TimeDistance is between 0 and LookAheadWindow
                        ScalarMultiplier = ...
                            (1 - (TimeDistance/LookAheadWindow))^Power;
                    else
                        % TimeDistance is greater than or equal to
                        % LookAheadWindow
                        ScalarMultiplier = 0;
                    end
                else
                    % TimeDistance is between -LookBackWindow and 0
                    ScalarMultiplier = ...
                        (1 - (-TimeDistance/LookBackWindow))^Power;
                end
            else
                % TimeDistance is less than or equal to -LookBackWindow
                ScalarMultiplier = 0;
            end
        end

        % Drops off linearly, with different slopes for the future and for
        % the past.
        function ScalarMultiplier = DropoffScalarLinearFalloff(~, ...
                TimeDistance, LookAheadWindow, LookBackWindow)
            % TimeDistance is positive if we're looking forward in time and
            % negative if we're looking backward in time
            if TimeDistance > -LookBackWindow
                if TimeDistance > 0
                    if TimeDistance < LookAheadWindow
                        % TimeDistance is between 0 and LookAheadWindow
                        ScalarMultiplier = ...
                            1 - (TimeDistance/LookAheadWindow);
                    else
                        % TimeDistance is greater than or equal to
                        % LookAheadWindow
                        ScalarMultiplier = 0;
                    end
                else
                    % TimeDistance is between -LookBackWindow and 0
                    ScalarMultiplier = ...
                        1 - (-TimeDistance/LookBackWindow);
                end
            else
                % TimeDistance is less than or equal to -LookBackWindow
                ScalarMultiplier = 0;
            end
        end
        

        %% PLOTTING INFO AND PLOTTING
        
        % Time-varying activation info: the output, ActivationValuesCell is
        % a cell array such that ActivationValuesCell{t,1} will be 
        % something like [0; 0.5; 1; 0.5; 0; 0], which would mean that at 
        % time t, the motor silhouette is fully active at the third region, 
        % half active at the 2nd and 4th regions, and not active at the 
        % 1st, 5th, and 6th regions.  This activation would be determined 
        % by the dropoff function.
        function ActivationValuesCell = ...
                TemporalActivationInfo(obj, LookBackAmt, LookAheadAmt)
            % Inititalize ActivationValuesCell to the right size -- the 
            % number of time steps.  
            ActivationValuesCell = cell(length(obj.Regions), 1);
            for t = 1:length(ActivationValuesCell)
                % Find the span of the window for which the activation is 
                % nonzero -- will be a little tricky at the beginning and 
                % end -- a is the beginning of the window and b is the end
                a = max(1, t - LookBackAmt);
                b = min(length(ActivationValuesCell), t + LookAheadAmt);
                
                % Initialize the set of activation values that will go in
                % these units in the cells; t is the index of the main
                % region (maximal activation, unless we're using an unusual
                % dropoff function), and then we'll go from t - LookBackAmt
                % to t + LookAheadAmt, but making sure not to go past the 
                % end of the silhouette on either side.  Note: we'll have 
                % zeros for activation values outside of the range a to b
                CurrentActivationValues = zeros(length(obj.Regions),1);
                % Fill in the values according to the DropoffScalar
                % function
                for RegionIndex = a:b
                    Distance = RegionIndex - t;
                    Activation = obj.DropoffScalar(Distance, ...
                        LookAheadAmt, LookBackAmt);
                    CurrentActivationValues(RegionIndex, 1) = Activation; 
                end
                ActivationValuesCell{t,1} = CurrentActivationValues;
            end
        end
        
        % Vertex and face data for plotting the silhouette using the patch
        % function -- this will be the plotting info for plotting it as a
        % sequence of polygons, with the number of vertices specified as an
        % input.
        function [VertexData, FaceData] = PlottingInfo(obj, NumberOfVertices)
            % Initialize VertexData and FaceData to be the right sizes
            VertexData = zeros(NumberOfVertices * length(obj.Regions), 2);
            FaceData = zeros(length(obj.Regions), NumberOfVertices);
            for t = 1:length(obj.Regions)
                % Getting the data for the current region -- that is, the 
                % region corresponding to time t
                a = (t-1) * NumberOfVertices + 1;
                b = t * NumberOfVertices;
                CurrentRegion = obj.Regions{t,1};
                % The vertices for the tth region
                RegionVertexData = ...
                    CurrentRegion.PolygonPlottingInfo(NumberOfVertices);
                % The indices of the vertices for the tth region
                RegionFaceData = a:b;
                
                % Putting the current-region stuff into the bigger matrices
                VertexData(a:b,:) = RegionVertexData;
                FaceData(t,:) = RegionFaceData;
            end
        end
        
        % Plotting the whole silhouette with full opacity, on axes (input), 
        % as a series of polygons with NumberOfVertices vertices (input), 
        % the color given by ColorRBG (input)
        function WholeSilhouettePlot = Plot(obj, axes, ColorRBG, ...
                NumberOfVertices)
            % Plots the silhouette 

            % Expand ColorRBG into a larger array that is the appropriate
            % length
            ColorArray = zeros(length(obj.Regions),3);
            for t = 1:length(obj.Regions)
                ColorArray(t,:) = ColorRBG;
            end

            % AlphaArray are the opacity values, which are all 1 (fully
            % opaque) in this case
            AlphaArray = ones(length(obj.Regions),1);

            % Vertex & Face Data
            [VertexData, FaceData] = obj.PlottingInfo(NumberOfVertices);
            
            % Plotting
            WholeSilhouettePlot = patch(axes, "Faces", FaceData, ...
                "Vertices", VertexData, "FaceVertexCData", ColorArray, ...
                "FaceColor", "flat", "EdgeColor", "none", ...
                "FaceVertexAlphaData", AlphaArray, "FaceAlpha", "flat", ...
                "AlphaDataMapping", "none");
        end
        
    end
end
