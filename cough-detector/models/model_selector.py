from models.resnet import ResNet18


class ModelSelector():
    """
    Selector class, so that you can call upon multiple models
    """
    def __init__(self, num_classes):
        self.num_classes = num_classes

    def select(self, model, args):
        """
        Selector utility to create models from model directory
        :param model: which model to select. Currently choices are: (cnn | resnet | preact_resnet | densenet | wresnet)
        :return: neural network to be trained
        """
        if model == 'resnet':
            assert args.resdepth in [18, 34, 50, 101, 152], \
                "Non-standard and unsupported resnet depth ({})".format(args.resdepth)
            if args.resdepth == 18:
                net = ResNet18(self.num_classes)
            # elif args.resdepth == 34:
            #     net = ResNet34(self.num_classes)
            # elif args.resdepth == 50:
            #     net = ResNet50(self.num_classes)
            # elif args.resdepth == 101:
            #     net = ResNet101(self.num_classes)
            # else:
            #     net = ResNet152()
        else:
            raise NotImplementedError('Model {} not supported'.format(model))
        return net
