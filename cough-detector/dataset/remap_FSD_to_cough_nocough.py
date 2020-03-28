import os
import shutil
import numpy as np
import pandas as pd

makedirs = lambda path: os.makedirs(path) if not os.path.exists(path) else None

def remap_to_cough_nocough(csv_file, wav_root, output_root):
    '''
    csv_file    - FSDmeta csv file 
    wav_root    - directory that contains FSD .wav files
    output_root - output directory in which the .wav files will be sorted to "1_cough/" and 0_nocough/ folders
    '''
    df = pd.read_csv(csv_file)
    df = df[['fname', 'label']]
    
    # all wav files that are labeled as something other then 'cough' are assigned 'nocough' label
    remapped = np.where(df['label']=='Cough', '1_cough', '0_nocough')
    df['label'] = remapped
    
    # create class/label directories
    for label in df.label.unique():
        label_dir = os.path.join(output_root, label)
        makedirs(label_dir)

    # move .wav files according to their class/label
    for i in range(len(df)):
        source_path = os.path.join(wav_root, df.fname[i])
        dest_path   = os.path.join(output_root, df.label[i], df.fname[i])
        
        shutil.move(source_path, dest_path)