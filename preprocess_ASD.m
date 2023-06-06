% preprocess the EEG data for ASD research
% Author: Weifeng Li 2023/8/4
%-----------------------------------------------
%%
clc;clear;clf;
% initiate the vars
raw_dataset_path = 'D:\inventor\ASD\sub4\20230420sub4_301\sub04-20230420-150700\default - 20230420T170819\default-20230420T170819.set';
ica_dataset_filename = 'ica_EEG.set';
ica_dataset_path = 'D:\inventor\ASD\sub4\20230420sub4_301\sub04-20230420-150700\default - 20230420T170819\';
final_dataset_filename = 'final_EEG.set';
final_dataset_path = 'D:\inventor\ASD\sub4\20230420sub4_301\sub04-20230420-150700\default - 20230420T170819\';
rmv_chans = {'STATUS','Counter 2power24','M1','M2'};
filter_low_cut = 4;
filter_high_cut = 45;
event_info_txt = 'event_3min.txt'; % generate with //event_txt.m//
per_range = [0,2]; % the period range for each stamp
amp_range = [-100,100];
downsample_freq = 250;

% 1. select data(remove status and M electro)
EEG = pop_loadset(raw_dataset_path);
out_EEG = pop_select(EEG,'rmchannel',rmv_chans);

% 2. filter 4-45Hz non-causal filter, 50 Hz notch filter
srate = EEG.srate;
filter_order = 3*fix(srate/filter_low_cut);
filt_EEG = pop_eegfilt(out_EEG,filter_low_cut,filter_high_cut,filter_order, 0, 0, 0, 'fir1', 1);

% 3. divide the events(2s/epoch)
evnt_EEG = pop_importevent(filt_EEG, 'event', event_info_txt ,'skipline', 1, 'fields',{ 'type', 'latency' });
evnt_EEG = pop_epoch( evnt_EEG, {} , per_range,'valuelim',amp_range);
evnt_EEG = pop_rmbase( evnt_EEG );
pop_eegplot(evnt_EEG, 1, 1, 1);

% 4. ICA
ica_EEG = pop_runica(evnt_EEG);
pop_saveset(ica_EEG,'filename', ica_dataset_filename ,'filepath',ica_dataset_path);

%%
%ICA remove the eye movement artefacts (eye binks)
ica_EEG = pop_loadset([ica_dataset_path,ica_dataset_filename]);
icl = iclabel(ica_EEG);
comps_list = 1:ica_EEG.nbchan;
pop_topoplot(icl,0,comps_list, 'ica', 0, 0,'iclabel', 'on');

%%
rmv_ica_comps = [];
% remove ica compos
ica_EEG = pop_loadset([ica_dataset_path,ica_dataset_filename]);
rmv_ica_EEG = pop_subcomp(ica_EEG,rmv_ica_comps);

% interpolate using spherical spline interpolation for each recording
interp_EEG = pop_interp(rmv_ica_EEG);

% 6. downsample to 250Hz
final_EEG = pop_resample(interp_EEG, downsample_freq);
pop_saveset(ica_EEG,'filename', final_dataset_filename ,'filepath',final_dataset_path);

