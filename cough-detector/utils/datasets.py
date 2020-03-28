import torch

def load_dataset(args):
    print('==> Preparing data..')
    
    data_dir = args.root

    train_dataset = CustomDataset(which_set=args.dataset,
                                  root='{}/{}'.format(data_dir, args.dataset),
                                  train=True,
                                  download=True,
                                  aug=args.data_aug,
                                  dataset_norm_type=args.dataset_norm_type)
    trainloader = torch.utils.data.DataLoader(train_dataset,
                                              batch_size=args.batch_size, shuffle=True)

    test_dataset = CustomDataset(which_set=args.dataset,
                                 root='{}/{}'.format(data_dir, args.dataset),
                                 train=False,
                                 download=True,
                                 aug=[],
                                 dataset_norm_type=args.dataset_norm_type)
    testloader = torch.utils.data.DataLoader(test_dataset,
                                             batch_size=args.test_batch_size, shuffle=False)

    args.norm_means = train_dataset.norm_means
    args.norm_stds = train_dataset.norm_stds
    return trainloader, testloader

