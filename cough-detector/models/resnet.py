from torch import nn
from torchvision.models import resnet18

def ResNet18(num_classes):
    model = resnet18()
    model.conv1 = nn.Conv2d(1, 64, kernel_size=(7, 7), stride=(2, 2), padding=(3, 3), bias=False)
    model.fc = nn.Linear(in_features=512, out_features=num_classes, bias=True)
    return model