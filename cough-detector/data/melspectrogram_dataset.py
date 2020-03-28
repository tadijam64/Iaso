import numpy as np
import torch
from torchvision.datasets import DatasetFolder
import torchaudio
from torchaudio.transforms import MelSpectrogram


class MelSpectrogramDataset(DatasetFolder):
    '''
    root      - directory that contains folders for each class and their appropriate data samples
    duration  - desired duration (seconds) of excerpts randomly sampledfrom sound files  
    transform - specify which torchaudio's transforms to use; performed on waveform
    '''
    # TODO: add options for MelSpectrogram()
    def __init__(self, root, duration, transform=None, extensions=('.wav')):
        super(MelSpectrogramDataset, self).__init__(root, transform=transform, extensions=extensions, loader=None)
        self.duration = duration
        self.transform = transform

    def __getitem__(self, index):
        path, target = self.samples[index]
        sample = wav_to_melspectrogram(path, self.duration, self.transform)
        return sample, target


def wav_to_melspectrogram(wav_path, duration=1, transform=None):
    waveform, sample_rate = torchaudio.load(wav_path, normalization=True)
    
    if transform is not None:
            waveform = transform(waveform)

    # calculate how many bitrates is the desired duration
    excerpt_length  = duration * sample_rate
    waveform_length = waveform.shape[1]
    
    # if the duration of original audio is shorter than desired excerpt's duration, add silence
    if excerpt_length > waveform_length:
        new_waveform = torch.zeros(waveform.shape[0], excerpt_length)  # silence of desired duration
        new_waveform[:, :waveform_length] = waveform  # paste the original sound over the silence 
        
        waveform = new_waveform
        waveform_length = waveform.shape[1]
        
    # randomly select excerpt with the desired duration
    start_idx = np.random.randint(0, waveform_length-excerpt_length+1) 
    end_idx   = start_idx + excerpt_length
    excerpt_waveform = waveform[:, start_idx:end_idx]
    
    return MelSpectrogram(sample_rate=sample_rate)(excerpt_waveform)


if __name__ == "__main__":
    dataset = MelSpectrogramDataset('/mnt/4B7D43F071EB179A/output/', 1)
    print(dataset.__getitem__(0)[0].min())
    print(dataset.__len__())
    print(dataset.class_to_idx)