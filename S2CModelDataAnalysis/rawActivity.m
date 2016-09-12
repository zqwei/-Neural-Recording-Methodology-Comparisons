%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Raw activity of all neurons
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath('../Func');
setDir;
load ([TempDatDir 'DataListS2CModel.mat']);

ylabels                 = {'dF/F', 'dF/F', 'dF/F', 'dF/F' };

if ~exist([PlotDir 'S2CModel'],'dir')
    mkdir([PlotDir 'S2CModel'])
end


for nData             = [3 4]
    load([TempDatDir DataSetList(nData).name '.mat'])
    plotMeanActivityImagescRasterOnly(nDataSet(positivePeak), DataSetList(nData).params, [], [], ylabels{nData}); 
    setPrint(6*2, 3*3, [PlotDir 'S2CModel/SingleUnitsImagescRasterOnly_' DataSetList(nData).name])
end



% close all;