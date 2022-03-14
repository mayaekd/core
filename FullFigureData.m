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
                if ~isempty(obj.ClusterXList{n,1})
                    scatter(obj.AxesList{n,1}, obj.ClusterXList{n,1}, ...
                        obj.ClusterYList{n,1}, obj.JunctureSizes, ...
                        obj.ClusterColorList{n,1}, "filled", ...
                        "MarkerFaceAlpha", "flat", ...
                        "MarkerEdgeAlpha", "flat", ...
                        "AlphaDataMapping", "none", ...
                        "AlphaData", obj.ClusterAlphaList{n,1});
                end
                % Silhouette
                if ~isempty(obj.SilhouetteFaceList{n,1})
                    patch(obj.AxesList{n,1}, "Faces", ...
                        obj.SilhouetteFaceList{n,1}, "Vertices", ...
                        obj.SilhouetteVertexList{n,1}, "FaceVertexCData", ...
                        obj.SilhouetteColorList{n,1}, ...
                        "FaceColor", "flat", "EdgeColor", "none", ...
                        "FaceVertexAlphaData", obj.SilhouetteAlphaList{n,1}, ...
                        "FaceAlpha", "flat", "AlphaDataMapping", "none");
                end
                % PerceptualTrajectory
                if ~isempty(obj.PerceptualTrajectoryXList{n,1})
                    scatter(obj.AxesList{n,1}, obj.PerceptualTrajectoryXList{n,1}, ...
                        obj.PerceptualTrajectoryYList{n,1}, obj.ResultPointSizes, ...
                        obj.PerceptualTrajectoryColorList{n,1}, "filled");
                end
                % Results
                if ~isempty(obj.ResultXList{n,1})
                    scatter(obj.AxesList{n,1}, obj.ResultXList{n,1}, ...
                        obj.ResultYList{n,1}, obj.ResultPointSizes, ...
                        obj.ResultColorList{n,1}, "filled");
                end
            end
        end
    end
end