import torch
from data.melspectrogram_dataset import MelSpectrogramDataset

def load_dataset(args):
    print('==> Preparing data..')
    
    train_root = os.path.join(args.root, 'train')
    val_root   = os.path.join(args.root, 'val')

    train_dataset = MelSpectrogramDataset(root=train_root, duration=1, data_range=args.data_range)
    trainloader = torch.utils.data.DataLoader(train_dataset,
                                              batch_size=args.batch_size, shuffle=True)

    val_dataset = MelSpectrogramDataset(root=val_root, duration=1, data_range=args.data_range)
    valloader = torch.utils.data.DataLoader(val_dataset,
                                             batch_size=args.batch_size, shuffle=False)

    return trainloader, valloader

