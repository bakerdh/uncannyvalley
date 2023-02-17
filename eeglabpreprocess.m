% script preprocessing in EEGlab and brainstorm

clear
close all;

eeglabdir = '/Users/db900/Documents/MATLAB/eeglab2022.1';
brainstormdir = '/Users/db900/Documents/MATLAB/brainstorm3';

rawdatadir = '/Users/db900/Documents/git/uncannyvalley/local/RawData/Experiment 1';
eeglabdata = '/Users/db900/Documents/git/uncannyvalley/local/preprocessed';
dbpath = '/Users/db900/Documents/git/uncannyvalley/local/brainstormdb';
procpath = '/Users/db900/Documents/git/uncannyvalley/local/robotsmvpa';
protocolpath = '/Users/db900/Documents/git/uncannyvalley/local/brainstormdb/Experiment1/data/';

if ~exist(dbpath,'dir')
    mkdir(dbpath);
end
if ~exist(procpath,'dir')
    mkdir(procpath);
end

rmpath(brainstormdir);
% addpath(eeglabdir);
% 
% [ALLEEG EEG CURRENTSET ALLCOM] = eeglab('nogui');
% % plugin_askinstall('ANTeepimport');
% 
% robotstoclean = [302 304 305 309 313];
% for s = 301:329
%     s
% 
%     if ~exist(strcat(eeglabdata,'/',num2str(s),'.set'),'file')
%         tic
% 
%         EEGpath = strcat(rawdatadir,'/',num2str(s));
%         d = dir(strcat(EEGpath,'/*.cnt'))       % index the directory containing the EEG files
%         counter = length(d);
% 
%         c = 1;
%         fname = d(c).name;
%         EEG = pop_loadeep_v4(strcat(EEGpath,'/',fname));    % load the EEG data
% 
%         if counter>1
%             for c = 2:counter                       % loop through all cnt files
%                 fname = d(c).name;
%                 EEG2 = pop_loadeep_v4(strcat(EEGpath,'/',fname));    % load the EEG data
%                 EEG = pop_mergeset(EEG, EEG2);
%             end
%         end
% 
%         EEG = eeg_checkset( EEG );
%         EEG=pop_chanedit(EEG, 'lookup',strcat(eeglabdir,'/plugins/dipfit/standard_BEM/elec/standard_1005.elc'));
% 
%         if ismember(s,robotstoclean)
%             EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on','pca',50);
%             EEG = pop_iclabel(EEG, 'default');
%             EEG = pop_icflag(EEG, [NaN NaN;0.9 1;0.9 1;NaN NaN;0.5 1;0.5 1;0.5 1]);
%             EEG = pop_subcomp( EEG, [], 0);  % key line that removes the flagged components
%         end
% 
%         EEG = pop_saveset( EEG, 'filename',strcat(num2str(s),'.set'),'filepath',eeglabdata);
%         toc
% 
%     end
% end
% 
% rmpath(eeglabdir);
% 
% 
% 
% addpath(brainstormdir);
% 
% brainstorm nogui;
% 
% % gui_brainstorm('SetDatabaseFolder',dbpath);
% gui_brainstorm('DeleteProtocol', 'Experiment1')
% gui_brainstorm('CreateProtocol', 'Experiment1', 0, 0);
% 
% for s = 301:329
%     s
%     if ~exist(strcat(procpath,'/',num2str(s),'_decoding.mat'),'file')
% 
%         tic
%         % Input files
%         sFiles = [];
%         SubjectNames = {num2str(s)};
%         RawFiles = {strcat(eeglabdata,'/',num2str(s),'.set')};
% 
%         % Process: Create link to raw file
%         sFiles = bst_process('CallProcess', 'process_import_data_raw', sFiles, [], ...
%             'subjectname',    SubjectNames{1}, ...
%             'datafile',       {RawFiles{1}, 'EEG-EEGLAB'}, ...
%             'channelreplace', 1, ...
%             'channelalign',   1, ...
%             'evtmode',        'value');
% 
%         % Process: Band-pass:0.5Hz-48Hz
%         sFiles = bst_process('CallProcess', 'process_bandpass', sFiles, [], ...
%             'sensortypes', 'MEG, EEG', ...
%             'highpass',    0.5, ...
%             'lowpass',     30, ...
%             'tranband',    0, ...
%             'attenuation', 'relax', ...  % 40dB
%             'ver',         '2019', ...  % 2019
%             'mirror',      0, ...
%             'read_all',    0);
% 
% 
%         % Process: Import MEG/EEG: Events
%         sFiles = bst_process('CallProcess', 'process_import_data_event', sFiles, [], ...
%             'subjectname',   SubjectNames{1}, ...
%             'condition',     '', ...
%             'eventname',     '101, 102, 103', ...
%             'timewindow',    [], ...
%             'epochtime',     [-0.2, 1], ...
%             'split',         0, ...
%             'createcond',    1, ...
%             'ignoreshort',   1, ...
%             'usectfcomp',    1, ...
%             'usessp',        1, ...
%             'freq',          [], ...
%             'baseline',      [-0.2, -0.001], ...
%             'blsensortypes', 'MEG, EEG');
% 
% 
%         d = dir(strcat(protocolpath,num2str(s),'/101/data_101_trial*'));
%         sFiles1 = {};
%         for n = 1:length(d)
%             sFiles1{end+1} = {strcat(num2str(s),'/101/',d(n).name)};
%         end
%         d = dir(strcat(protocolpath,num2str(s),'/102/data_102_trial*'));
%         sFiles2 = {};
%         for n = 1:length(d)
%             sFiles2{end+1} = {strcat(num2str(s),'/102/',d(n).name)};
%         end
%         d = dir(strcat(protocolpath,num2str(s),'/103/data_103_trial*'));
%         sFiles3 = {};
%         for n = 1:length(d)
%             sFiles3{end+1} = {strcat(num2str(s),'/103/',d(n).name)};
%         end
% 
%         sFiles = [sFiles1{:} sFiles2{:} sFiles3{:}];
% 
%         sFiles = bst_process('CallProcess', 'process_decoding_svm', sFiles, [], ...
%             'sensortypes',      '', ...
%             'lowpass',          0, ...
%             'num_permutations', 1000, ...
%             'kfold',            5, ...
%             'method',           1, ...  % Pairwise
%             'model',            'svm');
% 
%         clear sFiles;
%         sFiles = [sFiles1{:} sFiles2{:} sFiles3{:}];
% 
%         sFiles = bst_process('CallProcess', 'process_average', sFiles, [], ...
%             'avgtype',       1, ...
%             'avg_func',      1, ...
%             'weighted',      0, ...
%             'keepevents',    0);
% 
%         clear sFiles;
%         sFiles = [sFiles1{:} sFiles2{:} sFiles3{:}];
% 
%         sFiles = bst_process('CallProcess', 'process_average', sFiles, [], ...
%             'avgtype',       3, ...
%             'avg_func',      1, ...
%             'weighted',      0, ...
%             'keepevents',    0);
% 
%         d = dir(strcat(protocolpath,num2str(s),'/decoding/matrix*'));
%         copyfile(strcat(protocolpath,num2str(s),'/decoding/',d(1).name),strcat(procpath,'/',num2str(s),'_decoding.mat'));
% 
%         d = dir(strcat(protocolpath,num2str(s),'/@intra/data_average*'));
%         copyfile(strcat(protocolpath,num2str(s),'/@intra/',d(1).name),strcat(procpath,'/',num2str(s),'_grandmean.mat'));
% 
%         d = dir(strcat(protocolpath,num2str(s),'/101/data_101_average*'));
%         copyfile(strcat(protocolpath,num2str(s),'/101/',d(1).name),strcat(procpath,'/',num2str(s),'_101.mat'));
% 
%         d = dir(strcat(protocolpath,num2str(s),'/102/data_102_average*'));
%         copyfile(strcat(protocolpath,num2str(s),'/102/',d(1).name),strcat(procpath,'/',num2str(s),'_102.mat'));
% 
%         d = dir(strcat(protocolpath,num2str(s),'/103/data_103_average*'));
%         copyfile(strcat(protocolpath,num2str(s),'/103/',d(1).name),strcat(procpath,'/',num2str(s),'_103.mat'));
% 
%         toc
% 
%     end
% 
% end
% 
% brainstorm stop;
% 
% rmpath(brainstormdir);


rawdatadir = '/Users/db900/Documents/git/uncannyvalley/local/RawData/Experiment 2';
eeglabdata = '/Users/db900/Documents/git/uncannyvalley/local/preprocessed';
dbpath = '/Users/db900/Documents/git/uncannyvalley/local/brainstormdb';
procpath = '/Users/db900/Documents/git/uncannyvalley/local/masksmvpa';
protocolpath = '/Users/db900/Documents/git/uncannyvalley/local/brainstormdb/Experiment2/data/';

if ~exist(dbpath,'dir')
    mkdir(dbpath);
end
if ~exist(procpath,'dir')
    mkdir(procpath);
end

addpath(eeglabdir);

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab('nogui');

maskstoclean = [353 366 374 376 379];
for s = 351:380
    s
    if ~exist(strcat(eeglabdata,'/',num2str(s),'.set'),'file')
        tic

        EEGpath = strcat(rawdatadir,'/',num2str(s));
        d = dir(strcat(EEGpath,'/*.cnt'))       % index the directory containing the EEG files
        counter = length(d);

        c = 1;
        fname = d(c).name;
        EEG = pop_loadeep_v4(strcat(EEGpath,'/',fname));    % load the EEG data

        if counter>1
            for c = 2:counter                       % loop through all cnt files
                fname = d(c).name;
                EEG2 = pop_loadeep_v4(strcat(EEGpath,'/',fname));    % load the EEG data
                EEG = pop_mergeset(EEG, EEG2);
            end
        end

        EEG=pop_chanedit(EEG, 'lookup',strcat(eeglabdir,'/plugins/dipfit/standard_BEM/elec/standard_1005.elc'));

        if ismember(s,maskstoclean)
            EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on','pca',50);
            EEG = pop_iclabel(EEG, 'default');
            EEG = pop_icflag(EEG, [NaN NaN;0.9 1;0.9 1;NaN NaN;0.5 1;0.5 1;0.5 1]);
            EEG = pop_subcomp( EEG, [], 0);
        end

        EEG = pop_saveset( EEG, 'filename',strcat(num2str(s),'.set'),'filepath',eeglabdata);
        toc
    end
end

rmpath(eeglabdir);


addpath(brainstormdir);

brainstorm nogui;

% gui_brainstorm('SetDatabaseFolder',dbpath);
gui_brainstorm('DeleteProtocol', 'Experiment2')
gui_brainstorm('CreateProtocol', 'Experiment2', 0, 0);

for s = 351:380
    s
    if ~exist(strcat(procpath,'/',num2str(s),'_decoding.mat'),'file')

        tic
        % Input files
        sFiles = [];
        SubjectNames = {num2str(s)};
        RawFiles = {strcat(eeglabdata,'/',num2str(s),'.set')};

        % Process: Create link to raw file
        sFiles = bst_process('CallProcess', 'process_import_data_raw', sFiles, [], ...
            'subjectname',    SubjectNames{1}, ...
            'datafile',       {RawFiles{1}, 'EEG-EEGLAB'}, ...
            'channelreplace', 1, ...
            'channelalign',   1, ...
            'evtmode',        'value');

        % Process: Band-pass:0.5Hz-48Hz
        sFiles = bst_process('CallProcess', 'process_bandpass', sFiles, [], ...
            'sensortypes', 'MEG, EEG', ...
            'highpass',    0.5, ...
            'lowpass',     30, ...
            'tranband',    0, ...
            'attenuation', 'relax', ...  % 40dB
            'ver',         '2019', ...  % 2019
            'mirror',      0, ...
            'read_all',    0);

        % merge across asian and western image sets by renaming event triggers
        sFiles = bst_process('CallProcess', 'process_evt_rename', sFiles, [], ...
            'src',   '111, 211, 112, 212, 123, 223', ...
            'dest',  '101, 101, 102, 102, 103, 103');

        % Process: Import MEG/EEG: Events
        sFiles = bst_process('CallProcess', 'process_import_data_event', sFiles, [], ...
            'subjectname',   SubjectNames{1}, ...
            'condition',     '', ...
            'eventname',     '101, 102, 103', ...
            'timewindow',    [], ...
            'epochtime',     [-0.2, 1], ...
            'split',         0, ...
            'createcond',    1, ...
            'ignoreshort',   1, ...
            'usectfcomp',    1, ...
            'usessp',        1, ...
            'freq',          [], ...
            'baseline',      [-0.2, -0.001], ...
            'blsensortypes', 'MEG, EEG');


        d = dir(strcat(protocolpath,num2str(s),'/101/data_101_trial*'));
        sFiles1 = {};
        for n = 1:length(d)
            sFiles1{end+1} = {strcat(num2str(s),'/101/',d(n).name)};
        end
        d = dir(strcat(protocolpath,num2str(s),'/102/data_102_trial*'));
        sFiles2 = {};
        for n = 1:length(d)
            sFiles2{end+1} = {strcat(num2str(s),'/102/',d(n).name)};
        end
        d = dir(strcat(protocolpath,num2str(s),'/103/data_103_trial*'));
        sFiles3 = {};
        for n = 1:length(d)
            sFiles3{end+1} = {strcat(num2str(s),'/103/',d(n).name)};
        end

        sFiles = [sFiles1{:} sFiles2{:} sFiles3{:}];

        sFiles = bst_process('CallProcess', 'process_decoding_svm', sFiles, [], ...
            'sensortypes',      '', ...
            'lowpass',          0, ...
            'num_permutations', 1000, ...
            'kfold',            5, ...
            'method',           1, ...  % Pairwise
            'model',            'svm');

        clear sFiles;
        sFiles = [sFiles1{:} sFiles2{:} sFiles3{:}];

        sFiles = bst_process('CallProcess', 'process_average', sFiles, [], ...
            'avgtype',       1, ...
            'avg_func',      1, ...
            'weighted',      0, ...
            'keepevents',    0);

        clear sFiles;
        sFiles = [sFiles1{:} sFiles2{:} sFiles3{:}];

        sFiles = bst_process('CallProcess', 'process_average', sFiles, [], ...
            'avgtype',       3, ...
            'avg_func',      1, ...
            'weighted',      0, ...
            'keepevents',    0);

        d = dir(strcat(protocolpath,num2str(s),'/decoding/matrix*'));
        copyfile(strcat(protocolpath,num2str(s),'/decoding/',d(1).name),strcat(procpath,'/',num2str(s),'_decoding.mat'));

        d = dir(strcat(protocolpath,num2str(s),'/@intra/data_average*'));
        copyfile(strcat(protocolpath,num2str(s),'/@intra/',d(1).name),strcat(procpath,'/',num2str(s),'_grandmean.mat'));

        d = dir(strcat(protocolpath,num2str(s),'/101/data_101_average*'));
        copyfile(strcat(protocolpath,num2str(s),'/101/',d(1).name),strcat(procpath,'/',num2str(s),'_101.mat'));

        d = dir(strcat(protocolpath,num2str(s),'/102/data_102_average*'));
        copyfile(strcat(protocolpath,num2str(s),'/102/',d(1).name),strcat(procpath,'/',num2str(s),'_102.mat'));

        d = dir(strcat(protocolpath,num2str(s),'/103/data_103_average*'));
        copyfile(strcat(protocolpath,num2str(s),'/103/',d(1).name),strcat(procpath,'/',num2str(s),'_103.mat'));

        toc
    end
end

brainstorm stop;

rmpath(brainstormdir);

