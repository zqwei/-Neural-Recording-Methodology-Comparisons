%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dPCA and PCA across trials
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('../Func');
setDir;
load ([TempDatDir 'DataListEphys.mat']);

combinedParams = {{1}, {2}, {[1 2]}};
margNames      = {'Stim', 'Time', 'Inter'};
numTrials      = 100;
numComps       = 3;

for nData              = 1:length(DataSetList)
    load([TempDatDir DataSetList(nData).name '.mat']);
    numT               = size(nDataSet(1).unit_yes_trial, 2);
    firingRates        = generateDPCAData(nDataSet, numTrials);
    firingRatesAverage = nanmean(firingRates, ndims(firingRates));
    pcaFiringRatesAverage = zeros(numComps, 2, numT);
    firingRatesAverage = [squeeze(firingRatesAverage(:, 1, :)), squeeze(firingRatesAverage(:, 2, :));];
    [~,score,~]        = pca(firingRatesAverage', 'NumComponents', numComps);
    pcaFiringRatesAverage(:, 1, :) = score(1:numT, :)';
    pcaFiringRatesAverage(:, 2, :) = score(numT+1:end, :)';
    
    figure;
    for nPlot           = 1:numComps
        subplot(1, numComps, nPlot)
        hold on
        plot(DataSetList(nData).params.timeSeries, squeeze(pcaFiringRatesAverage(nPlot, 1, :)), '-r', 'linewid', 2);
        plot(DataSetList(nData).params.timeSeries, squeeze(pcaFiringRatesAverage(nPlot, 2, :)), '-b', 'linewid', 2);
        gridxy ([DataSetList(nData).params.polein, DataSetList(nData).params.poleout, 0],[], 'Color','k','Linestyle','--','linewid', 0.5)
        hold off
        box off
        xlim([min(DataSetList(nData).params.timeSeries) max(DataSetList(nData).params.timeSeries)]);
        xlabel('Time (s)')
        ylabel(['PC' num2str(nPlot) ' score'])  
    end
    
    setPrint(8*3, 6, [PlotDir 'EphysBinningTest/CollectedUnitsPCATrace_' DataSetList(nData).name])
    
end

close all