import json
import argparse
import torch
from torch.utils.data import DataLoader

import sys
sys.path.append('..')
from data.melspectrogram_dataset import MelSpectrogramDataset

# based on https://discuss.pytorch.org/t/computing-the-mean-and-std-of-dataset/34949/4
def dataset_stats(dataset, batch_size, num_workers=0):
    loader = DataLoader(dataset=dataset,
                        batch_size=batch_size,
                        num_workers=num_workers,
                        shuffle=False)
    max_value = -10000
    min_value =  10000
    mean = 0.0
    for images, _ in loader:
        if images.max() > max_value:
            max_value = images.max()
        if images.min() < min_value:
            min_value = images.min()

        batch_samples = images.size(0)
        images = images.view(batch_samples, images.size(1), -1)
        mean += images.mean(2).sum(0)
    mean = mean / len(loader.dataset)

    var = 0.0
    for images, _ in loader:
        batch_samples = images.size(0)
        images = images.view(batch_samples, images.size(1), -1)
        var += ((images - mean.unsqueeze(1))**2).sum([0,2])
    std = torch.sqrt(var / (len(loader.dataset)*images.shape[-1])) # the last dimension here is x*y of image size

    values = {'mean': int(mean.detach().numpy()), 
              'variance': int(var.detach().numpy()), 
              'std_deviation': int(std.detach().numpy()),
              'max_value': max_value,
              'min_value': min_value}

    print(values)
    with open('mean_var_std.json', 'w') as fp:
        json.dump(values, fp)
    return values

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    # TODO: add help
    parser.add_argument('--root', type=str, required=True, help='')
    parser.add_argument('--batch_size', type=int, required=True, help='')
    parser.add_argument('--num_workers', type=int, default=0, help='')
    args = parser.parse_args()

    dataset = MelSpectrogramDataset(args.root, 3, data_range=None)
    print(dataset_stats(dataset, batch_size=args.batch_size, num_workers=args.num_workers))