%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Similarity of PCA and LDA coefficient vectors as function of time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('../Func');
setDir;
load ([TempDatDir 'DataListShuffle.mat']);
addNoise         = [0 0 0 0];

if ~exist([PlotDir 'CollectedUnitsPCALDACorr'],'dir')
    mkdir([PlotDir 'CollectedUnitsPCALDACorr'])
end

cmap                = cbrewer('div', 'Spectral', 128, 'cubic');

numFold             = 30;
numRandPickUnits    = 100;
numTrials           = numRandPickUnits*6;
totTargets          = [true(numTrials/2,1); false(numTrials/2,1)];
ROCThres            = 0.5;


for nData             = [3 4]
    load([TempDatDir DataSetList(nData).name '_withOLRemoval.mat'])
    selectedNeuronalIndex = DataSetList(nData).ActiveNeuronIndex(~neuronRemoveList)';
    selectedNeuronalIndex = selectedHighROCneurons(nDataSet, DataSetList(nData).params, ROCThres, selectedNeuronalIndex);
    nDataSet              = nDataSet(selectedNeuronalIndex);
    numUnits              = length(nDataSet);
    numT                  = length(DataSetList(nData).params.timeSeries);
    corrMat               = nan(numFold, numT, numT);
    
    for nFold             = 1:numFold
        currRandPickUnits     = numRandPickUnits;
        nSessionData = shuffleSessionData(nDataSet(randperm(numUnits, currRandPickUnits)), totTargets, numTrials);
        nSessionData = normalizationDim(nSessionData, 2);
        coeffs       = coeffLDA(nSessionData, totTargets);
        corrMat(nFold, :, :) = coeffs'*coeffs;
    end
    
    
    figure;
    hold on
    
    imagesc(DataSetList(nData).params.timeSeries, DataSetList(nData).params.timeSeries, squeeze(mean(corrMat, 1)));
    xlim([min(DataSetList(nData).params.timeSeries) max(DataSetList(nData).params.timeSeries)]);
    ylim([min(DataSetList(nData).params.timeSeries) max(DataSetList(nData).params.timeSeries)]);
    caxis([0 1]);
    axis xy;
    gridxy ([DataSetList(nData).params.polein, DataSetList(nData).params.poleout, 0],[DataSetList(nData).params.polein, DataSetList(nData).params.poleout, 0], 'Color','k','Linestyle','--','linewid', 0.5);
    box off;
    hold off;
    xlabel('LDA Time (s)')
    ylabel('LDA Time (s)')
    colormap(cmap)
    set(gca, 'TickDir', 'out')
    setPrint(8, 6, [PlotDir 'CollectedUnitsPCALDACorr/SimilarityLDALDA_100_' DataSetList(nData).name '_withOLRemoval'])
end


numRandPickUnits    = 500;
numTrials           = numRandPickUnits*6;
totTargets          = [true(numTrials/2,1); false(numTrials/2,1)];
ROCThres            = 0.5;


for nData             = [3 4]
    load([TempDatDir DataSetList(nData).name '_withOLRemoval.mat'])
    selectedNeuronalIndex = DataSetList(nData).ActiveNeuronIndex(~neuronRemoveList)';
    selectedNeuronalIndex = selectedHighROCneurons(nDataSet, DataSetList(nData).params, ROCThres, selectedNeuronalIndex);
    nDataSet              = nDataSet(selectedNeuronalIndex);
    numUnits              = length(nDataSet);
    numT                  = length(DataSetList(nData).params.timeSeries);
    corrMat               = nan(numFold, numT, numT);
    
    for nFold             = 1:numFold
        currRandPickUnits     = numRandPickUnits;
        nSessionData = shuffleSessionData(nDataSet(randperm(numUnits, currRandPickUnits)), totTargets, numTrials);
        nSessionData = normalizationDim(nSessionData, 2);
        coeffs       = coeffLDA(nSessionData, totTargets);
        corrMat(nFold, :, :) = coeffs'*coeffs;
    end
    
    
    figure;
    hold on
    
    imagesc(DataSetList(nData).params.timeSeries, DataSetList(nData).params.timeSeries, squeeze(mean(corrMat, 1)));
    xlim([min(DataSetList(nData).params.timeSeries) max(DataSetList(nData).params.timeSeries)]);
    ylim([min(DataSetList(nData).params.timeSeries) max(DataSetList(nData).params.timeSeries)]);
    caxis([0 1]);
    axis xy;
    gridxy ([DataSetList(nData).params.polein, DataSetList(nData).params.poleout, 0],[DataSetList(nData).params.polein, DataSetList(nData).params.poleout, 0], 'Color','k','Linestyle','--','linewid', 0.5);
    box off;
    hold off;
    xlabel('LDA Time (s)')
    ylabel('LDA Time (s)')
    colormap(cmap)
    set(gca, 'TickDir', 'out')
    setPrint(8, 6, [PlotDir 'CollectedUnitsPCALDACorr/SimilarityLDALDA_500_' DataSetList(nData).name '_withOLRemoval'])
end

figure;
setColorbar(cmap, 0, 1, 'similarity', [PlotDir 'CollectedUnitsPCALDACorr/SimilarityLDALDA_500_'])
setColorbar(cmap, 0, 1, 'similarity', [PlotDir 'CollectedUnitsPCALDACorr/SimilarityLDALDA_100_'])

% close;