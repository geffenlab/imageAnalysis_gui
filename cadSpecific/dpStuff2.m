clear discNeurons discFrac hp rp auc1
for n=1:36,[discNeurons,discFrac,auc1(n,:),hp,rp]=cadROCf(trials.stDfs(:,:,:),gain.hitTrials,gain.missTrials,[1+(n-1) 5+(n-1)],0.6,0,0.1);,end

%%
clear discNeurons discFrac hp rp
for n=1:36,[discNeurons,discFrac,auc2(n,:),hp,rp]=cadROCf(trials.stDfsB(:,:,:),gain.hitTrials,gain.missTrials,[1+(n-1) 5+(n-1)],0.6,0,0.01);,end

%%
figure,plot(mean(auc1,2))
hold all,plot(mean(auc2,2))


%%
framesC=2.5:2.5:2.5*30;
figure, plot(mean(auc(:,gainCells),2))
hold all, plot(mean(auc(:,nonGainCells),2))
hold all, plot(mean(auc,2))
meanRtFrames_Hit=mean(analyzedBehavior.reactionTimes(gain.hitTrials))/timingParams.frameInterval;
hold all,plot([9 9],[0.4 0.7])
hold all,plot([10+meanRtFrames_Hit 10+meanRtFrames_Hit],[0.4 0.7])

%%
figure,plot(mean(auc2(:,gainCells),2))
hold,plot(mean(auc2(:,nonGainCells),2))

%%
figure,boundedline([1:36],mean(auc1(:,gainCells),2),std(auc1(:,gainCells)./sqrt(numel(gainCells)),1,2),'cmap',[1 0 0])
hold all,boundedline([1:36],mean(auc1(:,nonGainCells),2),std(auc1(:,nonGainCells)./sqrt(numel(nonGainCells)),1,2),'cmap',[0 0 1])
%%
figure,boundedline([1:36],mean(auc2(:,gainCells),2),std(auc2(:,gainCells)./sqrt(numel(gainCells)-1),1,2),'cmap',[1 0 0])
hold all,boundedline([1:36],mean(auc2(:,nonGainCells),2),std(auc2(:,nonGainCells)./sqrt(numel(nonGainCells)-1),1,2),'cmap',[0 0 1])

%%

stimDPs=mean(auc2(7:13,:));
preDPs=mean(auc1(1:6,:));
[stimDrivenSortedDPs,stimDrivenSortedIndicies]=sort(mean(auc2(8:13,drivenCells)));
figure,plot(stimDPs)
hold all,plot(preDPs)
figure,nhist({stimDPs(:,drivenCells),preDPs(:,drivenCells)},'box')
figure,nhist({stimDPs(:,gainCells),preDPs(:,gainCells)},'box')
figure,nhist({stimDPs(:,nonGainCells),preDPs(:,nonGainCells)},'box')

%%
clear meanRd_hit meanPd_hit
testCells=gainCells;
stEvents=trials.stDfs;
ncWindow=[1 7];
trialTypes=gain.hitTrials;
v=1;
for k=1:numel(testCells),
    for n=k+1:numel(testCells)
        [r,p]=corr(stEvents(ncWindow(1):ncWindow(2),trialTypes,testCells(k))-repmat(mean(stEvents(ncWindow(1):ncWindow(2),trialTypes,testCells(k)),2),1,numel(trialTypes)),stEvents(ncWindow(1):ncWindow(2),trialTypes,testCells(n))-repmat(mean(stEvents(ncWindow(1):ncWindow(2),trialTypes,testCells(n)),2),1,numel(trialTypes)));
        meanRd_hit_pre(:,v)=mean(diag(r));
        meanPd_hit_pre(:,v)=mean(diag(p));
        matDp(:,:,v)=[preDPs(k),preDPs(n),mean(diag(r))];
        v=v+1;
    end
end



%%
clear meanRd_miss meanPd_miss
testCells=drivenCells;
stEvents=trials.stDfs;
ncWindow=[1 7];
trialTypes=gain.missTrials;
v=1;
for k=1:numel(testCells),
    for n=k+1:numel(testCells)
        [r,p]=corr(stEvents(ncWindow(1):ncWindow(2),trialTypes,testCells(k))-repmat(mean(stEvents(ncWindow(1):ncWindow(2),trialTypes,testCells(k)),2),1,numel(trialTypes)),stEvents(ncWindow(1):ncWindow(2),trialTypes,testCells(n))-repmat(mean(stEvents(ncWindow(1):ncWindow(2),trialTypes,testCells(n)),2),1,numel(trialTypes)));
        meanRd_miss_pre(:,v)=mean(diag(r));
        meanPd_miss_pre(:,v)=mean(diag(p));
        v=v+1;
    end
end

%%
figure,nhist({meanRd_hit_pre,meanRd_miss_pre},'box')

%%
clear meanRd_hit meanPd_hit
testCells=gainCells;
stEvents=trials.stDfsB;
ncWindow=[8 14];
trialTypes=gain.hitTrials;
v=1;
for k=1:numel(testCells),
    for n=k+1:numel(testCells)
        [r,p]=corr(stEvents(ncWindow(1):ncWindow(2),trialTypes,testCells(k))-repmat(mean(stEvents(ncWindow(1):ncWindow(2),trialTypes,testCells(k)),2),1,numel(trialTypes)),stEvents(ncWindow(1):ncWindow(2),trialTypes,testCells(n))-repmat(mean(stEvents(ncWindow(1):ncWindow(2),trialTypes,testCells(n)),2),1,numel(trialTypes)));
        meanRd_hit_stim(:,v)=mean(diag(r));
        meanPd_hit_stim(:,v)=mean(diag(p));
        matDp(:,:,v)=[preDPs(k),preDPs(n),mean(diag(r))];
        v=v+1;
    end
end



%%
clear meanRd_miss meanPd_miss
testCells=drivenCells;
stEvents=trials.stDfsB;
ncWindow=[8 14];
trialTypes=gain.missTrials;
v=1;
for k=1:numel(testCells),
    for n=k+1:numel(testCells)
        [r,p]=corr(stEvents(ncWindow(1):ncWindow(2),trialTypes,testCells(k))-repmat(mean(stEvents(ncWindow(1):ncWindow(2),trialTypes,testCells(k)),2),1,numel(trialTypes)),stEvents(ncWindow(1):ncWindow(2),trialTypes,testCells(n))-repmat(mean(stEvents(ncWindow(1):ncWindow(2),trialTypes,testCells(n)),2),1,numel(trialTypes)));
        meanRd_miss_stim(:,v)=mean(diag(r));
        meanPd_miss_stim(:,v)=mean(diag(p));
        v=v+1;
    end
end

%%
figure,nhist({meanRd_hit_stim,meanRd_miss_stim},'box')