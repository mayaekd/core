classdef FullFigureData
    properties
        AxesList; % All the axes
        ClusterXList; % All the Cluster x data, across axes, in the same
        % order as the axes are listed
        ClusterYList;
        ClusterColorList;
        ClusterAlphaList;
        SilhouetteFaceList;
        SilhouetteVertexList;
        SilhouetteColorList;
        SilhouetteAlphaList;
        PerceptualTrajectoryXList;
        PerceptualTrajectoryYList;
        PerceptualTrajectoryColorList;
        ResultXList;
        ResultYList;
        ResultColorList;
        JunctureSizes;
        ResultPointSizes;
    end
    methods
        function obj = FullFigureData(axesList, clusterXList, ...
                clusterYList, clusterColorList, clusterAlphaList, ...
                silhouetteFaceList, silhouetteVertexList, ...
                silhouetteColorList, silhouetteAlphaList, ...
                trajectoryXList, trajectoryYList, trajectoryColorList, ...
                resultXList, resultYList, resultColorList, ...
                junctureSizes, resultPointSizes)
            obj.AxesList = axesList;
            obj.ClusterXList = clusterXList;
            obj.ClusterYList = clusterYList;
            obj.ClusterColorList = clusterColorList;
            obj.ClusterAlphaList = clusterAlphaList;
            obj.SilhouetteFaceList = silhouetteFaceList;
            obj.SilhouetteVertexList = silhouetteVertexList;
            obj.SilhouetteColorList = silhouetteColorList;
            obj.SilhouetteAlphaList = silhouetteAlphaList;
            obj.PerceptualTrajectoryXList = trajectoryXList;
            obj.PerceptualTrajectoryYList = trajectoryYList;
            obj.PerceptualTrajectoryColorList = trajectoryColorList;
            obj.ResultXList = resultXList;
            obj.ResultYList = resultYList;
            obj.ResultColorList = resultColorList;
            obj.JunctureSizes = junctureSizes;
            obj.ResultPointSizes = resultPointSizes;
        end

        function PlotFigures(obj)

            % For each axes, plot the appropriate things -- clusters first,
            % then silhouette, then perceptual trajectory, then result

            for ax = 1:length(obj.AxesList)
                CurrentAxes = obj.AxesList{ax,1};
                hold(CurrentAxes, "on");
            end
            for n = 1:length(obj.AxesList)
                % Clusters
                if ~isempty(obj.ClusterXList{n})
                    scatter(obj.AxesList{n}, obj.ClusterXList{n}, ...
                        obj.ClusterYList{n}, obj.JunctureSizes, ...
                        obj.ClusterColorList{n}, "filled", ...
                        "MarkerFaceAlpha", "flat", ...
                        "MarkerEdgeAlpha", "flat", ...
                        "AlphaDataMapping", "none", ...
                        "AlphaData", obj.ClusterAlphaList{n});
                end
                % Silhouette
                if ~isempty(obj.SilhouetteFaceList{n})
                    patch(obj.AxesList{n}, "Faces", ...
                        obj.SilhouetteFaceList{n}, "Vertices", ...
                        obj.SilhouetteVertexList{n}, "FaceVertexCData", ...
                        obj.SilhouetteColorList{n}, ...
                        "FaceColor", "flat", "EdgeColor", "none", ...
                        "FaceVertexAlphaData", obj.SilhouetteAlphaList{n}, ...
                        "FaceAlpha", "flat", "AlphaDataMapping", "none");
                end
                % PerceptualTrajectory
                if ~isempty(obj.PerceptualTrajectoryXList{n})
                    scatter(obj.AxesList{n}, obj.PerceptualTrajectoryXList{n}, ...
                        obj.PerceptualTrajectoryYList{n}, obj.ResultPointSizes, ...
                        obj.PerceptualTrajectoryColorList{n}, "filled");
                end
                % Results
                if ~isempty(obj.ResultXList{n})
                    scatter(obj.AxesList{n}, obj.ResultXList{n}, ...
                        obj.ResultYList{n}, obj.ResultPointSizes, ...
                        obj.ResultColorList{n}, "filled");
                end
            end
        end
    end
end