import torch
from data.melspectrogram_dataset import MelSpectrogramDataset

def load_dataset(args):
    print('==> Preparing data..')
    
    train_dataset = MelSpectrogramDataset(root=args.root, duration=1, data_range=(-20,15))
    trainloader = torch.utils.data.DataLoader(train_dataset,
                                              batch_size=args.batch_size, shuffle=True)

    val_dataset = MelSpectrogramDataset(root=args.root, duration=1, data_range=(-20,15))
    valloader = torch.utils.data.DataLoader(val_dataset,
                                             batch_size=args.batch_size, shuffle=False)

    return trainloader, valloader

