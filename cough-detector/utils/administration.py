import argparse
import json


def parse_args():
    """
    Argument parser
    :return: parsed arguments
    """
    parser = argparse.ArgumentParser()
    # data I/O
    
    parser.add_argument('-root', '--root', type=str, default='../data',
                        help='Which dataset to use')
                        
    parser.add_argument('--data_range', required=True, nargs='+', type=int, 
                        help='Minimum and maximum value of the dataset. Input example: 0 255')

    parser.add_argument('-batch', '--batch_size', type=int, default=128,
                        help='Batch Size')
    
    parser.add_argument('-x', '--max_epochs', type=int, default=200,
                        help='How many args.max_epochs to run in total?')
    parser.add_argument('-s', '--seed', type=int, default=-1,
                        help='Random seed to use')
    
    # logging
    parser.add_argument('-en', '--exp_name', type=str, default='default_experiment',
                        help='Experiment name for the model to be assessed')
    parser.add_argument('-o', '--logs_path', type=str, default='log',
                        help='Directory to save log files, check points, and tensorboard.')
    parser.add_argument('-resume', '--resume', type=int, default=0,
                        help='Resume training?')
    parser.add_argument('-save', '--save', type=int, default=1,
                        help='Save checkpoint files?')

    parser.add_argument('-saveimgs', '--save_images', type=int, default=0,
                        help='Build a folder for saved images?')

    # model
    parser.add_argument('-model', '--model', type=str, default='resnet',
                        help='resnet | preact_resnet | densenet | wresnet')
    # resnet models
    parser.add_argument('-dep', '--resdepth', type=int, default=18,
                        help='ResNet default depth')
    
    # optimization
    parser.add_argument('-l', '--learning_rate', type=float, default=0.1,
                        help='Base learning rate')
    parser.add_argument('-sched', '--scheduler', type=str, default='MultiStep',
                        help='Scheduler for learning rate annealing: CosineAnnealing | MultiStep')
    parser.add_argument('-mile', '--milestones', type=int, nargs='+', default=[60, 120, 160],
                        help='Multi step scheduler annealing milestones')
    parser.add_argument('-optim', '--optim', type=str, default='Adam',
                        help='Optimizer?')
    # simple regularisation
    parser.add_argument('-wd', '--weight_decay', type=float, default=5e-4,
                        help='Weight decay value')
    parser.add_argument('-mom', '--momentum', type=float, default=0.9,
                        help='Momentum multiplier')


    args = parser.parse_args()
    print('input args:\n', json.dumps(vars(args), indent=4, separators=(',', ':')))
    return args