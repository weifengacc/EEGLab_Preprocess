# EEGLab_Preprocess
The eeglab is used to preprocess and visualize the eeg dataset. Although the interface is handable for people, it veils the underlying codes. This respo achieves the common-use functions in the form of codes (of course, base EEGlAB)

File intro:
preprocess_ASD.m: the main file. It includes three sections: 
1. ICA Preprocessing, (a) selecting data(remove bad electros) (b) filtering (c) dividing events (d) ICA
2. Visualizing Artefacts: visualize the ICA result with IClabel (requiring IClabel plugin)
3. Removing ica components: (a) removing (b) interpolating (c) downsampling

Instructions:

1. Initialize the vars and run the first section $ICA Preprocessing$
@raw_dataset_path: the path of raw dataset you want to handle with
@ica_dataset_filename : the name of ICA result file
@ica_dataset_path: the path of ICA result file
@final_dataset_filename: the name of final file after preprocessing
@final_dataset_path: the path of final file after preprocessing
@rmv_chans: the bad channels(with name) 
@filter_low_cut: low cut of filter
@filter_high_cut: high cut of filter
@event_info_txt: the event_info_txt
@event_fields: the field of each columns in 'event_info_txt'
@per_range: the period range for each stamp
@amp_range: the amplitude range for each event; if larger or smaller, removed. 
@downsample_freq: downsample frequency. 

2. Run the second senction and visualize the iclabel of each ica components. Decide which components should be removed.
3. Input the index of ICA components you want to remove in the var 'rmv_ica_comps'(the first line in the third section).

Note: 
1. you need to install eeglab under matlab (including the iclabel plugin)
2. you need to learn some knowledges on EEG preprocessing.
3. Run the three sections one by one, don't Run all programs at once. 
